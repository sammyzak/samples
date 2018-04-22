<%@ Page Language="C#" %>
<%@ import Namespace="System.Data.SqlClient" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
	string bid;
    string businessname;

    protected void Page_Load(object sender, EventArgs e) {
		wws.authen.logoutIfNotValid();
        businessname = Request.QueryString["businessName"];
        bid = Request.QueryString["BID"];
		if(!IsPostBack){
			getAllBusinessTypes();
			getAllTubeStations();
            getAllCounties();
            getAllOffers();
		}
		loadBusinessTypes();
		loadTubeStations();
        loadCounties();
        loadOffers();
		
        string url = "~/production/images/logos/" + Request.QueryString["BID"] + ".jpg";
		
		Image1.ImageUrl = wws.nhs.imagePresent(Server.MapPath(url), "http://discounts-nhs.co.uk/production/images/logos/nologo.jpg");

        Image1.DataBind();

        HyperLink1.NavigateUrl = "~/production/business.aspx?BID=" + Request.QueryString["BID"];

        DetailsView1.Focus();
         
    }

	private void getAllBusinessTypes(){
		SqlConnection myConnection = new SqlConnection(wws.authen.getConn());
		try {
			myConnection.Open();
			try {
				SqlDataReader myReader = null;
				string strSql = "SELECT businessTypeID,businessTypeName FROM [businessType] ORDER BY businessTypeName";
				SqlCommand myCommand = new SqlCommand(strSql, myConnection);
				myReader = myCommand.ExecuteReader();
				lstBusinessTypes.Items.Clear();
				while (myReader.Read()) {
					lstBusinessTypes.Items.Add(new ListItem(myReader["businessTypeName"].ToString(),myReader["businessTypeID"].ToString()));
				}
				myReader.Close();
				myConnection.Close();
			}catch(Exception ex2){ Page.Title = "ex2:"+ex2.Message; }
		} catch (Exception ex1) { Page.Title = "ex1:" + ex1.Message; }
	}

	private void loadBusinessTypes(){
		string bTypesHtml = "";
		SqlConnection myConnection = new SqlConnection(wws.authen.getConn());
		try {
			myConnection.Open();
			try {
				SqlDataReader myReader = null;
				string strSql = "SELECT bbt.businessTypeID as typeID,bt.businessTypeName as typeName "+
									"FROM [business_businessType] as bbt,[businessType] as bt "+
										"WHERE businessID='"+bid+"'"+
											"AND bbt.businessTypeID = bt.businessTypeID";

				SqlCommand myCommand = new SqlCommand(strSql, myConnection);
				myReader = myCommand.ExecuteReader();
				int i = 0;
				bTypesHtml = "";
				while (myReader.Read()) {
					bTypesHtml += "<tr>"+
									"<td>" + myReader["typeName"].ToString() + "</td>"+
									"<td><input type='button' value='Unassign' onclick=doDel('" + myReader["typeID"].ToString() + "') /></td>"+
								  "</tr>";
					i++;
				}
				myReader.Close();
				myConnection.Close();
			}catch(Exception ex2){ Page.Title = "EX2"+ex2.Message; }
		}catch(Exception ex1){Page.Title = "EX1"+ex1.Message;}
		bTypes.InnerHtml = "<table class='types'><tr></tr>"+bTypesHtml+"</table>";
	}
	
	
// Tube Station Duplicate
	
	
	private void getAllTubeStations(){
		SqlConnection myConnection = new SqlConnection(wws.authen.getConn());
		try {
			myConnection.Open();
			try {
				SqlDataReader myReader = null;
				string strSql = "SELECT tubeID,tubeName FROM [tube] ORDER BY tubeName";
				SqlCommand myCommand = new SqlCommand(strSql, myConnection);
				myReader = myCommand.ExecuteReader();
				lstTubeStations.Items.Clear();
				while (myReader.Read()) {
					lstTubeStations.Items.Add(new ListItem(myReader["tubeName"].ToString(),myReader["tubeID"].ToString()));
				}
				myReader.Close();
				myConnection.Close();
			}catch(Exception ex2){ Page.Title = ex2.Message; }
		}catch(Exception ex1){Page.Title = ex1.Message;}
	}

	private void loadTubeStations(){
		string bStationsHtml = "";
		SqlConnection myConnection = new SqlConnection(wws.authen.getConn());
		try {
			myConnection.Open();
			try {
				SqlDataReader myReader = null;
				string strSql = "SELECT bbt.tubeID as tubeID,bt.tubeName as tubeName "+
									"FROM [business_tube] as bbt,[tube] as bt "+
										"WHERE businessID='"+bid+"'"+
											"AND bbt.tubeID = bt.tubeID";

				SqlCommand myCommand = new SqlCommand(strSql, myConnection);
				myReader = myCommand.ExecuteReader();
				int i = 0;
				bStationsHtml = "";
				while (myReader.Read()) {
					bStationsHtml += "<tr>"+
									"<td>" + myReader["tubeName"].ToString() + "</td>"+
									"<td><input type='button' value='Unassign' onclick=doDelTube('" + myReader["tubeID"].ToString() + "') /></td>"+
								  "</tr>";
					i++;
				}
				myReader.Close();
				myConnection.Close();
			}catch(Exception ex2){ Page.Title = ex2.Message; }
		}catch(Exception ex1){Page.Title = ex1.Message;}
		bStations.InnerHtml = "<table class='types'><tr></tr>"+bStationsHtml+"</table>";
	}
	
// End of Tube Station Duplicate

    
// County Duplicate


    private void getAllCounties()
    {
        SqlConnection myConnection = new SqlConnection(wws.authen.getConn());
        try
        {
            myConnection.Open();
            try
            {
                SqlDataReader myReader = null;
                string strSql = "SELECT countyID,countyName FROM [county] ORDER BY countyName";
                SqlCommand myCommand = new SqlCommand(strSql, myConnection);
                myReader = myCommand.ExecuteReader();
                lstCounty.Items.Clear();
                while (myReader.Read())
                {
                    lstCounty.Items.Add(new ListItem(myReader["countyName"].ToString(), myReader["countyID"].ToString()));
                }
                myReader.Close();
                myConnection.Close();
            }
            catch (Exception ex2) { Page.Title = "EX2:"+ex2.Message; }
        }
        catch (Exception ex1) { Page.Title = "EX1:" +ex1.Message; }
    }

    private void loadCounties()
    {
        string bCountyHtml = "";
        SqlConnection myConnection = new SqlConnection(wws.authen.getConn());
        try
        {
            myConnection.Open();
            try
            {
                SqlDataReader myReader = null;
                string strSql = "SELECT bc.countyID as countyID,c.countyName as countyName " +
                                    "FROM [business_county] as bc,[county] as c " +
                                        "WHERE businessID='" + bid + "'" +
                                            "AND bc.countyID = c.countyID";

                SqlCommand myCommand = new SqlCommand(strSql, myConnection);
                myReader = myCommand.ExecuteReader();
                int i = 0;
                bCountyHtml = "";
                while (myReader.Read())
                {
                    bCountyHtml += "<tr>" +
                                    "<td>" + myReader["countyName"].ToString() + "</td>" +
                                    "<td><input type='button' value='Unassign' onclick=doDelCounty('" + myReader["countyID"].ToString() + "') /></td>" +
                                  "</tr>";
                    i++;
                }
                myReader.Close();
                myConnection.Close();
            }
            catch (Exception ex2) { Page.Title ="EX2"+ ex2.Message; }
        } catch (Exception ex1) { Page.Title = "EX1" + ex1.Message; }
        bCounty.InnerHtml = "<table class='types'><tr></tr>" + bCountyHtml + "</table>";
    }

// End of County Duplicate


// Offer Duplicate


    private void getAllOffers()
    {
        SqlConnection myConnection = new SqlConnection(wws.authen.getConn());
        try
        {
            myConnection.Open();
            try
            {
                SqlDataReader myReader = null;
				string strSql = "SELECT offerName,offerID FROM [offer] ORDER BY offerName";
                SqlCommand myCommand = new SqlCommand(strSql, myConnection);
                myReader = myCommand.ExecuteReader();
                lstOffer.Items.Clear();
                while (myReader.Read())
                {
                    lstOffer.Items.Add(new ListItem(myReader["offerName"].ToString(), myReader["offerID"].ToString()));
                }
                myReader.Close();
                myConnection.Close();
            }
            catch (Exception ex2) { Page.Title = ex2.Message; }
        }
        catch (Exception ex1) { Page.Title = ex1.Message; }
    }

    private void loadOffers()
    {
        string bOfferHtml = "";
        SqlConnection myConnection = new SqlConnection(wws.authen.getConn());
        try
        {
            myConnection.Open();
            try
            {
                SqlDataReader myReader = null;
				string strSql = @"SELECT o.offerID, o.offerName as offer FROM business_offers as bo,
									offer as o,
									business as b
								WHERE o.offerID = bo.offerID
									AND bo.businessID = b.businessID
									AND bo.businessID = '" + bid + "'"; 

                SqlCommand myCommand = new SqlCommand(strSql, myConnection);
                myReader = myCommand.ExecuteReader();
                int i = 0;
                bOfferHtml = "";
                while (myReader.Read())
                {
                    bOfferHtml += "<tr>" +
                                    "<td>" + myReader["offer"].ToString() + "</td>" +
                                    "<td><input type='button' value='Unassign' onclick=doDelOffer('" + myReader["offerID"].ToString() + "') /></td>" +
                                  "</tr>";
                    i++;
                }
                myReader.Close();
                myConnection.Close();
            }
            catch (Exception ex2) { Page.Title = ex2.Message; }
        }
        catch (Exception ex1) { Page.Title = ex1.Message; }
        bOffer.InnerHtml = "<table class='types'><tr></tr>" + bOfferHtml + "</table>";
    }

    // End of County Duplicate            
   

    protected void btnAssignType_Click(object sender, EventArgs e) {
		wws.nhs.assignBusinessType(bid, lstBusinessTypes.Items[lstBusinessTypes.SelectedIndex].Value);
		loadBusinessTypes();
        lstBusinessTypes.Focus();
	}
	
	protected void btnAssignStation_Click(object sender, EventArgs e) {
		wws.nhs.assignTubeStation(bid, lstTubeStations.Items[lstTubeStations.SelectedIndex].Value);
		loadTubeStations();
        lstTubeStations.Focus();
	}

    protected void btnAssignCounty_Click(object sender, EventArgs e)
    {
        wws.nhs.assignBusinessCounty(bid, lstCounty.Items[lstCounty.SelectedIndex].Value);
        loadCounties();
        lstCounty.Focus();
    }

    protected void btnAssignOffer_Click(object sender, EventArgs e)
    {
        wws.nhs.assignBusinessOffer(bid,lstOffer.Items[lstOffer.SelectedIndex].Value);
        loadOffers();
        lstOffer.Focus();
    }


    protected void addTypeButton_Click(object sender, EventArgs e)
    {
        TextBox Name = FindControl("typeText") as TextBox;

        SqlDataSource6.InsertParameters["businessTypeName"].DefaultValue = typeText.Text;

        SqlDataSource6.Insert();

        typeText.Text = String.Empty;

        Page.Response.Redirect(Page.Request.Url.ToString(), true);

        lstBusinessTypes.Focus();
    }

    protected void addCountyButton_Click(object sender, EventArgs e)
    {
        TextBox County = FindControl("countyText") as TextBox;

        SqlDataSource7.InsertParameters["countyName"].DefaultValue = countyText.Text;

        SqlDataSource7.Insert();

        countyText.Text = String.Empty;

        Page.Response.Redirect(Page.Request.Url.ToString(), true);

        lstCounty.Focus();
    }

    protected void addOfferButton_Click(object sender, EventArgs e)
    {
        TextBox Offers = FindControl("offerText") as TextBox;

        SqlDataSource8.InsertParameters["offerName"].DefaultValue = offerText.Text;

        SqlDataSource8.Insert();

        offerText.Text = String.Empty;

        Page.Response.Redirect(Page.Request.Url.ToString(), true);

        lstOffer.Focus();
    }

// Logo Upload and Image Resize  

    		
        protected string savePath = "~/production/images/logos/";
		
		public System.Drawing.Bitmap ResizeBitmap (System.Drawing.Bitmap src, int newWidth, int newHeight) 
		{
    		System.Drawing.Bitmap result = new System.Drawing.Bitmap(newWidth, newHeight);
    		using ( System.Drawing.Graphics g = System.Drawing.Graphics.FromImage((System.Drawing.Image)result) ) 
    		{
        		g.DrawImage(src, 0, 0, newWidth, newHeight);
    		}
    		return result;
		}
		
		protected void uploadBtn_Click (object sender, EventArgs e) 
		{
    		string fileName = fuImageFile.FileName;

    		// Get the bitmap data from the uploaded file
    		System.Drawing.Bitmap src = System.Drawing.Bitmap.FromStream(fuImageFile.PostedFile.InputStream) as System.Drawing.Bitmap;

    		// Resize the bitmap data
    		System.Drawing.Bitmap result = ResizeBitmap (src, 300, 300);

    		string saveName = Server.MapPath(savePath) +  Request.QueryString["BID"] + ".jpg";
    		result.Save(saveName, System.Drawing.Imaging.ImageFormat.Jpeg);
    		
    		Page.Response.Redirect(Page.Request.Url.ToString(), true);

            Image1.Focus();
		}
		
		public System.Drawing.Bitmap ProportionallyResizeBitmap (System.Drawing.Bitmap src, int maxWidth, int maxHeight) 
		{
    		// original dimensions
    		int w = src.Width;
    		int h = src.Height;

    		// Longest and shortest dimension
    		int longestDimension = (w>h)?w: h;
    		int shortestDimension = (w<h)?w: h;

    		// propotionality
    		float factor = ((float)longestDimension) / shortestDimension;

    		// default width is greater than height
    		double newWidth = maxWidth;
    		double newHeight = maxWidth/factor;

    		// if height greater than width recalculate
    		if ( w < h ) 
    		{
        		newWidth = maxHeight / factor;
        		newHeight = maxHeight;
    		}

    		// Create new Bitmap at new dimensions
    		System.Drawing.Bitmap result = new System.Drawing.Bitmap((int)newWidth, (int)newHeight);
    		using ( System.Drawing.Graphics g = System.Drawing.Graphics.FromImage((System.Drawing.Image)result) )
        	g.DrawImage(src, 0, 0, (int)newWidth, (int)newHeight);
    		return result;
		}

</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <%= wws.authen.isAdmin() %><% Response.WriteFile("includes/rolling-ads.aspx"); %>
<title>Discounts - NHS - Business Record</title>
    <% Response.WriteFile("includes/head.aspx"); %>
<script type="text/javascript">
		function doDel(id) {
			$.post("./Scripts/doDel.aspx", { bid: '<%= bid %>', tid: id }, function () {
				document.forms['<%= form1.ClientID %>'].submit();
			});
		}
		function doDelTube(id) {
			$.post("./Scripts/doDelTube.aspx", { bid: '<%= bid %>', tid: id }, function () {
				document.forms['<%= form1.ClientID %>'].submit();
			});
		}
		function doDelOffer(id) {
			$.post("./Scripts/doDelOffer.aspx", { bid: '<%= bid %>', oid: id }, function () {
				document.forms['<%= form1.ClientID %>'].submit();
			});
		}
		function doDelCounty(id) {
			$.post("./Scripts/doDelCounty.aspx", { bid: '<%= bid %>', cid: id }, function () {
				document.forms['<%= form1.ClientID %>'].submit();
			});
		}
	</script>
    <style type="text/css">
        .style1 {
            height: 68px;
        }
    </style>
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
	 <%= wws.authen.isAdmin() %>
      <% Response.WriteFile("includes/nav.aspx"); %>
    <div id="search">
        <asp:TextBox ID="SearchBox" runat="server"></asp:TextBox>
    </div>
      <% Response.WriteFile("includes/nav-admin.aspx"); %>
    <div id="col-1">
      <br />
      <h2>Business Profile:</h2>

      <asp:HyperLink ID="HyperLink1" runat="server">View Business Record</asp:HyperLink>
      <br />
      <br />

        <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" 
            CellPadding="10" DataKeyNames="businessID" DataSourceID="SqlDataSource1" 
            EnableModelValidation="True" Height="50px" Width="440px" 
            DefaultMode="Edit" BorderStyle="None" GridLines="None">
            <Fields>
                <asp:BoundField DataField="businessID" HeaderText="businessID" 
                    InsertVisible="False" ReadOnly="True" SortExpression="businessID" 
                    Visible="False" />
                <asp:TemplateField HeaderText="Name" SortExpression="businessName">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("businessName") %>' 
                            Width="240px"></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("businessName") %>' 
                            Width="240px"></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("businessName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Address 1" SortExpression="address1">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("address1") %>' 
                            Width="240px"></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("address1") %>' 
                            Width="240px"></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("address1") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Address 2" SortExpression="address2">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("address2") %>' 
                            Width="240px"></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("address2") %>' 
                            Width="240px"></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("address2") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Road" SortExpression="road">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("road") %>' 
                            Width="240px"></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("road") %>' 
                            Width="240px"></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("road") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Town" SortExpression="town">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("town") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("town") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("town") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Postcode" SortExpression="postcode">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("postcode") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("postcode") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("postcode") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Contact Name" SortExpression="contact_name">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("contact_name") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("contact_name") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label7" runat="server" Text='<%# Bind("contact_name") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Email" SortExpression="email">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("email") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("email") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label8" runat="server" Text='<%# Bind("email") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Website" SortExpression="website">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox12" runat="server" Text='<%# Bind("website") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox12" runat="server" Text='<%# Bind("website") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label12" runat="server" Text='<%# Bind("website") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Telephone" SortExpression="contact_number">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox11" runat="server" Text='<%# Bind("contact_number") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox11" runat="server" Text='<%# Bind("contact_number") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label11" runat="server" Text='<%# Bind("contact_number") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Fax" SortExpression="contact_fax">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox10" runat="server" Text='<%# Bind("contact_fax") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox10" runat="server" Text='<%# Bind("contact_fax") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label10" runat="server" Text='<%# Bind("contact_fax") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Addtional Information" SortExpression="info">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("info") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("info") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label9" runat="server" Text='<%# Bind("info") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:CheckBoxField DataField="isHidden" HeaderText="Hidden" 
                    SortExpression="isHidden" />
                <asp:CommandField ButtonType="Button" ShowEditButton="True" />
            </Fields>
        </asp:DetailsView>
        <br />
        <br />

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConflictDetection="CompareAllValues" 
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
             
            DeleteCommand="DELETE FROM [business] WHERE [businessID] = @original_businessID AND (([businessName] = @original_businessName) OR ([businessName] IS NULL AND @original_businessName IS NULL)) AND (([address1] = @original_address1) OR ([address1] IS NULL AND @original_address1 IS NULL)) AND (([address2] = @original_address2) OR ([address2] IS NULL AND @original_address2 IS NULL)) AND (([road] = @original_road) OR ([road] IS NULL AND @original_road IS NULL)) AND (([town] = @original_town) OR ([town] IS NULL AND @original_town IS NULL)) AND (([postcode] = @original_postcode) OR ([postcode] IS NULL AND @original_postcode IS NULL)) AND (([contact_name] = @original_contact_name) OR ([contact_name] IS NULL AND @original_contact_name IS NULL)) AND (([email] = @original_email) OR ([email] IS NULL AND @original_email IS NULL)) AND (([website] = @original_website) OR ([website] IS NULL AND @original_website IS NULL)) AND (([contact_number] = @original_contact_number) OR ([contact_number] IS NULL AND @original_contact_number IS NULL)) AND (([contact_fax] = @original_contact_fax) OR ([contact_fax] IS NULL AND @original_contact_fax IS NULL)) AND (([info] = @original_info) OR ([info] IS NULL AND @original_info IS NULL)) AND (([isHidden] = @original_isHidden) OR ([isHidden] IS NULL AND @original_isHidden IS NULL))" 
            
            InsertCommand="INSERT INTO [business] ([businessName], [address1], [address2], [road], [town], [postcode], [contact_name], [email], [website], [contact_number], [contact_fax], [info], [isHidden]) VALUES (@businessName, @address1, @address2, @road, @town, @postcode, @contact_name, @email, @website, @contact_number, @contact_fax, @info, @isHidden)" 
            OldValuesParameterFormatString="original_{0}" 
            SelectCommand="SELECT * FROM [business] WHERE ([businessID] = @businessID)"
             
            
            
            
            
            
            
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
            <SelectParameters>
                <asp:QueryStringParameter Name="businessID" QueryStringField="bid" 
                    Type="Int32" />
            </SelectParameters>
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
      <hr />
      
      <div id="edit-logo">

      <table>
      
      <td><h2>Logo:   
      <tr>
      
      <td>
	  <asp:Image ID="Image1" runat="server" width="200px" height="200px" ImageUrl="" EnableViewState="False" /></td>    
      <td>
      
      	<asp:Label ID="labelStatus" runat="server" Visible="False"></asp:Label>
      	
      	<br />
      
      	<asp:FileUpload ID="fuImageFile" runat="server" />
      	
      	<br />
      
      	<asp:Button ID="uploadBtn" runat="server" OnClick="uploadBtn_Click" Text="Upload" />
      
      </td>
      
      </table>
    
      <br />

      </div>

      <hr />

      <div id="edit-station">

      <br />
      <table>
      <th><h2>Nearby Tube Stations:</h2></th><th><h2>Add Locations:</h2></th>
      <tr>
       <!-- ANTHONY'S HTML FOR EDITING STATIONS -->
       <td>
      <div>
        <div id="bStations" runat="server"></div>
        <div id="addStations">
       </td> 
       <td>
          <asp:DropDownList ID="lstTubeStations" runat="server" />
          <asp:Button ID="btnAssignStation" runat="server" Text="Assign" 
               onclick="btnAssignStation_Click" style="height: 26px" />
       </td>   
        </div>
      </div>
      <!--  -->
      </table>
      
      <br />

      </div>

      <hr />

      <div id="edit-type">

      <br />
     
      <table>
      <td><h2>Business Type:</h2></td><td><h2>Add New Business Type:</h2></td>
      <tr>
      <td>
      
      <!-- ANTHONY'S HTML FOR EDITING BUSINESS TYPES -->
      <div>
        <div id="bTypes" runat="server"></div>
        <div id="addTypes">
        <br />
          <asp:DropDownList ID="lstBusinessTypes" runat="server" Width="200px" />
          <asp:Button ID="btnAssignType" runat="server" Text="Assign" onclick="btnAssignType_Click" />
        </div>
      </div>
      <!--  -->
      
      </td>
      <br />
      <td>
      
      <asp:Label ID="Label1" runat="server" Text="Type:"></asp:Label>
      <asp:TextBox ID="typeText" runat="server" Width="200px"></asp:TextBox>
      <asp:Button ID="addTypeButton" runat="server" Text="Add" 
              onclick="addTypeButton_Click" />
      
      </td>
      
      </table>

      <br />
      <asp:SqlDataSource ID="SqlDataSource6" runat="server" 
          ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
          SelectCommand="SELECT [businessTypeID], [businessTypeName] FROM [businessType]" 
          OldValuesParameterFormatString="original_{0}" 
            ConflictDetection="CompareAllValues" 
            DeleteCommand="DELETE FROM [businessType] WHERE [businessTypeID] = @original_businessTypeID AND (([businessTypeName] = @original_businessTypeName) OR ([businessTypeName] IS NULL AND @original_businessTypeName IS NULL))" 
            InsertCommand="INSERT INTO [businessType] ([businessTypeName]) VALUES (@businessTypeName)" 
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

        </div>

        <hr />

        <div id="edit-county">

        <br />

        <table>
        
        <tr>

        <td><h2>County</h2></td>
        <td><h2>Add New County:</h2></td>

        </tr>
        <tr>
        
        <td>
        
        <!-- ANTHONY'S HTML FOR EDITING COUNTIES -->
      <div>
        <div id="bCounty" runat="server"></div>
        <div id="addCounty">
        <br />
          <asp:DropDownList ID="lstCounty" runat="server" Width="200px" />
          <asp:Button ID="btnAssignCounty" runat="server" Text="Assign" onclick="btnAssignCounty_Click" />
        </div>
      </div>
      <!--  -->
        
        </td>
        
        <td>
        
      <asp:Label ID="Label2" runat="server" Text="County:"></asp:Label>
      <asp:TextBox ID="countyText" runat="server" Width="200px"></asp:TextBox>
      <asp:Button ID="addCountyButton" runat="server" Text="Add" onclick="addCountyButton_Click" />
       
        </td>
        
        </tr>

        </table>
     
        <br />
        <br />
        <asp:SqlDataSource ID="SqlDataSource7" runat="server" 
            ConflictDetection="CompareAllValues" 
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            DeleteCommand="DELETE FROM [county] WHERE [countyID] = @original_countyID AND (([countyName] = @original_countyName) OR ([countyName] IS NULL AND @original_countyName IS NULL))" 
            InsertCommand="INSERT INTO [county] ([countyName]) VALUES (@countyName)" 
            OldValuesParameterFormatString="original_{0}" 
            SelectCommand="SELECT * FROM [county]" 
            UpdateCommand="UPDATE [county] SET [countyName] = @countyName WHERE [countyID] = @original_countyID AND (([countyName] = @original_countyName) OR ([countyName] IS NULL AND @original_countyName IS NULL))">
            <DeleteParameters>
                <asp:Parameter Name="original_countyID" Type="Int32" />
                <asp:Parameter Name="original_countyName" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="countyName" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="countyName" Type="String" />
                <asp:Parameter Name="original_countyID" Type="Int32" />
                <asp:Parameter Name="original_countyName" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>

     
        <br />
        <br />

        </div>

        <hr />

        <div id="edit-offer">

        <br />

        <table>

        <tr>

        <td><h2>Offers</h2></td>
        <td><h2>Add New Offer:</h2></td>

        </tr>

        <tr>

        <td>

        <!-- ANTHONY'S HTML FOR EDITING OFFERS -->
      <div>
        <div id="bOffer" runat="server"></div>
        <div id="addOffer">
        <br />
          <asp:DropDownList ID="lstOffer" runat="server" Width="200px" />
          <asp:Button ID="btnAssignOffer" runat="server" Text="Assign" onclick="btnAssignOffer_Click" />
        </div>
      </div>
      <!--  -->

      </td>

      <td>
      
      <asp:Label ID="Label3" runat="server" Text="Offer:"></asp:Label>
      <asp:TextBox ID="offerText" runat="server" Width="200px"></asp:TextBox>
      <asp:Button ID="addOfferButton" runat="server" Text="Add" onclick="addOfferButton_Click" />
      
      </td>

      </tr>

      </table>
     
        <br />
        <asp:SqlDataSource ID="SqlDataSource8" runat="server" 
            ConflictDetection="CompareAllValues" 
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            InsertCommand="INSERT INTO [offer] ([offerName]) VALUES (@offerName)" 
            OldValuesParameterFormatString="original_{0}" 
            SelectCommand="SELECT * FROM [offer]" 
            DeleteCommand="DELETE FROM [offer] WHERE [offerID] = @original_offerID AND [offerName] = @original_offerName" 
            
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

        <hr />
     
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