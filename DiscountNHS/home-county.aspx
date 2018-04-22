<%@ Page Language="C#" Debug="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
	protected void Page_Load(object sender, System.EventArgs e) {
		wws.authen.logoutIfNotValid();
	}
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>Discounts - NHS - Home Counties Map</title>
<% Response.WriteFile("includes/head.aspx"); %>
<%= wws.authen.isAdmin() %>
<% Response.WriteFile("includes/rolling-ads.aspx"); %>
</head>
<body onLoad="runSlideShow()" bgcolor="#00a4f8">
<form id="form1" runat="server">
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
    <div id="map">
      <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" 
            codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,28,0" 
            width="640" height="400">
        <param name="movie" value="HomeCounty.swf" />
        <param name="quality" value="high" />
        <param name="wmode" value="transparent" />
        <embed src="HomeCounty.swf" quality="high" allowfullscreen="true" wmode="transparent" pluginspage="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash" type="application/x-shockwave-flash" width="640" height="400"></embed>
      </object>
    </div>

        <br />

        <asp:DataList ID="DataList1" runat="server" DataKeyField="countyID" 
            DataSourceID="SqlDataSource1" RepeatColumns="3" CellPadding="20">
            <ItemTemplate>
                <asp:HyperLink ID="HyperLink1" runat="server" 
                    NavigateUrl='<%# Eval("countyID", "county.aspx?HCID={0}") %>' 
                    Text='<%# Eval("countyName") %>'></asp:HyperLink>
            </ItemTemplate>
        </asp:DataList>

        <br />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            SelectCommand="SELECT * FROM [county] ORDER BY [countyName]"></asp:SqlDataSource>

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
