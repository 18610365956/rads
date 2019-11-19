<%@page contentType="text/html;charset=gb2312"%>
<%@ page errorPage="error.jsp"%>
<html>
<head>
<title>信安世纪RA演示系统</title>
<script LANGUAGE="javaScript" src=function.js></script>
<link rel="stylesheet">
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
	<form name="free" action="updateResult_date.jsp" method="post">
		<table width="60%" border="0" cellpadding="2" class="top"
			cellspacing="1" align="center" bgcolor="#00CCCC">
			<tr bgcolor="#CAEEFF">
				<td align=center>
					<table width="90%">
						<tr>
							<td>证书序列号(16进制)</td>
							<td><input type="text" name="certSN" size="30"/></td>
						</tr>
						<tr>
							<td>证书模版</td>
							<td>
								<script language="javascript">
									template();
								</script>
							</td>
						</tr>
						<tr>
							<td>Subject DN</td>
							<td><input type="text" name="subjectDN" size="80"/></td>
						</tr>
						<tr>
							<td>证书有效期开始时间</td>
							<td><input type="text" name="NOTBEFORE" size="30"/>(yyyymmddhhmmss)</td>
						</tr>
						<tr>
							<td>证书有效期截止时间</td>
							<td><input type="text" name="NOTAFTER" size="30"/>(yyyymmddhhmmss)</td>
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