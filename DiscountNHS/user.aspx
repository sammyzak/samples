<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
    
	protected void Page_Load(object sender, System.EventArgs e) 
    {
		wws.authen.logoutIfNotValid();
	}

	protected void btnUpdatePass_Click(object sender, EventArgs e) {
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

    protected void Button1_Click(object sender, EventArgs e)
    {
        TextBox Email = FindControl("newmail") as TextBox;

        SqlDataSource2.UpdateParameters["email"].DefaultValue = newmail.Text;

        SqlDataSource2.Update();

        newmail.Text = String.Empty;

    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<%= wws.authen.isAdmin() %>
<% Response.WriteFile("includes/rolling-ads.aspx"); %>
<title>Discounts - NHS - User Admin</title>
<% Response.WriteFile("includes/head.aspx"); %>
    </head>
<body onLoad="runSlideShow()" bgcolor="#00a4f8">
<form id="form1" runat="server">
  <div id="container">
  <% Response.WriteFile("includes/account.aspx"); %>
    <div id="header">
      <div id="title"> <a href="./"><img alt="header logo" src="./images/title.png" width="600" height="100" alt="Discounts NHS - Exclusive Discounts &amp; Benefits for NHS Staff "></a> </div>
      <div id="main_ad"> <img alt="adverts" src="./images/ads/cobella.jpg" name="SlideShow" width="288" height="76" alt=""> </div>
    </div>
    <% Response.WriteFile("includes/nav.aspx"); %>
    <script language="javascript">
					/*VALIDATE THE PASSWORD FIELDS*/
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
          <td colspan="2" align="left"><asp:Button ID="btnUpdatePass" Enabled="false" runat="server" Text="Update" onclick="btnUpdatePass_Click" /></td>
        </tr>
      </table>
        <br />
        <br />
      <h2>Change Email:</h2>
      <br />
      <table>
      <tr>
      <td>New Email:</td><td><asp:TextBox ID="newmail" runat="server"></asp:TextBox></td>
      </tr>
      <tr>
      <td>Repeat Email:</td><td><asp:TextBox ID="emailrepeat" runat="server"></asp:TextBox></td>
      </tr>
      <tr>
      <td><asp:CompareValidator ID="CompareValidator1" runat="server" 
              ErrorMessage="Values don't Match" ControlToCompare="newmail" 
              ControlToValidate="emailrepeat"></asp:CompareValidator></td>
      </tr>
      <tr>
      <td><asp:Button ID="Button1" runat="server" Text="Update" onclick="Button1_Click" /></td>
      </tr>
      </table>
        
        
        <br />
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            SelectCommand="SELECT [email], [userID] FROM [user] WHERE ([userID] = @userID)">
            <SelectParameters>
                <asp:SessionParameter Name="userID" SessionField="uid" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
  
      <h2>Edit Profile</h2>
        <br />
        <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" 
            BorderStyle="None" CellPadding="5" CellSpacing="5" DataKeyNames="userID" 
            DataSourceID="SqlDataSource1" EnableModelValidation="True" GridLines="None" 
            Height="50px" Width="300px">
            <Fields>
                <asp:BoundField DataField="nhsNumber" HeaderText="NHS No." 
                    SortExpression="nhsNumber" />
                <asp:BoundField DataField="userID" HeaderText="userID" SortExpression="userID" 
                    InsertVisible="False" ReadOnly="True" Visible="False" />
                <asp:BoundField DataField="fname" HeaderText="First" SortExpression="fname" />
                <asp:BoundField DataField="lname" HeaderText="Last" 
                    SortExpression="lname" />
                <asp:BoundField DataField="address1" HeaderText="Address 1" 
                    SortExpression="address1" />
                <asp:BoundField DataField="address2" HeaderText="Address 2" 
                    SortExpression="address2" />
                <asp:BoundField DataField="road" HeaderText="Road" SortExpression="road" />
                <asp:BoundField DataField="town" HeaderText="Town" 
                    SortExpression="town" />
                <asp:BoundField DataField="postcode" HeaderText="Postcode" 
                    SortExpression="postcode" />
                <asp:BoundField DataField="county" HeaderText="County" 
                    SortExpression="county" />
                <asp:CommandField ButtonType="Button" ShowEditButton="True" />
            </Fields>
            <FooterStyle BorderStyle="None" />
        </asp:DetailsView>
        <br />
        <br />
        <br />
      <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"                    
      InsertCommand="INSERT INTO dbo.[user] (fname, lname, address1, address2, road, town, postcode, county, nhsNumber) VALUES (@fname, @lname, @address1, @address2, @road, @town, @postcode, @county, @nhsNumber)" 
      OldValuesParameterFormatString="original_{0}" 
      SelectCommand="SELECT userID, fname, lname, address1, address2, road, town, postcode, county, nhsNumber FROM dbo.[user] WHERE (userID = @userID)" 
      UpdateCommand="UPDATE dbo.[user] SET fname = @fname, lname = @lname, address1 = @address1, address2 = @address2, road = @road, town = @town, postcode = @postcode, county = @county, nhsNumber = @nhsNumber WHERE (userID = @original_userID)">
          <InsertParameters>
              <asp:Parameter Name="fname" Type="String" />
              <asp:Parameter Name="lname" Type="String" />
              <asp:Parameter Name="address1" Type="String" />
              <asp:Parameter Name="address2" Type="String" />
              <asp:Parameter Name="road" Type="String" />
              <asp:Parameter Name="town" Type="String" />
              <asp:Parameter Name="postcode" Type="String" />
              <asp:Parameter Name="county" Type="String" />
              <asp:Parameter Name="nhsNumber" Type="String" />
          </InsertParameters>
        <SelectParameters>
          <asp:SessionParameter Name="userID" SessionField="uid" Type="Int32" />
        </SelectParameters>
          <UpdateParameters>
              <asp:Parameter Name="fname" Type="String" />
              <asp:Parameter Name="lname" Type="String" />
              <asp:Parameter Name="address1" Type="String" />
              <asp:Parameter Name="address2" Type="String" />
              <asp:Parameter Name="road" Type="String" />
              <asp:Parameter Name="town" Type="String" />
              <asp:Parameter Name="postcode" Type="String" />
              <asp:Parameter Name="county" Type="String" />
              <asp:Parameter Name="nhsNumber" Type="String" />
              <asp:Parameter Name="original_userID" Type="Int32" />
          </UpdateParameters>
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