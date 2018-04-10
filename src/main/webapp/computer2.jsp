<%--
  Created by IntelliJ IDEA.
  User: 刘佳伟
  Date: 2018/4/1
  Time: 13:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" isELIgnored="false" %>
<%@ page pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>computer2</title>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="js/jquery.js"></script>


    <script language="javascript">

        set=function () {
            if(${sessionScope.user.shenfen=='管理员'}){

                <%session.setAttribute("disk",request.getAttribute("disk")); %>
                window.location.href='set.jsp?diskfather=${diskfather}';
            }else{
                alert("对不起，您没有此权限！");
            }

        }
        back=function () {

            if(${sessionScope.root==-1})
            {
                window.location.href = 'ship2.do';
            }else if (${sessionScope.root==0}) {
                window.location.href = 'ship.do';
            }
        };

        add=function () {
            if(${sessionScope.user.shenfen=='管理员'}){

                window.location.href='quickadd.jsp?diskfather=${diskfather}';
            }else {
                alert("对不起，您没有此权限！");
            }

        }


        $(function(){
            //导航切换
            $(".disklist li").click(function(){
                $(".disklist li.selected").removeClass("selected")
                $(this).addClass("selected");
            })
        })
    </script>

</head>


<body>


<div class="place">
    <span>位置：</span>
    <ul class="placeul">
        <c:if test="${sessionScope.root==0}">
            <li><a href="#">教案课件</a></li>
        </c:if>
        <c:if test="${sessionScope.root==-1}">
            <li><a href="#">督导档案</a></li>
        </c:if>
        <li><a href="#">${diskname}</a></li>
    </ul>
</div>
<div class="tools">
    <ul class="toolbar">
        <c:if test="${diskfather!=-1}">
            <li><label>&nbsp;</label><input type="button" class="btn" value="返回" onclick="back()"/></li>
        </c:if>
        <li name="set" onclick="set()"><span><img src="images/t05.png" /></span>设置</li>
        <c:if test="${disktype=='磁盘'}">
            <li class="click" onclick="add()"><span><img src="images/t01.png" /></span>快速添加</li>
        </c:if>
    </ul>
</div>
<div class="comtitle">
    <span><img src="images/clist.png" /></span>
    <h2>文件(${disknum})</h2>
    <div class="rline"></div>
</div>
<ul class="disklist">

    <c:forEach items="${disk}" var="list" >
        <li>
            <c:choose>
                <c:when test="${list.disktype=='文件夹'}">
                <a href="computer.do?diskid=${list.diskid}&path=computer2.jsp&diskname=${list.diskname}&diskfather=${list.diskid}">
                </c:when>
                <c:otherwise>
                    <a href="computer.do?diskid=${list.diskid}&path=filelist.jsp&diskname=${list.diskname}&diskfather=${list.diskid}">
                </c:otherwise>
            </c:choose>
                <div class="dleft2"></div>
                <div class="dright">
                    <c:choose>
                        <c:when test="${sessionScope.root==-1}">
                                <h3>${list.diskname}</h3>
                                <p>${list.disklen} 个文件</p>
                                <p>${list.disksize} MB</p>
                        </c:when>
                        <c:otherwise>
                            <h3>${list.diskname}</h3>
                            <p>${list.disktype}</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </a>
        </li>
    </c:forEach>

</ul>



</body>
</html>
