
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
    dim upload, count
    set upload=server.createobject("Persits.Upload") 
    count=upload.savevirtual("/kwik_disp/uploads") 
    response.write("success")
%>