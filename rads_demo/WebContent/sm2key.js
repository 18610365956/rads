/**
 objSel 是要显示国密key厂商的下拉列表
 */
function sm2_listProvider(objSel){
	objSel.options.length = 0;
	var ss = document.getElementById('Enroll').sm_skf_listProvider().toArray();
	if(ss!=''){
		var arr = ss;
		for(var i=0; i<arr.length; i++){
			var op = document.createElement("OPTION");
			op.text = arr[i];
			objSel.add(op);
		}
	}
}

/**
 objSel 是要显示国密key序列号的下拉列表
 dll 是国密key厂商的驱动名
 */
function sm2_listKeys(objSel, dll){
	objSel.options.length = 0;
	var ss = document.getElementById('Enroll').sm_skf_listDevice(dll).toArray();
	if(ss!=''){
		for(var i=0; i<ss.length; i++){
			var DevInfo = Enroll.sm_skf_getDeviceInfo(dll, ss[i]).toArray()[0];
			var op = document.createElement("OPTION");
			op.text = DevInfo;
			objSel.add(op);
		}
	}
}

/**
 在页面的onload事件调用。填充国密key厂商列表，和第一个厂商的当前连接设备的SN列表。
 objProviderSel: key厂商的下拉列表
 objSnSel：第一个厂商下的key的序列化下拉列表
 */
function findSM2provider(objProviderSel, objSnSel){
	sm2_listProvider(objProviderSel);
	if(objProviderSel.options.length>0){
		var dll = objProviderSel.options[0].text
		sm2_listKeys(objSnSel, dll);
	}
}

/**
 通过key序列号指定一个设备。在对一个key进行任何业务操作前，必须先调用此方法。
 provider：key厂商
 sn：key的序列号
 返回值：0-成功；1-失败，设置参数为空；
 */
function setDevice(provider, sn){
	if(provider==''){
		alert('请指定USB-Key的驱动。如果驱动列表为空，请检查驱动是否正确安装。');
		return 1;
	}else if(sn==''){
		alert('请指定要操作的USB-Key。如果USB-Key序列号列表为空，请确认USB-Key是否连接，并点击“刷新”按钮。');
		return 1;
	}else{
		document.getElementById('Enroll').sm_skf_useDevice(provider,sn,true);
		return 0;
	}
}

/**
 产生国密证书请求。
 dn：在证书请求中的主题，字符串。如果不指定主题，传入空串 ''
 */
function genCsr(dn){
	var p10 = document.getElementById('Enroll').sm_skf_genContainerP10(dn,'',true).toArray();
	return p10[1];
}

/**
 导入国密签名证书。应在产生证书请求后调用，导入对应的签名证书。
 cerBase64：证书的base64编码内容
 */
function importSignCert(cerBase64){
	if(cerBase64==''){
		alert('证书内容不能为空');
		return;
	}
	document.getElementById('Enroll').sm_skf_importSignX509Cert('',cerBase64);
	alert('导入签名证书成功');
}

/**
 导入国密加密证书。应在产生证书请求后调用，导入双证中的加密证书。
 cerBase64：证书的base64编码内容
 priKey: GMT-0009 封装的加密密钥的base64编码内容
 */
function importEncCert(cerBase64, priKey){
	if(cerBase64==''){
		alert('证书内容不能为空');
		return;
	}else if(priKey==''){
		alert('密钥内容不能为空');
		return;	
	}
	document.getElementById('Enroll').sm_skf_importEncX509Cert('',cerBase64, priKey);
	alert('导入加密证书成功');
}

/**
 使用key中的私钥做 SM3withSM2签名。返回签名结果的base64内容。
 */
function signData(plain){
	if(plain==''){
		alert('签名原文不能为空');
		return '';	
	}
	return document.getElementById('Enroll').signData(plain);
}

/**
 读取特定文本内容
 */
function readData(){
	return document.getElementById('Enroll').readData();
}

/**
 写入特定文本内容
 data：要写入的内容
 */
function writeData(data){
	document.getElementById('Enroll').writeData(data);
	alert('USB-Key写入数据成功');
}

/**
 产生安全的授权码
 refNo：参考号
 authCode：授权码
 p10：签名证书的证书请求
 */
function genSecureAuthCode(refNo, authCode, p10){
	return document.getElementById('Enroll').genSecureAuthCode(refNo, authCode, p10);
}