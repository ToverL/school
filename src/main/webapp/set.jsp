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
    <title>网站后台管理系统</title>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="js/jquery.js"></script>

    <script type="text/javascript">
        $(function () {

        })
        add=function () {
            $("#fom1").submit();
        }
        back=function () {

            if(${sessionScope.root==-1})
            {
                window.location.href = 'ship2.do';
            }else if (${sessionScope.root==0}) {
                window.location.href = 'ship.do';
            }
        }
    </script>


</head>


<body>
<form id="fom1" action="add.jsp" method="get">
    <input type="hidden" name="diskfather" value="<%=request.getParameter("diskfather")%>">
</form>
<div class="place">
    <span>位置：</span>
    <ul class="placeul">
        <li><a href="#">首页</a></li>
        <c:if test="${sessionScope.root==0}">
            <li><a href="ship.do">教案课件</a></li>
        </c:if>
        <c:if test="${sessionScope.root==-1}">
            <li><a href="ship2.do">督导档案</a></li>
        </c:if>
        <li><a href="#">设置</a></li>
    </ul>
</div>
<div class="tools">
    <ul class="toolbar">
        <li class="click" onclick="add()"><span><img src="images/t01.png" /></span>添加</li>
    </ul>
</div>
<h1 align="center" style="color: red;font-size: large">此权限为管理员专有，一旦删除无法找回此文件夹以及文件夹内所有内容！请谨慎操作！</h1>
<div class="rightinfo">
    <input type="hidden" name="diskfather" value="<%=request.getParameter("diskfather")%>">
    <input type="hidden" name="diskuserid" value="${sessionScope.user.userid}">

    <table class="tablelist">
        <thead>
        <tr>
            <th>编号<i class="sort"><img src="images/px.gif" /></i></th>
            <th>类型</th>
            <th>文件夹名</th>
            <th>创建者账号</th>
            <th>文件数量</th>
            <th>大小</th>
            <th>创建时间</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${sessionScope.disk}" var="list" >
            <tr>
                <td>${list.diskid}</td>
                <td>${list.disktype}</td>
                <td>${list.diskname}</td>
                <td>${list.diskuserid}</td>
                <td>${list.disklen}</td>
                <td>${list.disksize} MB</td>
                <td>${list.createtime}</td>
                <td>
                    <a href="delete.do?diskid=${list.diskid}&diskuserid=${list.diskuserid}"class="tablelink" onclick="if(confirm('确认删除吗？(请谨慎操作)')==false)return false;"> 删除</a>
                    <a href="setbase.jsp?diskid=${list.diskid}&diskname=${list.diskname}"class="tablelink">修改</a>
                </td>
            </tr>

        </c:forEach>

        </tbody>
    </table>
    <hr>
    <li><label>&nbsp;</label><input type="button" class="btn" value="返回" onclick="back()"/></li>
<%session.setAttribute("disk",null);%>
</div>
<script type="text/javascript">
    $('.tablelist tbody tr:odd').addClass('odd');
</script>
</body>
</html>




