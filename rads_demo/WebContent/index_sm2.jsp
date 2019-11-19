<%@ page contentType="text/html;charset=gb2312"%>
<%@ page
	import="cn.com.infosec.netcert.rads61.resource.*,cn.com.infosec.netcert.rads61.*,java.io.*,java.security.Security,java.security.cert.*"%>
<%@ page errorPage="error.jsp"%>
<%
	//设置基本属性
	cn.com.infosec.netcert.rads61.SysProperty sysProperty = new cn.com.infosec.netcert.rads61.SysProperty();
	// CA服务器IP
	sysProperty.setTransIP("10.20.88.125");
	// CA服务器Port
	sysProperty.setTransPort(60001);
	// 加密机
	sysProperty.setHsmName("");
	// 通信协议
	sysProperty.setProtocolName("XML");
	// 密钥索引
	sysProperty.setKeyIdx("./cert/sm2/rads");
	// 密钥口令
	sysProperty.setPwd("11111111");
	// 加密算法
	Security.addProvider(new cn.com.infosec.jce.provider.InfosecProvider());
	
	sysProperty.setSignAlgName("SM3withSM2");
	//传输超时 单位秒 
   	sysProperty.setTransTimeout(60);
    //连接超时 单位秒
  	sysProperty.setConnectTimeout(20);
	// 签名证书
	Certificate cert = CertificateFactory.getInstance("X.509","INFOSEC")
	.generateCertificate(new FileInputStream("./cert/sm2/rads.cer"));
	sysProperty.setSignCert(cert);
	sysProperty.setSSL_TrustStore("./cert/sm2/ca.cer");
	/***
		//加上此段可以记录香型的RADS的日志
	***/
	Writer debugWriter  = new OutputStreamWriter(new FileOutputStream("./RADSDebug.log"));
	sysProperty.setDebugWriter(debugWriter);

	// 通信通道类型 ssl或plain
	sysProperty.setChanelEncryptName("SSL");

	CertManager.setSysProperty(sysProperty); 
	
%>
<html>
<head>
<title>信安世纪RA演示系统</title>
<%@include file="header.inc"%>
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
