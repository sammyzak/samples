<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
  
    protected void Page_Load(object sender, EventArgs e)
    {
		wws.authen.logoutIfNotValid();
        string hcid = Request.QueryString["HCID"];
        string countyname = Request.QueryString["countyName"];

        string businessType = Request.QueryString["businessTypeName"];
        
        DataBind();  
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<%= wws.authen.isAdmin() %>
<% Response.WriteFile("includes/rolling-ads.aspx"); %>
<title>Discounts - NHS - County Business Types</title>
<% Response.WriteFile("includes/head.aspx"); %>
</head>
<body onLoad="runSlideShow()" bgcolor="#00a4f8">
<form id="form1" runat="server">
  <div>
  <div id="container">
  <% Response.WriteFile("includes/account.aspx"); %>
  <div id="header">
    <div id="title"> <a href="./"><img src="./images/title.png" width="600" height="100" alt="Discounts NHS - Exclusive Discounts &amp; Benefits for NHS Staff "></a>
      </h1>
    </div>
    <div id="main_ad"><img src="./images/ads/cobella.jpg" name="SlideShow" width="288" height="76" alt=""></div>
  </div>
  <% Response.WriteFile("includes/nav.aspx"); %>
  <div id="search">
      <asp:TextBox ID="SearchBox" runat="server"></asp:TextBox>
  </div>
  <div id="col-1">
    <table>
      <td><h2>County:</h2></td>
        <td><asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        BorderStyle="None" DataKeyNames="countyID" DataSourceID="SqlDataSource1" 
        GridLines="None" ShowHeader="False" PageSize="1">
            <Columns>
            <asp:BoundField DataField="countyID" HeaderText="countyID" InsertVisible="False" 
                ReadOnly="True" SortExpression="countyID" Visible="False" />
            <asp:BoundField DataField="countyName" HeaderText="countyName" 
                SortExpression="countyName" />
            </Columns>
          </asp:GridView></td>
        <td><asp:TextBox ID="TextBox1" runat="server" 
        Text='<%# Request.QueryString["hcid"] %>' Visible="False"></asp:TextBox></td>
    </table>
    
    &nbsp;<br />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        SelectCommand="SELECT * FROM [county] WHERE ([countyID] = @countyID)">
      <SelectParameters>
        <asp:ControlParameter ControlID="TextBox1" Name="countyID" PropertyName="Text" 
                Type="Int32" />
      </SelectParameters>
    </asp:SqlDataSource>


      <br />


     <table>
      <td><h2>Business Type:</h2></td>
        <td>
            <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" 
                DataKeyNames="businessTypeID" DataSourceID="SqlDataSource2" 
                EnableModelValidation="True" BorderStyle="None" GridLines="None" 
                ShowHeader="False">
                <Columns>
                    <asp:BoundField DataField="businessTypeID" HeaderText="businessTypeID" 
                        InsertVisible="False" ReadOnly="True" SortExpression="businessTypeID" 
                        Visible="False" />
                    <asp:BoundField DataField="businessTypeName" HeaderText="businessTypeName" 
                        SortExpression="businessTypeName" />
                </Columns>
            </asp:GridView>
         </td>
        <td><asp:TextBox ID="TextBox2" runat="server" 
        Text='<%# Request.QueryString["businessType"] %>' Visible="False"></asp:TextBox></td>
    </table>
    
    &nbsp;<br />
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        
          
          SelectCommand="SELECT * FROM [businessType] WHERE ([businessTypeID] = @businessTypeID)">
      <SelectParameters>
          <asp:QueryStringParameter Name="businessTypeID" QueryStringField="btid" 
              Type="Int32" />
      </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <h2>Business of this Type within this County:</h2>
    <br />
      <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" 
          DataSourceID="SqlDataSource3" EnableModelValidation="True" 
          BorderStyle="None" CellPadding="10" GridLines="Horizontal" ShowHeader="False">
          <Columns>
              <asp:BoundField DataField="countyID" HeaderText="countyID" 
                  InsertVisible="False" ReadOnly="True" SortExpression="countyID" 
                  Visible="False" />
              <asp:BoundField DataField="countyBusinessID" HeaderText="countyBusinessID" 
                  InsertVisible="False" ReadOnly="True" SortExpression="countyBusinessID" 
                  Visible="False" />
              <asp:BoundField DataField="businessID" HeaderText="businessID" 
                  SortExpression="businessID" Visible="False" />
              <asp:BoundField DataField="businessTypeID" HeaderText="businessTypeID" 
                  InsertVisible="False" ReadOnly="True" SortExpression="businessTypeID" 
                  Visible="False" />
              <asp:BoundField DataField="businessName" HeaderText="businessName" 
                  SortExpression="businessName" />
                  <asp:HyperLinkField DataNavigateUrlFields="businessID, businessName" DataNavigateUrlFormatString="business.aspx?BID={0}&businessName={1}" Text="Details" />
          </Columns>
      </asp:GridView>
    <br />
      <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
          ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
          
          SelectCommand="SELECT dbo.county.countyID, dbo.business_county.countyBusinessID, dbo.business_businessType.businessID, dbo.businessType.businessTypeID, dbo.business.businessName FROM dbo.county INNER JOIN dbo.business_county ON dbo.county.countyID = dbo.business_county.countyID INNER JOIN dbo.business ON dbo.business_county.businessID = dbo.business.businessID INNER JOIN dbo.business_businessType INNER JOIN dbo.businessType ON dbo.business_businessType.businessTypeID = dbo.businessType.businessTypeID ON dbo.business.businessID = dbo.business_businessType.businessID WHERE (dbo.county.countyID = @countyID) AND (dbo.businessType.businessTypeID = @businessTypeID)">
          <SelectParameters>
              <asp:QueryStringParameter Name="countyID" QueryStringField="hcid" />
              <asp:QueryStringParameter Name="businessTypeID" QueryStringField="btid" />
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