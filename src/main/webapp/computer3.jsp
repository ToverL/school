<%--
  Created by IntelliJ IDEA.
  User: 刘佳伟
  Date: 2018/4/6
  Time: 19:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" isELIgnored="false" %>
<%@ page pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>computer</title>
    <link href="css/style.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="js/jquery.js"></script>

    <script language="javascript">

        $(function () {

            //导航切换
            $(".disklist li").click(function () {
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
        <li><a href="#">个人中心</a></li>
    </ul>
</div>
<div class="comtitle">
    <span><img src="images/clist.png"/></span>
    <h2>文件磁盘</h2>
    <div class="rline"></div>
</div>

<ul class="disklist">

    <c:if test="${jiaoan!=null}">
        <li>
            <a href="computer.do?diskid=${jiaoan.diskid}&path=computer2.jsp&diskname=${jiaoan.diskname}&disktype=${jiaoan.disktype}">
                <div class="dleft1"></div>
                <div class="dright">
                    <h2>我的教案</h2>
                    <div class="dinfo"><span style="width:100px;"></span></div>
                    <p>${jiaoan.disksize} MB 空间,共 ${jiaoan.disklen} 个文件</p>
                </div>
            </a>
        </li>
    </c:if>


    <c:if test="${dangan!=null}">
        <li>
            <a href="myfilelist.do?diskid=${dangan.diskid}&path=computer2.jsp&diskname=${dangan.diskname}&disktype=${dangan.disktype}">
                <div class="dleft1"></div>
                <div class="dright">
                    <h2>我的档案</h2>
                    <div class="dinfo"><span style="width:100px;"></span></div>
                    <p>${dangan.disksize} MB 空间,共 ${dangan.disklen} 个文件</p>
                </div>
            </a>
        </li>
    </c:if>


    <%--<li>--%>
    <%--<div class="dleft"></div>--%>
    <%--<div class="dright">--%>
    <%--<h2>图片(30)</h2>--%>
    <%--<div class="dinfo"><span style="width:50px;"></span></div>--%>
    <%--<p>120 MB 空间,共 5100 个文件</p>--%>
    <%--</div>--%>
    <%--</li>--%>

    <%--<li>--%>
    <%--<div class="dleft"></div>--%>
    <%--<div class="dright">--%>
    <%--<h2>软件资料(43)</h2>--%>
    <%--<div class="dinfo"><span style="width:38px;"></span></div>--%>
    <%--<p>500 MB 空间,共 12 个文件</p>--%>
    <%--</div>--%>
    <%--</li>--%>

    <%--<li>--%>
    <%--<div class="dleft"></div>--%>
    <%--<div class="dright">--%>
    <%--<h2>系统资料(25)</h2>--%>
    <%--<div class="dinfo"><span style="width:60px;"></span></div>--%>
    <%--<p>125 MB 空间,共 3585 个文件</p>--%>
    <%--</div>--%>
    <%--</li>--%>

    <%--<li class="selected">--%>
    <%--<div class="dleft"></div>--%>
    <%--<div class="dright">--%>
    <%--<h2>(89)</h2>--%>
    <%--<div class="dinfo"><span style="width:40px;"></span></div>--%>
    <%--<p>10 MB 空间,共 25 个文件</p>--%>
    <%--</div>--%>
    <%--</li>--%>

    <%--<li>--%>
    <%--<div class="dleft"></div>--%>
    <%--<div class="dright">--%>
    <%--<h2>其他(10)</h2>--%>
    <%--<div class="dinfo"><span style="width:15px;"></span></div>--%>
    <%--<p>2 MB 空间,共 53 个文件</p>--%>
    <%--</div>--%>
    <%--</li>--%>


</ul>


<div class="comtitle">
    <span><img src="images/clist.png"/></span>
    <h2>最近访问</h2>
    <div class="rline"></div>
</div>

<ul class="disklist">

    <c:if test="${sessionScope.user.laterdisk!=-2}">
        <li>
            <a href="computer.do?diskid=${sessionScope.laterdisk.diskid}&path=filelist.jsp&diskname=${sessionScope.laterdisk.diskname}&diskfather=${sessionScope.laterdisk.diskid}">
                <div class="dleft2"></div>
                <div class="dright">
                    <h3>${sessionScope.laterdiskuser.fenzu}->${sessionScope.laterdiskuser.name}->${sessionScope.laterdisk.diskname}</h3>
                    <p>${sessionScope.laterdisk.disktype}</p>
                    <p>${sessionScope.laterdisk.disklen} 个文件</p>
                </div>
            </a>
        </li>
    </c:if>


</ul>
</body>
</html>
