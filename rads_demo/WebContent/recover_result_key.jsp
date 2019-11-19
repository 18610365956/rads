<%@ page language="java" contentType="text/html;charset=gb2312"%>
<%@ page
	import="cn.com.infosec.netcert.framework.resource.*,cn.com.infosec.netcert.framework.*,java.util.*,java.text.*,cn.com.infosec.netcert.rads61.*"%>
<%@ page errorPage="error.jsp"%>

<%
	String refno = request.getParameter("refno");
	String authcode = request.getParameter("authcode");
    String alg = request.getParameter("alg");
    String symAlg = request.getParameter("symAlg");
    String publicKey = request.getParameter("p10");

    String cryptProv=null, sm2KeySn=null;
    if(alg.equals("SM2")){
		cryptProv = request.getParameter("sm2_cryptprov");
		sm2KeySn = request.getParameter("sm2_key_sn");
    }else{
		cryptProv = request.getParameter("cryptprov");
    }




	Properties p = new Properties();
	p.setProperty(PropertiesKeysRes.REFNO, refno);
	p.setProperty(PropertiesKeysRes.AUTHCODE, authcode);	//旧方式，仍保留
//	p.setProperty(PropertiesKeysRes.SECUREAUTHCODE, authcode);	//新方式
	p.setProperty(PropertiesKeysRes.PUBLICKEY, publicKey);
    p.setProperty(PropertiesKeysRes.RETSYMALG, symAlg);

	CertManager manager = CertManager.getInstance();
	Properties pro = manager.recoverEncCert(p);
    String encCer = pro.getProperty(PropertiesKeysRes.P7DATA_ENC, "");  //加密证书返回内容
    String encPri = pro.getProperty(PropertiesKeysRes.ENCPRIVATEKEY, "");    //加密证书私钥
    String ukek = pro.getProperty(PropertiesKeysRes.TEMPUKEK, "");      //ukek
    
  	 System. out.println("[2]: "+encCer);
  	 System. out.println("[3]: "+encPri);
  	 System. out.println("[4]: "+ukek);
%>
<html>
<head>
<title>信安世纪RA演示系统</title>
<link rel="stylesheet">
<!--OBJECT	classid="clsid:56CDEB7B-F041-4F5C-9861-D9E1A62157AD" id="ecc_enroll" width=0 height=0 codebase="netpassctrl.cab#version=6,1,1,14"> </OBJECT>
<OBJECT	classid=clsid:BF25F911-E8B0-4402-89BA-5298805F0F9A id="infosecEnroll" width=0 height=0></OBJECT>


<OBJECT	classid="clsid:ECF314B1-4159-46DE-AC9C-EB7B24CCA382" id="rsa_enroll" width=0 height=0 codebase="netcertenroll.cab#version=2,5,23,2"> </OBJECT-->

<OBJECT classid="clsid:9A10AF0C-A21B-4835-A276-7272405973C0" id="Enroll" codebase="SKFCSPEnroll_32.cab#version=6,31,73,5"></OBJECT>
<script type="text/javascript" src="sm2key.js"></script>
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

    <br /><br /><br /><br />
<script type="text/javascript">
<%if(symAlg.startsWith("SM")){		//SM1, SM4%>
	var ret = setDevice('<%=cryptProv%>', '<%=sm2KeySn%>');
debugger;
	if(0==ret){
		//document.getElementById('Enroll').sm_skf_VerifyPin('<%=request.getParameter("sm2_pin")%>');
		importEncCert('<%=encCer%>', '<%=encPri%>');     //写加密证书
	}
<%}else{	//RSA%>
	Enroll.rsa_csp_setProvider('<%=cryptProv%>');
    Enroll.rsa_csp_importEncP7Cert('','<%=encCer%>', '<%=encPri%>', '<%=ukek%>',true,true);
<%}%>

	document.write("<p align=center><b>加密证书恢复完成</b></p>");
</script>

</body>
</html>