// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) radix(10) lradix(10) 
// Source File Name:   CertManager.java

package cn.com.infosec.netcert.rads61;

import cn.com.infosec.jce.provider.InfosecProvider;
import cn.com.infosec.netcert.framework.Request;
import cn.com.infosec.netcert.framework.Response;
import cn.com.infosec.netcert.rads61.exception.CAException;
import cn.com.infosec.netcert.rads61.exception.RAException;
import cn.com.infosec.netcert.rads61.resource.CustomExtValue;
import cn.com.infosec.netcert.rads61.resource.QueryResult;
import cn.com.infosec.netcert.rads61.resource.RAErrorNumRes;
import cn.com.infosec.netcert.rads61.sender.SenderCreator;
import cn.com.infosec.netcert.rads61.util.DataChecker;
import cn.com.infosec.util.Base64;
import java.io.PrintStream;
import java.security.Security;
import java.util.*;
import org.dom4j.*;

// Referenced classes of package cn.com.infosec.netcert.rads61:
//            SysProperty

public class CertManager
{

    private CertManager(SysProperty sp)
        throws RAException
    {
        sc = new SenderCreator(sp);
    }

    public static CertManager getInstance()
        throws RAException
    {
        if(!sysProperty.containsKey("_default_"))
            throw new RAException("63000001", RAErrorNumRes.getProperty("63000001"));
        if(!inst.containsKey("_default_"))
        {
            CertManager cm = new CertManager((SysProperty)sysProperty.get("_default_"));
            inst.put("_default_", cm);
        }
        return (CertManager)inst.get("_default_");
    }

    public static CertManager getInstance(String name)
        throws RAException
    {
        if(!sysProperty.containsKey(name))
            throw new RAException("63000001", RAErrorNumRes.getProperty("63000001"));
        if(!inst.containsKey(name))
        {
            CertManager cm = new CertManager((SysProperty)sysProperty.get(name));
            inst.put(name, cm);
        }
        return (CertManager)inst.get(name);
    }

    public static void setSysProperty(SysProperty sp)
        throws RAException
    {
        if(sp == null)
        {
            throw new RAException("63000001", RAErrorNumRes.getProperty("63000001"));
        } else
        {
            sysProperty.put("_default_", sp);
            return;
        }
    }

    public static void setSysProperty(String name, SysProperty sp)
        throws RAException
    {
        if(sp == null)
        {
            throw new RAException("63000001", RAErrorNumRes.getProperty("63000001"));
        } else
        {
            sysProperty.put(name, sp);
            return;
        }
    }

    public static SysProperty getSysProperty()
    {
        return (SysProperty)sysProperty.get("_default_");
    }

    public static SysProperty getSysProperty(String name)
    {
        return (SysProperty)sysProperty.get(name);
    }

    private Response execute(String type, Properties p)
        throws Exception
    {
        Request req = new Request(type);
        req.setHeader("VERSION", "0");
        req.setHeader("LOCALTIME", String.valueOf(System.currentTimeMillis()));
        req.setHeader("TASKTAG", String.valueOf((new Random()).nextInt(100000)));
        Collection pList = p.keySet();
        String name;
        for(Iterator pIter = pList.iterator(); pIter.hasNext(); req.setValue(name, p.getProperty(name, "")))
            name = (String)pIter.next();

        Response res = sc.sendRequest(req);
        return res;
    }

    public Properties recoverEncCertReq(Properties p)
        throws RAException, CAException
    {
        String uid = p.getProperty("UUID");
        String strEncCertSN = p.getProperty("CERTSN");
        if(uid == null || uid.length() == 0)
            throw new RAException("63140001", RAErrorNumRes.getProperty("63140001"));
        if(strEncCertSN == null || strEncCertSN.length() == 0)
            throw new RAException("63140002", RAErrorNumRes.getProperty("63140002"));
        Response response = null;
        try
        {
            response = execute("RECOVERENCCERTREQ", p);
        }
        catch(Exception e)
        {
            throw new RAException(e, "63140000", RAErrorNumRes.getProperty("63140000"));
        }
        String errorNum = response.getHeader("ERRORNUM");
        if(errorNum.equals("0"))
            return response.getP();
        else
            throw new CAException(errorNum, response.getHeader("ERRORMSG"));
    }

    public Properties recoverEncCert(Properties p)
        throws RAException, CAException
    {
        String auth = p.getProperty("AUTHCODE");
        String ref = p.getProperty("REFNO");
        String p10 = p.getProperty("PUBLICKEY");
        String symAlg = p.getProperty("RETSYMALG");
        if(ref == null || ref.length() == 0)
            throw new RAException("63140101", RAErrorNumRes.getProperty("63140101"));
        if(auth == null || auth.length() == 0)
            throw new RAException("63140102", RAErrorNumRes.getProperty("63140102"));
        if(p10 == null || p10.length() == 0)
            throw new RAException("63140103", RAErrorNumRes.getProperty("63140103"));
        if(symAlg == null || symAlg.length() == 0)
            throw new RAException("63140104", RAErrorNumRes.getProperty("63140104"));
        Response response = null;
        try
        {
            response = execute("RECOVERENCCERT", p);
        }
        catch(Exception e)
        {
            throw new RAException(e, "63140100", RAErrorNumRes.getProperty("63140100"));
        }
        String errorNum = response.getHeader("ERRORNUM");
        if(errorNum.equals("0"))
            return response.getP();
        else
            throw new CAException(errorNum, response.getHeader("ERRORMSG"));
    }

    public Properties requestCert(Properties p, Map listCustomExtValue)
        throws RAException, CAException
    {
        if(p == null)
            throw new RAException("63010001", RAErrorNumRes.getProperty("63010001"));
        String templateName = p.getProperty("TEMPLATENAME");
        String certDN = p.getProperty("SUBJECTDN");
        String uuid = p.getProperty("UUID");
        String tp = p.getProperty("TP", "1");
        if(DataChecker.isStrNull(templateName))
            throw new RAException("63010002", RAErrorNumRes.getProperty("63010002"));
        if(DataChecker.isStrNull(certDN))
            throw new RAException("63010003", RAErrorNumRes.getProperty("63010003"));
        if("1".equals(tp))
        {
            String validTime = p.getProperty("VALIDITYLEN");
            if(DataChecker.isStrNull(validTime))
                throw new RAException("63010004", RAErrorNumRes.getProperty("63010004"));
            if(!DataChecker.isNumeric(validTime))
                throw new RAException("63010005", RAErrorNumRes.getProperty("63010005"));
        } else
        {
            String notbefore = p.getProperty("NOTBEFORE");
            String notafter = p.getProperty("NOTAFTER");
            if(DataChecker.isStrNull(notbefore) || DataChecker.isStrNull(notafter))
                throw new RAException("63010004", RAErrorNumRes.getProperty("63010004"));
            if(!DataChecker.isNumeric(notbefore) || !DataChecker.isNumeric(notafter))
                throw new RAException("63010005", RAErrorNumRes.getProperty("63010005"));
        }
        if(DataChecker.isStrNull(uuid))
            throw new RAException("63010007", RAErrorNumRes.getProperty("63010007"));
        if(uuid.getBytes().length > 128)
            throw new RAException("63010010", RAErrorNumRes.getProperty("63010010"));
        if(listCustomExtValue != null)
        {
            DocumentFactory df = DocumentFactory.getInstance();
            for(Iterator iterator = listCustomExtValue.values().iterator(); iterator.hasNext();)
            {
                Document doc = df.createDocument("UTF-8");
                List list = (List)iterator.next();
                Element entry = doc.addElement("entry");
                for(int i = 0; i < list.size(); i++)
                {
                    CustomExtValue extValue = (CustomExtValue)list.get(i);
                    if(i == 0)
                        entry.addAttribute("OID", extValue.getOid());
                    Element item = entry.addElement("item");
                    item.addAttribute("type", extValue.getType());
                    item.addCDATA(extValue.getValue());
                }

                String xmlStr = doc.asXML();
                String xml = xmlStr.substring(xmlStr.indexOf("\n") + 1);
                System.out.println(xml);
                try
                {
                    p.setProperty(((CustomExtValue)list.get(0)).getOid(), Base64.encode(xml.getBytes("utf-8")));
                }
                catch(Exception e)
                {
                    throw new RAException(e, "63010009", RAErrorNumRes.getProperty("63010009"));
                }
            }

        }
        Response response = null;
        try
        {
            response = execute("REQUESTCERT", p);
        }
        catch(Exception e)
        {
            throw new RAException(e, "63010008", RAErrorNumRes.getProperty("63010008"));
        }
        String errorNum = response.getHeader("ERRORNUM");
        if(errorNum.equals("0"))
            return response.getP();
        else
            throw new CAException(errorNum, response.getHeader("ERRORMSG"));
    }

    public Properties requestCert(Properties p)
        throws RAException, CAException
    {
        return requestCert(p, null);
    }

    public boolean revokeCert(Properties p)
        throws RAException, CAException
    {
        String dn = p.getProperty("SUBJECTDN");
        String template = p.getProperty("TEMPLATENAME");
        String certSN = p.getProperty("CERTSN");
        String reason = p.getProperty("REVOKEREASON");
        if(!DataChecker.isNumeric(reason))
            throw new RAException("63020001", RAErrorNumRes.getProperty("63020001"));
        if(Integer.valueOf(reason).intValue() > 10)
            throw new RAException("63020002", RAErrorNumRes.getProperty("63020002"));
        if(Integer.valueOf(reason).intValue() < 0)
            throw new RAException("63020003", RAErrorNumRes.getProperty("63020003"));
        if(!DataChecker.isConfirmCertDataEnough(certSN, dn, template))
            throw new RAException("63020004", RAErrorNumRes.getProperty("63020004"));
        Response response = null;
        try
        {
            response = execute("REVOKECERT", p);
        }
        catch(Exception e)
        {
            throw new RAException(e, "63020005", RAErrorNumRes.getProperty("63020005"));
        }
        String errorNum = response.getHeader("ERRORNUM");
        if(errorNum.equals("0"))
            return true;
        else
            throw new CAException(errorNum, response.getHeader("ERRORMSG"));
    }

    public Properties updateCert(Properties p)
        throws RAException, CAException
    {
        String template = p.getProperty("TEMPLATENAME");
        String dn = p.getProperty("SUBJECTDN");
        String certSN = p.getProperty("CERTSN");
        String tp = p.getProperty("TP", "1");
        if("1".equals(tp))
        {
            String validTime = p.getProperty("VALIDITYLEN");
            if(DataChecker.isStrNull(validTime))
                throw new RAException("63030001", RAErrorNumRes.getProperty("63030001"));
            if(!DataChecker.isNumeric(validTime))
                throw new RAException("63030002", RAErrorNumRes.getProperty("63030002"));
        } else
        {
            String notbefore = p.getProperty("NOTBEFORE");
            String notafter = p.getProperty("NOTAFTER");
            if(DataChecker.isStrNull(notbefore) || DataChecker.isStrNull(notafter))
                throw new RAException("63030001", RAErrorNumRes.getProperty("63030001"));
            if(!DataChecker.isNumeric(notbefore) || !DataChecker.isNumeric(notafter))
                throw new RAException("63030002", RAErrorNumRes.getProperty("63030002"));
        }
        if(!DataChecker.isConfirmCertDataEnough(certSN, dn, template))
            throw new RAException("63030004", RAErrorNumRes.getProperty("63030004"));
        Response response = null;
        try
        {
            response = execute("UPDATECERT", p);
        }
        catch(Exception e)
        {
            throw new RAException(e, "63030005", RAErrorNumRes.getProperty("63030005"));
        }
        String errorNum = response.getHeader("ERRORNUM");
        if(errorNum.equals("0"))
            return response.getP();
        else
            throw new CAException(errorNum, response.getHeader("ERRORMSG"));
    }

    public boolean unlockCert(Properties p)
        throws RAException, CAException
    {
        String template = p.getProperty("TEMPLATENAME");
        String dn = p.getProperty("SUBJECTDN");
        String certSN = p.getProperty("CERTSN");
        if(!DataChecker.isConfirmCertDataEnough(certSN, dn, template))
            throw new RAException("63040001", RAErrorNumRes.getProperty("63040001"));
        Response response = null;
        try
        {
            response = execute("UNLOCKCERT", p);
        }
        catch(Exception e)
        {
            throw new RAException(e, "63040002", RAErrorNumRes.getProperty("63040002"));
        }
        String errorNum = response.getHeader("ERRORNUM");
        if(errorNum.equals("0"))
            return true;
        else
            throw new CAException(errorNum, response.getHeader("ERRORMSG"));
    }

    public boolean lockCert(Properties p)
        throws RAException, CAException
    {
        String template = p.getProperty("TEMPLATENAME");
        String dn = p.getProperty("SUBJECTDN");
        String certSN = p.getProperty("CERTSN");
        if(!DataChecker.isConfirmCertDataEnough(certSN, dn, template))
            throw new RAException("63050001", RAErrorNumRes.getProperty("63050001"));
        Response response = null;
        try
        {
            response = execute("LOCKCERT", p);
        }
        catch(Exception e)
        {
            throw new RAException(e, "63050002", RAErrorNumRes.getProperty("63050002"));
        }
        String errorNum = response.getHeader("ERRORNUM");
        if(errorNum.equals("0"))
            return true;
        else
            throw new CAException(errorNum, response.getHeader("ERRORMSG"));
    }

    public QueryResult searchCert(Properties p)
        throws RAException, CAException
    {
        String template = p.getProperty("TEMPLATENAME");
        String dn = p.getProperty("SUBJECTDN");
        String certSN = p.getProperty("CERTSN");
        String userID = p.getProperty("UUID");
        if(DataChecker.isStrNull(template) && DataChecker.isStrNull(dn) && DataChecker.isStrNull(certSN) && DataChecker.isStrNull(userID))
            throw new RAException("63060001", RAErrorNumRes.getProperty("63060001"));
        Response response = null;
        try
        {
            response = execute("SEARCHCERT", p);
        }
        catch(Exception e)
        {
            throw new RAException(e, "63060002", RAErrorNumRes.getProperty("63060002"));
        }
        String errorNum = response.getHeader("ERRORNUM");
        if(errorNum.equals("0"))
        {
            QueryResult qr = new QueryResult();
            qr.setPs(response.getItemData());
            Properties pNums = new Properties();
            pNums = response.getP();
            qr.setTotalPages(Integer.valueOf(pNums.getProperty("TOTALPAGES", "0")).intValue());
            qr.setTotalNums(Integer.valueOf(pNums.getProperty("TOTALROW", "0")).intValue());
            return qr;
        } else
        {
            throw new CAException(errorNum, response.getHeader("ERRORMSG"));
        }
    }

    public Properties downCert(Properties p)
        throws RAException, CAException
    {
        String ref = p.getProperty("REFNO");
        String auth = p.getProperty("AUTHCODE");
        String P10 = p.getProperty("PUBLICKEY");
        if(DataChecker.isStrNull(ref))
            throw new RAException("63070001", RAErrorNumRes.getProperty("63070001"));
        if(DataChecker.isStrNull(auth))
            throw new RAException("63070002", RAErrorNumRes.getProperty("63070002"));
        if(DataChecker.isStrNull(P10))
            throw new RAException("63070003", RAErrorNumRes.getProperty("63070003"));
        Response response = null;
        try
        {
            response = execute("DOWNCERT", p);
        }
        catch(Exception e)
        {
            throw new RAException(e, "63070004", RAErrorNumRes.getProperty("63070004"));
        }
        String errorNum = response.getHeader("ERRORNUM");
        if(errorNum.equals("0"))
            return response.getP();
        else
            throw new CAException(errorNum, response.getHeader("ERRORMSG"));
    }

    public Properties get2Code(Properties p)
        throws RAException, CAException
    {
        String template = p.getProperty("TEMPLATENAME");
        String dn = p.getProperty("SUBJECTDN");
        String certSN = p.getProperty("CERTSN");
        if(!DataChecker.isConfirmCertDataEnough(certSN, dn, template))
            throw new RAException("63080001", RAErrorNumRes.getProperty("63080001"));
        Response response = null;
        try
        {
            response = execute("GET2CODE", p);
        }
        catch(Exception e)
        {
            throw new RAException(e, "63080002", RAErrorNumRes.getProperty("63080002"));
        }
        String errorNum = response.getHeader("ERRORNUM");
        if(errorNum.equals("0"))
            return response.getP();
        else
            throw new CAException(errorNum, response.getHeader("ERRORMSG"));
    }

    public Properties getCertEntity(Properties p)
        throws RAException, CAException
    {
        String template = p.getProperty("TEMPLATENAME");
        String dn = p.getProperty("SUBJECTDN");
        String certSN = p.getProperty("CERTSN");
        if(!DataChecker.isConfirmCertDataEnough(certSN, dn, template))
            throw new RAException("63090001", RAErrorNumRes.getProperty("63090001"));
        Response response = null;
        try
        {
            response = execute("GETCERTENTITY", p);
        }
        catch(Exception e)
        {
            throw new RAException(e, "63090002", RAErrorNumRes.getProperty("63090002"));
        }
        String errorNum = response.getHeader("ERRORNUM");
        if(errorNum.equals("0"))
            return response.getP();
        else
            throw new CAException(errorNum, response.getHeader("ERRORMSG"));
    }

    public Properties applyUser(Properties p)
        throws RAException, CAException
    {
        String userName = p.getProperty("USERNAME");
        if(DataChecker.isStrNull(userName))
            throw new RAException("63100001", RAErrorNumRes.getProperty("63100001"));
        Response response = null;
        try
        {
            response = execute("APPLYUSER", p);
        }
        catch(Exception e)
        {
            throw new RAException(e, "63100002", RAErrorNumRes.getProperty("63100002"));
        }
        String errorNum = response.getHeader("ERRORNUM");
        if(errorNum.equals("0"))
            return response.getP();
        else
            throw new CAException(errorNum, response.getHeader("ERRORMSG"));
    }

    public QueryResult searchUser(Properties p)
        throws RAException, CAException
    {
        Response response = null;
        try
        {
            response = execute("SEARCHUSER", p);
        }
        catch(Exception e)
        {
            throw new RAException(e, "63110002", RAErrorNumRes.getProperty("63110002"));
        }
        String errorNum = response.getHeader("ERRORNUM");
        if(errorNum.equals("0"))
        {
            QueryResult qr = new QueryResult();
            qr.setPs(response.getItemData());
            Properties pNums = new Properties();
            pNums = response.getP();
            qr.setTotalPages(Integer.valueOf(pNums.getProperty("TOTALPAGES", "0")).intValue());
            qr.setTotalNums(Integer.valueOf(pNums.getProperty("TOTALROW", "0")).intValue());
            return qr;
        } else
        {
            throw new CAException(errorNum, response.getHeader("ERRORMSG"));
        }
    }

    public boolean modifyUser(Properties p)
        throws RAException, CAException
    {
        String uuid = p.getProperty("UUID");
        String userName = p.getProperty("USERNAME");
        String telephone = p.getProperty("TELEPHONE");
        String email = p.getProperty("EMAIL");
        String remark = p.getProperty("REMARK");
        if(DataChecker.isStrNull(uuid))
            throw new RAException("63120001", RAErrorNumRes.getProperty("63120001"));
        if(DataChecker.isStrNull(userName))
            throw new RAException("63120002", RAErrorNumRes.getProperty("63120002"));
        Response response = null;
        try
        {
            response = execute("MODIFYUSER", p);
        }
        catch(Exception e)
        {
            throw new RAException(e, "63120006", RAErrorNumRes.getProperty("63120006"));
        }
        String errorNum = response.getHeader("ERRORNUM");
        if(errorNum.equals("0"))
            return true;
        else
            throw new CAException(errorNum, response.getHeader("ERRORMSG"));
    }

    public static CertManager resetCertManager(SysProperty sp)
        throws RAException
    {
        if(sp == null)
            throw new RAException("63000001", RAErrorNumRes.getProperty("63000001"));
        else
            return resetCertManager("_default_", sp);
    }

    public static CertManager resetCertManager(String name, SysProperty sp)
        throws RAException
    {
        if(sp == null)
        {
            throw new RAException("63000001", RAErrorNumRes.getProperty("63000001"));
        } else
        {
            sysProperty.put(name, sp);
            CertManager cm = new CertManager(sp);
            inst.put(name, cm);
            return cm;
        }
    }

    public static void removeCertManager(String name)
        throws RAException
    {
        if(name == null || "_default_".equals(name))
            throw new RAException("63000001", RAErrorNumRes.getProperty("63000001"));
        if(sysProperty.containsKey(name))
            sysProperty.remove(name);
        else
            throw new RAException("63000001", RAErrorNumRes.getProperty("63000001"));
        if(inst.containsKey(name))
            inst.remove(name);
        else
            throw new RAException("63000001", RAErrorNumRes.getProperty("63000001"));
    }

    public static String getVersion()
    {
        return "V3";
    }

    private static final String _default_ = "_default_";
    private static HashMap sysProperty = new HashMap();
    private static HashMap inst = new HashMap();
    private SenderCreator sc;

    static 
    {
        Security.addProvider(new InfosecProvider());
    }
}


/*
	DECOMPILATION REPORT

	Decompiled from: D:\java\rads_demo\WebContent\WEB-INF\lib\RADS_6.1.003.3.jar
	Total time: 43 ms
	Jad reported messages/errors:
	Exit status: 0
	Caught exceptions:
*/