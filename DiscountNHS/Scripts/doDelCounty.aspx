﻿<%@ Page Language="C#" %>
<%@ import Namespace="System.Data.SqlClient" %>
<script runat="server">
	protected void Page_Load(object sender, EventArgs e) {
		if(wws.authen.isUserAdmin()){
			try{
				int bid = Convert.ToInt32(HttpContext.Current.Request["bid"]);
				int cid = Convert.ToInt32(HttpContext.Current.Request["cid"]);
				SqlConnection myConnection = new SqlConnection(wws.authen.getConn());
					try {
						myConnection.Open();
						try {
							string strSql = "DELETE FROM [business_county] WHERE businessID = '" + bid.ToString() + "' AND countyID = '" + cid.ToString() + "'";
							SqlCommand myCommand = new SqlCommand(strSql, myConnection);
							Response.Write(myCommand.ExecuteNonQuery());
							myConnection.Close();
					}catch(Exception ex1){}
				}catch(Exception ex2){}
			}catch(Exception ex3){}
		}
	}
</script>