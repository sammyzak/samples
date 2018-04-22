<%@ Page Language="C#" Debug="true"%>
<%@ Import Namespace="System.Data.SqlClient" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<script runat="server">
	
	string hcid;
	
	protected void Page_load(object sender, System.EventArgs e) 
	{
		wws.authen x = new wws.authen();

		hcid = Request.QueryString["hcid"];

		if (x.validUser()) {
			string uid = (string)HttpContext.Current.Session["uid"];
			SqlConnection myConnection = new SqlConnection(x.getConnectionString());
			try {
				myConnection.Open();
				try {
					SqlDataReader myReader = null;
					string strSql = "SELECT countyName FROM [dbo].[county] WHERE countyID = "+hcid;

					SqlCommand myCommand = new SqlCommand(strSql, myConnection);
					myReader = myCommand.ExecuteReader();
					string p_type, p_beds, p_status, p_price, miniDescr;
					if (myReader.Read()) {
						lblTitle.Text = myReader["countyName"]+" County Business Types:";
					}
					myReader.Close();
					myConnection.Close();
				} catch (Exception ex1) {
				}
			} catch (Exception ex2) {
			}
		}

		wws.authen.logoutIfNotValid();
	}
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head id="head" runat="server">
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
		<%= wws.authen.isAdmin() %>
		<% Response.WriteFile("includes/rolling-ads.aspx"); %>
		<title>Discounts - NHS - County Business Types</title>
		<% Response.WriteFile("includes/head.aspx"); %>
	</head>
	<body>
		<form id="form1" runat="server">
			<div id="container">
				<% Response.WriteFile("includes/account.aspx"); %>
				<div id="header">
					<div id="title">
						<a href="./">
							<img src="./images/title.png" width="600" height="100" alt="Discounts NHS - Exclusive Discounts &amp; Benefits for NHS Staff " />
						</a>
					</div>
					<div id="main_ad">
						<img src="./images/ads/cobella.jpg" name="SlideShow" width="288" height="76" alt="" />
					</div>
				</div>

				<% Response.WriteFile("includes/nav.aspx"); %>
				<script type="text/javascript">
					$(document).ready(function () {
						runSlideShow();
					});
				</script>
				<div id="search">
					<asp:TextBox ID="SearchBox" runat="server" />
				</div>
				<div id="col-1">
					<asp:Label ID="lblTitle" runat="server" cssclass="title" /><br /><br /><br />
					<asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource4" BorderStyle="None" DataKeyNames="businessTypeID" GridLines="Horizontal" ShowHeader="False" CellPadding="10" EnableModelValidation="True">
						<Columns>
							<asp:TemplateField>
								<ItemTemplate>
									<asp:Image ID="Image1" runat="server" Height="30px" ImageUrl='<%# Eval("businessTypeName", "./images/icons/{0}.jpg") %>' Width="30px" />
								</ItemTemplate>
							</asp:TemplateField>
							<asp:BoundField DataField="businessTypeID" HeaderText="businessTypeID" SortExpression="businessTypeID" InsertVisible="False" ReadOnly="True" Visible="False" />
							<asp:BoundField DataField="businessTypeName" HeaderText="businessTypeName" SortExpression="businessTypeName" Visible="False" />
							<asp:TemplateField>
								<ItemTemplate>
									<asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# Eval("businessTypeID", "countybusinesses.aspx?btid={0}&hcid="+hcid) %>' Text='<%# Eval("businessTypeName") %>'></asp:HyperLink>
								</ItemTemplate>
							</asp:TemplateField>
						</Columns>
						<EmptyDataTemplate>Sorry, there are currently no Businesses near this Station.<br /><br /></EmptyDataTemplate>
					</asp:GridView>
					<br />
					<h3>Know a business in this area that you would like discounts from?</h3>
					<p>Or do you own a business in this area and would like it listed?</p>
					<p>Refer a business here:</p>
					<asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="./refer.aspx" Text="Business Referral" />
					<br />
					
					<asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
							SelectCommand="SELECT * 
												FROM businessType 
												WHERE businessTypeID IN(
															SELECT bt.businessTypeID
																FROM business AS b,
																		business_businessType AS bbt,
																		businessType AS bt      
																WHERE b.businessID = bbt.businessID
																		AND bt.businessTypeID = bbt.businessTypeID
																		AND b.businessID IN (
																					SELECT business.businessID
																						FROM business, business_county, county
																						WHERE business.businessID = business_county.businessID 
																								AND business_county.countyID = county.countyID
																								AND county.countyID = @county
																		)
														)
										ORDER BY businessTypeName">
						<SelectParameters>
							<asp:QueryStringParameter Name="county" QueryStringField="hcid" />
						</SelectParameters>
					</asp:SqlDataSource>
				</div>
				<div id="col-2">
					<% Response.WriteFile("includes/adverts.aspx"); %>
				</div>
				<% Response.WriteFile("includes/footer.aspx"); %>  
  
				<div id="footer-img"></div>
			</div>
		</form>
	</body>
</html>
