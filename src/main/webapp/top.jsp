<%--
  Created by IntelliJ IDEA.
  User: 刘佳伟
  Date: 2018/4/1
  Time: 13:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" isELIgnored="false" %>
<%@ page pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>导航</title>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <script language="JavaScript" src="js/jquery.js"></script>
    <script type="text/javascript">
        $(function(){
            //顶部导航切换
            $(".nav li a").click(function(){
                $(".nav li a.selected").removeClass("selected")
                $(this).addClass("selected");
            })
        })
    </script>


</head>

<body style="background:url(images/topbg.gif) repeat-x;">

<div class="topleft">
    <a href="main.jsp" target="_parent"><img src="images/logo.png" title="系统首页" /></a>
</div>


<ul class="nav">
    <%--<li><a href="default.html" target="rightFrame" class="selected"><img src="images/icon01.png" title="工作台" /><h2>工作台</h2></a></li>--%>
        <li><a href="mine.do" class="selected" target="rightFrame"><img src="images/icon02.png" title="模型管理" /><h2>个人中心</h2></a></li>
        <%--<li><a href="imglist.html"  target="rightFrame"><img src="images/icon03.png" title="模块设计" /><h2>模块设计</h2></a></li>--%>
        <%--<li><a href="tools.html"  target="rightFrame"><img src="images/icon04.png" title="常用工具" /><h2>常用工具</h2></a></li>--%>
        <li><a href="ship.do" target="rightFrame"><img src="images/icon05.png" title="文件管理" /><h2>教案课件</h2></a></li>
        <li><a href="ship2.do" target="rightFrame"><img src="images/icon01.png" title="工作台" /><h2>督导档案</h2></a></li>
        <li><a href="userself.do"  target="rightFrame"><img src="images/icon06.png" title="系统设置" /><h2>个人设置</h2></a></li>
</ul>

<div class="topright">
    <ul>
        <li><span><img src="images/help.png" title="帮助"  class="helpimg"/></span><a href="#">帮助</a></li>
        <li><a href="#">关于</a></li>
        <li><a href="login.html" onclick="function x() {
          ${sessionScope.clear()}
        }" target="_parent">退出</a></li>
    </ul>

    <div class="user">
        <span>${sessionScope.user.name}</span>
        <i>消息</i>
        <b>0</b>
    </div>

</div>
</body>
</html>

