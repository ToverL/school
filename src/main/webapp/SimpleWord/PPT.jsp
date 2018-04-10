<%@ page language="java"
	import="java.util.*,com.zhuozhengsoft.pageoffice.*"
	pageEncoding="utf-8"%>
<%@ page import="com.oracle.vo.User" %>
<%
	//String filePath = request.getSession().getServletContext().getRealPath("User-Files/2018/4/4/dcc0feaeee79f753baed65801c4ddc0c.doc");
	String filePath=(String)session.getAttribute("path");
	System.out.println("磁盘路径："+filePath);
	PageOfficeCtrl poCtrl=new PageOfficeCtrl(request);
//设置服务器页面
	poCtrl.setServerPage(request.getContextPath()+"/poserver.zz");
//添加自定义按钮
	poCtrl.addCustomToolButton("保存","Save",1);
	poCtrl.addCustomToolButton("打印设置","PrintSet",0);
	poCtrl.addCustomToolButton("打印","PrintFile",6);
	poCtrl.addCustomToolButton("全屏/还原", "IsFullScreen", 4);
	poCtrl.addCustomToolButton("-", "", 0);
	poCtrl.addCustomToolButton("关闭","Close",21);
//设置保存页面
	//设置页面的显示标题
	poCtrl.setCaption("PPT文档");
	poCtrl.setSaveFilePage("SaveFile.jsp");
	User user=(User)session.getAttribute("user");
//打开PPT文档
	poCtrl.webOpen(filePath,OpenModeType.pptNormalEdit,user.getName());

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>tover.xin文档系统</title>
<style>
#main{
	width:1040px;
	height:890px;
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

    function PrintSet() {
        document.getElementById("PageOfficeCtrl1").ShowDialog(5);
    }
    function PrintFile() {
        document.getElementById("PageOfficeCtrl1").ShowDialog(4);
    }
    function Close() {
        window.external.close();
    }
    function IsFullScreen() {
        document.getElementById("PageOfficeCtrl1").FullScreen = !document.getElementById("PageOfficeCtrl1").FullScreen;
    }
    //文档关闭前先提示用户是否保存
    function BeforeBrowserClosed(){
        if (document.getElementById("PageOfficeCtrl1").IsDirty){
            if(confirm("提示：文档已被修改，是否继续关闭放弃保存 ？"))
            {
                return  true;

            }else{

                return  false;
            }

        }

    }
</script>

   
<div id="main">
<div id="shut"><img src="../js/close.png"  onclick="Close()" title="关闭" /></div>
<div id="content"  style="height:850px;width:1036px;overflow:hidden;">
<%=poCtrl.getHtmlCode("PageOfficeCtrl1")%>
</div>
</div>
<br />
<div style=" text-align:center; height:80px; border-top: solid 1px #666; line-height:70px;">www.tover.xin &copy 2018 如一科技有限公司-刘佳伟</div>
</body>
</html>
