<%@ page import="org.springframework.web.context.request.SessionScope" %><%--
  Created by IntelliJ IDEA.
  User: 刘佳伟
  Date: 2018/4/1
  Time: 17:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" isELIgnored="false" %>
<%@ page pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html >
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>无标题文档</title>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="js/jquery.js"></script>

    <script language="javascript">

        $(function () {

            $("#back").click(function () {

                window.location.href='ship.do';
            });





        });

    </script>
</head>

<body>
<div class="place">
    <span>位置：</span>
    <ul class="placeul">
        <c:if test="${sessionScope.root==0}">
            <li><a href="ship.do">教案课件</a></li>
        </c:if>
        <c:if test="${sessionScope.root==-1}">
            <li><a href="ship2.do">督导档案</a></li>
        </c:if>
        <li><a href="#">快速创建</a></li>
    </ul>
</div>
<laber>&nbsp;</laber><input id="back" type="button" class="btn" value="返回"/>
<form action="createoneuserdisk.do" method="post">
    <input type="hidden" name="diskfather" value="<%=request.getParameter("diskfather")%>">
    <%--<input type="hidden" name="diskuserid" value="${sessionScope.user.userid}">--%>
    <div class="formbody">
        <div class="formtitle"><span>单条快速创建</span></div>
        <ul class="forminfo">
            <li><i style="font-size: 14px">操作阅读：</i></li>
            <li><i style="font-size: 12px">默认以用户姓名命名个人档案文件夹（默认添加本年度文件夹）</i></li>
            <li><i style="font-size: 12px">单条创建不会核对用户学科分组，请管理员核对用户信息后再创建</i></li>
            <li><label>用户账号</label><input name="diskuserid" type="text" class="dfinput"/><i style="font-size: 12px">默认身份证号</i></li>
            <br>
            <li><label>&nbsp;</label><input name="" type="submit" class="btn" value="快速创建" onclick="if(confirm('确认创建吗？(请谨慎操作)')==false)return false;"/></li>

        </ul>
    </div>
</form>

<form action="createalldir.do" method="post">
    <input type="hidden" name="diskfather" value="<%=request.getParameter("diskfather")%>">
    <div class="formbody">
        <div class="formtitle"><span>快速创建所有</span></div>
        <ul class="forminfo">
            <li><i style="font-size: 14px">操作阅读：</i></li>
            <li><i style="font-size: 12px">默认以用户姓名命名个人档案文件夹（默认添加本年度文件夹）</i></li>
            <li><i style="font-size: 12px">快速添加会将所有未在此文件夹下的用户添加进去，默认按照用户学科添加到此组</i></li>
            <br>
            <li><label>&nbsp;</label><input name="" id="btn11" type="submit" class="btn" value="创建所有" onclick="if(confirm('确认创建吗？(请谨慎操作)')==false)return false;"/></li>
        </ul>
    </div>
</form>


<form action="createnewyear.do" method="post">
    <div class="formbody">
        <input type="hidden" name="diskfather" value="<%=request.getParameter("diskfather")%>">
        <div class="formtitle"><span>添加新年份文件夹</span></div>
        <ul class="forminfo">
            <li><i style="font-size: 14px">操作阅读：</i></li>
            <li><i style="font-size: 12px">默认一次性添加新年份两学期文件夹</i></li>
            <li><i style="font-size: 12px">默认为此文件夹下所有用户添加新年份文件夹，目录结构与之前相同（切记不可重复名）</i></li>
            <li><label>添加年份</label><input name="diskname" type="text" class="dfinput"/><i style="font-size: 12px">例：2018</i></li>
            <br>
            <li><label>&nbsp;</label><input name="" id="btn12" type="submit" class="btn" value="添加" onclick="if(confirm('确认创建吗？(请谨慎操作)')==false)return false;"/></li>


        </ul>
    </div>
</form>

</body>
</html>

