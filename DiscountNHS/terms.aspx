<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
	protected void Page_Load(object sender, System.EventArgs e) {
		wws.authen.logoutIfNotValid();
	}
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<% Response.WriteFile("includes/rolling-ads.aspx"); %>
<title>Discounts - NHS - Terms &amp; Conditions</title>
<% Response.WriteFile("includes/head.aspx"); %>
</head>
<body onLoad="runSlideShow()" bgcolor="#00a4f8">
<form id="form1" runat="server">
  <div>
    <div id="container">
      <div id="header">
        <div id="title"> <a href="./"><img src="./images/title.png" width="600" height="100" alt="Discounts NHS - Exclusive Discounts &amp; Benefits for NHS Staff "></a> </div>
        <div id="main_ad"><img src="./images/ads/cobella.jpg" name="SlideShow" width="288" height="76" alt=""></div>
      </div>
      <% Response.WriteFile("includes/nav.aspx"); %>
      <div id="search">
      <asp:TextBox ID="SearchBox" runat="server"></asp:TextBox>
      </div>
      <div id="content">
        <table>
          <td></td>
            <td></td>
          <tr>
            <td></td>
            <td></td>
        </table>
      </div>
      <div id="col-1">
        <h1>TERMS &amp; CONDITIONS</h1>
        <b>1. THE PARTIES TO AGREEMENT</b><br>
        The parties to the Agreement are first medical and the first medical Gold Card holder.<br>
        <br>
        <b>1.1</b> All NHS staff MUST register (ensuring to fill in ALL the fields) to receive their password to avail the Discounts within this Programme. Incorrect registrations submitted will be rejected automatically.<br>
        <br>
        <b>1.2</b> All Gold Card holders MUST register (ensuring to fill in ALL the fields) BEFORE using their Gold Card. If you have not registered please click <a href="login.aspx">here</a> NOW to register. You will receive your password upon verification. Incorrect registrations submitted will be rejected automatically.<br>
        <br>
        <b>2. DEFINITIONS</b><br>
        &quot;Discounts NHS&quot; is the Discount Directory Website for the first medical National Staff Benefit Programme for NHS Staff/fm Gold Card holders. &quot;We&quot;, &quot;Us&quot;, &quot;the Company&quot; means first medical.<br>
        <br>
        &quot;first medical National Staff Benefit Programme&quot; hereinafter referred to as fm National Staff Benefit Programme for NHS Staff.<br>
        <br>
        &quot;Trust&quot; means NHS Trusts participating in the fm National Staff Benefit Programme for NHS Staff.<br>
        <br>
        &quot;Gold Card&quot; means any fm Gold Privilege Card issued by first medical to the participating NHS Trusts and fm Gold Card holders.<br>
        <br>
        &quot;Gold Card holder&quot; means first medical Gold Card holder issued with an fm Gold Privilege Card by the participating NHS Trusts and/or first medical.<br>
        <br>
        &quot;Service Establishments&quot; means Retailer and or other outlets that accept the Gold Card within the fm National Staff Benefit Programme for NHS Staff.<br>
        <Br>
        &quot;Transaction&quot; means any payment made for Goods or Services.<br>
        <br>
        &quot;We&quot;, &quot;Us&quot;, &quot;the Company&quot; means first medical.<br>
        <br>
        &quot;You&quot; means The Gold Card holder issued with an fm Gold Privilege Card under this Agreement by participating NHS Trusts and/or first medical.<br>
        <br>
        <b>3. USING THE GOLD CARD</b><br>
        <b>3.1</b> You must sign the Gold Card in ink as soon as you receive it. By signing the Gold Card you hereby agree to comply by all the Terms and Conditions of the fm National Staff Benefit Programme for NHS Staff.<br>
        <br>
        <b>3.2</b> Although you use the Gold Card, all Gold Cards will at all times remain our property. This means you must give the Gold Card back if we ask you to do so. A Service Establishment, or any person acting on our behalf can also keep the Gold Card on our behalf.<br>
        <br>
        <b>3.3</b> You must not use the Gold Card if it has been withdrawn or cancelled.<br>
        <br>
        <b>3.4</b> All the Service Establishments are voluntarily offering the Gold Card holders incentives within the fm National Staff Benefit Programme for NHS Staff.<br>
        <br>
        <b>3.5</b> At all times, it is your sole responsibility as an employee of the NHS Trust or an fm Gold Card holder to evaluate the nature of the incentives available to you, prior to concluding any Transaction with the Service Establishments in the fm National Staff Benefit Programme for NHS Staff.<br>
        <br>
        <b>3.6</b> You must register with <a href="www.discounts-nhs.co.uk"></a> if you require additional fm Gold Cards for your immediate family. A limited number of additional fm Gold Privilege Cards will be issued upon verification of the registration details. We specifically reserve the right, at our discretion, the circumstances in which these fm Gold Privilege Cards are issued.<br>
        <br>
        <b>4. THE ACCOUNT</b><br>
        <b>4.1</b> You must not allow anyone else to use the Gold Card.<br>
        <br>
        <b>4.2</b> You must tell us immediately about any change of address by e-mailing to: <a href="mailto:admin@DiscountsNHS.co.uk"></a>. You must also tell us if your phone number changes.<br>
        <br>
        <b>5. THE FEES</b><br>
        <b>5.1</b> No annual fee is charged for this Service. The Gold Card is issued free of charge by the participating NHS Trusts and or first medical.<br>
        <br>
        <b>5.2</b> If your Gold Card is lost or stolen or misused without your permission you may have to pay up to &pound;5 for a replacement Gold Card. If it is misused with your permission, your Gold Card and any additional Gold Cards requested will be automatically cancelled.<br>
        <br>
        <b>6. ENDING THIS AGREEMENT</b><br>
        <b>6.1</b> You can end this Agreement at any time by returning to us all Gold Cards (cut in half) you have received either from participating NHS Trusts and/or first medical with a letter addressed to First Medical, DiscountsNHS.com, 2nd Floor, 145-157 St John Street, London EC1V 4PY via Recorded Delivery. We will only end this Agreement when we receive all Gold Cards received by you.<br>
        <br>
        <b>6.2</b> We can end this Agreement at any time by giving immediate notice to you but unless there are exceptional circumstances we will give you 30 days notice. <br>
        <br>
        <b>6.3</b> If we have good reason we may also without telling you first and without incurring liability for loss or damage you or an additional Gold Card holder may suffer as a result, stop you from using the Gold Card or refuse approval of a Transaction.<br>
        <br>
        <b>7. PROTECTING YOUR GOLD CARD</b><br>
        <b>7.1</b> You must take proper care and ensure the Gold Card is safe to stop anyone else using it.<br>
        <br>
        <b>7.2</b> If you lose the Gold Card, it is stolen or damaged you must:<br>
        &nbsp;&nbsp;&nbsp;(i)  call us immediately. The number is 0870 850 6169.<br>
        &nbsp;&nbsp;&nbsp;(ii) confirm the same by e-mailing to: <a href="mailto:admin@DiscountsNHS.co.uk"></a>.<br>
        <br>
        <b>7.3</b> You must tell us immediately about any change of address by e-mailing to: <a href="mailto:admin@DiscountsNHS.co.uk"></a>. You must tell us if your phone number changes.<br>
        <br>
        <b>8. LIABILITY</b><br>
        <b>8.1</b> first medical is not responsible for any non acceptance of the Gold Card or the manner in which the Gold card is accepted or not accepted.<br>
        <br>
        <b>8.2</b> first medical is not responsible nor liable either in contract, tort (including negligence) for any failure to carry out any of first medical's obligations under this Agreement if this is because of industrial dispute, data processing failure, force majeure, systems failure or any other event outside first medicals reasonable control.<br>
        <br>
        <b>8.2 (i)</b> first medical is not responsible nor liable for direct or indirect loss of profits, business or anticipated savings nor for any indirect, special or consequential damages for any destruction of date or arising under this Agreement.<br>
        <br>
        <b>8.3</b> first medical excludes all liability of any kind in respect of the following:<br>
        <br>
        <b>8.3 (i)</b> Any material on the Internet which can be accessed via the website and is not responsible in any way for any goods (including software) or services provided by third parties advertised, sold or otherwise made available by means of the Service or on the Internet;<br>
        <br>
        <b>8.3.2</b> The accuracy, completeness or suitability for any purpose of any Content.<br>
        <br>
        <b>8.3 (ii)</b> first medical is not responsible nor liable for is not liable either in contract, tort (including negligence) or otherwise for the acts or omissions of other providers of goods or services or for faults in those goods or services.<br>
        <br>
        <b>9. COMPLAINTS PROCEDURE</b><br>
        <b>9.1</b> Should any disputes arise in connection with the first medical National Staff Benefit Programme for NHS Staff, they should only be resolved between the parties direct or else referred to:<br>
        <br>
        First Medical,<br>
        Discounts-NHS.co.uk<br>
        2nd Floor,<br>
        145-157 St John Street<br>
        London EC1V 4PY<br>
        <br>
        <b>9.2</b> Under no circumstances should the employees or other fm Gold Card holders contact the participating NHS Trusts.<br>
        <br>
        <b>10. DISCLAIMER</b><br>
        <b>10.1</b> 10.1 Information within this Website is provided &quot;as is&quot;, first medical and participating NHS Trusts make no warranties, express or implied as to the correctness of the information presented, and shall not be liable for any inconveniences, losses of revenue, consequential damages of any kind, resulting from the direct or indirect use of this information presented within the Website.<br>
        <br>
        <b>10.2</b> first medical grants the Gold Card holder permission to use the information for personal use only, and such results may not be copied, reused, modified, manipulated or transmitted without the express permission of first medical.<br>
        <br>
        <b>10.3</b> Mention of Companies, businesses, firms, products, organisations or persons within the Website is for information purposes only and constitutes neither an endorsement nor a recommendation. All brands, products, trademarks and service names mentioned within the Website are the property of their respective owners.<br>
        <br>
        <b>10.4</b> first medical and the participating NHS Trusts will not be held responsible for any financial matters incurred by the employees and fm Gold Card holders for whatever reason.<br>
        <br>
        <b>11.0 LEGAL STATEMENT</b><br>
        DiscountsNHS.com has taken every care in the preparation in the content of this site. first medical disclaims all warranties, express or implied, to the fullest extent permitted by law, as to the accuracy of all information contained herein.<br>
        <br>
        first medical is not liable for any loss or damage arising from the use of any information contained on this website. Hypertext links in this site will lead to websites which are not under the control of first medical. Furthermore, first medical accepts no responsibility or liability in respect of the material on any website which is not controlled by first medical.<br>
        <br>
        The site and all the DiscountsNHS.com text/text layout information or Discounts NHS graphics contained on this site belong to first medical in the absence of any indication to the contrary. Copyright and all intellectual property rights in Discounts NHS text/text layout information or Discounts NHS graphics on this site are vested in first medical and all rights are reserved. Mention of Companies, businesses, firms, products, organisations or persons within the site is for information purposes only and constitutes neither an endorsement nor a recommendation. All brands, products, trademarks and service names mentioned within the site are the property of their respective owners. At all times, no part of the text or graphics on the site may be reproduced or transmitted in any form by any means, electronic or mechanical or otherwise, including by recording, photocopying, facsimile transmission, or using any information, storage and retrieval system without the prior written consent of first medical.<br>
        <br>
      </div>
      <div id="col-2">
        <% Response.WriteFile("includes/adverts.aspx"); %>
      </div>
      
      <div id="hidden-footer"></div>
      
  </div>
<% Response.WriteFile("includes/footer.aspx"); %>
</form>
</body>
</html>