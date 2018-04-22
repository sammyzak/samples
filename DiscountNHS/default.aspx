<%@ Page Language="C#" Debug="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
	protected void Page_Load(object sender, System.EventArgs e) {
		wws.authen.logoutIfNotValid();
	}
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>Discounts - NHS</title>
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
      <h2>Welcome to Discounts NHS</h2>
      <p>Working in Partnership with NHS Trusts the DiscountsNHS Directory is brought to you by first medical. first medical is contracted by the participating NHS Trusts to vet, negotiate and secure Exclusive Discounts and Benefits for NHS Staff.</p>
      <p>This unique Programme enables the existing and new NHS staff and their immediate families to make savings of in excess of &pound;3,000 annually, by simply presenting their first medical NHS Gold Privilege Cards to the local and national businesses who are offering substantial incentives normally not available to the general public. The first medical NHS Gold Privilege Cards are issued to all the NHS Staff free of charge by the NHS Trusts.</p>
      <p>You can obtain these FANTASTIC Discounts by simply presenting your NHS ID Card or your first medical NHS Gold Privilege Card. first medical NHS Gold Privilege Cards are available free of charge from the Pay Services Department/HR Department at your Hospital. If you have any queries, please contact us at: <a href="support@DiscountsNHS.com">support@DiscountsNHS.com</a></p>
      <br />
      <h3>Registrations</h3>
      <p>If you have not already registered as per your Welcome Letter enclosed with your first medical NHS Gold Privilege Card, please click here now to register. 
        The basic information you give will help us to replace your first medical Gold Privilege Card if it is lost, contact businesses you have recommended you would like discounts from and forward ongoing promotions and offers free of charge. When registering don't forget to recommend new businesses you would like discounts from and we will approach them accordingly. All your personal details are secure - we will not forward your personal details to third parties.</p>
      <br />
      <h3>Recommendations</h3>
      <p>If you have a favourite restaurant, hairdresser, beauty salon or any other business you frequent regularly, why not recommend it to us. In addition to receiving a discount from your favourite place you will be entered into a Prize Draw. You can recommend as many businesses as you like! Look in your Newsletters for more details about the first medical National Staff Benefit Programme for NHS Staff or contact your HR Department.</p>
      <p>Please enter any recommendations into our Refer Business page here: <a href="refer.aspx">Refer a Business</a></p>
      <p>See <a href="terms.aspx">Terms &amp; Conditions</a> for details.</p>
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
