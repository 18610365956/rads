<%@ page language="java" contentType="text/html;charset=gb2312"%>
<%@ page
	import="cn.com.infosec.netcert.framework.resource.*,cn.com.infosec.netcert.rads61.resource.*,cn.com.infosec.netcert.framework.*,java.util.*,java.text.*,cn.com.infosec.netcert.rads61.*"%>
<%@ page errorPage="error.jsp"%>

<%
	request.setCharacterEncoding("gbk");
	String template = request.getParameter("template");
	String subjectDN = request.getParameter("subjectDN");
	String validTime = request.getParameter("validTime");
	String uuid = request.getParameter("userid");
	String publicKey = request.getParameter("publicKey");
	String tmpPubKey = request.getParameter("tmpPubKey");

	Properties p = new Properties();
	p.put(PropertiesKeysRes.TEMPLATENAME, template);
	p.put(PropertiesKeysRes.SUBJECTDN, subjectDN);
	p.put(PropertiesKeysRes.VALIDITYLEN, validTime);
	p.put(PropertiesKeysRes.UUID, uuid);
	p.setProperty(PropertiesKeysRes.PUBLICKEY, publicKey);

	if(tmpPubKey!=null && tmpPubKey.length()>0){
		p.setProperty(PropertiesKeysRes.RSA_TMP_PUB_KEY, tmpPubKey);      //rsa才使用这项内容
    	p.setProperty(PropertiesKeysRes.KMC_KEYLEN, "1024");
    	p.setProperty(PropertiesKeysRes.RETSYMALG, "RC4");
    	p.setProperty(PropertiesKeysRes.RETURNTYPE, "P7CERT");
	}else{
    	p.setProperty(PropertiesKeysRes.KMC_KEYLEN, "256");
    	p.setProperty(PropertiesKeysRes.RETSYMALG, "SM4");
    	p.setProperty(PropertiesKeysRes.RETURNTYPE, "CERT");
	}


	List<CustomExtValue> listAll = new ArrayList<CustomExtValue>();
	String num = request.getParameter("txtTRLastIndex");
	int size = Integer.valueOf(num);

	for (int i = 0; i < size; i++) {
		CustomExtValue ext = new CustomExtValue();
		String oid = request.getParameter("oid" + i);
		if("".equals(oid)||oid==null){
			break;
		}
		ext.setOid(oid);	
		ext.setType(request.getParameter("extType" + i));
		ext.setValue(request.getParameter("extValue" + i));
		listAll.add(ext);
	}

	Map<String, List<CustomExtValue>> map = new HashMap<String, List<CustomExtValue>>();
	for (int i = 0; i < listAll.size(); i++) {
		CustomExtValue customExtValue = listAll.get(i);
		String oid = customExtValue.getOid();
		if (!map.containsKey(oid)) {
			List<CustomExtValue> listExtValue = new ArrayList<CustomExtValue>();
			listExtValue.add(customExtValue);
			map.put(oid, listExtValue);
		} else {
			List<CustomExtValue> list = map.get(oid);
			map.remove(oid);
			list.add(customExtValue);
			map.put(oid, list);
		}
	}

	CertManager manager = CertManager.getInstance();
	Properties pro = manager.requestAndDown(p, map);
	String p7 = pro.getProperty(PropertiesKeysRes.P7DATA, "");
    String encCer = pro.getProperty(PropertiesKeysRes.P7DATA_ENC, "");  //加密证书返回内容
    String encPri = pro.getProperty(PropertiesKeysRes.ENCPRIVATEKEY, "");    //加密证书私钥
    String ukek = pro.getProperty(PropertiesKeysRes.TEMPUKEK, "");      //rsa才使用这项内容
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
					
					<textarea rows="30" cols="80" readonly="readonly">
----- 签名证书 开始 -----
<%=p7%>
----- 签名证书 结束 -----
<%if(encCer.length()>0){%>
----- 加密证书 开始 -----
<%=encCer%>
----- 加密证书 结束 -----
<%}%>
<%if(encPri.length()>0){%>
----- 加密私钥 开始 -----
<%=encPri%>
----- 加密私钥 结束 -----
<%}%>
<%if(ukek.length()>0){%>
----- 保护密钥 开始 -----
<%=ukek%>
----- 保护密钥 结束 -----
<%}%>
					</textarea>
				
				</div>
			</td>
		</tr>
	</table>
</body>
</html>