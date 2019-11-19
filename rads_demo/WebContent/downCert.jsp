<%@ page contentType="text/html;charset=gb2312"%>
<%@ page
	import="cn.com.infosec.netcert.framework.resource.*,cn.com.infosec.netcert.framework.*,java.util.*,java.text.*,cn.com.infosec.netcert.rads61.*"%>
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
	<form name="f" action="downCert_result.jsp" method="post">
		<table width="60%" border="0" cellpadding="2" class="top" cellspacing="1" align="center" bgcolor="#00CCCC">
			<tr bgcolor="#CAEEFF">
				<td align=center>
					<table width="90%">
						<tr>
							<td>参考号；</td>
							<td><input type="text" name="refno" /></td>
						</tr>
						<tr>
							<td>授权码：</td>
							<td><input type="text" name="authcode" /></td>
						</tr>
						<tr>
							<td>P10：</td>
							<td><textarea id="p10" name="publicKey" cols=80 rows=10></textarea></td>
						</tr>
						<tr>
							<td>RSA临时公钥：</td>
							<td><textarea id="p10" name="tmpPubKey" cols=80 rows=10></textarea></td>
						</tr>
						<tr>
							<td colspan=2 align=center><input type=submit value="下  载"></td>
						</tr>
					</table>

				</td>
			</tr>
		</table>
	</form>

<p>如果是双证，RSA使用RC4做对称加密，国密使用SM4做对称加密</p>

</body>


</html>