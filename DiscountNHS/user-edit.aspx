<%@ Page Language="C#" %>

<%@ Import Namespace="System" %> <%@ Import Namespace="System.Net.Mail" %> <%@ Import Namespace="System.IO" %> <%@ Import Namespace="System.Web" %> <%@ Import Namespace="System.Web.UI.HtmlControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
    
    string selectedEmail;
    string selectedPass;
    
	protected void Page_Load(object sender, System.EventArgs e) {
		wws.authen.logoutIfNotValid();
		wws.authen.redirIfNotAdmin();
        
        selectedEmail = emailList.SelectedValue;
        
        selectedPass = "thisisthepassword";
        
        TextBox1.Focus();
	}

    protected void Button1_Click(object sender, EventArgs e)
    {
        TextBox First = FindControl("TextBox1") as TextBox;
        TextBox Last = FindControl("TextBox2") as TextBox;
        TextBox Email = FindControl("TextBox3") as TextBox;
        TextBox Password = FindControl("TextBox4") as TextBox;

        SqlDataSource1.InsertParameters["fname"].DefaultValue = TextBox1.Text;
        SqlDataSource1.InsertParameters["lname"].DefaultValue = TextBox2.Text;
        SqlDataSource1.InsertParameters["email"].DefaultValue = TextBox3.Text;
        SqlDataSource1.InsertParameters["password"].DefaultValue = TextBox4.Text;

        SqlDataSource1.Insert();

        TextBox1.Text = String.Empty;
        TextBox2.Text = String.Empty;
        TextBox3.Text = String.Empty;
        TextBox4.Text = String.Empty;
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        TextBox1.Text = String.Empty;
        TextBox2.Text = String.Empty;
        TextBox3.Text = String.Empty;
        TextBox4.Text = String.Empty;
    }

    protected void activateBtn_Click(object sender, EventArgs e)
    {

        // send email notification
        if (IsPostBack)
        {
            try
            {
				string u_email;
				string u_password;
				if(wws.nhs.getuserpass(Convert.ToInt32(emailList.SelectedValue), out u_email, out u_password)){
					//if user exists	
					string output = "";
					MailMessage mail = new MailMessage();

					// Replace with your own host address
					string hostAddress = "localhost";

					// Replaces newlines with br
					/*string email = (selectedEmail);
					email = email.Replace(Environment.NewLine, "<br />");*/

					output = "<p>Your Account at DiscountsNHS has now been activated, you can now log into the site using the information below:</p> <p>Email: " + (u_email) + "</p> <p>Password: " + (u_password) + "</p>";

					mail.From = new MailAddress("no-reply@discounts-nhs.co.uk");
					mail.To.Add(u_email);
					mail.Bcc.Add("sammy@zakonline.co.uk");
					mail.Subject = "Your DiscountsNHS Account has been Activated";
					mail.Body = output;

					mail.IsBodyHtml = true;
					SmtpClient smtp = new SmtpClient(hostAddress);
					smtp.Send(mail);

					statusLabel.Text = "E-mail sent successfully.";
				}else{
					statusLabel.Text = "Username could not be found.";
				}
            }
            catch (Exception err)
            {
                statusLabel.Text = "There was an exception whilst sending the e-mail: " + err.ToString() + ".";
            }
        }

    }

    protected void emailList_SelectedIndexChanged(object sender, EventArgs e)
    {
         selectedEmail = emailList.SelectedValue;
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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
        <%= wws.authen.isAdmin() %><% Response.WriteFile("includes/nav.aspx"); %>
      <div id="search">
          <asp:TextBox ID="SearchBox" runat="server"></asp:TextBox>
      </div>
        <% Response.WriteFile("includes/nav-admin.aspx"); %>
      <div id="content">
        <h2>Edit Users</h2>
        <br />
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
        AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="userID" 
        DataSourceID="SqlDataSource1" Width="930px" BackColor="#FFFFCC" 
        BorderColor="#CCCCCC" BorderStyle="Solid" CellPadding="1" CellSpacing="1" ForeColor="Black" 
        HorizontalAlign="Center" PageSize="15" ShowHeaderWhenEmpty="True" 
              EnableModelValidation="True">
            <AlternatingRowStyle BackColor="#FFCC99" />
          <Columns>
              <asp:TemplateField ShowHeader="False">
                  <EditItemTemplate>
                      <asp:Button ID="Button1" runat="server" CausesValidation="False" 
                          CommandName="Update" Text="Update" />
                      &nbsp;<asp:Button ID="Button2" runat="server" CausesValidation="False" 
                          CommandName="Cancel" Text="Cancel" />
                  </EditItemTemplate>
                  <ItemTemplate>
                      <asp:Button ID="Button1" runat="server" CausesValidation="False" 
                          CommandName="Edit" Text="Edit" />
                      <asp:Button ID="LinkButton1" runat="server" CausesValidation="False" 
                          CommandName="Delete" 
                          OnClientClick='return confirm("Are you sure you want to delete this User?");' 
                          Text="Delete" />
                      &nbsp;<br />
                      <asp:Button ID="Button2" runat="server" CausesValidation="False" 
                          CommandName="Delete" Text="qDelete" Visible="False" />
                  </ItemTemplate>
                  <ItemStyle Width="120px" />
              </asp:TemplateField>
          <asp:BoundField DataField="userID" HeaderText="ID" InsertVisible="False" 
                ReadOnly="True" SortExpression="userID" Visible="False" />
          <asp:BoundField DataField="fname" HeaderText="First" SortExpression="fname" />
          <asp:BoundField DataField="lname" HeaderText="Last" SortExpression="lname" />
              <asp:TemplateField HeaderText="Email" SortExpression="email">
                  <EditItemTemplate>
                      <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("email") %>'></asp:TextBox>
                  </EditItemTemplate>
                  <ItemTemplate>
                      <asp:Label ID="Label2" runat="server" Text='<%# Bind("email") %>'></asp:Label>
                      <br />
                  </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Password" SortExpression="password">
                  <EditItemTemplate>
                      <asp:TextBox ID="passwordBox" runat="server" Text='<%# Bind("password") %>'></asp:TextBox>
                  </EditItemTemplate>
                  <ItemTemplate>
                      <asp:Label ID="passwordLabel" runat="server" Text='<%# Bind("password") %>'></asp:Label>
                  </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Address" SortExpression="address1">
                  <EditItemTemplate>
                      <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("address1") %>'></asp:TextBox>
                      <br />
                      <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("address2") %>'></asp:TextBox>
                      <br />
                      <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("road") %>'></asp:TextBox>
                      <br />
                      <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("town") %>'></asp:TextBox>
                      <br />
                      <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("postcode") %>'></asp:TextBox>
                      <br />
                      <asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("county") %>'></asp:TextBox>
                  </EditItemTemplate>
                  <ItemTemplate>
                      <asp:Label ID="Label1" runat="server" Text='<%# Bind("address1") %>'></asp:Label>
                      <br />
                      <asp:Label ID="Label5" runat="server" Text='<%# Bind("address2") %>'></asp:Label>
                      <br />
                      <asp:Label ID="Label6" runat="server" Text='<%# Bind("road") %>'></asp:Label>
                      <br />
                      <asp:Label ID="Label8" runat="server" Text='<%# Bind("town") %>'></asp:Label>
                      <br />
                      <asp:Label ID="Label9" runat="server" Text='<%# Bind("postcode") %>'></asp:Label>
                      <br />
                      <asp:Label ID="Label10" runat="server" Text='<%# Bind("county") %>'></asp:Label>
                  </ItemTemplate>
              </asp:TemplateField>
              <asp:CheckBoxField DataField="isInactive" HeaderText="Inactive" 
                  SortExpression="isInactive" />
          </Columns>
          <EditRowStyle BackColor="#99FFCC" />
            <FooterStyle BackColor="#FFCC00" />
          <HeaderStyle BackColor="#FFCC00" />
          <PagerStyle BackColor="#FFCC00" HorizontalAlign="Left" />
            <RowStyle BackColor="#FFFF99" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConflictDetection="CompareAllValues" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        DeleteCommand="DELETE FROM [user] WHERE [userID] = @original_userID" 
        InsertCommand="INSERT INTO [user] ([fname], [lname], [email], [address1], [address2], [road], [town], [postcode], [county], [nhsNumber], [password], [isAdmin], [isInactive]) VALUES (@fname, @lname, @email, @address1, @address2, @road, @town, @postcode, @county, @nhsNumber, @password, @isAdmin, @isInactive)" 
        OldValuesParameterFormatString="original_{0}" 
        SelectCommand="SELECT * FROM [user] ORDER BY [userID] DESC" 
        
              UpdateCommand="UPDATE [user] SET [fname] = @fname, [lname] = @lname, [email] = @email, [address1] = @address1, [address2] = @address2, [road] = @road, [town] = @town, [postcode] = @postcode, [county] = @county, [nhsNumber] = @nhsNumber, [password] = @password, [isAdmin] = @isAdmin, [isInactive] = @isInactive WHERE [userID] = @original_userID">
          <DeleteParameters>
            <asp:Parameter Name="original_userID" Type="Int32" />
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
          </UpdateParameters>
        </asp:SqlDataSource>
        <br />
        <h2>Add New a User</h2>
        <table>
        <tr>
          <td><asp:Label ID="Label1" runat="server" Text="First:"></asp:Label></td>
            <td><asp:TextBox ID="TextBox1" runat="server"></asp:TextBox></td>
            <td><asp:Label ID="Label2" runat="server" Text="Last:"></asp:Label></td>
            <td><asp:TextBox ID="TextBox2" runat="server"></asp:TextBox></td>
            <td><asp:Label ID="Label3" runat="server" Text="Email:"></asp:Label></td>
            <td><asp:TextBox ID="TextBox3" runat="server"></asp:TextBox></td>
            <td><asp:Label ID="Label4" runat="server" Text="Password:"></asp:Label></td>
            <td><asp:TextBox ID="TextBox4" runat="server"></asp:TextBox></td>
        </tr>
        </table>
        <table cellpadding="5">
        <tr>
        <td>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ControlToValidate="TextBox3" ErrorMessage="Email Address Required"></asp:RequiredFieldValidator>
            </td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                    ControlToValidate="TextBox4" ErrorMessage="Password Required"></asp:RequiredFieldValidator>
            
            </td>
        </tr>
        </table>
        <asp:Button ID="Button1" runat="server" Text="Add" onclick="Button1_Click" />
        <asp:Button ID="Button2" runat="server" onclick="Button2_Click" Text="Clear" />
        
        <br />
        <br />

        <h2>Send Activation Email</h2>

        <table cellpadding="10" cellspacing="1">        
        
        <tr>
        
        <td><asp:Label ID="activateUser" runat="server" Text="User:"></asp:Label></td>
        <td><asp:DropDownList ID="emailList" runat="server" DataSourceID="SqlDataSource2" 
                DataTextField="email" DataValueField="userID" 
                onselectedindexchanged="emailList_SelectedIndexChanged"></asp:DropDownList></td>
        <td><asp:Button ID="activateBtn" runat="server" Text="Send Activation Email" 
                onclick="activateBtn_Click" CausesValidation="False" /></td>
        <td>
            <asp:Label ID="statusLabel" runat="server"></asp:Label>
            </td>
        
        </tr>

        </table>

          <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
              ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
              SelectCommand="SELECT [userID], [email], [password], [isInactive] FROM [user] WHERE ([isInactive] = @isInactive)">
              <SelectParameters>
                  <asp:Parameter DefaultValue="True" Name="isInactive" Type="Boolean" />
              </SelectParameters>
          </asp:SqlDataSource>

          <br />

        <br />
        
      </div>
      
      <% Response.WriteFile("includes/footer.aspx"); %>
  
  </div>
<div id="footer-img"></div>
</form>
</body>
</html>