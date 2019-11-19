<%@page contentType="text/html;charset=gb2312"%>
<%@ page
	import="cn.com.infosec.netcert.rads61.*,cn.com.infosec.netcert.rads61.resource.*,cn.com.infosec.netcert.framework.resource.PropertiesKeysRes,java.util.*,java.text.*,cn.com.infosec.netcert.framework.*"%>
<%@page errorPage="error.jsp"%>
<%
	request.setCharacterEncoding("gbk");
		String certSN = request.getParameter("certSN");
		String template = request.getParameter("template");
		String subjectDN = request.getParameter("subjectDN");
		String pageSize = request.getParameter("pageSize");
		String pageNum = request.getParameter("pageNum");
		if(null==pageSize || "".equals(pageSize)){
			pageSize = "30";
		}
		if(null==pageNum || "".equals(pageNum)){
			pageNum = "1";
		}
		int pageNumInt = Integer.valueOf(pageNum);
		int pageSizeInt = Integer.valueOf(pageSize);
		if (certSN == null)
			certSN = "";
		certSN = certSN.trim();
		if (subjectDN == null)
			subjectDN = "";
		subjectDN = subjectDN.trim();
		Properties pro = new Properties();
		pro.put(PropertiesKeysRes.CERTSN, certSN);
		pro.put(PropertiesKeysRes.TEMPLATENAME, template);
		pro.put(PropertiesKeysRes.SUBJECTDN, subjectDN);
		pro.put(PropertiesKeysRes.PAGESIZE, pageSize);
		pro.put(PropertiesKeysRes.PAGENUM, pageNum);

		CertManager manager = CertManager.getInstance();
		QueryResult qr = manager.searchCert(pro);

		Properties[] results = qr.getPs();
		int totalRow = qr.getTotalNums();
		int totalPages = qr.getTotalPages();
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
			<tr bgcolor="#CAEEFF">
				<td align=center>
					<table border="1">
						<tr>
							<th>证书序列号</th>
							<th>加密证书序列号</th>
							<th>证书状态</th>
							<th>证书生效时间</th>
							<th>证书失效时间</th>
							<th>模板类型</th>
							<th>是否过期</th>
							<th>证书DN</th>
						</tr>

						<%
							for (int i = 0; i < results.length; i++) {
										if (results[i] != null) {
											String sn = results[i]
													.getProperty(PropertiesKeysRes.CERTSN);
											String sn_enc = results[i]
													.getProperty(PropertiesKeysRes.CERTSN+"_ENC");
											String statusRes = results[i]
													.getProperty(PropertiesKeysRes.CERTSTATUS);
											String status = CertStatusRes
													.getCertStatusStringByResNum(Integer.valueOf(statusRes));
											String notBefore = results[i]
													.getProperty(PropertiesKeysRes.NOTBEFORE);
											String notAfter = results[i]
													.getProperty(PropertiesKeysRes.NOTAFTER);
											String templateName = results[i]
													.getProperty(PropertiesKeysRes.TEMPLATENAME);
											String isExpired = results[i]
													.getProperty(PropertiesKeysRes.ISEXPIRED);
											String dn = results[i]
													.getProperty(PropertiesKeysRes.SUBJECTDN);
						%>
						<tr>
							<td><%=sn%></td>
							<td><%=(sn_enc==null?"":sn_enc)%></td>
							<td><%=status%></td>
							<td><%=notBefore%></td>
							<td><%=notAfter%></td>
							<td><%=templateName%></td>
							<td><%=isExpired%></td>
							<td><%=dn%></td>
						</tr>
						<%
							}
									}
						
								
					if (pageNumInt != 1) {
						out.println("<a href=queryResult.jsp?template="+template+"&certSN="+certSN+"&pageNum="
								+ (pageNumInt - 1) + ">上一页</a>");
					}
					//显示超链接
					for (int j = 1; j <= Integer.valueOf(totalPages); j++) {
						out.println("<a href=queryResult.jsp?template="+template+"&certSN="+certSN+"&pageNum=" +j + ">["
								+j + "]</a>");
					}
					//下一页
					if (pageNumInt != totalPages) {
						out.println("<a href=queryResult.jsp?template="+template+"&certSN="+certSN+"&pageNum="
								+ (pageNumInt + 1) + ">下一页</a>");
					}
					
					out.println("共 "+totalRow+" 条记录数");
						%>
	               </table>
	        </td></tr>
	         
	</table>
</body>
</html>
