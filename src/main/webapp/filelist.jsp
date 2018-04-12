<%--
  Created by IntelliJ IDEA.
  User: 刘佳伟
  Date: 2018/4/1
  Time: 15:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" isELIgnored="false" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.pageoffice.cn" prefix="po" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>子文件</title>
    <!-- Modernizr JS -->
    <script src="js/modernizr-2.6.2.min.js"></script>
    <!-- FOR IE9 below -->
    <!--[if lt IE 9]>
    <script src="js/respond.min.js"></script>
    <![endif]-->
    <!--PageOffice.js和jquery.min.js文件一定要引用-->
    <script type="text/javascript" src="jquery.min.js"></script>
    <script type="text/javascript" src="pageoffice.js" id="po_js_main"></script>
    <link href="css/style.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="js/jquery.js"></script>
    <script type="text/javascript">

        $(function () {
            $(".td_click").click(function () {
                var path = $(this).children('input').val();
                var q = $(this).children('input').attr("class");
                var p=path.split("\\");
                var flag=0;
                var pp="";
                for(var i=0;i< p.length;i++){
                    if(flag==1||p[i]=="User-Files"){
                        if(i== p.length-1){
                            pp+=p[i];
                        }
                        else{
                            pp+=p[i]+"/";
                        }
                        flag=1;
                    }
                }
                var disk = {path: path};
                $.ajax({
                        url: "changedata.do",
                        type: "get",
                        data: disk,
                        dataType: "json",
                        success: function f(data) {
                            if (data.success == "success") {

                                <c:choose>
                                    <c:when test="${(sessionScope.diskuserid==sessionScope.user.userid)||(sessionScope.user.shenfen=='管理员')||(sessionScope.user.shenfen=='教案管理员'&&sessionScope.root==0)||(sessionScope.user.shenfen=='档案管理员'&&sessionScope.root==-1)||sessionScope.user.shenfen=='高级用户'}">
                                if(q=='word'){
                                    POBrowser.openWindowModeless('SimpleWord/Word.jsp', 'width=1050px;height=900px;');
                                }else if(q=="ppt"){
                                    POBrowser.openWindowModeless('SimpleWord/PPT.jsp' , 'width=1050px;height=900px;');
                                }else if(q=="excl"){
                                    POBrowser.openWindowModeless('SimpleWord/Excel.jsp' , 'left=20px;top=10px;width=780px;height=800px;frame=no;');
                                }
                                    </c:when>
                                    <c:otherwise>
                                if(q=='word'){
                                    POBrowser.openWindowModeless('SimpleWord/OpenWord.jsp', 'width=1050px;height=900px;');
                                }else if(q=="ppt"){
                                    POBrowser.openWindowModeless('SimpleWord/OpenPPT.jsp' , 'width=1050px;height=900px;');
                                }else if(q=="excl"){
                                    POBrowser.openWindowModeless('SimpleWord/OpenExcel.jsp' , 'left=20px;top=10px;width=780px;height=800px;frame=no;');
                                }
                                    </c:otherwise>
                                    </c:choose>

                                else if(q=="mp4"){
                                    window.open("showvidio.jsp?path="+pp);
                                }else if(q=="jpg"){
                                    window.open("showjpg.jsp?path="+pp);
                                }else if(q=="zip"){
                                  window.open(pp);
                                }
                            } else {
                                alert("服务器繁忙，请稍后！");
                            }

                        }
                    }
                );

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
        <li><a href="#">${diskname}</a></li>
    </ul>
</div>


<table class="filetable">

    <thead>
    <tr>
        <th width="25%">名称</th>
        <th width="11%">上传日期</th>
        <th width="10%">类型</th>
        <th width="6%">大小</th>
        <th width="10%">作者</th>
        <th width="6%">操作</th>
        <th width="48%"></th>
    </tr>
    </thead>

    <tbody>

    <c:forEach items="${disk}" var="list">
        <tr class="tr_click">
            <c:choose>
            <c:when test="${list.disktype=='word'}">
            <td class="td_click"><img src="images/f06.png"/>
                <input type="hidden" value="${list.path}" class="word">
                </c:when>
                <c:when test="${list.disktype=='ppt'}">

            <td class="td_click"><img src="images/f04.png"/>
                <input type="hidden" value="${list.path}" class="ppt">
                </c:when>
                <c:when test="${list.disktype=='excl'}">
            <td class="td_click"><img src="images/f05.png"/>
                <input type="hidden" value="${list.path}" class="excl">
                </c:when>
                <c:when test="${list.disktype=='mp4'}">

                <td class="td_click"><img src="images/f05.png"/>
                <input type="hidden" value="${list.path}" class="mp4">
                    </c:when>
                <c:when test="${list.disktype=='jpg'}">

                <td class="td_click"><img src="images/f05.png"/>
                <input type="hidden" value="${list.path}" class="jpg">
                    </c:when>
                <c:otherwise>
            <td class="td_click"><img src="images/f02.png"/>
                <input type="hidden" value="${list.path}" class="zip">
                </c:otherwise>
                    </c:choose>
                    ${list.diskname}</td>
                <td>${list.createtime}</td>
                <td>${list.disktype}</td>
                <td>${list.disksize} MB</td>
                <td>${sessionScope.user.name}</td>
                <td><a href="delete.do?diskid=${list.diskid}&diskuserid=${list.diskuserid}" onclick="if(confirm('确认删除吗？(请谨慎操作)')==false)return false;">删除</a></td>
            <td></td>
        </tr>
    </c:forEach>

    </tbody>
</table>

<c:if test="${(sessionScope.diskuserid==sessionScope.user.userid)||(sessionScope.user.shenfen=='管理员')||(sessionScope.user.shenfen=='教案管理员'&&sessionScope.root==0)||(sessionScope.user.shenfen=='档案管理员'&&sessionScope.root==-1)||sessionScope.user.shenfen=='高级用户'}">
    <div style="position:relative;left:20px;top:400px">
        <%@include file="index.jsp"%>
    </div>
</c:if>





<!-- jQuery -->
<script src="js1/jquery.min.js"></script>
<!-- jQuery Easing -->
<script src="js1/jquery.easing.1.3.js"></script>
<!-- Bootstrap -->
<script src="js1/bootstrap.min.js"></script>
<!-- Waypoints -->
<script src="js1/jquery.waypoints.min.js"></script>
<!-- Carousel -->
<script src="js1/owl.carousel.min.js"></script>
<!-- countTo -->
<script src="js1/jquery.countTo.js"></script>
<!-- Magnific Popup -->
<script src="js1/jquery.magnific-popup.min.js"></script>
<script src="js1/magnific-popup-options.js"></script>
<!-- Main -->
<script src="js/main.js"></script>

</body>
</html>


