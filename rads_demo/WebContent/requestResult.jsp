<%@ page contentType="text/html;charset=gb2312"%>
<%@ page
	import="cn.com.infosec.netcert.framework.resource.*,cn.com.infosec.netcert.rads61.resource.*,cn.com.infosec.netcert.framework.*,java.util.*,java.text.*,cn.com.infosec.netcert.rads61.*"%>
<%@ page errorPage="error.jsp"%>
<%@page import="java.math.BigDecimal"%>
<%
	request.setCharacterEncoding("gbk");
	String template = request.getParameter("template");
	String subjectDN = request.getParameter("subjectDN");
	String validTime = request.getParameter("validTime");
	String uuid = request.getParameter("userid");

	Properties pro = new Properties();
	pro.put(PropertiesKeysRes.TEMPLATENAME, template);
	pro.put(PropertiesKeysRes.SUBJECTDN, subjectDN);
	pro.put(PropertiesKeysRes.VALIDITYLEN, validTime);
	pro.put(PropertiesKeysRes.UUID, uuid);

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
	Properties p = manager.requestCert(pro, map);

	String ref = p.getProperty(PropertiesKeysRes.REFNO);
	String authCode = p.getProperty(PropertiesKeysRes.AUTHCODE);

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
					<%

							out.println("参考号 ：" + ref);
							out.print("<br>");
							out.println("授权码 ：" + authCode);
						
					%>
				</div>
			</td>
		</tr>
	</table>
</body>
</html>

