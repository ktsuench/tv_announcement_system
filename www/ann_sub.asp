
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
        strQuery="SELECT * FROM announcements"
    else
        strQuery="SELECT * FROM announcements WHERE ID="&int(id)
    end if
    
    set objConn=server.createobject("ADODB.Connection")
    set objRs=server.createobject("ADODB.Recordset")
    
    objConn.connectionstring="DRIVER={Microsoft Access Driver (*.mdb)};DBQ="&server.mappath("db/rciann.mdb")
    objConn.open
    objRs.open strQuery, objConn,, adLockOptimistic
    
    if not action="delete" then
        if not action="verify" then 
            if isempty(id) or isnull(id) then objRs.addnew
            objRs("Title")=request("subject")
            objRs("Description")=request("desc")
            objRs("Type")=request("anntype")
            objRs("Start_Date")=request("dateStart")
            objRs("End_Date")=request("dateFinish")
            objRs("Start_Time")=request("timeStart")
            objRs("End_Time")=request("timeFinish")
    
            dim img
            img=request("img")
            if not(isempty(img) or isnull(img)) then
                objRs("Image")=img
            elseif isempty(request("img-db")) or isnull(request("img-db")) or trim(request("img-db"))="" then
                objRs("Image")=""
            end if
    
            if isempty(id) or isnull(id) then
                objRs("Cur_Posted")=false
                objRs("Prev_Posted")=false
                objRs("Verified")=false
                objRs("Date_Created")=now()
                objRs("Created_By")=session("signature")
            end if
            
            objRs("Date_Modified")=now()
            objRs("Modified_By")=session("signature")
        else
            objRs("Verified")=true
        end if
    
        objRs.update
    else
        objRs.delete
    end if
    
    objRs.close
    objConn.close
    set objRs=nothing
    set objConn=nothing 
    
    response.redirect(strURL&"ann_list.asp?action=list")
%>