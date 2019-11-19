//function.js
//�޸�RA����Ա��ģ��Ȩ��
function template()
{
    document.write("<select name='template'>");
    document.write("<option value='wo'>wo</option>");
    document.write("<option value='ee_sign'>ee_sign</option>");
	document.write("<option value='advance'>advance</option>");
	document.write("<option value='code_sign'>code_sign</option>");
	document.write("<option value='cross_ca'>cross_ca</option>");
	document.write("<option value='ms_domaincontroller'>ms_domaincontroller</option>");
	document.write("<option value='smart_card'>smart_card</option>");
	document.write("<option value='ocsp'>ocsp</option>");
	document.write("<option value='scep'>scep</option>");
	document.write("<option value='ssl_server'>ssl_server</option>");
	document.write("<option value='tsa'>tsa</option>");
	document.write("<option value='test'>test</option>");
	document.write("<option value=''></option>");
	document.write("</select>");
}

//��Կ����
function keylength()
{
   	document.write("<SELECT NAME='keylength'>");
	document.write("<OPTION SELECTED VALUE='512'>512</OPTION>");
	document.write("<OPTION  VALUE='1024'>1024</OPTION>");
	document.write("<OPTION  VALUE='2048'>2048</OPTION>");
	document.write("<OPTION  VALUE='4096'>4096</OPTION>");
	document.write("</SELECT>");
 }


