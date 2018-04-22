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
<%@ Import Namespace="System.Text.RegularExpressions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    
    protected void Page_Load(object sender, EventArgs e)
    {
    	wws.authen.logoutIfNotValid();
    }

    override protected void OnLoad(System.EventArgs e)
    {
        base.OnLoad(e);
        if (!IsPostBack)
        {
            GridView1.DataBind();
        }
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

    protected string[] CleanUploadList()
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

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<%= wws.authen.isAdmin() %>
<% Response.WriteFile("includes/rolling-ads.aspx"); %>
    <title>Discounts - NHS - Newsletters</title>
    <% Response.WriteFile("includes/head.aspx"); %>
</head>
<body onLoad="runSlideShow()" bgcolor="#00a4f8">
    <form id="form1" runat="server">
    <div>
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
      <div id="news">
        <h2>Newletters</h2>
        
        <br />
        
        <asp:GridView ID="GridView1" runat="server" DataSource="<%# GetUploadList() %>" 
        AutoGenerateColumns="False" BorderStyle="None" CellPadding="10" CellSpacing="1" 
        GridLines="Horizontal" ShowHeader="False" Width="450px" 
              EnableModelValidation="True" HorizontalAlign="Center" >
          <Columns>
              <asp:TemplateField HeaderText="Preview">
                  <EditItemTemplate>
                      <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                  </EditItemTemplate>
                  <ItemTemplate>
                      <asp:ImageButton ID="Image1" runat="server" 
                          ImageUrl='<%# wws.nhs.cleannewsletter(Container.DataItem.ToString()) %>' Width="100px" Height="100px" />
                  </ItemTemplate>
              </asp:TemplateField>
          <asp:TemplateField HeaderText="Newsletters">
            <ItemStyle HorizontalAlign="Center" Width="40%" />
            <ItemTemplate>
              <asp:Label ID="File" Text='<%# wws.nhs.cleanfname(Container.DataItem.ToString()) %>' runat="server" />
            </ItemTemplate>
            <ItemStyle HorizontalAlign="Center" Width="30%" />
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Download">
            <ItemStyle HorizontalAlign="Center" Width="40%" />
            <ItemTemplate>
              <asp:HyperLink ID="Download" NavigateUrl='<%# "newsletters/" + Container.DataItem.ToString() %>' Text="Download" runat="server" Target="_blank" ImageUrl="./images/pdf-small.jpg" />
            </ItemTemplate>
            <ItemStyle HorizontalAlign="Center" Width="30%" />
          </asp:TemplateField>
              <asp:TemplateField Visible="False">
                  <ItemTemplate>
                      <asp:Label ID="Label1" runat="server" Text="Download"></asp:Label>
                  </ItemTemplate>
              </asp:TemplateField>
          </Columns>
        </asp:GridView>
        <br />
        <h2>first medical NHS Gold Privilege Cards</h2>
        <p>If you have not received your fm NHS Gold Privilege Card please contact the HR Department and they will provide you with one. You can also use your NHS ID Card to obtain these discounts. As an existing member of this unique Programme, you will receive the latest offers from the likes of ASDA, Carphone Warehouse, La Senza, Littlewoods, etc and ongoing promotions from other participating businesses.</p>
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
