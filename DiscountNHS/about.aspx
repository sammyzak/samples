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
<title>Discounts - NHS - About Us</title>
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
        <h2>About Us</h2>
        <p>first medical was launched solely to enable NHS staff and their families to obtain preferential rates from local and national businesses who value the custom of Europe's largest single employer. The NHS employs approximately 1.7 million people. This also invariably, makes it the largest local employer. first medical works in conjunction with the NHS Trust enhancing the Improving Working Life initiatives for recruitment and retention of new and existing staff. The NHS staff and their families are able to make savings of in excess of &pound;3,000 per year by using the participating businesses who are offering the NHS staff and their families substantial discounts normally not available to the general public. The discount offered can be obtained by simply presenting the first medical NHS Gold Privilege Card at establishments displaying the first medical Gold Privilege Window Sticker. No other form of identification is deemed valid. NHS Employees can obtain their first medical NHS Gold Privilege Cards for themselves and their families free of charge from the Pay Services Department at their Hospital. If you or your Hospital has any queries, you can contact us at: <a href="admin@DiscountsNHS.com">admin@DiscountsNHS.com</a></p>
        <br />
        <h2>Hotels & Guest Houses</h2>
        <p>The NHS employs approximately 1.7 million staff. Hundreds and thousands of NHS Staff and their families will have the need for a Hotel or Guest House establishments the length and breadth of the country. Be it for a conference, visiting relatives, attending weddings, staff interviews, a shopping spree in the Capital or for leisure breaks.
          
          We are compiling a list of Hotels and Guest Houses who value the custom of Europe's largest single employer and are willing to offer the NHS staff and their families incentives normally not available to the general public. When making a reservation or requesting a service, simply inform them you are a first medical NHS Gold Privilege Card holder to obtain the allocated discount.
          
          If you would like to recommend a Hotel or a Guest House where you have had an enjoyable stay and feel they should be included in DiscountsNHS website Directory, then simply let us have the name of the establishment by e-mail to: <a href="admin@DiscountsNHS.com">admin@DiscountsNHS.com</a>. Please leave your contact details, including your telephone number, an e-mail address and the name of the Trust you are currently working at. All the recommendations submitted will go into ongoing Prize Draws. Please look in your Trust Newsletter for winners. first medical will pay up to &pound;100 towards your stay at a Hotel or Guest House of your choice.</p>
        <br />
        <h2>Careers</h2>
        <p>first medical operate the National Staff Benefit Programme for the NHS in the UK. We negotiate discounts for NHS Staff from local and national companies. Thus enabling the NHS Staff to make savings of thousands of pounds throughout the year. We are looking to recruit experienced Sales Managers and Sales Consultants across London who feels they can make a difference. If you are presentable, articulate, enthusiastic and are looking for a long term career working in conjunction with the largest single employer in Europe then don't hesitate to e-mail your CV to: <a href="careers@DiscountsNHS.com">careers@DiscountsNHS.com</a> for vacancies in your area.
          
          You will be required to negotiate discounts on fully qualified appointments. Full training and support is provided for the right applicants.
          
          We offer an excellent financial package and look forward to hearing from you.</p>
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
