<%@ Page Language="C#" %>
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
        TextBox TubeName = FindControl("TextBox1") as TextBox;

        SqlDataSource1.InsertParameters["tubeName"].DefaultValue = TextBox1.Text;

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
        <div id="title"> <a href="./"><img src="./images/title.png" width="600" height="100" alt="Discounts NHS - Exclusive Discounts &amp; Benefits for NHS Staff "></a> </div>
      </div>
      <%= wws.authen.isAdmin() %>
      <% Response.WriteFile("includes/nav.aspx"); %>
      <div id="search">
          <asp:TextBox ID="SearchBox" runat="server"></asp:TextBox>
      </div>
      <% Response.WriteFile("includes/nav-admin.aspx"); %>
      <div id="col-2-1">
        <h2>Edit Stations</h2>
        <br />
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
        AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="tubeID" 
        DataSourceID="SqlDataSource1" Width="500px" BackColor="#FFFFCC" 
        BorderColor="#CCCCCC" BorderStyle="Solid" EnableModelValidation="True" 
              PageSize="20">
          <Columns>
              <asp:TemplateField ShowHeader="False">
                  <EditItemTemplate>
                      <asp:Button ID="Button1" runat="server" CausesValidation="False" 
                          CommandName="Update" Text="Update" />
                      &nbsp;<asp:Button ID="Button2" runat="server" CausesValidation="False" 
                          CommandName="Cancel" Text="Cancel" />
                  </EditItemTemplate>
                  <ItemTemplate>
                      <asp:Button ID="Button2" runat="server" CausesValidation="False" 
                          CommandName="Edit" Text="Edit" />
                      &nbsp;<asp:Button ID="Button3" runat="server" CausesValidation="False" 
                          CommandName="Delete" Text="qDelete" Visible="False" />
                      <asp:Button ID="LinkButton1" runat="server" CausesValidation="False" 
                          CommandName="Delete" 
                          OnClientClick="return confirm(&quot;Are you sure you want to delete this Station?&quot;);" 
                          Text="Delete" />
                  </ItemTemplate>
                  <ItemStyle Width="120px" />
              </asp:TemplateField>
          <asp:BoundField DataField="tubeID" HeaderText="Tube ID" InsertVisible="False" 
                ReadOnly="True" SortExpression="tubeID" Visible="False" />
          <asp:BoundField DataField="tubeName" HeaderText="Station Name" 
                SortExpression="tubeName" />
          </Columns>
          <HeaderStyle BackColor="#FFCC00" />
          <EditRowStyle BackColor="#99FFCC" />
          <PagerStyle BackColor="#FFFF99" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConflictDetection="CompareAllValues" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        DeleteCommand="DELETE FROM [tube] WHERE [tubeID] = @original_tubeID AND (([tubeName] = @original_tubeName) OR ([tubeName] IS NULL AND @original_tubeName IS NULL))" 
        InsertCommand="INSERT INTO [tube] ([tubeName]) VALUES (@tubeName)" 
        OldValuesParameterFormatString="original_{0}" 
        SelectCommand="SELECT * FROM [tube] ORDER BY [tubeID] DESC" 
        
              UpdateCommand="UPDATE [tube] SET [tubeName] = @tubeName WHERE [tubeID] = @original_tubeID AND (([tubeName] = @original_tubeName) OR ([tubeName] IS NULL AND @original_tubeName IS NULL))">
          <DeleteParameters>
            <asp:Parameter Name="original_tubeID" Type="Int32" />
            <asp:Parameter Name="original_tubeName" Type="String" />
          </DeleteParameters>
          <InsertParameters>
            <asp:Parameter Name="tubeName" Type="String" />
          </InsertParameters>
          <UpdateParameters>
            <asp:Parameter Name="tubeName" Type="String" />
            <asp:Parameter Name="original_tubeID" Type="Int32" />
            <asp:Parameter Name="original_tubeName" Type="String" />
          </UpdateParameters>
        </asp:SqlDataSource>
      </div>
      <div id="col-2-2">
        <h2>Add New Station</h2>
        <asp:Label ID="Label1" runat="server" Text="Name:"></asp:Label>
        <asp:TextBox ID="TextBox1" runat="server" Width="250px"></asp:TextBox>
        <asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text="Add" />
          <br />
          <br />
          <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
              ControlToValidate="TextBox1" ErrorMessage="Station Name Required"></asp:RequiredFieldValidator>
        </div>
        
        <% Response.WriteFile("includes/footer.aspx"); %>  
  
  </div>
<div id="footer-img"></div>
</form>
</body>
</html>