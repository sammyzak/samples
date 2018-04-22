<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    
    string bid;
    string businessname;
    string hcid;
    
    protected void Page_Load(object sender, EventArgs e)
    {
    
    	wws.authen x = new wws.authen();
        bid = Request.QueryString["BID"];
        businessname = Request.QueryString["businessName"];
        hcid = Request.QueryString["HCID"];
    
    	if (x.validUser()) {
			string uid = (string)HttpContext.Current.Session["uid"];
			SqlConnection myConnection = new SqlConnection(x.getConnectionString());
			try {
				myConnection.Open();
				try {
					SqlDataReader myReader = null;

					string strSql = @"SELECT businessName, countyName
										FROM [dbo].[business] LEFT JOIN [dbo].[county] 
											ON countyID = '"+hcid+@"'
										WHERE businessID = '"+bid+"'";

					SqlCommand myCommand = new SqlCommand(strSql, myConnection);
					myReader = myCommand.ExecuteReader();
					if (myReader.Read()) {
						lblTitle.Text = myReader["businessName"]+" in "+myReader["countyName"];
					}
					myReader.Close();
					myConnection.Close();
				} catch (Exception ex1) {
				}
			} catch (Exception ex2) {
			}
		}
		
		wws.authen.logoutIfNotValid();
        
        string url = "~/production/images/logos/" + Request.QueryString["BID"] + ".jpg";

        Image1.ImageUrl = wws.nhs.imagePresent(Server.MapPath(url), "http://discounts-nhs.co.uk/production/images/logos/nologo.jpg");
        
        Image1.DataBind();
        
        HyperLink1.NavigateUrl = "~/production/business-record.aspx?BID=" + Request.QueryString["BID"];
        
        
         
    }

    protected void DetailsView1_Load(object sender, EventArgs e)
    {

        String data;

        foreach (DetailsViewRow r in DetailsView1.Rows)
        {
            if (r.Cells.Count > 1)
            {
                data = r.Cells[1].Text;
            }
            else
            {
                data = r.Cells[0].Text;
            }

            data = data.Replace("&nbsp;", "").Trim();
            if (data == null || data == "")
            {
                r.Visible = false;
            }
        }

    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <%= wws.authen.isAdmin() %><% Response.WriteFile("includes/rolling-ads.aspx"); %>
<title>Discounts - NHS - Businesses</title>
    <% Response.WriteFile("includes/head.aspx"); %>
    </head>
<body onLoad="runSlideShow()" bgcolor="#00a4f8">
<form id="form1" runat="server">
  <div>
  <div id="container">
  <% Response.WriteFile("includes/account.aspx"); %>
  <div id="header">
    <div id="title"> <a href="./"><img src="./images/title.png" width="600" height="100" alt="Discounts NHS - Exclusive Discounts &amp; Benefits for NHS Staff "></a> </div>
    <div id="main_ad"><img src="./images/ads/cobella.jpg" name="SlideShow" width="288" height="76" alt=""></div>
  </div>
      <% Response.WriteFile("includes/nav.aspx"); %>
  <div id="search">
      <asp:TextBox ID="SearchBox" runat="server"></asp:TextBox>
  </div>
  <div id="col-1">
  <br />
    <span class="admin"><asp:HyperLink ID="HyperLink1" runat="server">Edit Business Record</asp:HyperLink></span>

      <table width="620">
      
      <tr>
      
      <td>
      
					<asp:Label ID="lblTitle" runat="server" cssclass="title" />

      </td>

      <td>
      
      <asp:GridView ID="GridView5" runat="server" AutoGenerateColumns="False" 
        BorderStyle="None" 
        DataKeyNames="businessID,business_businessTypeID,businessTypeID" 
        DataSourceID="SqlDataSource5" GridLines="None" ShowHeader="False" 
            EnableModelValidation="True" CellPadding="5" Width="150px">
      <Columns>
          <asp:TemplateField>
              <ItemTemplate>
                  <asp:Image ID="Image1" runat="server" Height="30px" 
                      ImageUrl='<%# Eval("businessTypeName", "./images/icons/{0}.jpg") %>' 
                      Width="30px" />
              </ItemTemplate>
          </asp:TemplateField>
      <asp:BoundField DataField="businessID" HeaderText="businessID" 
                InsertVisible="False" ReadOnly="True" SortExpression="businessID" 
                Visible="False" />
          <asp:TemplateField HeaderText="businessTypeName" 
              SortExpression="businessTypeName">
              <EditItemTemplate>
                  <asp:TextBox ID="TextBox1" runat="server" 
                      Text='<%# Bind("businessTypeName") %>'></asp:TextBox>
              </EditItemTemplate>
              <ItemTemplate>
                  <asp:Label ID="Label1" runat="server" Text='<%# Bind("businessTypeName") %>'></asp:Label>
              </ItemTemplate>
          </asp:TemplateField>
      <asp:BoundField DataField="business_businessTypeID" 
                HeaderText="business_businessTypeID" InsertVisible="False" ReadOnly="True" 
                SortExpression="business_businessTypeID" Visible="False" />
      <asp:BoundField DataField="businessTypeID" HeaderText="businessTypeID" 
                InsertVisible="False" ReadOnly="True" SortExpression="businessTypeID" 
                Visible="False" />
      </Columns>
    </asp:GridView>

      </td>

      <td width="100">
        <asp:Image ID="Image1" runat="server" width="100px" height="100px" ImageUrl="" EnableViewState="False" />
      </td>
      
      </tr>
      
      </table>

    <br />
      <asp:DataList ID="DataList1" runat="server" DataKeyField="businessID" 
          DataSourceID="SqlDataSource2" Width="500px">
          <ItemTemplate>
              <asp:Label ID="infoLabel" runat="server" Text='<%# Eval("info") %>' />
              <br />
              <br />
          </ItemTemplate>
      </asp:DataList>


    <asp:SqlDataSource ID="SqlDataSource5" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        SelectCommand="SELECT dbo.business.businessID, dbo.businessType.businessTypeName, dbo.business_businessType.business_businessTypeID, dbo.businessType.businessTypeID FROM dbo.business INNER JOIN dbo.business_businessType ON dbo.business.businessID = dbo.business_businessType.businessID INNER JOIN dbo.businessType ON dbo.business_businessType.businessTypeID = dbo.businessType.businessTypeID WHERE (dbo.business.businessID = @businessID)">
      <SelectParameters>
          <asp:QueryStringParameter Name="businessID" QueryStringField="bid" />
      </SelectParameters>
    </asp:SqlDataSource>
    
    <h2>Offers:</h2>
    <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" 
        BorderStyle="None" DataKeyNames="businessOfferID" 
        DataSourceID="SqlDataSource3" GridLines="Horizontal" ShowHeader="False" 
          CellPadding="10" EnableModelValidation="True">
      <Columns>
          <asp:TemplateField>
              <ItemTemplate>
                  <asp:Image ID="Image2" runat="server" ImageUrl="./images/offer.png" />
              </ItemTemplate>
          </asp:TemplateField>
      <asp:BoundField DataField="businessOfferID" HeaderText="businessOfferID" ReadOnly="True" 
                SortExpression="businessOfferID" Visible="False" InsertVisible="False" />
      <asp:BoundField DataField="businessID" HeaderText="businessID" 
                SortExpression="businessID" Visible="False" />
      <asp:BoundField DataField="offerID" HeaderText="offerID" SortExpression="offerID" 
              Visible="False" />
          <asp:BoundField DataField="offerName" HeaderText="offerName" 
              SortExpression="offerName" />
      </Columns>
        <EmptyDataTemplate>
            Sorry, there are currently no Offers listed with this Business.
        </EmptyDataTemplate>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        
          SelectCommand="SELECT dbo.business_offers.businessOfferID, dbo.business_offers.businessID, dbo.business_offers.offerID, dbo.offer.offerName FROM dbo.business_offers INNER JOIN dbo.offer ON dbo.business_offers.offerID = dbo.offer.offerID WHERE (dbo.business_offers.businessID = @businessID)">
      <SelectParameters>
          <asp:QueryStringParameter Name="businessID" QueryStringField="bid" 
              Type="Int32" />
      </SelectParameters>
    </asp:SqlDataSource>

      <br />
      <h2>Location:</h2>
    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource4" BorderStyle="None" 
        DataKeyNames="tubeID" GridLines="Horizontal" 
        ShowHeader="False" CellPadding="10" EnableModelValidation="True">
      <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <img alt="Station" src="images/tube.png" style="height: 48px; width: 45px">
                        </img>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
          <ItemTemplate>
              Near
          <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# Eval("tubeID", "station.aspx?TID={0}") %>'
                  Text='<%# Eval("tubeName") %>'></asp:HyperLink>
                  Station
                  </ItemTemplate>
          </asp:TemplateField>
      </Columns>
        <EmptyDataTemplate>
              <br />
              Sorry, there are currently no Stations listed near this Business.<br />
              <br />
          </EmptyDataTemplate>
    </asp:GridView>

    <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        
        
          SelectCommand="SELECT dbo.business_tube.businessID, dbo.tube.tubeName, dbo.tube.tubeID FROM dbo.business_tube INNER JOIN dbo.tube ON dbo.business_tube.tubeID = dbo.tube.tubeID WHERE (dbo.business_tube.businessID = @businessID)">
      <SelectParameters>
          <asp:QueryStringParameter Name="businessID" QueryStringField="bid" />
      </SelectParameters>
    </asp:SqlDataSource>

      <br />

    <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" 
          BorderStyle="None" CellPadding="10" DataKeyNames="businessID" 
          DataSourceID="SqlDataSource2" EnableModelValidation="True" 
          GridLines="None" Height="50px" Width="300px" onload="DetailsView1_Load">
          <Fields>
              <asp:BoundField DataField="info" HeaderText="Information:" 
                  SortExpression="info" Visible="False" />
              <asp:BoundField DataField="address1" HeaderText="Address:" 
                  SortExpression="address1" />
              <asp:BoundField DataField="address2" 
                  SortExpression="address2" />
              <asp:BoundField DataField="road" HeaderText="Road:" 
                  SortExpression="road" />
              <asp:BoundField DataField="town" HeaderText="Town:" 
                  SortExpression="town" />
              <asp:BoundField DataField="postcode" HeaderText="Postcode:" 
                  SortExpression="postcode" />
              <asp:TemplateField HeaderText="Contact Name:" SortExpression="contact_name">
                  <EditItemTemplate>
                      <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("contact_name") %>'></asp:TextBox>
                  </EditItemTemplate>
                  <InsertItemTemplate>
                      <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("contact_name") %>'></asp:TextBox>
                  </InsertItemTemplate>
                  <ItemTemplate>
                      <asp:Label ID="Label1" runat="server" Text='<%# Bind("contact_name") %>'></asp:Label>
                  </ItemTemplate>
              </asp:TemplateField>
              <asp:BoundField DataField="contact_number" HeaderText="Tel:" 
                  SortExpression="contact_number" />
              <asp:BoundField DataField="contact_fax" HeaderText="Fax:" 
                  SortExpression="contact_fax" />
              <asp:BoundField DataField="email" HeaderText="Email:" SortExpression="email" />
              <asp:BoundField DataField="website" HeaderText="Website:" 
                  SortExpression="website" />
          </Fields>
      </asp:DetailsView>

    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        SelectCommand="SELECT * FROM [business] WHERE ([businessID] = @businessID)" 
          OldValuesParameterFormatString="original_{0}">
      <SelectParameters>
          <asp:QueryStringParameter Name="businessID" QueryStringField="bid" 
              Type="Int32" />
      </SelectParameters>
    </asp:SqlDataSource>
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