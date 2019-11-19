<%@ page language="java" contentType="text/html;charset=gb2312"%>
<%@ page
	import="cn.com.infosec.netcert.framework.resource.*,cn.com.infosec.netcert.framework.*,java.util.*,java.text.*,cn.com.infosec.netcert.rads61.*"%>
<%@ page errorPage="error.jsp"%>
<%
	request.setCharacterEncoding("gbk");
	String userid = request.getParameter("userid");
	String userName = request.getParameter("userName");
	String telephone = request.getParameter("telephone");
	String email = request.getParameter("email");
	String remark = request.getParameter("remark");

	Properties p = new Properties();
	p.setProperty(PropertiesKeysRes.UUID, userid);
	p.setProperty(PropertiesKeysRes.USERNAME, userName);
	p.setProperty(PropertiesKeysRes.TELEPHONE, telephone);
	p.setProperty(PropertiesKeysRes.EMAIL, email);
	p.setProperty(PropertiesKeysRes.REMARK, remark);

	CertManager manager = CertManager.getInstance();
	boolean flag = manager.modifyUser(p);

	String result = "修改成功";

	if (!flag) {
		result = "修改失败";
	}
%>

<html>
<head>
<title>信安世纪RA演示系统</title>

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
	<table width="500" border="0" cellpadding="2" cellspacing="1"
		class="top" align="center" bgcolor="#00CCCC">
		<tr bgcolor="#CAEEFF">
			<td colspan="18">
				<div align="left">
					<%=result%>
				</div>
			</td>
		</tr>
	</table>
</body>
</html>