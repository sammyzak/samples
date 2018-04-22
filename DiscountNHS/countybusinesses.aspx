<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
  
  string btid;
  string hcid;
  
    protected void Page_Load(object sender, EventArgs e)
    {
		wws.authen x = new wws.authen();
		btid = Request.QueryString["BTID"];
        hcid = Request.QueryString["HCID"];
        
        if (x.validUser()) {
			string uid = (string)HttpContext.Current.Session["uid"];
			SqlConnection myConnection = new SqlConnection(x.getConnectionString());
			try {
				myConnection.Open();
				try {
					SqlDataReader myReader = null;

					string strSql = @"SELECT businessTypeName, countyName
										FROM [dbo].[businessType] LEFT JOIN [dbo].[county] 
											ON countyID = '"+hcid+@"'
										WHERE businessTypeID = '"+btid+"'";

					SqlCommand myCommand = new SqlCommand(strSql, myConnection);
					myReader = myCommand.ExecuteReader();
					if (myReader.Read()) {
						lblTitle.Text = myReader["businessTypeName"]+" in "+myReader["countyName"];
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
<head runat="server">
<%= wws.authen.isAdmin() %>
<% Response.WriteFile("includes/rolling-ads.aspx"); %>
<title>Discounts - NHS - County Businesses</title>
<% Response.WriteFile("includes/head.aspx"); %>
</head>
<body onLoad="runSlideShow()" bgcolor="#00a4f8">
<form id="form1" runat="server">
  <div>
  <div id="container">
  <% Response.WriteFile("includes/account.aspx"); %>
  <div id="header">
    <div id="title"> <a href="./"><img src="./images/title.png" width="600" height="100" alt="Discounts NHS - Exclusive Discounts &amp; Benefits for NHS Staff "></a>
    </div>
    <div id="main_ad"><img src="./images/ads/cobella.jpg" name="SlideShow" width="288" height="76" alt=""></div>
  </div>
  <% Response.WriteFile("includes/nav.aspx"); %>
  <div id="search">
      <asp:TextBox ID="SearchBox" runat="server"></asp:TextBox>
  </div>
  <div id="col-1">
<asp:Label ID="lblTitle" runat="server" cssclass="title" />
  <br />
  <br />
  <br />
    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource4" BorderStyle="None" 
        DataKeyNames="businessID" GridLines="Horizontal" 
        ShowHeader="False" CellPadding="10" EnableModelValidation="True">
      <Columns>
          <asp:TemplateField>
              <ItemTemplate>
                   <asp:Image ID="Image1" runat="server" Height="30px" 
                      ImageUrl='<%# Eval("businessTypeName", "./images/icons/{0}.jpg") %>' 
                      Width="30px" />
              </ItemTemplate>
          </asp:TemplateField>
      <asp:BoundField DataField="countyID" HeaderText="countyID" 
                SortExpression="countyID" 
              Visible="False" />
      <asp:BoundField DataField="businessTypeID" HeaderText="businessTypeID" 
                SortExpression="businessTypeID" Visible="False" />
                <asp:BoundField DataField="businessID" HeaderText="businessID" 
              InsertVisible="False" ReadOnly="True" SortExpression="businessID" 
              Visible="False" />
          <asp:TemplateField HeaderText="businessName" SortExpression="businessName">
              <EditItemTemplate>
                  <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("businessName") %>'></asp:TextBox>
              </EditItemTemplate>
              <ItemTemplate>
          
<asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# Eval("businessID", "business.aspx?BID={0}&HCID="+hcid) %>' Text='<%# Eval("businessName") %>'></asp:HyperLink>

              </ItemTemplate>
          </asp:TemplateField>
          <asp:BoundField DataField="businessTypeName" HeaderText="businessTypeName" 
              SortExpression="businessTypeName" Visible="False" />
      </Columns>
        <EmptyDataTemplate>
              Sorry, there are currently no Businesses of this type in this County.<br />
              <br />
          </EmptyDataTemplate>
    </asp:GridView>
      <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
          ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 

          
          
          SelectCommand="SELECT dbo.business_county.countyID, dbo.business_businessType.businessTypeID, dbo.business.businessID, dbo.business.businessName, dbo.businessType.businessTypeName FROM dbo.business INNER JOIN dbo.business_businessType ON dbo.business.businessID = dbo.business_businessType.businessID INNER JOIN dbo.business_county ON dbo.business.businessID = dbo.business_county.businessID INNER JOIN dbo.businessType ON dbo.business_businessType.businessTypeID = dbo.businessType.businessTypeID WHERE (dbo.business_county.countyID = @countyID) AND (dbo.business_businessType.businessTypeID = @businessTypeID)">
          <SelectParameters>
              <asp:QueryStringParameter Name="countyID" QueryStringField="hcid" />
              <asp:QueryStringParameter Name="businessTypeID" QueryStringField="btid" />
          </SelectParameters>
      </asp:SqlDataSource>
      <br />
      <h3>Know a business in this area that you would like discounts from?</h3>
              <p>Or do you own a business in this area and would like it listed?</p>
              <p>Refer a business here:</p>

              <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="./refer.aspx" Text="Business Referral"></asp:HyperLink>
      <br />
      <br />
      <br />
    <br />
  </div>
  <div id="col-2">
    <% Response.WriteFile("includes/adverts.aspx"); %>
  </div>
  
	<% Response.WriteFile("includes/footer.aspx"); %>  
  
  </div>
<div id="footer-img"></div>
</form>
</body>
</html>