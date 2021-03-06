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
<title>Discounts - NHS - Counties</title>
<% Response.WriteFile("includes/head.aspx"); %>
</head>
<body onLoad="runSlideShow()" bgcolor="#00a4f8">
<form id="form1" runat="server">
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
    <h2>County List</h2>
    <br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataKeyNames="countyID" DataSourceID="SqlDataSource1" AllowPaging="True" 
        AllowSorting="True" Width="630px" PageSize="35" BorderStyle="None" 
        GridLines="Horizontal">
      <Columns>
      <asp:HyperLinkField DataNavigateUrlFields="countyID, countyName" DataNavigateUrlFormatString="county.aspx?HCID={0}&countyName={1}" Text="County Page" />
      <asp:BoundField DataField="countyID" HeaderText="countyID" InsertVisible="False" 
                    ReadOnly="True" SortExpression="countyID" Visible="False" />
      <asp:BoundField DataField="countyName" HeaderText="Counties" 
                    SortExpression="countyName" />
      </Columns>
      <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
      <HeaderStyle BackColor="#66CCFF" />
      <PagerStyle BackColor="#99CCFF" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            SelectCommand="SELECT * FROM [county]"></asp:SqlDataSource>
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