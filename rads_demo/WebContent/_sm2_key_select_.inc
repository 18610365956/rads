<%@page contentType="text/html;charset=gb2312"%>
	         <tr>
	          <td width='20%' align='right' bgcolor='#edefd9'>USB-Key Çý¶¯£º</td>
	          <td bgcolor='#eeeeec'>
	            <select id="sm2_cryptprov" name="sm2_cryptprov"  style="width: 200px" ></select>
	          </td>
	        </tr>
	        <tr>
	          <td align='right' bgcolor='#edefd9'>USB-Key ÐòÁÐºÅ£º</td>
	          <td bgcolor='#eeeeec'>
	            <select id="sm2_key_sn" name="sm2_key_sn"  style="width: 200px" ></select>
	            &nbsp;
	            <img src='refresh.jpg' border='0' alt='Ë¢ÐÂ' onclick='sm2_listKeys(document.all.sm2_key_sn, document.all.sm2_cryptprov.options[document.all.sm2_cryptprov.selectedIndex].text)'/>
	          </td>
	        </tr>
			<tr>
	          <td width='20%' align='right' bgcolor='#edefd9'>PINÂë£º</td>
	          <td bgcolor='#eeeeec'>
	            <input type="password" id="sm2_pin" name="sm2_pin"  style="width: 200px" ></select>
	          </td>
	        </tr>