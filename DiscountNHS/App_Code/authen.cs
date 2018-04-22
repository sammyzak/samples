using System;
using System.Collections.Generic;
using System.Web;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Web.UI;
using System.Web.UI.HtmlControls;

/// <summary>
/// Eg:
///		authen x = new authen();
///		if(x.doLogin("smih@smith.com", "smith", false)){
///			//login success
///			if(x.validUser()){
///				//session variable set
///				//and is user
///			}
///		}
/// </summary>

namespace wws {
	public class nhs {
		public static string imagePresent(string imgFile, string failImg){
			string ret = failImg;

			System.IO.FileInfo imageFile = new System.IO.FileInfo(imgFile);
			bool fileExists = imageFile.Exists;
			if (fileExists) { 
				ret = imgFile;
			}

			return ret;
		}

		public static string cleannewsletter(string str) {
			string ext = System.IO.Path.GetExtension(str);
			string strSrc = "";
			switch(ext.ToLower()){
			case ".pdf":
                strSrc = "./newsletters/thumbs/" + System.IO.Path.GetFileNameWithoutExtension(str)+".jpg";
                //strSrc = "./images/pdf.png";
				break;
			default:
				strSrc =  "./newsletters/thumbs/" + str;
				break;
			}
			return strSrc;
		}
		public static string cleanfname(string str) {
			str = str.Substring(0, str.LastIndexOf(".")>0?str.LastIndexOf("."):str.Length);
			return str.Replace("_", "&nbsp;").Replace("-", "&nbsp;");
		}

		public static void assignBusinessType(string bid, string tid){
			SqlConnection myConnection = new SqlConnection(wws.authen.getConn());
			try {
				myConnection.Open();
				try {
					string strSql = "IF NOT EXISTS (SELECT * FROM [business_businessType] WHERE businessID="+bid+" AND businessTypeId="+tid+") " +
									"BEGIN "+
										"INSERT INTO [business_businessType] (businessID, businessTypeId) VALUES ("+bid+","+tid+") "+
									"END";
					SqlCommand myCommand = new SqlCommand(strSql, myConnection);
					myCommand.ExecuteNonQuery();
					myConnection.Close();
				} catch (Exception ex2) {}
			} catch (Exception ex1) {}
		}
		
		// sam's copy of assignBusinessType
		
		public static void assignTubeStation(string bid, string btid){
			SqlConnection myConnection = new SqlConnection(wws.authen.getConn());
			try {
				myConnection.Open();
				try {
					string strSql = "IF NOT EXISTS (SELECT * FROM [business_tube] WHERE businessID="+bid+" AND tubeID="+btid+") " +
									"BEGIN "+
										"INSERT INTO [business_tube] (businessID, tubeID) VALUES ("+bid+","+btid+") "+
									"END";
					SqlCommand myCommand = new SqlCommand(strSql, myConnection);
					myCommand.ExecuteNonQuery();
					myConnection.Close();
				} catch (Exception ex2) {}
			} catch (Exception ex1) {}
		}
		
		// end of sam's copy
		
		// 2nd copy of assignBusinessType
		
		public static void assignBusinessCounty(string bid, string hcid){
			SqlConnection myConnection = new SqlConnection(wws.authen.getConn());
			try {
				myConnection.Open();
				try {
					string strSql = "IF NOT EXISTS (SELECT * FROM [business_county] WHERE businessID="+bid+" AND countyID="+hcid+") " +
									"BEGIN "+
										"INSERT INTO [business_county] (businessID, countyID) VALUES ("+bid+","+hcid+") "+
									"END";
					SqlCommand myCommand = new SqlCommand(strSql, myConnection);
					myCommand.ExecuteNonQuery();
					myConnection.Close();
				} catch (Exception ex2) {}
			} catch (Exception ex1) {}
		}
		
		// end of 2nd copy
		
		// 3rd copy of assignBusinessType
		
		public static void assignBusinessOffer(string bid, string oid){
			SqlConnection myConnection = new SqlConnection(wws.authen.getConn());
			try {
				myConnection.Open();
				try {
					string strSql = "IF NOT EXISTS (SELECT * FROM [business_offers] WHERE businessID="+bid+" AND offerID="+oid+") " +
									"BEGIN "+
										"INSERT INTO [business_offers] (businessID, offerID) VALUES ("+bid+","+oid+")"+
									"END";
					SqlCommand myCommand = new SqlCommand(strSql, myConnection);
					myCommand.ExecuteNonQuery();
					myConnection.Close();
				} catch (Exception ex2) {}
			} catch (Exception ex1) {}
		}
		
		// end of 3rd copy
		public static bool getuserpass(int userid, out string email, out string pass){
			bool ret = false;
			email = "";
			pass = "";		

			authen x = new authen();
			if (x.validUser()) {
				SqlConnection myConnection = new SqlConnection(x.getConnectionString());
				try {
					myConnection.Open();
					try {
						string strSql = @"SELECT [email], [password] FROM [user]
											WHERE userID = '"+userid+"'";
						SqlCommand myCommand = new SqlCommand(strSql, myConnection);
						SqlDataReader myReader = null;
						myReader = myCommand.ExecuteReader();
						if (myReader.Read()) {
							email = myReader["email"].ToString();
							pass = myReader["password"].ToString();
							ret = true;
						}
						myReader.Close();
						myConnection.Close();
					} catch (Exception ex1) {
					}
				} catch (Exception ex2) {
				}
			}

			return ret;
		}

		public static string autocomplete() {
			//do some admin stuff
			string ret = "";
			authen x = new authen();

			SqlConnection myConnection = new SqlConnection(x.getConnectionString());
			try {
				myConnection.Open();
				try {
					SqlDataReader myReader = null;
					string strSql = "SELECT DISTINCT businessName AS aText, businessID AS aID, 1 AS aType FROM [business] " +
						"UNION " +
							"SELECT DISTINCT businessTypeName, bt.businessTypeID, 2 " +
								"FROM [business] as b, [businessType] as bt,[business_businessType] as bbt " +
								"WHERE bt.businessTypeID = bbt.businessTypeID " +
									"AND b.businessID = bbt.businessID "+
						"UNION "+
							"SELECT DISTINCT tubeName, t.tubeID, 3 "+
							"FROM [tube] as t "+
							"WHERE convert(varbinary(50), UPPER(tubeName)) != convert(varbinary(50), tubeName) " +
						"UNION "+
							"SELECT DISTINCT countyName, c.countyID, 4 "+
							"FROM [county] as c "+
							"WHERE convert(varbinary(50), UPPER(countyName)) != convert(varbinary(50), countyName) " +
						"ORDER BY aText";
						
						
						
					SqlCommand myCommand = new SqlCommand(strSql, myConnection);
					myReader = myCommand.ExecuteReader();
					while (myReader.Read()) {
						ret += (ret.Length > 0) ? "|" : "";
						ret += myReader["aText"].ToString() + ";" + myReader["aID"].ToString() + ";" + myReader["aType"].ToString();
					}
					myReader.Close();
					myConnection.Close();
				} catch (Exception ex1) {}
			} catch (Exception ex2) {}
			return ret;
		}
	}

	public class authen {
		static string connString = "user id=***********;password=***********;server=***********; connection timeout=30";
		private string err;
		private string rdUser; //remembered username
		private bool isAnAdmin = false;
		public string userID;

		public static void logoutIfNotValid() {
			authen x = new authen();
			if (!x.validUser()) { 
				HttpContext.Current.Response.Redirect("./login.aspx");
			}	
		}
		public static void redirIfNotAdmin() {
			authen x = new authen();
			if (!x.isAnAdmin) {
				HttpContext.Current.Response.Redirect("./default.aspx");
			}			
		}

		public static int changePass(string oldPass, string newPass) {
			int ret = -1;

			authen x = new authen();
			if (x.validUser()) {
				string uid = (string)HttpContext.Current.Session["uid"];

				SqlConnection myConnection = new SqlConnection(connString);
				try {
					myConnection.Open();
					try {
						string strSql = "UPDATE [dbo].[user]" +
							"SET password = '" + newPass + "'" +
							"WHERE userID = " + uid + " AND password='" + oldPass + "'";
						SqlCommand myCommand = new SqlCommand(strSql, myConnection);
						ret = myCommand.ExecuteNonQuery();
						myConnection.Close();
					} catch (Exception ex1) {
					}
				} catch (Exception ex2) {
				}
			}

			return ret; /*-1: failed, 0: old pass mismatch, >1: success*/
		}
		public static bool isUserAdmin() {
			authen x = new authen();
			return x.isAnAdmin;
		}

		public static string isAdmin() {
			//do some admin stuff
			authen x = new authen();
			string ret = "<style type='text/css'>.admin{display:none;}</style>";
			if (x.isAnAdmin) { //is admin
				ret = "<style type='text/css'>.useronly{display:none;}</style>";
			}
			return ret;
		}

		public authen() {
			if (HttpContext.Current.Session["uid"] == null) {
				HttpContext.Current.Session["uid"]= "";
			}else{
				SqlConnection myConnection = new SqlConnection(connString);
				try {
					myConnection.Open();
					try {
						SqlDataReader myReader = null;
						string strSql = "SELECT TOP 1 isAdmin FROM [dbo].[user] WHERE userID = '" + HttpContext.Current.Session["uid"]+"'";
						SqlCommand myCommand = new SqlCommand(strSql, myConnection);
						myReader = myCommand.ExecuteReader();
						while (myReader.Read()) {
							isAnAdmin = (myReader["isAdmin"].ToString() == "True");
						}
						myReader.Close();
						myConnection.Close();
					} catch (Exception ex1) {
						err = "Ex1:" + ex1.Message;
					}
				} catch (Exception ex2) {
					err = "Ex2:" + ex2.Message;
				}
			}
			userID = HttpContext.Current.Session["uid"].ToString();
		}

		private string getCookie(string cookie) {
			HttpCookie myCookie = new HttpCookie(cookie);
			myCookie = HttpContext.Current.Request.Cookies[cookie];

			if (myCookie != null)
				return myCookie.Value;
			else
				return("");
		}

		private void setCookie(string cookieName, string value) {
			if (HttpContext.Current.Request.Cookies[cookieName] != null) {
				HttpCookie myCookie = new HttpCookie(cookieName);
				myCookie.Expires = DateTime.Now.AddDays(-1d);
				HttpContext.Current.Response.Cookies.Add(myCookie);
			}

			HttpCookie cookie = HttpContext.Current.Response.Cookies[cookieName];
			cookie.Value = value;
			cookie.Expires = DateTime.Now.AddYears(100);
			HttpContext.Current.Response.Cookies.Add(cookie);
		}

		private void setSession(string uid){
			HttpContext.Current.Session["uid"] = uid;
		}

		private bool sendEmail(string oFrom, string oTo, string oSubject, string oBody) {
			bool ret = false;
			try {
				MailMessage mmsg = new MailMessage(oFrom, oTo, oSubject, oBody);
				mmsg.IsBodyHtml = true;

				SmtpClient emailClient = new SmtpClient("localhost", 25);
				emailClient.Send(mmsg);
				ret = true;
			} catch (Exception ex1) {
				err = "Ex1:" + ex1.Message;
			}
			return ret;
		}

		

		public bool emailPass(string email) {
			//forgotten email
			//check if you
			bool ret = false;
			SqlConnection myConnection = new SqlConnection(connString);
			try {
				myConnection.Open();
				try {
					SqlDataReader myReader = null;
					string strSql = "SELECT TOP 1 password FROM [dbo].[user] WHERE email = '" + email + "'";

					SqlCommand myCommand = new SqlCommand(strSql, myConnection);
					myReader = myCommand.ExecuteReader();
					string p_type, p_beds, p_status, p_price, miniDescr;
					while (myReader.Read()) {
						return sendEmail("no-reply@discount-nhs.co.uk", email, "Forgotten Password", "Your password is: "+myReader[0].ToString());
						ret = true;
					}
					myReader.Close();
					myConnection.Close();
				} catch (Exception ex1) {
					err = "Ex1:" + ex1.Message;
				}
			} catch (Exception ex2) {
				err = "Ex2:" + ex2.Message;
			}
			return ret;
		}

		public bool validUser() {
			return (!String.IsNullOrEmpty(HttpContext.Current.Session["uid"].ToString()));
		}

		public string getRememberedUser() {
			return getCookie("lastUser");
		}

		public bool doLogin(string user, string pass, bool remember){
			authen x = new authen();
			bool ret = false;
			setCookie("lastUser", (remember)?user:"");

			SqlConnection myConnection = new SqlConnection(connString);
			try {
				myConnection.Open();
				try {
					SqlDataReader myReader = null;
					string strSql = "SELECT userID FROM [dbo].[user] WHERE email = '"+user+"' AND password = '"+pass+"'";

					SqlCommand myCommand = new SqlCommand(strSql, myConnection);
					myReader = myCommand.ExecuteReader();
					while (myReader.Read()) {
						HttpContext.Current.Session["uid"] = myReader[0].ToString();
						userID = myReader[0].ToString();
						ret = true;
					}
					myReader.Close();
					myConnection.Close();
				} catch (Exception ex1) {
					err = "Ex1:" + ex1.Message;
				}
			}catch (Exception ex2){
				err = "Ex2:" + ex2.Message;
			}
			
			/*if (!ret) HttpContext.Current.Session["uid"]="";*/
			return ret;
		}

		public string getConnectionString() {
			return connString;
		}
		
		public static string getConn() {
			authen x = new authen();
			return x.getConnectionString();
		}

		public string getLastErrorMsg() {
			return err;
		}
	}
}