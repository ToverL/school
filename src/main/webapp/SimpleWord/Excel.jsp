<%@ page language="java"
         import="java.util.*,com.zhuozhengsoft.pageoffice.*,com.zhuozhengsoft.pageoffice.excelwriter.*"
         pageEncoding="utf-8"%>
<%@ page import="com.oracle.vo.User" %>
<%
    PageOfficeCtrl poCtrl=new PageOfficeCtrl(request);
    String filePath=(String)session.getAttribute("path");
    System.out.println("磁盘路径："+filePath);
//设置服务器页面
    poCtrl.setServerPage(request.getContextPath()+"/poserver.zz");
//添加自定义按钮
    poCtrl.addCustomToolButton("保存","Save",1);
    poCtrl.addCustomToolButton("关闭","Close",21);
    //设置页面的显示标题
    poCtrl.setCaption("Excl文档");
//设置保存页面
    poCtrl.setSaveFilePage("SaveFile1.jsp");
//打开Word文档
    User user=(User)session.getAttribute("user");
    poCtrl.webOpen(filePath,OpenModeType.xlsNormalEdit,user.getName());
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>tover.xin文档系统</title>



    <style>
        #main{
            width:750px;
            height:800px;
            border:#83b3d9 2px solid;
            background:#f2f7fb;

        }
        #shut{
            width:45px;
            height:30px;
            float:right;
            margin-right:-1px;
        }
        #shut:hover{
        }
    </style>
</head>
<body style="overflow:hidden" >
<script type="text/javascript">
    function Save() {
        document.getElementById("PageOfficeCtrl1").WebSave();
    }
    function Close() {
        window.external.close();
    }
</script>
<form id="form1">
   <div id="main">
<div id="shut"><img src="../js/close.png"  onclick="Close()" title="关闭" /></div>
       <div id="content"  style="height:750px;width:750px;overflow-y:hidden;">
<%=poCtrl.getHtmlCode("PageOfficeCtrl1")%>
</div>
   </div>
    </form>
    <br />
    <div style=" text-align:center; height:80px; border-top: solid 1px #666; line-height:70px;">www.tover.xin &copy 2018 如一科技有限公司-刘佳伟</div>
</body>
</html>
