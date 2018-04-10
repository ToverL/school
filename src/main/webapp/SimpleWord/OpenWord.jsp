<%@ page language="java"
	import="java.util.*,com.zhuozhengsoft.pageoffice.*,com.zhuozhengsoft.pageoffice.wordwriter.*"
	pageEncoding="utf-8"%>
<%@ page import="com.oracle.vo.User" %>
<%
//******************************卓正PageOffice组件的使用*******************************
	String filePath=(String)session.getAttribute("path");
	System.out.println("磁盘路径："+filePath);
	//设置PageOffice服务器组件
	PageOfficeCtrl poCtrl1 = new PageOfficeCtrl(request);
	poCtrl1.setServerPage(request.getContextPath()+"/poserver.zz"); //此行必须
	//隐藏Office工具条
	poCtrl1.setOfficeToolbars(false);
	//隐藏自定义工具栏
	poCtrl1.setCustomToolbar(false);
	//设置页面的显示标题
	poCtrl1.setCaption("Word文档-只读");
	User user=(User)session.getAttribute("user");
	//打开文件
	poCtrl1.webOpen(filePath,OpenModeType.docReadOnly, user.getName());
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>   
    <title>tover.xin文档系统</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">


  </head>
  
  <body>
    <div style=" width:auto; height:700px;">
    <%=poCtrl1.getHtmlCode("PageOfficeCtrl1")%>
    </div>
  </body>
</html>
