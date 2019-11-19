<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Demo</title>
<script type="text/javascript">

function t1(obr){
	var s =document.getElementById("test").value+obr;
	s=s+'-';
	document.getElementById("test").value=s;
}

</script>
</head>
<body onload="t1('load')">
<table>
<tr><td><label>name:</label></td><td><input type="text" onblur="t1('blur')" onchange="t1('changer')" onclick="t1('click')" ondblclick="t1('dbclick')" onfocus="t1('foucus')"
	onhelp="t1('help')" onkeydown="t1('keydown')" onkeypress="t1(keypress)" onkeyup="t1('keyup')"
	></td></tr>
<tr><td><label>mouse:</label></td><td><input type="text" onfocus="t1('foucus1')" onblur="t1('blur1')" onclick="t1('click1')" onmousedown="t1('mousedown')" onmousemove="t1('mousemove')" onmouseout="t1('mouseout')"  onmouseup="t1('mouseup')" ></td></tr>
<tr><td><label>select:</label></td><td><input type="checkbox" onselect="t1('select')" ></td></tr>
<tr><td><label>value:</label></td><td><input type="text" id ="test" style="width: 1000px"></td></tr>
<tr><td></td><td></td></tr>
<tr><td></td><td></td></tr>



<tr><td></td><td></td></tr>
<tr><td></td><td></td></tr>
<tr><td></td><td></td></tr>
<tr><td></td><td></td></tr>
<tr><td></td><td></td></tr>
<tr><td></td><td></td></tr>
<tr><td></td><td></td></tr>
<tr><td></td><td></td></tr>
<tr><td></td><td></td></tr>
<tr><td></td><td></td></tr>

</table>

</body>
</html>