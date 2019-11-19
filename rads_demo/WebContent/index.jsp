<%@page import="cn.com.infosec.jce.provider.InfosecProvider"%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ page
	import="cn.com.infosec.netcert.rads61.resource.*,cn.com.infosec.netcert.rads61.*,java.io.*,java.security.Security,java.security.cert.*"%>
<%//@ page errorPage="error.jsp"%>
<%
	//设置基本属性
	SysProperty sysProperty = new SysProperty();
	// CA服务器IP
	sysProperty.setTransIP("10.20.61.141");
	// CA服务器Port
	sysProperty.setTransPort(22343);
	
	// 通信协议
	sysProperty.setProtocolName("XML");

	// 密钥索引
	sysProperty.setKeyIdx("d:/ra");
	// 加密机
	sysProperty.setHsmName("");
	// 密钥口令
	sysProperty.setPwd("123456");
	// 加密算法
	Security.addProvider(new InfosecProvider());
    sysProperty.setSignAlgName("SHA256withRSA");
    //sysProperty.setSignAlgName("SM3withSM2");
    

	// 签名证书
	Certificate cert = CertificateFactory.getInstance("X.509","INFOSEC").generateCertificate(new FileInputStream(new File("d:/ra.cer")));
	sysProperty.setSignCert(cert);
	
	// 通信通道类型 ssl或plain
   	sysProperty.setChanelEncryptName("plain");
	// 错误提示语言的类型，目前支持"CN"和"EN",可以不设置，默认为计算机本地语言,
	sysProperty.setCountry("CN");
	CertManager.setSysProperty(sysProperty); 
	
	
	
%>
<html>
<head>
<title>信安世纪RA演示系统</title>
</head>
<frameset rows="112,*,20" cols="*" border="0" framespacing="0">
	<frame src="top.jsp" marginwidth="0" marginheight="0" frameborder="NO"
		scrolling="NO" name="top">
	<frameset cols="160,*" rows="*">
		<frame src="left.jsp" name="left" target="right" scrolling="default"
			marginwidth="0" marginheight="0" frameborder="NO">
		<frame
			src="right.jsp"
			name="right" scrolling="default" frameborder="NO" marginwidth="0"
			marginheight="0">
	</frameset>
	<frame src="bottom.jsp" name="bottom" marginwidth="0" marginheight="0"
		scrolling="NO" frameborder="NO">
</frameset>
<noframes>
	<body bgcolor="#FFFFFF">

	</body>
</noframes>
</html>
