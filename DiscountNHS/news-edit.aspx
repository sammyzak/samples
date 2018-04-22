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
    }

    override protected void OnLoad(System.EventArgs e)
    {
        base.OnLoad(e);
        if (!IsPostBack)
        {
            GridView1.DataBind();
        }
    }

    override protected void OnInit(EventArgs e)
    {
        base.OnInit(e);

        Button1.Click += Button1_Click;
    }

    protected string[] GetUploadList()
    {
        string folder = Server.MapPath("~/production/newsletters/");
        string[] files = Directory.GetFiles(folder);
        string[] fileNames = new string[files.Length];
        Array.Sort(files);

        for (int i = 0; i < files.Length; i++)
        {
            fileNames[i] = Path.GetFileName(files[i]);
        }

        return fileNames;
    }
    
    protected string[] GetUploadThumbList()
    {
        string folder = Server.MapPath("~/production/newsletters/thumbs");
        string[] files = Directory.GetFiles(folder);
        string[] fileNames = new string[files.Length];

        Array.Sort(files);

        for (int i = 0; i < files.Length; i++)
        {
            fileNames[i] = Path.GetFileName(files[i]);
        }

        return fileNames;
    }

    protected void UploadThisFile(FileUpload upload)
    {
        if (upload.HasFile)
        {
            string theFileName = Path.Combine(Server.MapPath("~/production/newsletters/"), upload.FileName);

            upload.SaveAs(theFileName);
            labelStatus.Text = "<b>File has been uploaded.</b>";

        }
    }

    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        e.Cancel = true;
        string fileName = ((HyperLink)GridView1.Rows[e.RowIndex].FindControl("FileLink")).Text;

        fileName = Path.Combine(Server.MapPath("~/production/newsletters/"), fileName);
        File.Delete(fileName);
        GridView1.DataBind();
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        UploadThisFile(FileUpload1);
        GridView1.DataBind();
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
        <h2>Update Newsletters</h2>
        <br />
        <asp:GridView ID="GridView1" runat="server" DataSource="<%# GetUploadList() %>" 
        OnRowDeleting="GridView1_RowDeleting" AutoGenerateColumns="False" BackColor="#FFFFCC" 
        BorderStyle="None" CellPadding="10" CellSpacing="1" GridLines="Horizontal" 
              EnableModelValidation="True" >
          <Columns>
              <asp:TemplateField HeaderText="Preview">
                  <EditItemTemplate>
                      <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                  </EditItemTemplate>
                  <ItemTemplate>
                       <asp:ImageButton ID="Image1" runat="server" 
                          ImageUrl='<%# wws.nhs.cleannewsletter(Container.DataItem.ToString()) %>' 
                           Width="100px" Height="100px" />
                  </ItemTemplate>
              </asp:TemplateField>
          <asp:TemplateField HeaderText="Uploaded File">
            <ItemStyle HorizontalAlign="Center" Width="70%" />
            <ItemTemplate>
              <asp:HyperLink
ID="FileLink" 
NavigateUrl='<%# "newsletters/" + Container.DataItem.ToString() %>' 
Text='<%# Container.DataItem.ToString() %>'
runat="server" Target="_blank" />
            </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="">
            <ItemStyle HorizontalAlign="Center" Width="30%" />
            <ItemTemplate>
              <asp:Button ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete"
OnClientClick='return confirm("Are you sure you want to delete this Newsletter?");'
Text="Delete" />
            </ItemTemplate>
          </asp:TemplateField>
          </Columns>
          <HeaderStyle BackColor="#FFCC00" />
        </asp:GridView>
      </div>
      <div id="col-2-2">
        <h2>Upload Newsletters</h2>
        <br />
        <asp:Label ID="labelStatus" runat="server"></asp:Label>
        <br />
        <asp:FileUpload ID="FileUpload1" runat="server" />
        <br />
        <asp:Button ID="Button1" runat="server" Text="Upload" OnClick="Button1_Click" />
          <br />
          <br />
          <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
              ControlToValidate="FileUpload1" ErrorMessage="No File Selected"></asp:RequiredFieldValidator>
        <br />
        <br />
      </div>
      
      <% Response.WriteFile("includes/footer.aspx"); %>
    
  </div>
<div id="footer-img"></div>
    </form>
</body>
</html>
