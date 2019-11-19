<%@ page language="java" contentType="text/html;charset=gb2312"%>
<%@ page errorPage="error.jsp"%>
<html>
<head>
<title>信安世纪RA演示系统</title>
<link rel="stylesheet">

<!--OBJECT	classid="clsid:56CDEB7B-F041-4F5C-9861-D9E1A62157AD" id="ecc_enroll" width=0 height=0 codebase="netpassctrl.cab#version=6,1,1,14"> </OBJECT-->
<!-- <OBJECT	classid=clsid:BF25F911-E8B0-4402-89BA-5298805F0F9A id="infosecEnroll" width=0 height=0></OBJECT>

<OBJECT	classid="clsid:ECF314B1-4159-46DE-AC9C-EB7B24CCA382" id="rsa_enroll" width=0 height=0 codebase="netcertenroll.cab#version=2,5,23,2"> </OBJECT>
 -->
 
<OBJECT classid="clsid:9A10AF0C-A21B-4835-A276-7272405973C0" id="Enroll" codebase="SKFCSPEnroll_32.cab#version=6,31,73,5"></OBJECT>

<script charset="UTF-8" type="text/javascript" src="sm2key.js"></script>

<script type="text/javascript">
function FindRsaProviders(){
	var i=0;
	var temp = new Array();
	temp = Enroll.rsa_csp_listProvider().toArray();		
	if(temp != ''){
		for(;i < temp.length;i++){
				var el = document.createElement("OPTION");
				el.text = temp[i];
				el.value = temp[i];
				f.cryptprov.add(el);
				
		}
	}
}

function chg_alg(t){
    var s = t.options[t.selectedIndex].value;
    if(s.indexOf('RSA') != -1){
        document.all.csplist.style.display = '';
        document.all.sm2key.style.display = 'none';

		f.cryptprov.options.length =0;
		FindRsaProviders();
    }else{
        document.all.csplist.style.display = 'none';
        document.all.sm2key.style.display = '';
        
        f.sm2_cryptprov.options.length =0;
        findSM2provider(document.all.sm2_cryptprov, document.all.sm2_key_sn);
    }
}




function chk(){
    var s = f.alg.options[f.alg.selectedIndex].value;
    if(s.indexOf('RSA') != -1){
        var keyLen = s.substr(4,7);
        f.keyLen.value = keyLen;
        Enroll.rsa_csp_setProvider(f.cryptprov.options[f.cryptprov.selectedIndex].value);
        f.p10.value = Enroll.rsa_csp_genContainerP10(true,keyLen,'cn=test,o=test','','','',false,false).toArray()[1];
        //f.p10.value = rsa_enroll.genP10_kex(keyLen);//用来下载域登录的RSA证书
        if(f.sd.options[f.sd.selectedIndex].value=='d'){    //双证，产生临时公钥
            f.tmpPubKey.value = Enroll.rsa_csp_genEncKeyPair();
        }
    }else{  //sm2
		var ret = setDevice(document.all.sm2_cryptprov.options[document.all.sm2_cryptprov.selectedIndex].text, document.all.sm2_key_sn.options[document.all.sm2_key_sn.selectedIndex].text);
		if(ret != 0){
           return;
        }else{
	    	var pin = document.all.sm2_pin.value;
	    	if(pin != ''){
	    		var verify_result = document.getElementById('Enroll').sm_skf_VerifyPin(pin);
	    		if(verify_result == false){
	    			alert('pin码错误');
	    			return;
	    		}
	    	}else{
	    		alert('请输入pin码');
	    		return;
	    	}
	    	f.p10.value = genCsr('cn=test,o=test');   //产生sm2的p10
	        f.keyLen.value = 256;
        }
    }
    f.submit();
}
</script>
</head>
<body onLoad="FindRsaProviders()" background="qy_back.gif" leftmargin="0" topmargin="0"
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
	<form name="f" action="downcert_result_key.jsp" method="post">
    <input type="hidden" name="p10" />
    <input type="hidden" name="tmpPubKey" />
    <input type="hidden" name="keyLen" />
		<table width="60%" border="0" cellpadding="2" class="top" cellspacing="1" align="center" bgcolor="#00CCCC">
			<tr bgcolor="#CAEEFF">
				<td align=center>
					<table width="90%">
						<tr>
							<td >算法类型:</td>
							<td >
                                <select id="alg" name='alg' onchange='chg_alg(this)'>
                                    <option value="RSA_1024">RSA_1024</option>
                                    <option value="RSA_2048">RSA_2048</option>
                                    <option value="SM2">SM2</option>
                                </select>
                            </td>
						</tr>
						<tr>
							<td >证书类型:</td>
							<td >
                                <select id="sd" name='sd'>
                                    <option value="s">单证</option>
                                    <option value="d">双证</option>
                                </select>
                            </td>
						</tr>
						<tr>
							<td nowarp>参考号:</td>
							<td ><input type="text" name="refno" maxlength="50"/></td>
						</tr>
						<tr>
							<td nowarp>授权码：</td>
							<td>
								<input type="text" name="authcode" maxlength="50"/>
							</td>
						</tr>
                        <tr>
							<td colspan=2 align=center>
                                <div id='csplist'>
                                <table>
                                    <tr>
                                        <td>
                                            <select NAME="cryptprov"></select>
                                        </td>
                                    </tr>
                                </table>
                                </div>
                                <div id='sm2key' style='display:none'>
                                <table>
                                	<%@include file="_sm2_key_select_.inc"%>
                                </table>
                                </div>
                            </td>
							<td>
							</td>
						</tr>
						<tr align="center">
							<td colspan=2><input type=button value="下  载" onclick='chk()'></td>
						</tr>
					</table>
				
				</td>
			</tr>
		</table>
	</form>
</body>
</html>

