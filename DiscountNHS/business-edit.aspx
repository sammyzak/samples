<%@ Page Language="C#" %>

<%@ Import Namespace="System" %> 
<%@ Import Namespace="System.Data" %> 
<%@ Import Namespace="System.Configuration" %>
<%@ Import Namespace="System.Web" %> 
<%@ Import Namespace="System.Web.Security" %>
<%@ Import Namespace="System.Web.UI" %>
<%@ Import Namespace="System.Web.UI.WebControls" %>
<%@ Import Namespace="System.Web.UI.WebControls.WebParts" %>
<%@ Import Namespace="System.Web.UI.HtmlControls" %>
<%@ Import Namespace="System.IO" %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    
    protected void Page_Load(object sender, System.EventArgs e)
    {
        wws.authen.logoutIfNotValid();
        wws.authen.redirIfNotAdmin();
        TextBox1.Focus(); 
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        TextBox Name = FindControl("TextBox1") as TextBox;
        SqlDataSource1.InsertParameters["businessName"].DefaultValue = TextBox1.Text;
        SqlDataSource1.Insert();
        TextBox1.Text = String.Empty;
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
   <div id="title"> 
   	<a href="./"><img src="./images/title.png" width="600" height="100" alt="Discounts NHS - Exclusive Discounts &amp; Benefits for NHS Staff "></a>
   </div>
      </div>
	  <%= wws.authen.isAdmin() %>
      <% Response.WriteFile("includes/nav.aspx"); %>
      <div id="search">
          <asp:TextBox ID="SearchBox" runat="server"></asp:TextBox>
      </div>
      <% Response.WriteFile("includes/nav-admin.aspx"); %>
      <div id="col-2-1">
        <h2>Edit Businesses</h2>
        <br />
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
        AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="businessID" BackColor="#FFFFCC" 
        BorderColor="#CCCCCC" BorderStyle="None" CellPadding="1" CellSpacing="1" GridLines="Horizontal" 
        DataSourceID="SqlDataSource1" Width="480px" 
              EnableModelValidation="True" PageSize="20">
            <AlternatingRowStyle BackColor="#FFFFCC" />
            <Columns>
            <asp:HyperLinkField DataNavigateUrlFields="businessID, businessName" DataNavigateUrlFormatString="business-record.aspx?BID={0}&businessName={1}" Text="Edit Record" />
                <asp:TemplateField HeaderText="Logo">
                    <ItemTemplate>
                        <asp:Image ID="Image1" runat="server" 
                            ImageUrl='<%# Eval("businessID", "~/images/logos/{0}.jpg") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="businessID" HeaderText="businessID" 
                    InsertVisible="False" ReadOnly="True" SortExpression="businessID" 
                    Visible="False" />
                <asp:BoundField DataField="businessName" HeaderText="Business Name" 
                    SortExpression="businessName" />
                <asp:BoundField DataField="address1" HeaderText="address1" 
                    SortExpression="address1" Visible="False" />
                <asp:BoundField DataField="address2" HeaderText="address2" 
                    SortExpression="address2" Visible="False" />
                <asp:BoundField DataField="road" HeaderText="road" SortExpression="road" 
                    Visible="False" />
                <asp:BoundField DataField="town" HeaderText="town" SortExpression="town" 
                    Visible="False" />
                <asp:BoundField DataField="postcode" HeaderText="postcode" 
                    SortExpression="postcode" Visible="False" />
                <asp:BoundField DataField="contact_name" HeaderText="contact_name" 
                    SortExpression="contact_name" Visible="False" />
                <asp:BoundField DataField="contact_number" HeaderText="contact_number" 
                    SortExpression="contact_number" Visible="False" />
                <asp:BoundField DataField="website" HeaderText="website" 
                    SortExpression="website" Visible="False" />
                <asp:BoundField DataField="email" HeaderText="email" SortExpression="email" 
                    Visible="False" />
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:Button ID="Button1" runat="server" CausesValidation="False" 
                            CommandName="Delete" Text="qDelete" Visible="False" />
                            <asp:Button ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete"
OnClientClick='return confirm("Are you sure you want to delete this Business?");'
Text="Delete" />
                    </ItemTemplate>
                    <ItemStyle Width="50px" />
                </asp:TemplateField>
            </Columns>
          <EditRowStyle BackColor="#99FFCC" />
          <HeaderStyle BackColor="#FFCC00" />
          <PagerStyle BackColor="#FFFF99" HorizontalAlign="Left" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        OldValuesParameterFormatString="original_{0}" 
        SelectCommand="SELECT * FROM [business] ORDER BY [businessID] DESC" 
              DeleteCommand="DELETE FROM [business] WHERE [businessID] = @original_businessID" 
              
              InsertCommand="INSERT INTO [business] ([businessName], [address1], [address2], [road], [town], [postcode], [contact_name], [email], [website], [contact_number], [contact_fax], [info], [isHidden]) VALUES (@businessName, @address1, @address2, @road, @town, @postcode, @contact_name, @email, @website, @contact_number, @contact_fax, @info, @isHidden)" 
              ConflictDetection="CompareAllValues" 
              
              UpdateCommand="UPDATE [business] SET [businessName] = @businessName, [address1] = @address1, [address2] = @address2, [road] = @road, [town] = @town, [postcode] = @postcode, [contact_name] = @contact_name, [email] = @email, [website] = @website, [contact_number] = @contact_number, [contact_fax] = @contact_fax, [info] = @info, [isHidden] = @isHidden WHERE [businessID] = @original_businessID AND (([businessName] = @original_businessName) OR ([businessName] IS NULL AND @original_businessName IS NULL)) AND (([address1] = @original_address1) OR ([address1] IS NULL AND @original_address1 IS NULL)) AND (([address2] = @original_address2) OR ([address2] IS NULL AND @original_address2 IS NULL)) AND (([road] = @original_road) OR ([road] IS NULL AND @original_road IS NULL)) AND (([town] = @original_town) OR ([town] IS NULL AND @original_town IS NULL)) AND (([postcode] = @original_postcode) OR ([postcode] IS NULL AND @original_postcode IS NULL)) AND (([contact_name] = @original_contact_name) OR ([contact_name] IS NULL AND @original_contact_name IS NULL)) AND (([email] = @original_email) OR ([email] IS NULL AND @original_email IS NULL)) AND (([website] = @original_website) OR ([website] IS NULL AND @original_website IS NULL)) AND (([contact_number] = @original_contact_number) OR ([contact_number] IS NULL AND @original_contact_number IS NULL)) AND (([contact_fax] = @original_contact_fax) OR ([contact_fax] IS NULL AND @original_contact_fax IS NULL)) AND (([info] = @original_info) OR ([info] IS NULL AND @original_info IS NULL)) AND (([isHidden] = @original_isHidden) OR ([isHidden] IS NULL AND @original_isHidden IS NULL))" >
            <DeleteParameters>
                <asp:Parameter Name="original_businessID" Type="Int32" />
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
          <br />
          <br />
        </div>
        <div id="col-2-2">




        <h2>Add New Business</h2>
        <table>
            <td><asp:Label ID="Label1" runat="server" Text="Name:"></asp:Label></td>
            <td><asp:TextBox ID="TextBox1" runat="server" Width="250px"></asp:TextBox>
            <td><asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text="Add" /></td>
            </td>
        </table>
        <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ControlToValidate="TextBox1" ErrorMessage="Business Name Required"></asp:RequiredFieldValidator>
        <br />


          <br />
      </div>
      
      <% Response.WriteFile("includes/footer.aspx"); %>
  
  </div>
<div id="footer-img"></div>

    </form>
</body>
</html>
