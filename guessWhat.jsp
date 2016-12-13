#版本信息 : {{getv "/versionKeyOnly"}}
<%@ page language="java" import="java.util.*, java.net.*" pageEncoding="UTF-8"%> 

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"> 
<html> 
<head> 
<title>JSP获取服务器参数</title> 
</head> 
<body> 
<%
    Enumeration<NetworkInterface> netInterfaces = null;
    try {
        netInterfaces = NetworkInterface.getNetworkInterfaces();
        while (netInterfaces.hasMoreElements()) {
            NetworkInterface ni = netInterfaces.nextElement();

            String displayName = ni.getDisplayName();
            String name = ni.getName();
            Enumeration<InetAddress> ips = ni.getInetAddresses();
            while (ips.hasMoreElements()) {

                String ipStr = ips.nextElement().getHostAddress();
                if(ipStr.startsWith("192.168")) {
                    String partIpStr = ipStr.replace("192.168.", "");
                    StringBuffer reverseIp = new StringBuffer(partIpStr);
                    String targetIp = reverseIp.reverse().toString();
                    
%>
               
                   <div> <%="SERVER_HOST   " + name + ":" + targetIp%></div>
<%
                }
            }

        }
    }   catch (Exception e) {
        e.printStackTrace();
    }

%>
<% 

String DOMAIN_NAME = request.getServerName(); 
String REQUEST_PROTOCOL = request.getProtocol();
String REQUEST_METHOD = request.getMethod(); 
String PAGE_NAME = request.getServletPath(); 
String HTTP_USER_AGENT = request.getHeader("User-Agent"); 

HashMap infoMap = new HashMap(); 


infoMap.put("DOMAIN_NAME", DOMAIN_NAME); 
infoMap.put("REQUEST_PROTOCOL", REQUEST_PROTOCOL); 
infoMap.put("REQUEST_METHOD", REQUEST_METHOD); 
infoMap.put("PAGE_NAME", PAGE_NAME); 
infoMap.put("HTTP_USER_AGENT", HTTP_USER_AGENT); 

Iterator it = infoMap.keySet().iterator(); 

%> 

<% 
while (it.hasNext()) { 
Object o = it.next(); 
%> 
　　<div>
        <%=o + ":"%>
　　    <%=infoMap.get(o)%>
    </div>
<%}%>


</body> 
</html> 