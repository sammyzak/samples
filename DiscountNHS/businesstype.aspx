<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
  
    protected void Page_Load(object sender, EventArgs e)
    {
		wws.authen.logoutIfNotValid();
        string btid = Request.QueryString["BTID"];
        string typename = Request.QueryString["businessTypeName"];
        
        DataBind();
         
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<%= wws.authen.isAdmin() %>
<% Response.WriteFile("includes/rolling-ads.aspx"); %>
<title>Discounts - NHS - Business Types</title>
<% Response.WriteFile("includes/head.aspx"); %>
</head>
<body onLoad="runSlideShow()" bgcolor="#00a4f8">
<form id="form1" runat="server">
  <div>
  <div id="container">
  <% Response.WriteFile("includes/account.aspx"); %>
  <div id="header">
    <div id="title">
      <a href="./"><img src="./images/title.png" width="600" height="100" alt="Discounts NHS - Exclusive Discounts &amp; Benefits for NHS Staff "></a>
    </div>
    <div id="main_ad"><img src="./images/ads/cobella.jpg" name="SlideShow" width="288" height="76" alt=""></div>
  </div>
  <% Response.WriteFile("includes/nav.aspx"); %>
  <div id="search">
      <asp:TextBox ID="SearchBox" runat="server"></asp:TextBox>
  </div>
  <div id="col-1">
  <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        BorderStyle="None" DataKeyNames="businessTypeID" DataSourceID="SqlDataSource1" 
        GridLines="None" ShowHeader="False" PageSize="1" EnableModelValidation="True">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Image ID="Image1" runat="server" Height="100px" 
                            ImageUrl='<%# Eval("businessTypeName", "./images/icons/{0}.jpg") %>' 
                            Width="100px" />
                    </ItemTemplate>
                </asp:TemplateField>
            <asp:BoundField DataField="businessTypeID" HeaderText="businessTypeID" InsertVisible="False" 
                ReadOnly="True" SortExpression="businessTypeID" Visible="False" />
                <asp:TemplateField HeaderText="businessTypeName" 
                    SortExpression="businessTypeName">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" 
                            Text='<%# Bind("businessTypeName") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("businessTypeName") %>'></asp:Label>
                        Businesses:
                    </ItemTemplate>
                    <ItemStyle Font-Bold="True" Font-Names="Arial" Font-Size="16pt" 
                        ForeColor="#05004C" />
                </asp:TemplateField>
            </Columns>
          </asp:GridView>

      <br />

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        SelectCommand="SELECT * FROM [businessType] WHERE ([businessTypeID] = @businessTypeID)">
      <SelectParameters>
          <asp:QueryStringParameter Name="businessTypeID" QueryStringField="btid" 
              Type="Int32" />
      </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource2" BorderStyle="None" 
        DataKeyNames="businessTypeID" GridLines="Horizontal" 
        ShowHeader="False" CellPadding="10" EnableModelValidation="True" 
          style="margin-top: 0px">
      <Columns>
          <asp:TemplateField>
              <ItemTemplate>
                  <asp:Image ID="Image1" runat="server" Height="15px" 
                      ImageUrl='./images/buildings.png' 
                      Width="15px" />
              </ItemTemplate>
          </asp:TemplateField>
      <asp:BoundField DataField="businessTypeID" HeaderText="businessTypeID" 
                SortExpression="businessTypeID" InsertVisible="False" ReadOnly="True" 
              Visible="False" />
          <asp:BoundField DataField="businessTypeName" HeaderText="businessTypeName" 
              SortExpression="businessTypeName" Visible="False" />
      <asp:BoundField DataField="businessID" HeaderText="businessID" 
                SortExpression="businessID" Visible="False" />
      <asp:BoundField DataField="businessName" HeaderText="businessName" 
                SortExpression="businessName" Visible="False" />
          <asp:TemplateField>
          <ItemTemplate>
          <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# Eval("businessID", "business.aspx?BID={0}") %>'
                  Text='<%# Eval("businessName") %>'></asp:HyperLink>
                  </ItemTemplate>
          </asp:TemplateField>
      </Columns>
        <EmptyDataTemplate>
              Sorry, there are currentley no Businesses near this Station.<br />
              <br />
          </EmptyDataTemplate>
    </asp:GridView>
    <br />
    <h3>Know a business in this area that you would like discounts from?</h3>
              <p>Or do you own a business in this area and would like it listed?</p>
              <p>Refer a business here:</p>

              <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="./refer.aspx" Text="Business Referral"></asp:HyperLink>
    <br />
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        
        
        
          SelectCommand="SELECT dbo.businessType.businessTypeID, dbo.business_businessType.businessID, dbo.business.businessName, dbo.businessType.businessTypeName FROM dbo.businessType INNER JOIN dbo.business_businessType ON dbo.businessType.businessTypeID = dbo.business_businessType.businessTypeID INNER JOIN dbo.business ON dbo.business_businessType.businessID = dbo.business.businessID WHERE (dbo.businessType.businessTypeID = @businessTypeID)">
      <SelectParameters>
          <asp:QueryStringParameter Name="businessTypeID" QueryStringField="btid" />
      </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <br />
    <br />
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
