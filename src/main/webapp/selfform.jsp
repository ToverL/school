<%--
  Created by IntelliJ IDEA.
  User: 刘佳伟
  Date: 2018/4/6
  Time: 22:58
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
    <title>用户详情</title>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="js/jquery.js"></script>

    <script type="text/javascript">
        $(document).ready(function(){
            $("#Button1").click(function(){
                $(".tip").fadeIn(200);
            });

            $(".tiptop a").click(function(){
                $(".tip").fadeOut(200);
            });

            $(".sure").click(function(){

                    var old=$("#oldpassword").val();
                    var newp=$("#newpassword1").val();
                    var newp2=$("#newpassword2").val();

                        $("#oldpassword").val("");
                        $("#newpassword1").val("");
                        $("#newpassword2").val("");
                    if (newp!=newp2||newp==""){
                        $("#tipp").text("两次新密码不一致！");
                    } else{

                        $.ajax({
                            url: "setmypassword.do",
                            type: "post",
                            data:{oldpassword: old,newpassword:newp},
                            dataType: "json",
                            success: function f(data) {
                                if(data.success=="success"){
                                    alert("密码重置成功！请重新登录！");
                                }else {
                                    alert("原始密码错误！重置失败！");
                                }

                            }

                        });

                        $(".tip").fadeOut(100);

                    }
            });

            $(".cancel").click(function(){
                $(".tip").fadeOut(100);
            });

        });
    </script>


    <script language="JavaScript">


        window.onload=function () {

            var ck_val = "${checked}";
            var ck_val1=ck_val.split(',');

            for(var i=0;i<ck_val1.length;i++){
               var span=document.getElementById(ck_val1[i]);
               span.innerText="已拥有";
            }


        };

        $(function () {


            $("#sub1").click(function () {
                alert("提交成功！");
                $("#form1").submit();
            });



        });



    </script>




</head>

<body>

<div class="place">
    <span>位置：</span>
    <ul class="placeul">
        <li><a href="#">个人设置</a></li>
    </ul>
</div>

<div class="formbody">

    <div class="formtitle"><span>个人信息</span></div>

    <form id="form1" action="savemyself.do" method="post">
        <input type="hidden" name="havelist" value="${user.havelist}">
        <input type="hidden" name="laterdisk" value="${user.laterdisk}">
        <input type="hidden" name="memory" value="${user.memory}">
        <ul class="forminfo">
            <li><label style="color: red">修改密码：</label><input id="Button1" type="button" class="btn" value="修改密码" /></li>
            <li><label>账号</label><input id="userid" name="userid" type="text" value="${user.userid}" readonly class="dfinput" /><i>不可修改</i></li>
            <li><label>姓名</label><input name="name" type="text" readonly value="${user.name}" class="dfinput" /><i>不可修改</i></li>
            <li><label>性别</label><input name="sex" type="text" value="${user.sex}" class="dfinput" /></li>
            <li><label>民族</label><input name="nation" type="text" value="${user.nation}" class="dfinput" /></li>
            <li><label>学校</label><input name="workschool" type="text" value="${user.workschool}" class="dfinput" /></li>
            <li><label>工作时间</label><input name="worktime" type="date" value="${user.worktime}" class="dfinput" /></li>
            <li><label>问题程序</label><input name="wentichenxu" type="text" value="${user.wentichenxu}" class="dfinput" /></li>
            <li><label>职务</label><input name="zhiwu" type="text" value="${user.zhiwu}" class="dfinput" /></li>
            <li><label>职称</label><input name="zhichen" type="text" value="${user.zhichen}" class="dfinput" /></li>
            <li><label>专任教师</label><input name="zhuanrenjiaoshi" type="text" value="${user.zhuanrenjiaoshi}" class="dfinput" /></li>
            <li><label>科目</label><input name="kemu" type="text" value="${user.kemu}" class="dfinput" /></li>
            <li><label>年级</label><input name="nianji" type="text" value="${user.nianji}" class="dfinput" /></li>
            <li><label>班级</label><input name="banji" type="text" value="${user.banji}" class="dfinput" /></li>
            <li><label>班主任</label><input name="banzhuren" type="text" value="${user.banzhuren}" class="dfinput" /></li>
            <li><label>电话</label><input name="phone" type="text" value="${user.phone}" class="dfinput" /></li>
            <li><label>备注</label><textarea name="tip" cols="" rows=""  class="textinput">${user.tip}</textarea></li>
            <li><label>&nbsp;</label><input id="sub1" name="" type="button" class="btn"  value="确认修改"/></li>
            <br>
            <br>
        </ul>
        <div class="formtitle"><span>拥有权限</span></div>

        <ul class="forminfo">
            <li><label>当前身份</label><input type="text" name="shenfen" readonly class="dfinput" value="${user.shenfen}"></li>
            <li><label>当前分组</label><input name="fenzu" type="text"  readonly value="${user.fenzu}" class="dfinput" /></li>
            <li><label>我的内存</label><input name="memoryflag"type="text" readonly value="${user.memoryflag}" class="dfinput" />MB &nbsp;&nbsp;<i>当前使用:&nbsp;${user.memory} MB </i></li>
            <br>
            <br>
        </ul>
    </form>

    <div class="formtitle"><span>档案信息</span></div>
    <br>
    <div class="rightinfo">
        <table class="tablelist">
            <thead>
            <tr>
                <th style="font-size: 16px">档案分组</th>
                <th style="font-size: 16px">当前状态</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${checkbox}" var="c" varStatus="i">
                <tr>
                    <td style="font-size: 16px">${c.diskname}</td>
                    <td style="font-size: 16px"><span style="font-size: 16px;color: red" id="${c.diskid}"></span></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

    </div>
</div>

<div class="tip" style="width: 633px;height: 276px">
    <div class="tiptop"><span>修改密码</span><a></a></div>

    <div class="tipinfo">
        <span><img src="images/ticon.png" /></span>
        <div class="tipright">
                <ul class="forminfo">
                <li><label>原始密码</label><input id="oldpassword" type="password"class="dfinput" /></li>
                    <li><label>新密码</label><input id="newpassword1" type="password"class="dfinput" /></li>
                    <li><label>重复确认</label><input id="newpassword2" type="password"class="dfinput" /></li>
                </ul>
        </div>
        <span id="tipp" style="color: red;font-size: 16px"></span>
    </div>

    <div class="tipbtn" align="center">
        <input name="" type="button"  class="sure" value="确定" />&nbsp;
        <input name="" type="button"  class="cancel" value="取消" />
    </div>

</div>

<script type="text/javascript">
    $('.imgtable tbody tr:odd').addClass('odd');
</script>

</body>
</html>
