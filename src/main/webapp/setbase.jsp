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

        back=function () {
            window.location.href='computer.do';
        }
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
        <li><a href="#">修改</a></li>
    </ul>
</div>

<form action="setbase.do" method="get">
    <%--<input type="hidden" name="diskfather" value="<%=request.getParameter("diskfather")%>">--%>
    <input type="hidden" name="diskuserid" value="${sessionScope.user.userid}">
    <input type="hidden" name="diskid" value="<%=request.getParameter("diskid")%>">
    <div class="formbody">
        <div class="formtitle"><span>修改信息</span></div>
        <ul class="forminfo">
            <li><label>原文件名</label>&nbsp;&nbsp;&nbsp;&nbsp;<label><%=request.getParameter("diskname")%></label></li>
            <li><label>文件命名</label><input name="diskname" type="text" class="dfinput"/><i>命名不能超过15个字符</i></li>
            <li>
                <label>文件夹类型</label>
                <select name="disktype" class="dfinput">
                    <option value="磁盘">磁盘</option>
                    <option value="文件夹">文件夹</option>
                </select>
            </li>
            <hr/>
            <li><label>&nbsp;</label><input name="" type="submit" class="btn" value="确认保存"/>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="btn" value="返回" onclick="back()"/></li>
        </ul>
    </div>
</form>

</body>
</html>
