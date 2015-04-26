<%
function htmlEntityEncode(string)
	dim i, char, charCode, newStr

	for i=1 to len(string)
		char=mid(string,i,1)
		charCode=ascw(char)
		newStr=newStr&"&#"&charCode
	next

	htmlEntityEncode=newStr
end function
%>