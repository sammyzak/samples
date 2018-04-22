<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
	protected void Page_Load(object sender, System.EventArgs e) {
		wws.authen.logoutIfNotValid();
		wws.authen.redirIfNotAdmin();

        typeBox.Focus();
	}

    protected void addTypeButton_Click(object sender, EventArgs e)
    {
        TextBox Type = FindControl("typeBox") as TextBox;

        SqlDataSource1.InsertParameters["businessTypeName"].DefaultValue = typeBox.Text;

        SqlDataSource1.Insert();

        typeBox.Text = String.Empty;
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
        <h2>Edit Business Types</h2>
        <br />
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
        AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="businessTypeID" 
        DataSourceID="SqlDataSource1" Width="500px" BackColor="#FFFFCC" 
        BorderColor="#CCCCCC" BorderStyle="Solid" CellPadding="1" CellSpacing="1" 
              EnableModelValidation="True" PageSize="20">
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
                          OnClientClick="return confirm(&quot;Are you sure you want to delete this Business Type?&quot;);" 
                          Text="Delete" />
                  </ItemTemplate>
                  <ItemStyle Width="120px" />
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Image">
                  <ItemTemplate>
                      <asp:Image ID="Image1" runat="server" Height="30px" 
                          ImageUrl='<%# Eval("businessTypeName", "./images/icons/{0}.jpg") %>' 
                          Width="30px" />
                  </ItemTemplate>
              </asp:TemplateField>
          <asp:BoundField DataField="businessTypeID" HeaderText="Type ID" 
                SortExpression="businessTypeID" InsertVisible="False" ReadOnly="True" >
              <ItemStyle Width="80px" />
              </asp:BoundField>
              <asp:BoundField DataField="businessTypeName" HeaderText="Type Name" 
                  SortExpression="businessTypeName" />
          </Columns>
          <HeaderStyle BackColor="#FFCC00" />
          <EditRowStyle BackColor="#99FFCC" />
          <PagerStyle BackColor="#FFFF99" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConflictDetection="CompareAllValues" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        DeleteCommand="DELETE FROM [businessType] WHERE [businessTypeID] = @original_businessTypeID AND (([businessTypeName] = @original_businessTypeName) OR ([businessTypeName] IS NULL AND @original_businessTypeName IS NULL))" 
        InsertCommand="INSERT INTO [businessType] ([businessTypeName]) VALUES (@businessTypeName)" 
        OldValuesParameterFormatString="original_{0}" 
        SelectCommand="SELECT * FROM [businessType]" 
        
        
              
              
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
        <br />

        </div>

        <div id="col-2-2">

            <h2>Add New Business Type:</h2>
            <br />
            <br />

        <asp:Label ID="Label1" runat="server" Text="Business Type:"></asp:Label>
        <asp:TextBox ID="typeBox" runat="server" Width="246px"></asp:TextBox>
        <asp:Button ID="addTypeButton" runat="server" onclick="addTypeButton_Click" Text="Add" />
          <br />
          <br />
          <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
              ControlToValidate="typeBox" ErrorMessage="Business Type Required"></asp:RequiredFieldValidator>

        </div>
      
      <% Response.WriteFile("includes/footer.aspx"); %>
         
  </div>
  <div id="footer-img"></div>
</form>
</body>
</html>