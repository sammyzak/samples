<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
	protected void Page_Load(object sender, System.EventArgs e) {
		wws.authen.logoutIfNotValid();
		wws.authen.redirIfNotAdmin();

        offerBox.Focus();
	}

    protected void addOfferButton_Click(object sender, EventArgs e)
    {
        TextBox Offer = FindControl("offerBox") as TextBox;

        SqlDataSource1.InsertParameters["offerName"].DefaultValue = offerBox.Text;

        SqlDataSource1.Insert();

        offerBox.Text = String.Empty;
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
      <div id="content">
        <h2>Edit Business Offers</h2>
        <br />
        <asp:Label ID="Label1" runat="server" Text="Offer:"></asp:Label>
        <asp:TextBox ID="offerBox" runat="server" Width="550px"></asp:TextBox>
        <asp:Button ID="addOfferButton" runat="server" onclick="addOfferButton_Click" Text="Add" />
          <br />
          <br />
          <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
              ControlToValidate="offerBox" ErrorMessage="Offer Required"></asp:RequiredFieldValidator>
        <br />
        <br />
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
        AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="offerID" 
        DataSourceID="SqlDataSource1" Width="820px" BackColor="#FFFFCC" 
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
                      <asp:Button ID="Button1" runat="server" CausesValidation="False" 
                          CommandName="Edit" Text="Edit" />
                      &nbsp;<asp:Button ID="Button2" runat="server" CausesValidation="False" 
                          CommandName="Delete" Text="qDelete" Visible="False" />
                      <asp:Button ID="LinkButton1" runat="server" CausesValidation="False" 
                          CommandName="Delete" 
                          OnClientClick='return confirm("Are you sure you want to delete this Offer?");' 
                          Text="Delete" />
                  </ItemTemplate>
                  <ItemStyle Width="120px" />
              </asp:TemplateField>
          <asp:BoundField DataField="offerID" HeaderText="offerID" 
                SortExpression="offerID" InsertVisible="False" ReadOnly="True" 
                Visible="False" />
              <asp:TemplateField HeaderText="Offers" SortExpression="offerName">
                  <EditItemTemplate>
                      <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("offerName") %>' 
                          Width="550px"></asp:TextBox>
                  </EditItemTemplate>
                  <ItemTemplate>
                      <asp:Label ID="Label1" runat="server" Text='<%# Bind("offerName") %>'></asp:Label>
                  </ItemTemplate>
              </asp:TemplateField>
          </Columns>
          <HeaderStyle BackColor="#FFCC00" />
          <EditRowStyle BackColor="#99FFCC" />
          <PagerStyle BackColor="#FFFF99" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConflictDetection="CompareAllValues" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        DeleteCommand="DELETE FROM [offer] WHERE [offerID] = @original_offerID AND [offerName] = @original_offerName" 
        InsertCommand="INSERT INTO [offer] ([offerName]) VALUES (@offerName)" 
        OldValuesParameterFormatString="original_{0}" 
        SelectCommand="SELECT * FROM [offer] ORDER BY [offerID] DESC" 
        
        
              
              UpdateCommand="UPDATE [offer] SET [offerName] = @offerName WHERE [offerID] = @original_offerID AND [offerName] = @original_offerName">
          <DeleteParameters>
            <asp:Parameter Name="original_offerID" Type="Int32" />
            <asp:Parameter Name="original_offerName" Type="String" />
          </DeleteParameters>
          <InsertParameters>
            <asp:Parameter Name="offerName" Type="String" />
          </InsertParameters>
          <UpdateParameters>
            <asp:Parameter Name="offerName" Type="String" />
            <asp:Parameter Name="original_offerID" Type="Int32" />
            <asp:Parameter Name="original_offerName" Type="String" />
          </UpdateParameters>
        </asp:SqlDataSource>
        <br />
        <br />
        <br />
      </div>
      
      <% Response.WriteFile("includes/footer.aspx"); %>
         
  </div>
  <div id="footer-img"></div>
</form>
</body>
</html>