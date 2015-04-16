
<!--Bare Template-->
<%'@language=vbscript%>
<%'option explicit%>
<!--End Bare Template--><!DOCTYPE html>
<html lang="en">
    <head>
        <!--Template-->
        <meta charset="utf-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <meta name="author" content=""/>
        <link rel="icon" href="images/favicon.ico"/>
        <!--End Template-->
        <meta name="description" content="Riverdale Collegiate Institute Dashboard - Logout"/>
        <title>Riverdale Collegiate Institute Dashboard - Logout</title>
        <!--Template-->
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
        <!--End Template-->
    </head>
    <body>
        <%
            baseURL=request.servervariables("URL")
            strURL=mid(baseURL,1,instrrev(baseURL,"/"))
        %>
        <script type="text/javascript">window.location.replace('<%=strURL%>login.asp?a=l');
        </script>
    </body>
</html>