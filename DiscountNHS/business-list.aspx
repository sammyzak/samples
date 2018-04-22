<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
	protected void Page_Load(object sender, System.EventArgs e) {
		wws.authen.logoutIfNotValid();
	}
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<%= wws.authen.isAdmin() %>
<% Response.WriteFile("includes/rolling-ads.aspx"); %>
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
      <div id="content">
        <h2>Business List</h2>
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataKeyNames="businessID" DataSourceID="SqlDataSource1" 
        AllowPaging="True" AllowSorting="True" Width="960px" BorderStyle="None" 
              GridLines="Horizontal" EnableModelValidation="True">
          <Columns>
          <asp:HyperLinkField DataNavigateUrlFields="businessID, businessName" DataNavigateUrlFormatString="business.aspx?BID={0}&businessName={1}" Text="Business Page" />
          <asp:BoundField DataField="businessID" HeaderText="businessID" 
                    InsertVisible="False" ReadOnly="True" SortExpression="businessID" 
            Visible="False" />
          <asp:BoundField DataField="businessName" HeaderText="Business" 
                    SortExpression="businessName" />
          <asp:BoundField DataField="contact_name" HeaderText="contact_name" 
                    SortExpression="contact_name" Visible="False" />
          <asp:BoundField DataField="contact_number" HeaderText="contact_number" 
                    SortExpression="contact_number" Visible="False" />
          <asp:BoundField DataField="website" HeaderText="Website" 
                    SortExpression="website" />
          <asp:BoundField DataField="email" HeaderText="Email" SortExpression="email" />
          </Columns>
          <HeaderStyle BackColor="#66CCFF" />
          <PagerStyle BackColor="#99CCFF" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            SelectCommand="SELECT * FROM [business] WHERE ([isHidden] IS NULL)"></asp:SqlDataSource>
      </div>
<% Response.WriteFile("includes/footer.aspx"); %>
</div>
</div>
<div id="footer-img"></div>
</form>
</body>
</html>