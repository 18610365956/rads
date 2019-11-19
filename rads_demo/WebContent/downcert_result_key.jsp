<%@ page language="java" contentType="text/html;charset=gb2312"%>
<%@ page
	import="cn.com.infosec.netcert.framework.resource.*,cn.com.infosec.netcert.framework.*,java.util.*,java.text.*,cn.com.infosec.netcert.rads61.*"%>
<%@ page errorPage="error.jsp"%>

<%
	String refno = request.getParameter("refno");
	String authcode = request.getParameter("authcode");

    String alg = request.getParameter("alg");

	String tmpPubKey = request.getParameter("tmpPubKey");
    String publicKey = request.getParameter("p10");
    String keyLen = request.getParameter("keyLen");

    String cryptProv=null, sm2KeySn=null,sm2_pin="";
    String symAlg = null, retType = null;
    if(alg.equals("SM2")){
        symAlg = "SM4";
        retType = "CERT";
		cryptProv = request.getParameter("sm2_cryptprov");
		sm2KeySn = request.getParameter("sm2_key_sn");
		sm2_pin = request.getParameter("sm2_pin");
    }else{
        symAlg = "RC4";
        retType = "CERT";
		cryptProv = request.getParameter("cryptprov");
    }
   
	Properties p = new Properties();
	p.setProperty(PropertiesKeysRes.REFNO, refno);
	p.setProperty(PropertiesKeysRes.AUTHCODE, authcode);
	p.setProperty(PropertiesKeysRes.PUBLICKEY, publicKey);
    p.setProperty(PropertiesKeysRes.RSA_TMP_PUB_KEY, tmpPubKey);      //rsa才使用这项内容
    p.setProperty(PropertiesKeysRes.KMC_KEYLEN, keyLen);
    p.setProperty(PropertiesKeysRes.RETSYMALG, symAlg);
    p.setProperty(PropertiesKeysRes.RETURNTYPE, retType);

	CertManager manager = CertManager.getInstance();
	Properties pro = manager.downCert(p);
	String signCer = pro.getProperty(PropertiesKeysRes.P7DATA, "");  //签名证书返回内容
    String encCer = pro.getProperty(PropertiesKeysRes.P7DATA_ENC, "");  //加密证书返回内容
    String encPri = pro.getProperty(PropertiesKeysRes.ENCPRIVATEKEY, "");    //加密证书私钥
    String ukek = pro.getProperty(PropertiesKeysRes.TEMPUKEK, "");      //rsa才使用这项内容
    
     System.out.println("[1]: "+signCer);
  	 System. out.println("[2]: "+encCer);
  	 System. out.println("[3]: "+encPri);
  	 System. out.println("[4]: "+ukek);
%>
<html>
<head>
<title>信安世纪RA演示系统</title>
<link rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html;charset=gb2312" />
	<OBJECT classid="clsid:9A10AF0C-A21B-4835-A276-7272405973C0" id="Enroll" codebase="SKFCSPEnroll_64.cab#version=6,31,73,5"></OBJECT>
	<script  type="text/javascript" src="sm2key.js"></script>
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
<%if(alg.equals("SM2")){%>
	var ret = setDevice('<%=cryptProv%>', '<%=sm2KeySn%>');
	if(0==ret){
		importSignCert('<%=signCer%>');
		<%if(encCer.length()>0){%>
		document.getElementById('Enroll').sm_skf_VerifyPin('<%=sm2_pin%>');
		importEncCert('<%=encCer%>', '<%=encPri%>');     //写加密证书
	    <%}%>
	}
<%}else{%>
    Enroll.rsa_csp_setProvider('<%=cryptProv%>');
    Enroll.rsa_csp_importSignX509Cert('','<%=signCer%>');
   //  rsa_enroll.writeClientCert_kex('<%=signCer%>');//用来下载域登录的RSA证书
   <%if(encCer.length()>0){%>
   Enroll.rsa_csp_importEncX509Cert('','<%=encCer%>', '<%=encPri%>', '<%=ukek%>',false,false);
   <%}%>
<%}%>

	document.write("<p align=center><b>证书下载完成</b></p>");
</script>

</body>
</html>