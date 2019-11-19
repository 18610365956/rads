<%@page contentType="text/html;charset=gb2312"%>

<html>
<head>
<title>信安世纪RA演示系统</title>

<link rel="stylesheet" href="gend.css">
<base target="right">
</head>

<body background="qy_back.gif" leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0">
	<table width="100%" border="0" cellspacing="4" cellpadding="2">

		<tr>
			<td><a href=register_user.jsp class=\left\>注册用户</a></td>
		</tr>
		<tr>
			<td><a href=search_user.jsp class=\left\>查询用户</a></td>
		</tr>
		<!--tr>
			<td><a href=modify_user.jsp class=\left\>修改用户信息</a></td>
		</tr-->
		<tr>
			<td><a href=requestCert_direct.jsp class=\left\>直接申请证书</a></td>
		</tr>
		<tr>
			<td><a href=requestAndSign.jsp class=\left\>一次下证（RA管用户）</a></td>
		</tr>
		<tr>
			<td><a href=downCert.jsp class=\left\>下载证书(p10)</a></td>
		</tr>
		<tr>
			<td><a href=downcert_key.jsp class=\left\>下载证书</a></td>
		</tr>
		<tr>
			<td><a href=downCertAnonymous.jsp class=\left\>匿名下载证书(p10)</a></td>
		</tr>
		<tr>
			<td><a href=revokeCert.jsp class=\left\>作废证书</a></td>
		</tr>
		<tr>
			<td><a href=updateCert.jsp class=\left\>更新证书</a></td>
		</tr>
		<tr>
			<td><a href=updateCert_date.jsp class=\left\>更新证书(指定起止时间)</a></td>
		</tr>
		<tr>
			<td><a href=lockCert.jsp class=\left\>冻结证书</a></td>
		</tr>
		<tr>
			<td><a href=unlockCert.jsp class=\left\>解冻证书</a></td>
		</tr>
		<tr>
			<td><a href=queryCert.jsp class=\left\>查询证书</a></td>
		</tr>
		<tr>
			<td><a href=getP7.jsp class=\left\>获取证书实体</a></td>
		</tr>
		<tr>
			<td><a href=get2Code.jsp class=\left\>重取两码</a></td>
		</tr>
		<tr>
			<td><a href=recoverCert.jsp class=\left\>恢复加密证书</a></td>
		</tr>
	</table>
</body>
</html>