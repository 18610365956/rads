<%@ page language="java" contentType="text/html;charset=gb2312"%>
<%@ page errorPage="error.jsp"%>
<html>
<head>
<title>信安世纪RA演示系统</title>
<link rel="stylesheet">
<script LANGUAGE="javaScript" src=function.js></script>
</head>
<body background="qy_back.gif" leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellspacing="4" cellpadding="2">
		<tr bgcolor="#336699">
			<td>
				<div align="center" class="hei14">
					<b><font color="#FFFFFF">欢迎使用信安世纪RA演示系统</font></b>
				</div>
			</td>
		</tr>
	</table>


	<p>&nbsp;</p>
	<form name="free" action="register_user_result.jsp" method="post">
		<table width="60%" border="0" cellpadding="2" class="top"
			cellspacing="1" align="center" bgcolor="#00CCCC">
			<tr bgcolor="#CAEEFF">
				<td align=center>
					<table width="90%">
						<tr>
							<td>用户名:</td>
							<td><input type="text" name="userName" size="30" /></td>
						</tr>
						<tr>
							<td>电 话:</td>
							<td><input type="text" name="telephone" size="30"/></td>
						</tr>
						<tr>
							<td>邮 箱:</td>
							<td><input type="text" name="email" size="50"/></td>
						</tr>
						<tr>
							<td>备 注:</td>
							<td><input type="text" name="remark" size="80"/></td>
						</tr>
						<tr>
							<td colspan=2 align=center><input type=submit value="提  交"></td>
						</tr>
					</table>

				</td>
			</tr>
		</table>
	</form>



</body>
</html>