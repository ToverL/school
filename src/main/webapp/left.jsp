<%--
  Created by IntelliJ IDEA.
  User: 刘佳伟
  Date: 2018/4/9
  Time: 16:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" isELIgnored="false" %>
<%@ page pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>left</title>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <script language="JavaScript" src="js/jquery.js"></script>

    <script type="text/javascript">
        $(function(){

            //导航切换
            $(".menuson li").click(function(){
                $(".menuson li.active").removeClass("active")
                $(this).addClass("active");
            });

            $('.title').click(function(){
                var $ul = $(this).next('ul');
                $('dd').find('ul').slideUp();
                if($ul.is(':visible')){
                    $(this).next('ul').slideUp();
                }else{
                    $(this).next('ul').slideDown();
                }
            });
        })
    </script>


</head>

<body style="background:#f0f9fd;">
<div class="lefttop"><span></span>系统管理</div>

<dl class="leftmenu">

    <dd>
        <div class="title">
            <span><img src="images/leftico01.png" /></span>用户信息
        </div>
        <ul class="menuson">
       <c:if test="${sessionScope.user.shenfen=='管理员'}">
           <li class="active"><cite></cite><a class="admin" href="selectuser.do" target="rightFrame">用户详情</a><i></i></li>
           <li><cite></cite><a class="admin" href="upuser.do" target="rightFrame">用户导入</a><i></i></li>
       </c:if>

        </ul>

    </dd>

    <dd>
        <div class="title">
            <span><img src="images/leftico02.png" /></span>其他设置
        </div>
        <ul class="menuson">
            <li><cite></cite><a href="imgtable.html" target="rightFrame">图片数据表</a><i></i></li>
            <li><cite></cite><a href="form.html" target="rightFrame">添加编辑</a><i></i></li>
            <li><cite></cite><a href="imglist.html" target="rightFrame">图片列表</a><i></i></li>
            <li><cite></cite><a href="imglist1.html" target="rightFrame">自定义</a><i></i></li>
            <li><cite></cite><a href="tools.html" target="rightFrame">常用工具</a><i></i></li>
            <li><cite></cite><a href="filelist.html" target="rightFrame">信息管理</a><i></i></li>
            <li><cite></cite><a href="tab.html" target="rightFrame">Tab页</a><i></i></li>
            <li><cite></cite><a href="error.html" target="rightFrame">404页面</a><i></i></li>
            <li><cite></cite><a href="#">编辑内容</a><i></i></li>
            <li><cite></cite><a href="#">发布信息</a><i></i></li>
            <li><cite></cite><a href="#">档案列表显示</a><i></i></li>
        </ul>
    </dd>


    <!--<dd><div class="title"><span><img src="images/leftico03.png" /></span>编辑器</div>-->
    <!--<ul class="menuson">-->
    <!--<li><cite></cite><a href="#">自定义</a><i></i></li>-->
    <!--<li><cite></cite><a href="#">常用资料</a><i></i></li>-->
    <!--<li><cite></cite><a href="#">信息列表</a><i></i></li>-->
    <!--<li><cite></cite><a href="#">其他</a><i></i></li>-->
    <!--</ul>    -->
    <!--</dd>  -->
    <!---->
    <!---->
    <!--<dd><div class="title"><span><img src="images/leftico04.png" /></span>日期管理</div>-->
    <!--<ul class="menuson">-->
    <!--<li><cite></cite><a href="#">自定义</a><i></i></li>-->
    <!--<li><cite></cite><a href="#">常用资料</a><i></i></li>-->
    <!--<li><cite></cite><a href="#">信息列表</a><i></i></li>-->
    <!--<li><cite></cite><a href="#">其他</a><i></i></li>-->
    <!--</ul>-->
    <!---->
    <!--</dd>   -->

</dl>
</body>
</html>
