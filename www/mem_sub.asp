
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
	dim objConn, objRs, strQuery, id, action
	
	baseURL=request.servervariables("URL")
	strURL=mid(baseURL,1,instrrev(baseURL,"/"))
	id=request("ID")
	action=request("action")
	
	if isempty(id) or isnull(id) then 
		strQuery="SELECT * FROM authentication"
	else
		strQuery="SELECT * FROM authentication WHERE ID="&int(id)
	end if
	
	set objConn=server.createobject("ADODB.Connection")
	set objRs=server.createobject("ADODB.Recordset")
	
	objConn.connectionstring="DRIVER={Microsoft Access Driver (*.mdb)};DBQ="&server.mappath("db/rciann.mdb")
	objConn.open
	objRs.open strQuery, objConn,, adLockOptimistic
	
	if not action="delete" then
		if action="_cp" then
			if objRs("Password")=request("p") then 
				response.write("1")
			else
				response.write("0")
			end if
		else
			if isempty(id) or isnull(id) then objRs.addnew
			objRs("Firstname")=request("firstname")
			objRs("Lastname")=request("lastname")
			objRs("Clearance")=request("memtype")
	
			if action="editExisting" and trim(request("new_pass"))<>"" then
				objRs("Password")=request("new_pass")
			elseif trim(request("pass"))<>"" then
				objRs("Password")=request("pass")
			end if
	
			objRs("Email")=request("email")
			objRs("Signature")=ucase(left(request("firstname"),1)&left(request("lastname"),3))
			objRs("Status")=request("status")
			objRs.update
		end if
	else
		objRs.delete
	end if
	
	objRs.close
	objConn.close
	set objRs=nothing
	set objConn=nothing 
	
	if not action="_cp" then response.redirect(strURL&"mem_list.asp?action=list")
%>