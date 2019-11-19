<%@page contentType="text/html;charset=gb2312"%>
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
	<form name="free" action="revokeResult.jsp" method="post">
		<table width="60%" border="0" cellpadding="2" class="top"
			cellspacing="1" align="center" bgcolor="#00CCCC">
			<tr bgcolor="#CAEEFF">
				<td align=center>
					<table width="90%">
						<tr>
							<td>证书序列号(16进制)</td>
							<td><input type="text" name="certSN"  size="30"/></td>
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
							<td><input type="text" name="subjectDN" size="60"/></td>
						</tr>
						<tr>
							<td>废止原因</td>
							<td><select name="reason">
									<option value="0">Unspecified-未指定的原因</option>
									<option value="1">key Compromise-密钥安全</option>
									<option value="2">CA Compromise-密钥不安全</option>
									<option value="3">Affiliation Changed-改变证书的从属关系</option>
									<option value="4">Superseded-证书被替代但没有危及私钥安全</option>
									<option value="5">Cessation Of Operation-停止操作</option>
									<option value="6">Certificate Hold-证书停止使用</option>
									<option value="8">Remove From CRL-从CRL中删除</option>
									<option value="9">Privilege With Drawn-收回权限</option>
									<option value="10">AA Compromise-审计管理员密钥不安全</option>
							</select></td>
						</tr>
						<tr>
							<td colspan=2 align=center><input type=submit value="提  交" /></td>
						</tr>
					</table>

				</td>
			</tr>
		</table>
	</form>



</body>
</html>