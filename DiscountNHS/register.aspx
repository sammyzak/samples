<%@ Page Language="C#" Debug="true" %>

<%@ Import Namespace="System" %> <%@ Import Namespace="System.Net.Mail" %> <%@ Import Namespace="System.IO" %> <%@ Import Namespace="System.Web" %> <%@ Import Namespace="System.Web.UI.HtmlControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
	protected void Page_Load(object sender, System.EventArgs e) 
    {
		/*wws.authen.logoutIfNotValid();*/
		emailBox.Text = Request.QueryString["email"];
		fnameBox.Focus();

        newUser.Visible = true;
    }

    protected void registerSubmit_Click(object sender, EventArgs e)
    {
        emailBox.Focus();

        TextBox email = FindControl("emailBox") as TextBox;
        TextBox fname = FindControl("fnameBox") as TextBox;
        TextBox lname = FindControl("lnameBox") as TextBox;
        TextBox address1 = FindControl("address1Box") as TextBox;
        TextBox address2 = FindControl("address2Box") as TextBox;
        TextBox road = FindControl("roadBox") as TextBox;
        TextBox county = FindControl("countyBox") as TextBox;
        TextBox password = FindControl("passBox2") as TextBox;

        SqlDataSource1.InsertParameters["email"].DefaultValue = emailBox.Text;
        SqlDataSource1.InsertParameters["fname"].DefaultValue = fnameBox.Text;
        SqlDataSource1.InsertParameters["lname"].DefaultValue = lnameBox.Text;
        SqlDataSource1.InsertParameters["address1"].DefaultValue = address1Box.Text;
        SqlDataSource1.InsertParameters["address2"].DefaultValue = address2Box.Text;
        SqlDataSource1.InsertParameters["road"].DefaultValue = roadBox.Text;
        SqlDataSource1.InsertParameters["county"].DefaultValue = countyBox.Text;
        SqlDataSource1.InsertParameters["password"].DefaultValue = passBox2.Text;
        
        SqlDataSource1.InsertParameters["isInactive"].DefaultValue = "True";

        SqlDataSource1.Insert();

        emailBox.Text = String.Empty;
        fnameBox.Text = String.Empty;
        lnameBox.Text = String.Empty;
        address1Box.Text = String.Empty;
        address2Box.Text = String.Empty;
        roadBox.Text = String.Empty;
        countyBox.Text = String.Empty;
        passBox1.Text = String.Empty;
        passBox2.Text = String.Empty;

        registerForm.Visible = false;
        
        // send email notification
        if (IsPostBack)
        {
            try
            {
                string output = "";

                MailMessage mail = new MailMessage();

                // Replace with your own host address
                string hostAddress = "localhost";

                // Replaces newlines with br
                string name = Request.Form["emailBox"].ToString();
                name = name.Replace(Environment.NewLine, "<br />");

                output = "<p>First: " + Request.Form["fnameBox"].ToString() + "</p> <p>Last: " + Request.Form["lnameBox"].ToString() + "</p> <p>Address 1: " + Request.Form["address1Box"].ToString() + "</p> <p>Address 2: " + Request.Form["address2Box"].ToString() + "</p> <p>Road: " + Request.Form["roadBox"].ToString() + "</p> <p>County: " + Request.Form["countyBox"].ToString() + "</p>";

                mail.From = new MailAddress("no-reply@discounts-nhs.co.uk");
                mail.To.Add("sammy@zakonline.co.uk");
                mail.Subject = "New User Registered at DiscountsNHS";
                mail.Body = output;

                mail.IsBodyHtml = true;
                SmtpClient smtp = new SmtpClient(hostAddress);
                smtp.Send(mail);

               statusLabel.Text = "Thanks, your account will be active within 48 hours";
               Response.AddHeader("REFRESH", "5;URL=./login.aspx");
            }
            catch (Exception err)
            {
                statusLabel.Text = "There was an exception whilst submitting the form: " + err.ToString() + ".";
            }
        }
       
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>Discounts - NHS - Register</title>
    <% Response.WriteFile("includes/head.aspx"); %><%= wws.authen.isAdmin() %><% Response.WriteFile("includes/rolling-ads.aspx"); %>
</head>
<body onLoad="runSlideShow()" bgcolor="#00a4f8">
<form id="form1" runat="server">
  <div id="container">
    <div id="header">
      <div id="title"> <a href="./"><img src="./images/title.png" width="600" height="100" alt="Discounts NHS - Exclusive Discounts &amp; Benefits for NHS Staff "></a> </div>
      <div id="main_ad"><img src="./images/ads/cobella.jpg" name="SlideShow" width="288" height="76" alt=""></div>
    </div>
    <div id="col-1">
      <h2>Register Form</h2>
      
        <asp:Panel ID="newUser" runat="server" Width="500px">

         <p>We have detected that your are an existing user of the Discount NHS service, we 
             are now providing the ability for users to use unique usernames and passwords to 
             access their accounts.</p>
      
         <p>Complete the form below to create your new account:</p>

        </asp:Panel>
          
          <br />

        <asp:Panel ID="registerForm" runat="server">

        <table cellpadding="5">
        <tr>
        <td><asp:Label ID="Label1" runat="server" Text="Email:"></asp:Label></td>
        <td><asp:TextBox ID="emailBox" runat="server" Width="200px"></asp:TextBox></td>
        <td><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ErrorMessage="Email Address Required" ControlToValidate="emailBox"></asp:RequiredFieldValidator></td>
        </tr>
        <tr>
            <td><asp:Label ID="businessName2" runat="server" Text="First:"></asp:Label></td>
            <td><asp:TextBox ID="fnameBox" runat="server" Width="150px"></asp:TextBox></td>
            <td><asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                    ErrorMessage="First Name Required" ControlToValidate="fnameBox"></asp:RequiredFieldValidator></td>
        </tr>            
        <tr>
            <td><asp:Label ID="businessType" runat="server" Text="Last:"></asp:Label></td>
            <td><asp:TextBox ID="lnameBox" runat="server" Width="150px"></asp:TextBox></td>
            <td><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                    ErrorMessage="Last Name Required" ControlToValidate="lnameBox"></asp:RequiredFieldValidator></td>
        </tr>
        <tr>
            <td><asp:Label ID="address1" runat="server" Text="Address 1:"></asp:Label></td>
            <td><asp:TextBox ID="address1Box" runat="server" Width="200px"></asp:TextBox></td>
            <td><asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                    ErrorMessage="Address Required" ControlToValidate="address1Box"></asp:RequiredFieldValidator></td>
        </tr>
        <tr>
            <td><asp:Label ID="address2" runat="server" Text="Address 2:"></asp:Label></td>
            <td><asp:TextBox ID="address2Box" runat="server" Width="200px"></asp:TextBox></td>
        </tr>
        <tr>
            <td><asp:Label ID="road" runat="server" Text="Road:"></asp:Label></td>
            <td><asp:TextBox ID="roadBox" runat="server" Width="150px"></asp:TextBox></td>
        </tr>
        <tr>
            <td><asp:Label ID="town" runat="server" Text="Town:"></asp:Label></td>
            <td><asp:TextBox ID="townBox" runat="server" Width="150px"></asp:TextBox></td>
        </tr>
        <tr>
            <td><asp:Label ID="postcode" runat="server" Text="Post Code:"></asp:Label></td>
            <td><asp:TextBox ID="postcodeBox" runat="server"></asp:TextBox></td>
            <td><asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" 
                    ErrorMessage="Post Code Required" ControlToValidate="postcodeBox"></asp:RequiredFieldValidator></td>
        </tr>
        <tr>
            <td><asp:Label ID="contactName" runat="server" Text="County:"></asp:Label></td>
            <td><asp:TextBox ID="countyBox" runat="server"></asp:TextBox></td>
        </tr>
        <tr><td></td></tr>
        <tr>
            <td><asp:Label ID="password1" runat="server" Text="Password:"></asp:Label></td>
            <td><asp:TextBox ID="passBox1" runat="server" TextMode="Password" Width="150px"></asp:TextBox></td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" 
                    ControlToValidate="passBox1" ErrorMessage="Password Required"></asp:RequiredFieldValidator>
            </td>
        </tr>

        <tr>
            <td><asp:Label ID="password2" runat="server" Text="Verify Password:"></asp:Label></td>
            <td><asp:TextBox ID="passBox2" runat="server" TextMode="Password" Width="150px"></asp:TextBox></td>
            <td>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" 
                    ControlToValidate="passBox2" ErrorMessage="Verified Password Required"></asp:RequiredFieldValidator>

            </td>
        </tr>
        <tr>
        <td></td><td></td>
        <td><asp:CompareValidator ID="CompareValidator1" runat="server" 
                    ControlToCompare="passBox1" ControlToValidate="passBox2" 
                    ErrorMessage="Passwords do not match"></asp:CompareValidator></td>
        </tr>

        </table>

            <asp:Button ID="registerSubmit" runat="server" Text="Submit" 
                onclick="registerSubmit_Click" />
        
        </asp:Panel>
      
        <br />
        <asp:Label ID="statusLabel" runat="server"></asp:Label>
      
        <br />
      <br />
      <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                    SelectCommand="SELECT * FROM [user]" 
            ConflictDetection="CompareAllValues" 
            DeleteCommand="DELETE FROM [user] WHERE [userID] = @original_userID AND (([fname] = @original_fname) OR ([fname] IS NULL AND @original_fname IS NULL)) AND (([lname] = @original_lname) OR ([lname] IS NULL AND @original_lname IS NULL)) AND (([email] = @original_email) OR ([email] IS NULL AND @original_email IS NULL)) AND (([address1] = @original_address1) OR ([address1] IS NULL AND @original_address1 IS NULL)) AND (([address2] = @original_address2) OR ([address2] IS NULL AND @original_address2 IS NULL)) AND (([road] = @original_road) OR ([road] IS NULL AND @original_road IS NULL)) AND (([town] = @original_town) OR ([town] IS NULL AND @original_town IS NULL)) AND (([postcode] = @original_postcode) OR ([postcode] IS NULL AND @original_postcode IS NULL)) AND (([county] = @original_county) OR ([county] IS NULL AND @original_county IS NULL)) AND (([nhsNumber] = @original_nhsNumber) OR ([nhsNumber] IS NULL AND @original_nhsNumber IS NULL)) AND (([password] = @original_password) OR ([password] IS NULL AND @original_password IS NULL)) AND (([isAdmin] = @original_isAdmin) OR ([isAdmin] IS NULL AND @original_isAdmin IS NULL)) AND (([isInactive] = @original_isInactive) OR ([isInactive] IS NULL AND @original_isInactive IS NULL))" 
            InsertCommand="INSERT INTO [user] ([fname], [lname], [email], [address1], [address2], [road], [town], [postcode], [county], [nhsNumber], [password], [isAdmin], [isInactive]) VALUES (@fname, @lname, @email, @address1, @address2, @road, @town, @postcode, @county, @nhsNumber, @password, @isAdmin, @isInactive)" 
            OldValuesParameterFormatString="original_{0}" 
            
            UpdateCommand="UPDATE [user] SET [fname] = @fname, [lname] = @lname, [email] = @email, [address1] = @address1, [address2] = @address2, [road] = @road, [town] = @town, [postcode] = @postcode, [county] = @county, [nhsNumber] = @nhsNumber, [password] = @password, [isAdmin] = @isAdmin, [isInactive] = @isInactive WHERE [userID] = @original_userID AND (([fname] = @original_fname) OR ([fname] IS NULL AND @original_fname IS NULL)) AND (([lname] = @original_lname) OR ([lname] IS NULL AND @original_lname IS NULL)) AND (([email] = @original_email) OR ([email] IS NULL AND @original_email IS NULL)) AND (([address1] = @original_address1) OR ([address1] IS NULL AND @original_address1 IS NULL)) AND (([address2] = @original_address2) OR ([address2] IS NULL AND @original_address2 IS NULL)) AND (([road] = @original_road) OR ([road] IS NULL AND @original_road IS NULL)) AND (([town] = @original_town) OR ([town] IS NULL AND @original_town IS NULL)) AND (([postcode] = @original_postcode) OR ([postcode] IS NULL AND @original_postcode IS NULL)) AND (([county] = @original_county) OR ([county] IS NULL AND @original_county IS NULL)) AND (([nhsNumber] = @original_nhsNumber) OR ([nhsNumber] IS NULL AND @original_nhsNumber IS NULL)) AND (([password] = @original_password) OR ([password] IS NULL AND @original_password IS NULL)) AND (([isAdmin] = @original_isAdmin) OR ([isAdmin] IS NULL AND @original_isAdmin IS NULL)) AND (([isInactive] = @original_isInactive) OR ([isInactive] IS NULL AND @original_isInactive IS NULL))">
          <DeleteParameters>
              <asp:Parameter Name="original_userID" Type="Int32" />
              <asp:Parameter Name="original_fname" Type="String" />
              <asp:Parameter Name="original_lname" Type="String" />
              <asp:Parameter Name="original_email" Type="String" />
              <asp:Parameter Name="original_address1" Type="String" />
              <asp:Parameter Name="original_address2" Type="String" />
              <asp:Parameter Name="original_road" Type="String" />
              <asp:Parameter Name="original_town" Type="String" />
              <asp:Parameter Name="original_postcode" Type="String" />
              <asp:Parameter Name="original_county" Type="String" />
              <asp:Parameter Name="original_nhsNumber" Type="String" />
              <asp:Parameter Name="original_password" Type="String" />
              <asp:Parameter Name="original_isAdmin" Type="Boolean" />
              <asp:Parameter Name="original_isInactive" Type="Boolean" />
          </DeleteParameters>
          <InsertParameters>
              <asp:Parameter Name="fname" Type="String" />
              <asp:Parameter Name="lname" Type="String" />
              <asp:Parameter Name="email" Type="String" />
              <asp:Parameter Name="address1" Type="String" />
              <asp:Parameter Name="address2" Type="String" />
              <asp:Parameter Name="road" Type="String" />
              <asp:Parameter Name="town" Type="String" />
              <asp:Parameter Name="postcode" Type="String" />
              <asp:Parameter Name="county" Type="String" />
              <asp:Parameter Name="nhsNumber" Type="String" />
              <asp:Parameter Name="password" Type="String" />
              <asp:Parameter Name="isAdmin" Type="Boolean" />
              <asp:Parameter Name="isInactive" Type="Boolean" />
          </InsertParameters>
          <UpdateParameters>
              <asp:Parameter Name="fname" Type="String" />
              <asp:Parameter Name="lname" Type="String" />
              <asp:Parameter Name="email" Type="String" />
              <asp:Parameter Name="address1" Type="String" />
              <asp:Parameter Name="address2" Type="String" />
              <asp:Parameter Name="road" Type="String" />
              <asp:Parameter Name="town" Type="String" />
              <asp:Parameter Name="postcode" Type="String" />
              <asp:Parameter Name="county" Type="String" />
              <asp:Parameter Name="nhsNumber" Type="String" />
              <asp:Parameter Name="password" Type="String" />
              <asp:Parameter Name="isAdmin" Type="Boolean" />
              <asp:Parameter Name="isInactive" Type="Boolean" />
              <asp:Parameter Name="original_userID" Type="Int32" />
              <asp:Parameter Name="original_fname" Type="String" />
              <asp:Parameter Name="original_lname" Type="String" />
              <asp:Parameter Name="original_email" Type="String" />
              <asp:Parameter Name="original_address1" Type="String" />
              <asp:Parameter Name="original_address2" Type="String" />
              <asp:Parameter Name="original_road" Type="String" />
              <asp:Parameter Name="original_town" Type="String" />
              <asp:Parameter Name="original_postcode" Type="String" />
              <asp:Parameter Name="original_county" Type="String" />
              <asp:Parameter Name="original_nhsNumber" Type="String" />
              <asp:Parameter Name="original_password" Type="String" />
              <asp:Parameter Name="original_isAdmin" Type="Boolean" />
              <asp:Parameter Name="original_isInactive" Type="Boolean" />
          </UpdateParameters>
        </asp:SqlDataSource>  
      
        <br />
        <br />
      
    </div>
    <div id="col-2">
        <% Response.WriteFile("includes/adverts.aspx"); %>
    </div>
    
    <% Response.WriteFile("includes/footer-guest.aspx"); %>
    
    </div>

<div id="footer-img"></div>   
</form>
</body>
</html>
