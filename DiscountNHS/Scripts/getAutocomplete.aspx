<%@ Page Language="C#" %>
<script runat="server">
	protected void Page_Load(object sender, System.EventArgs e) {
		/*Response.Write("test;1;1|tester;1;2");*/
		Response.Write(wws.nhs.autocomplete());
		return;
	}
</script>