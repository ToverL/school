<%--
  Created by IntelliJ IDEA.
  User: 刘佳伟
  Date: 2018/4/5
  Time: 22:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*,com.zhuozhengsoft.pageoffice.*" pageEncoding="utf-8"%>
<%
    FileSaver fs=new FileSaver(request,response);
    fs.saveToFile(session.getAttribute("path").toString());
    fs.close();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>My JSP 'SaveFile1.jsp' starting page</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <!--
    <link rel="stylesheet" type="text/css" href="styles.css">
    -->

</head>

<body>

</body>
</html>
