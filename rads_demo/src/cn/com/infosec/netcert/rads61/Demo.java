package cn.com.infosec.netcert.rads61;
import java.io.StringReader;
import java.security.cert.X509Certificate;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
/**
 * 
 */
import java.util.Random;
import java.util.UUID;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentFactory;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

/**  
* @ClassName: Demo  
* @Description:   
* @author wanghaixiang  
* @date 2019年7月23日 上午11:32:51   
*    
*/
public class Demo {
	private String name;
	
	/*<?xml version="1.0" encoding="utf-8"?>

	<Entry oid="4ac4ab315d2841faa27421d557fa8863">
	  <item type="value0"/>
	  <item type="value-1427365723"/>
	  <item type="value-809722388"/>
	</Entry>*/
	/**
	 * @throws DocumentException   
	*
	* @Description:  
	* @param args  
	* @return void    
	* @throws  
	*/
	public static void main(String[] args) throws DocumentException {
		Document document = DocumentFactory.getInstance().createDocument("utf-8");
		Element root = document.addElement("Entry");
		for (int i = 0; i < 3; i++) {
			if(i==0) {
				root.addAttribute("oid", UUID.randomUUID().toString().replaceAll("-", ""));
			}
			Element item = root.addElement("item");
			item.addAttribute("type", "value"+i*(new Random().nextInt()+1));
			item.addCDATA("value"+i*(new Random().nextInt()+1));
		}
		root.addElement("name").addText("wanghx");
		root.addElement("age").addText("19");
		String asXML = root.asXML();
		System.out.println(asXML);
		Document element =  new SAXReader().read(new StringReader(asXML));
		Element rootElement = element.getRootElement();
		String name = rootElement.element("name").getName();
		String value= rootElement.element("name").getStringValue();
		System.out.println(name+": "+value);
	}

}
