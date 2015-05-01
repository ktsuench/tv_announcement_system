
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta name="description" content="Redirect"/>
		<title>Redirect</title>
	</head>
	<body>
		<%
			dim baseURL, strURL
			
			baseURL=request.servervariables("URL")
			strURL=mid(baseURL,1,instrrev(baseURL,"/"))
			
			'response.redirect(strURL&"login.asp")
			response.redirect(strURL&"site_under_construction.asp")
		%>
	</body>
</html>