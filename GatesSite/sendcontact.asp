<%
dim body
 
body = "New Enquiry from VMS Electric Gate Website submitted at: " & now() & "<br /><br />Name: "&request.Form("Name")&"<br/>Email: " & request.Form("Email")&"<br />Phone: " & request.Form("Phone") & "<br />Enquiry: " & request.Form("Enquiry")
 
Set Mail = Server.CreateObject("CDO.Message")
Set MailConfig = Server.CreateObject ("CDO.Configuration")
MailConfig.Fields( "http://schemas.microsoft.com/cdo/configuration/smtpserver" ) = "localhost"
MailConfig.Fields( "http://schemas.microsoft.com/cdo/configuration/smtpserverport" ) = 25
MailConfig.Fields( "http://schemas.microsoft.com/cdo/configuration/sendusing" ) = 2
MailConfig.Fields( "http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout" ) = 60
MailConfig.Fields.Update
Set Mail.Configuration = MailConfig
Mail.From = request.Form("Email")
Mail.To = "vms@live.co.uk"
Mail.Bcc = "matt@businessfish.co.uk"
Mail.Subject = "New Enquiry from VMS Electric Gates"
body = "<html><body><span STYLE='color:#003; font-size: 15px'>"&body&"</span></body></html>"
Mail.HTMLBody = body
Mail.Send
Set Mail = Nothing
Set MailConfig = Nothing

response.Redirect("thanks.html")
 
%>