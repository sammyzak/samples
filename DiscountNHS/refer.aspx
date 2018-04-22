<%@ Page Language="C#" %>

<%@ Import Namespace="System" %> <%@ Import Namespace="System.Net.Mail" %> <%@ Import Namespace="System.IO" %> <%@ Import Namespace="System.Web" %> <%@ Import Namespace="System.Web.UI.HtmlControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
	protected void Page_Load(object sender, System.EventArgs e) 
    {
		wws.authen.logoutIfNotValid();
        ownerForm.Visible = false;
        referForm.Visible = false;
    }

    protected void businessSubmit_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (businessSubmit.SelectedItem.Value == "owner")
        {
            ownerForm.Visible = true;
            referForm.Visible = false;
        }

        if (businessSubmit.SelectedItem.Value == "referer")
        {
            referForm.Visible = true;
            ownerForm.Visible = false;
        }
    }

    protected void referSubmit_Click(object sender, EventArgs e)
    {
        TextBox BusinessName = FindControl("nameBox") as TextBox;
        TextBox businessTown = FindControl("locationBox") as TextBox;

        SqlDataSource1.InsertParameters["businessName"].DefaultValue = nameBox.Text;
        SqlDataSource1.InsertParameters["town"].DefaultValue = locationBox.Text;

        SqlDataSource1.InsertParameters["isHidden"].DefaultValue = "True";

        SqlDataSource1.Insert();

        nameBox.Text = String.Empty;
        locationBox.Text = String.Empty;

        statusLabel.Text = "Business has been submitted, Thank You!";
        

        // send email notifcation
        if (IsPostBack)
        {
            try
            {
                string output = "";

                MailMessage mail = new MailMessage();

                // Replace with your own host address
                string hostAddress = "localhost";

                // Replaces newlines with br
                string location = Request.Form["locationBox"].ToString();
                location = location.Replace(Environment.NewLine, "<br />");

                output = "<p>Business: " + Request.Form["nameBox"].ToString() + ".</p>";
                output += "<p>Location: " + location + ".</p>";

                mail.From = new MailAddress("no-reply@discounts-nhs.co.uk");
                mail.To.Add("sammy@zakonline.co.uk");
                mail.Subject = "New Business Request from DiscountsNHS";
                mail.Body = output;

                mail.IsBodyHtml = true;
                SmtpClient smtp = new SmtpClient(hostAddress);
                smtp.Send(mail);

                lblOutcome.Text = "E-mail sent successfully.";
            }
            catch (Exception err)
            {
                lblOutcome.Text = "There was an exception whilst sending the e-mail: " + err.ToString() + ".";
            }
        }
        
    }

    protected void ownerSubmit_Click(object sender, EventArgs e)
    {
        TextBox businessName2 = FindControl("nameBox") as TextBox;
        DropDownList businessType = FindControl("DropDownList1") as DropDownList;
        TextBox address1 = FindControl("address1Box") as TextBox;
        TextBox address2 = FindControl("address2Box") as TextBox;
        TextBox road = FindControl("roadBox") as TextBox;

        SqlDataSource1.InsertParameters["businessName"].DefaultValue = nameBox.Text;
        SqlDataSource1.InsertParameters["address1"].DefaultValue = address1Box.Text;
        SqlDataSource1.InsertParameters["address2"].DefaultValue = address2Box.Text;
        SqlDataSource1.InsertParameters["road"].DefaultValue = roadBox.Text;

        SqlDataSource1.InsertParameters["isHidden"].DefaultValue = "True";

        SqlDataSource2.InsertParameters["businesstypeID"].DefaultValue = DropDownList1.Text;

        SqlDataSource1.Insert();
        SqlDataSource2.Insert();

        nameBox2.Text = String.Empty;
        address1Box.Text = String.Empty;
        address2Box.Text = String.Empty;
        roadBox.Text = String.Empty;

        statusLabel.Text = "Business has been submitted, Thank You!";

        // send email notifcation
        if (IsPostBack)
        {
            try
            {
                string output = "";

                MailMessage mail = new MailMessage();

                // Replace with your own host address
                string hostAddress = "localhost";

                // Replaces newlines with br
                string message = Request.Form["address1"].ToString();
                message = message.Replace(Environment.NewLine, "<br />");

                output = "<p>Business: " + Request.Form["nameBox2"].ToString() + ".</p>";
                output += "<p>Address 1: " + message + ".</p>";

                mail.From = new MailAddress("refer@discounts-nhs.co.uk");
                mail.To.Add("sammy@zakonline.co.uk");
                mail.Subject = "New Business Request from Owner at DiscountsNHS";
                mail.Body = output;

                mail.IsBodyHtml = true;
                SmtpClient smtp = new SmtpClient(hostAddress);
                smtp.Send(mail);

                lblOutcome.Text = "E-mail sent successfully.";
            }
            catch (Exception err)
            {
                lblOutcome.Text = "There was an exception whilst sending the e-mail: " + err.ToString() + ".";
            }
        }
        
    }

</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>Discounts - NHS - Refer a Business</title>
    <% Response.WriteFile("includes/head.aspx"); %><%= wws.authen.isAdmin() %><% Response.WriteFile("includes/rolling-ads.aspx"); %>
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
      <h2>Recommend businesses you would like discounts from</h2>
      
		<p>We are currently procuring discounts from local and national businesses recommended by the NHS Staff. Details of participating businesses will be posted as they join this unique Programme.</p>

		<p>If you would like discounts from a business you are presently using and would like it to be included in the first medical National Staff Benefit Programme for NHS Staff, then to recommend the business please click here.</p>

		<p>Please ensure to leave your contact details, including your telephone number, an e-mail address and the name of the Hospital/Trust you are currently working at.</p>

		<p>All the recommendations submitted will go into a Prize Draw. In addition to receiving FANTASTIC discounts from participating businesses already you could also win &pound;100. You can recommend as many businesses as you like!</p>
        

        <asp:RadioButtonList ID="businessSubmit" runat="server" 
            onselectedindexchanged="businessSubmit_SelectedIndexChanged" 
            AutoPostBack="True">
            <asp:ListItem Value="referer">I would like to refer a business</asp:ListItem>
            <asp:ListItem Value="owner">I own a Business</asp:ListItem>
        </asp:RadioButtonList>
        
        <asp:Panel ID="referForm" runat="server">
        <h3>Refer a Business</h3>
        <table cellpadding="5">
            <tr>
                <td><asp:Label ID="businessName" runat="server" Text="Business Name"></asp:Label></td>
                <td><asp:TextBox ID="nameBox" runat="server"></asp:TextBox></td>
                <td><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Business Name Required" ControlToValidate="nameBox"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td><asp:Label ID="businessLocation" runat="server" Text="Business Town"></asp:Label></td>
                <td><asp:TextBox ID="locationBox" runat="server"></asp:TextBox></td>
                <td><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Business Town Required" ControlToValidate="locationBox"></asp:RequiredFieldValidator></td>
            </tr>
        </table>
        <br />
            <asp:Button ID="referSubmit" runat="server" Text="Submit" 
                onclick="referSubmit_Click" />
            
        </asp:Panel>

        <asp:Panel ID="ownerForm" runat="server">

        <h3>I Own a Business</h3>

        <table cellpadding="5">
        <tr>
            <td><asp:Label ID="businessName2" runat="server" Text="Business Name"></asp:Label></td>
            <td><asp:TextBox ID="nameBox2" runat="server"></asp:TextBox></td>
            <td><asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                    ErrorMessage="Business Name Required" ControlToValidate="nameBox2"></asp:RequiredFieldValidator></td>
        </tr>            
        <tr>
            <td><asp:Label ID="businessType" runat="server" Text="Business Type"></asp:Label></td>
            <td>
                <asp:DropDownList ID="DropDownList1" runat="server" 
                    DataSourceID="SqlDataSource3" DataTextField="businessTypeName" 
                    DataValueField="businessTypeID">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td><asp:Label ID="address1" runat="server" Text="Address 1"></asp:Label></td>
            <td><asp:TextBox ID="address1Box" runat="server"></asp:TextBox></td>
            <td><asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                    ErrorMessage="Address Required" ControlToValidate="address1Box"></asp:RequiredFieldValidator></td>
        </tr>
        <tr>
            <td><asp:Label ID="address2" runat="server" Text="Address 2"></asp:Label></td>
            <td><asp:TextBox ID="address2Box" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
            <td><asp:Label ID="road" runat="server" Text="Road"></asp:Label></td>
            <td><asp:TextBox ID="roadBox" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
            <td><asp:Label ID="town" runat="server" Text="Town"></asp:Label></td>
            <td><asp:TextBox ID="townBox" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
            <td><asp:Label ID="postcode" runat="server" Text="Post Code"></asp:Label></td>
            <td><asp:TextBox ID="postcodeBox" runat="server"></asp:TextBox></td>
            <td><asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" 
                    ErrorMessage="Post Code Required" ControlToValidate="postcodeBox"></asp:RequiredFieldValidator></td>
        </tr>
        <tr>
            <td><asp:Label ID="contactName" runat="server" Text="Contact Name"></asp:Label></td>
            <td><asp:TextBox ID="contactNameBox" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
            <td><asp:Label ID="phoneNumber" runat="server" Text="Phone Number"></asp:Label></td>
            <td><asp:TextBox ID="phoneBox" runat="server"></asp:TextBox></td>
            <td><asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                    ErrorMessage="Phone Number Required" ControlToValidate="phoneBox"></asp:RequiredFieldValidator></td>
        </tr>
        <tr>
            <td><asp:Label ID="faxNumber" runat="server" Text="Fax Number"></asp:Label></td>
            <td><asp:TextBox ID="faxBox" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
            <td><asp:Label ID="website" runat="server" Text="Website"></asp:Label></td>
            <td><asp:TextBox ID="websiteBox" runat="server"></asp:TextBox></td>
        </tr>

        </table>
        <br />
            <asp:Button ID="ownerSubmit" runat="server" Text="Submit" 
                onclick="ownerSubmit_Click" />
        
        </asp:Panel>
      
        <br />
        <asp:Label ID="statusLabel" runat="server"></asp:Label>
      
        <br />
        <asp:Label ID="lblOutcome" runat="server" Visible="False"></asp:Label>
      
      <br />
      <br />
      <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                    SelectCommand="SELECT * FROM [business]" 
            ConflictDetection="CompareAllValues" 
            DeleteCommand="DELETE FROM [business] WHERE [businessID] = @original_businessID AND (([businessName] = @original_businessName) OR ([businessName] IS NULL AND @original_businessName IS NULL)) AND (([address1] = @original_address1) OR ([address1] IS NULL AND @original_address1 IS NULL)) AND (([address2] = @original_address2) OR ([address2] IS NULL AND @original_address2 IS NULL)) AND (([road] = @original_road) OR ([road] IS NULL AND @original_road IS NULL)) AND (([town] = @original_town) OR ([town] IS NULL AND @original_town IS NULL)) AND (([postcode] = @original_postcode) OR ([postcode] IS NULL AND @original_postcode IS NULL)) AND (([contact_name] = @original_contact_name) OR ([contact_name] IS NULL AND @original_contact_name IS NULL)) AND (([email] = @original_email) OR ([email] IS NULL AND @original_email IS NULL)) AND (([website] = @original_website) OR ([website] IS NULL AND @original_website IS NULL)) AND (([contact_number] = @original_contact_number) OR ([contact_number] IS NULL AND @original_contact_number IS NULL)) AND (([contact_fax] = @original_contact_fax) OR ([contact_fax] IS NULL AND @original_contact_fax IS NULL)) AND (([info] = @original_info) OR ([info] IS NULL AND @original_info IS NULL)) AND (([isHidden] = @original_isHidden) OR ([isHidden] IS NULL AND @original_isHidden IS NULL))" 
            InsertCommand="INSERT INTO [business] ([businessName], [address1], [address2], [road], [town], [postcode], [contact_name], [email], [website], [contact_number], [contact_fax], [info], [isHidden]) VALUES (@businessName, @address1, @address2, @road, @town, @postcode, @contact_name, @email, @website, @contact_number, @contact_fax, @info, @isHidden)" 
            OldValuesParameterFormatString="original_{0}" 
            UpdateCommand="UPDATE [business] SET [businessName] = @businessName, [address1] = @address1, [address2] = @address2, [road] = @road, [town] = @town, [postcode] = @postcode, [contact_name] = @contact_name, [email] = @email, [website] = @website, [contact_number] = @contact_number, [contact_fax] = @contact_fax, [info] = @info, [isHidden] = @isHidden WHERE [businessID] = @original_businessID AND (([businessName] = @original_businessName) OR ([businessName] IS NULL AND @original_businessName IS NULL)) AND (([address1] = @original_address1) OR ([address1] IS NULL AND @original_address1 IS NULL)) AND (([address2] = @original_address2) OR ([address2] IS NULL AND @original_address2 IS NULL)) AND (([road] = @original_road) OR ([road] IS NULL AND @original_road IS NULL)) AND (([town] = @original_town) OR ([town] IS NULL AND @original_town IS NULL)) AND (([postcode] = @original_postcode) OR ([postcode] IS NULL AND @original_postcode IS NULL)) AND (([contact_name] = @original_contact_name) OR ([contact_name] IS NULL AND @original_contact_name IS NULL)) AND (([email] = @original_email) OR ([email] IS NULL AND @original_email IS NULL)) AND (([website] = @original_website) OR ([website] IS NULL AND @original_website IS NULL)) AND (([contact_number] = @original_contact_number) OR ([contact_number] IS NULL AND @original_contact_number IS NULL)) AND (([contact_fax] = @original_contact_fax) OR ([contact_fax] IS NULL AND @original_contact_fax IS NULL)) AND (([info] = @original_info) OR ([info] IS NULL AND @original_info IS NULL)) AND (([isHidden] = @original_isHidden) OR ([isHidden] IS NULL AND @original_isHidden IS NULL))">
          <DeleteParameters>
              <asp:Parameter Name="original_businessID" Type="Int32" />
              <asp:Parameter Name="original_businessName" Type="String" />
              <asp:Parameter Name="original_address1" Type="String" />
              <asp:Parameter Name="original_address2" Type="String" />
              <asp:Parameter Name="original_road" Type="String" />
              <asp:Parameter Name="original_town" Type="String" />
              <asp:Parameter Name="original_postcode" Type="String" />
              <asp:Parameter Name="original_contact_name" Type="String" />
              <asp:Parameter Name="original_email" Type="String" />
              <asp:Parameter Name="original_website" Type="String" />
              <asp:Parameter Name="original_contact_number" Type="String" />
              <asp:Parameter Name="original_contact_fax" Type="String" />
              <asp:Parameter Name="original_info" Type="String" />
              <asp:Parameter Name="original_isHidden" Type="Boolean" />
          </DeleteParameters>
          <InsertParameters>
              <asp:Parameter Name="businessName" Type="String" />
              <asp:Parameter Name="address1" Type="String" />
              <asp:Parameter Name="address2" Type="String" />
              <asp:Parameter Name="road" Type="String" />
              <asp:Parameter Name="town" Type="String" />
              <asp:Parameter Name="postcode" Type="String" />
              <asp:Parameter Name="contact_name" Type="String" />
              <asp:Parameter Name="email" Type="String" />
              <asp:Parameter Name="website" Type="String" />
              <asp:Parameter Name="contact_number" Type="String" />
              <asp:Parameter Name="contact_fax" Type="String" />
              <asp:Parameter Name="info" Type="String" />
              <asp:Parameter Name="isHidden" Type="Boolean" />
          </InsertParameters>
          <UpdateParameters>
              <asp:Parameter Name="businessName" Type="String" />
              <asp:Parameter Name="address1" Type="String" />
              <asp:Parameter Name="address2" Type="String" />
              <asp:Parameter Name="road" Type="String" />
              <asp:Parameter Name="town" Type="String" />
              <asp:Parameter Name="postcode" Type="String" />
              <asp:Parameter Name="contact_name" Type="String" />
              <asp:Parameter Name="email" Type="String" />
              <asp:Parameter Name="website" Type="String" />
              <asp:Parameter Name="contact_number" Type="String" />
              <asp:Parameter Name="contact_fax" Type="String" />
              <asp:Parameter Name="info" Type="String" />
              <asp:Parameter Name="isHidden" Type="Boolean" />
              <asp:Parameter Name="original_businessID" Type="Int32" />
              <asp:Parameter Name="original_businessName" Type="String" />
              <asp:Parameter Name="original_address1" Type="String" />
              <asp:Parameter Name="original_address2" Type="String" />
              <asp:Parameter Name="original_road" Type="String" />
              <asp:Parameter Name="original_town" Type="String" />
              <asp:Parameter Name="original_postcode" Type="String" />
              <asp:Parameter Name="original_contact_name" Type="String" />
              <asp:Parameter Name="original_email" Type="String" />
              <asp:Parameter Name="original_website" Type="String" />
              <asp:Parameter Name="original_contact_number" Type="String" />
              <asp:Parameter Name="original_contact_fax" Type="String" />
              <asp:Parameter Name="original_info" Type="String" />
              <asp:Parameter Name="original_isHidden" Type="Boolean" />
          </UpdateParameters>
        </asp:SqlDataSource>  
      
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConflictDetection="CompareAllValues" 
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            DeleteCommand="DELETE FROM [business_businessType] WHERE [business_businessTypeID] = @original_business_businessTypeID AND (([businessID] = @original_businessID) OR ([businessID] IS NULL AND @original_businessID IS NULL)) AND (([businessTypeID] = @original_businessTypeID) OR ([businessTypeID] IS NULL AND @original_businessTypeID IS NULL))" 
            InsertCommand="INSERT INTO [business_businessType] ([businessID], [businessTypeID]) VALUES (@businessID, @businessTypeID)" 
            OldValuesParameterFormatString="original_{0}" 
            SelectCommand="SELECT * FROM [business_businessType]" 
            UpdateCommand="UPDATE [business_businessType] SET [businessID] = @businessID, [businessTypeID] = @businessTypeID WHERE [business_businessTypeID] = @original_business_businessTypeID AND (([businessID] = @original_businessID) OR ([businessID] IS NULL AND @original_businessID IS NULL)) AND (([businessTypeID] = @original_businessTypeID) OR ([businessTypeID] IS NULL AND @original_businessTypeID IS NULL))">
            <DeleteParameters>
                <asp:Parameter Name="original_business_businessTypeID" Type="Int32" />
                <asp:Parameter Name="original_businessID" Type="Int32" />
                <asp:Parameter Name="original_businessTypeID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="businessID" Type="Int32" />
                <asp:Parameter Name="businessTypeID" Type="Int32" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="businessID" Type="Int32" />
                <asp:Parameter Name="businessTypeID" Type="Int32" />
                <asp:Parameter Name="original_business_businessTypeID" Type="Int32" />
                <asp:Parameter Name="original_businessID" Type="Int32" />
                <asp:Parameter Name="original_businessTypeID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
            ConflictDetection="CompareAllValues" 
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            DeleteCommand="DELETE FROM [businessType] WHERE [businessTypeID] = @original_businessTypeID AND (([businessTypeName] = @original_businessTypeName) OR ([businessTypeName] IS NULL AND @original_businessTypeName IS NULL))" 
            InsertCommand="INSERT INTO [businessType] ([businessTypeName]) VALUES (@businessTypeName)" 
            OldValuesParameterFormatString="original_{0}" 
            SelectCommand="SELECT * FROM [businessType] ORDER BY [businessTypeName]" 
            
            UpdateCommand="UPDATE [businessType] SET [businessTypeName] = @businessTypeName WHERE [businessTypeID] = @original_businessTypeID AND (([businessTypeName] = @original_businessTypeName) OR ([businessTypeName] IS NULL AND @original_businessTypeName IS NULL))">
            <DeleteParameters>
                <asp:Parameter Name="original_businessTypeID" Type="Int32" />
                <asp:Parameter Name="original_businessTypeName" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="businessTypeName" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="businessTypeName" Type="String" />
                <asp:Parameter Name="original_businessTypeID" Type="Int32" />
                <asp:Parameter Name="original_businessTypeName" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <br />
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
