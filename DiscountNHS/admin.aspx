<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
	protected void Page_Load(object sender, System.EventArgs e) {
		wws.authen.logoutIfNotValid();
		wws.authen.redirIfNotAdmin();
	}
	
	protected void btnUpdatePass_Click(object sender, EventArgs e) {
		//DUPLICATE OF THE UPDATEPASS SCRIPT IN USER.ASPX
		switch (wws.authen.changePass(txtOldPass.Value, txtNewPass.Value)) {
		case -1:
			lblStatus.Text = "There was a unexpected error";
			break;
		case 0:
			lblStatus.Text = "Current password entered was incorrect";
			break;
		case 1:
			lblStatus.Text = "Your password has been changed";
			break;
		default:
			break;
		}
	}
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<%= wws.authen.isAdmin() %>
<title>Discounts - NHS - Admin Control</title>
<% Response.WriteFile("includes/head.aspx"); %>
</head>
<body>
<form id="form1" runat="server">
  <div>
    <div id="container">
    <% Response.WriteFile("includes/account.aspx"); %>
      <div id="header">
        <div id="title"> <a href="./"><img src="./images/title.png" width="600" height="100" alt="Discounts NHS - Exclusive Discounts &amp; Benefits for NHS Staff "></a> </div>
      </div>
      <% Response.WriteFile("includes/nav.aspx"); %>
      <script language="javascript">
					/*VALIDATE THE PASSWORD FIELDS*/
					/// DUPLICATE OF THE VALIDATION IN USER.ASPX
					var txtOldPass = false;
					var txtNewPass = false;

					function validate() {
						if (txtOldPass && txtNewPass) {
							$('#<%= btnUpdatePass.ClientID %>').removeAttr("disabled");
						} else {
							$('#<%= btnUpdatePass.ClientID %>').attr("disabled", "disabled");
						}
					}

					$(document).ready(function () {
						$('#<%= txtOldPass.ClientID %>').bind("change keyup", function () {
							txtOldPass = ($('#<%= txtOldPass.ClientID %>').val() != "");
							validate();
						});

						$('#<%= txtNewPass.ClientID %>, #<%= txtAgainPass.ClientID %>').bind("change keyup", function () {
							var nPass = $('#<%= txtNewPass.ClientID %>').val();
							var aPass = $('#<%= txtAgainPass.ClientID %>').val();
							txtNewPass = (nPass != "" && aPass != "" && (aPass == nPass));
							validate();
						});
					});
				</script>
      <div id="search">
          <asp:TextBox ID="SearchBox" runat="server" />
      </div>
      <% Response.WriteFile("includes/nav-admin.aspx"); %>
      <div id="col-1">
        <h2>Change Password:</h2>
        <table>
          <tr>
            <td>Old Password:</td>
            <td><input type="password" ID="txtOldPass" runat="server" /></td>
          </tr>
          <tr>
            <td>New Password:</td>
            <td><input type="password"  ID="txtNewPass" runat="server" /></td>
          </tr>
          <tr>
            <td>Repeat Password:</td>
            <td><input type="password"  ID="txtAgainPass" runat="server" />
              <span id=""></span></td>
          </tr>
          <tr>
            <td colspan="2" align="right"><span class="errMsg">
              <asp:Literal ID="lblStatus" runat="server" />
              </span></td>
          </tr>
          <tr>
            <td colspan="2" align="right"><asp:Button ID="btnUpdatePass" Enabled="false" runat="server" Text="Update" onclick="btnUpdatePass_Click" /></td>
          </tr>
        </table>
      </div>
      
      <% Response.WriteFile("includes/footer.aspx"); %>
      
    </div>
<div id="footer-img"></div>  
</form>
</body>
</html>