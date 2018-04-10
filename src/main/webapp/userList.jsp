<%--
  Created by IntelliJ IDEA.
  User: 刘佳伟
  Date: 2018/4/6
  Time: 21:00
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
            $("#find").click(function () {
                var name=$("#usernamefind").val();
                window.location.href="findname.do?name="+name;
            });
        });

        add=function () {
           window.location.href="createuser.do";
        }
    </script>


</head>


<body>
<div class="place">
    <span>位置：</span>
    <ul class="placeul">
        <li><a href="#">用户信息</a></li>

    </ul>
</div>
<div class="tools">
    <ul class="toolbar">
        <li class="click" onclick="add()"><span><img src="images/t01.png" /></span>添加</li>
    </ul>
</div>
<ul class="forminfo">
    <li><label>姓名关键字查找</label><input id="usernamefind" name="name" type="text" value="" class="dfinput" /><input type="button" class="btn" value="查找" id="find"></li>
</ul>
<div class="rightinfo">
    <input type="hidden" name="diskfather" value="<%=request.getParameter("diskfather")%>">
    <input type="hidden" name="diskuserid" value="${sessionScope.user.userid}">

    <table class="tablelist">
        <thead>
        <tr>
            <th>账号<i class="sort"><img src="images/px.gif" /></i></th>
            <th>姓名</th>
            <th>性别</th>
            <th>职务</th>
            <th>科目</th>
            <th>专任教师</th>
            <th>班主任</th>
            <th>电话</th>
            <th>身份</th>
            <th>分组</th>
            <th>已用空间(MB)</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${user}" var="list" >
            <tr>
                <td>${list.userid}</td>
                <td>${list.name}</td>
                <td>${list.sex}</td>
                <td>${list.zhiwu}</td>
                <td>${list.kemu}</td>
                <td>${list.zhuanrenjiaoshi}</td>
                <td>${list.banzhuren}</td>
                <td>${list.phone}</td>
                <td>${list.shenfen}</td>
                <td>${list.fenzu}</td>
                <td>${list.memory}</td>
                <td>
                    <a href="#"class="tablelink" onclick="if(confirm('确认删除吗？(请谨慎操作)')==false)return false;"> 删除</a>
                    <a href="findoneuser.do?userid=${list.userid}"class="tablelink">详情</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <hr>
</div>
</body>
</html>







