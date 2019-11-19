<%@ page language="java" contentType="text/html;charset=gb2312"%>
<%@ page
	import="cn.com.infosec.netcert.framework.resource.*,cn.com.infosec.netcert.framework.*,java.util.*,java.text.*,cn.com.infosec.netcert.rads61.*"%>
<%@ page errorPage="error.jsp"%>

<%
	//设置基本属性
	SysProperty sysProperty = new SysProperty();
	// CA服务器IP
	sysProperty.setTransIP("192.168.2.154");
	// CA服务器Port
	sysProperty.setTransPort(22345);
	// 通信协议
	sysProperty.setProtocolName("XML");
	// 通信通道类型 ssl或plain
    //sysProperty.setChanelEncryptName("plain");
	sysProperty.setChanelEncryptName("ssl");
    sysProperty.setSSL_TrustStore("D:\\workspace\\netcert_6.1\\caServer\\cert\\ca.cer");
    //sysProperty.setSSL_TrustStorePass("11111111");

	String refno = request.getParameter("refno");
	String authcode = request.getParameter("authcode");
	String publicKey = request.getParameter("publicKey");
	
	Properties p = new Properties();
	p.setProperty(PropertiesKeysRes.REFNO, refno);
	p.setProperty(PropertiesKeysRes.AUTHCODE, authcode);
	p.setProperty(PropertiesKeysRes.PUBLICKEY, publicKey);

	CertManager.setAnonymousSysProperty(sysProperty); 
	AnonymousCertManager manager = CertManager.getAnonymousInstance();
	Properties pro = manager.downCert(p);
	String p7 = pro.getProperty(PropertiesKeysRes.P7DATA, "");
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
					
					<textarea rows="10" cols="80" readonly="readonly"><%=p7%></textarea>
				
				</div>
			</td>
		</tr>
	</table>
</body>
</html>