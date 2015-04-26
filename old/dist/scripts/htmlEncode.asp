<%
function htmlEntityEncode(str)
	dim i, char, charCode, newStr

	for i=1 to len(str)
		char=mid(str,i,1)
		charCode=ascw(char)
		newStr=newStr&"&#"&charCode
	next

	htmlEntityEncode=newStr
end function

function htmlEntityDecode(str)
	dim i, char, charCode, newStr, pos, strLen

	i=1
	pos=instr(i,str,"&#")
	do while(pos>0)
		strLen=instr(i+1,str,"&#")-pos
		charCode=mid(str,pos,strLen)
		char=chrw(charCode)
		newStr=newStr&char
		i=instr(i+1,str,"&#")
	loop

	htmlEntityDecode=newStr
end function
%>