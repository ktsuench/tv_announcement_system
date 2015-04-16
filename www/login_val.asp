
<%'@language=vbscript%>
<%'option explicit%>
<%
    if instr(baseURL,"upload.asp")=-1 then
        const adLockOptimistic=3           
        const adOpenDynamic=2
        const adAddNew=16778240 
        const adDelete=16779264     
        const adUpdate=16809984
        const adUpdateBatch=65536
    end if
    
    dim baseURL, strURL
%>
<%
    dim objConn, objRS, strSQL
    dim username, pass
    dim verified, errMsg
    dim passAttemps
    
    username=request("email")
    pass=request("password")
    verified=false
    errMsg=""
    baseURL=request.servervariables("URL")
    strURL=mid(baseURL,1,instrrev(baseURL,"/"))
    strSQL="SELECT * FROM authentication ORDER BY Email"
    
    set objConn=server.createobject("ADODB.Connection")
    set objRS=server.createobject("ADODB.Recordset")
    
    objConn.connectionstring="DRIVER={Microsoft Access Driver (*.mdb)};DBQ="&server.mappath("db/rciann.mdb")
    objConn.open
    objRS.open strSQL, objConn
    
    do while not objRS.EOF and not verified
    	if username=objRS("email") and pass=objRS("password") then 
    		verified=true
    		errMsg=""
    	elseif username=objRS("email") and pass<>objRS("password") then
    		errMsg="Incorrect password for user."
    		exit do
    	else
    		errMsg="User does not exist."
    	end if
    	if not verified then objRS.movenext
    loop
    
    if verified then
    	session("verified")=true
    	session("email")=username
    	session("clearance")=objRS("clearance")
    	session("signature")=objRS("Signature")
    	session("id")=objRS("ID")
    	session("firstname")=objRS("firstname")
    	session("lastname")=objRS("lastname")
    	session("pass_attempts")=0
    	response.redirect(strURL&"dashboard.asp")
    else
    	session("error_message")=errMsg
    	session("status")=-1
    
    	if errMsg<>"User does not exist." then
    		if trim(session("username"))<>"" then session("prev_username")=session("username")
    		session("username")=username
    		if trim(session("prev_username"))<>"" and session("username")<>session("prev_username") then
    			session("pass_attempts")=1
    		else
    			session("pass_attempts")=session("pass_attempts")+1
    		end if
    	elseif trim(session("prev_username"))<>"" then
    		session("username")=""
    		session("prev_username")=""
    	end if
    	response.redirect(strURL&"login.asp")
    end if
    
    objRS.close
    objConn.close
    set objRs=nothing
    set objConn=nothing
%>