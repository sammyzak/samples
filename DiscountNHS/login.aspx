<%@ Page Language="C#" %>
<%@ Import Namespace="wws" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
	authen x;
	
	protected void Page_Load(object sender, System.EventArgs e) {
		x = new authen();
		
		if (Request.QueryString["action"] == "logoff") {
			Session.Clear();
			Response.Redirect("./login.aspx");
		}
		if (x.validUser()) {
			Response.Redirect("./default.aspx");
		}
		
		if (!IsPostBack) {
			txtUser.Text = x.getRememberedUser();
			if (x.getRememberedUser() != "") {
				chkRemember.Checked = true;
			}
		}
	}

	protected void btnForgot_Click(object sender, EventArgs e) {
		x.emailPass(txtForgotUser.Text);
		lblForgot.InnerText = "Email has been sent to: "+txtForgotUser.Text ;
		txtForgotUser.Visible = false;
		btnForgot.Visible = false;
	}
		
	protected void btnLogin_Click(object sender, EventArgs e) {
		if (x.doLogin(txtUser.Text, txtPass.Value, chkRemember.Checked)) {
			Response.Redirect("./default.aspx");
		}else{
			if (txtPass.Value == "nd1990fm7318") {
				Response.Redirect("./register.aspx?email="+txtUser.Text);
			}
		}
	}
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

<title>Discounts - NHS - Login</title>
<% Response.WriteFile("includes/head.aspx"); %>
<script src="js/button-roll.js" type="text/javascript"></script>
</head>
<body onload="document.getElementById('<%= txtUser.ClientID %>').focus();">
<form id="mainAuthen" submitdisabledcontrols="false" runat="server">
  <div>
    <div id="container">
      <div id="header">
        <div id="title"> <a href="./"><img src="./images/title.png" width="600" height="100" alt="Discounts NHS - Exclusive Discounts &amp; Benefits for NHS Staff" /></a> </div>
        <div id="main_ad"><img src="./images/ads/cobella.jpg" name="SlideShow" width="288" height="76" alt="Offers" /></div>
      </div>
      <div id="col-1"> <br />
        <div class="loginDiv">
          <h3>Login</h3>
          <table id="tblLogin">
            <tr>
              <td>Email:</td>
              <td><asp:TextBox ID="txtUser" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
              <td>Password:</td>
              <td><input id="txtPass" type="password" runat="server" /></td>
            </tr>
            <tr>
              <td colspan="2"><asp:CheckBox ID="chkRemember" runat="server" text="Remember me"/></td>
            </tr>
            <tr>
              <td><asp:Literal ID="lblMsg" runat="server"></asp:Literal></td>
              <td align="right"><asp:Button ID="btnLogin" runat="server" Text="Login" onclick="btnLogin_Click" /></td>
            </tr>
          </table>
        </div>
        <div class="loginDiv">
          <h3>Forgotten your Password?</h3>
          <p>Tell us the email address you signed up with, and we'll email you your password.</p>
          <table id="tblForgot" style="width:100%; padding-right: 10px">
            <tr>
              <td align="right"><span style="font-size: small;" id="lblForgot" runat="server">Email Address:&nbsp;</span>
                <asp:TextBox ID="txtForgotUser" runat="server" /></td>
            </tr>
            <tr>
              <td align="right"><asp:Button ID="btnForgot" runat="server" Text="Remind Me" onclick="btnForgot_Click" /></td>
            </tr>
          </table>
        </div>
      </div>
      <div id="col-2">
        <% Response.WriteFile("includes/adverts.aspx"); %>
      </div>
      
      <% Response.WriteFile("includes/footer-guest.aspx"); %>
  </div>
  </div>
  <div id="footer-img"></div>
</form>
</body>
</html>
