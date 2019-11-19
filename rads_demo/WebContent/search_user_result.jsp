<%@page  language="java" contentType="text/html;charset=gb2312"%>
<%@page import="cn.com.infosec.netcert.rads61.*,cn.com.infosec.netcert.rads61.resource.*,cn.com.infosec.netcert.framework.resource.PropertiesKeysRes,java.util.*,java.text.*,cn.com.infosec.netcert.framework.*"%>
<%@page errorPage="error.jsp"%>
<%

        request.setCharacterEncoding("gbk");
		String userName = request.getParameter("userName");
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
		
		
		if (userName == null)
			userName = "";
		userName = userName.trim();

		Properties pro = new Properties();

		//pro.put(PropertiesKeysRes.UUID, uuid);
		
		pro.put(PropertiesKeysRes.USERNAME, userName);
		pro.put(PropertiesKeysRes.PAGENUM, pageNum);
		pro.put(PropertiesKeysRes.PAGESIZE, pageSize);

		CertManager manager = CertManager.getInstance();
		QueryResult qr = manager.searchUser(pro);

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

		<p>&nbsp;</p>

		<table width="60%" border="0" cellpadding="2" class="top"
			cellspacing="1" align="center" bgcolor="#00CCCC">
			<tr bgcolor="#CAEEFF">
				<td align=center>
					<table border="1">
						<tr>
							<!-- <th>用户ID</th> -->
							<th>ID</th>
							<th>用户名</th>
							<th>电话</th>
							<th>邮箱</th>
							<th>备注</th>
							<th>操作</th>
						</tr>

						<%
							for (int i = 0; i < results.length; i++) {
										if (results[i] != null) {
											String userid = results[i]
													.getProperty(PropertiesKeysRes.UUID,"");
											String name = results[i]
													.getProperty(PropertiesKeysRes.USERNAME,"");
											String telephone = results[i]
													.getProperty(PropertiesKeysRes.TELEPHONE,"");
											String email = results[i]
													.getProperty(PropertiesKeysRes.EMAIL,"");
											String remark = results[i]
													.getProperty(PropertiesKeysRes.REMARK,"");
											
						%>
						<tr>
							<td><%=userid%></td>
							<%-- <td><%=i+1 %></td> --%>
							<td><%=name%></td>
							<td><%=telephone%></td>
							<td><%=email%></td>
							<td><%=remark%></td>
							<td><a href="modify_user.jsp?userid=<%=userid%>">修改信息</a> <a
								href="requestCert.jsp?userid=<%=userid%>">申请证书</a> <a
								href="requestCert_date.jsp?userid=<%=userid%>">申请证书(指定起止时间)</a>
							</td> 
						</tr>
						<%
							}

						}
	
					if (pageNumInt != 1) {
						out.println("<a href=search_user_result.jsp?pageNum="
								+ (pageNumInt - 1) + ">上一页</a>");
					}
					//显示超链接
					for (int j = 1; j <= Integer.valueOf(totalPages); j++) {
						out.println("<a href=search_user_result.jsp?pageNum=" +j + ">["
								+j + "]</a>");
					}
					//下一页
					if (pageNumInt != totalPages) {
						out.println("<a href=search_user_result.jsp?pageNum="
								+ (pageNumInt + 1) + ">下一页</a>");
					}
					
					out.println("共 "+totalRow+" 条记录数");
						%>

					</table>
					
					
					
</body>
</html>