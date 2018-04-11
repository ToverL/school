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
    <script language="JavaScript">

        function back(){
            window.location.href="selectuser.do";
        }

        window.onload=function () {
            var ck_val = "${checked}";
            var ck_val1=ck_val.split(',');

            for(var i=0;i<ck_val1.length;i++){
                var el = document.getElementById(ck_val1[i]);
                el.checked=true;
            }

        }



        $(function () {

            $("#sub1").click(function () {
                alert("提交成功！");
                $("#form1").submit();
            });


            $("#password_set").click(function () {

                var userid=$("#userid").val();
                var user={password:"123456",userid:userid};
                $.ajax({
                    url: "setpassword.do",
                    type: "post",
                    data: user,
                    dataType: "json",
                    success: function f(data) {
                        if(data.success=="success"){
                            alert("密码重置成功！请用户尽快修改密码！");
                        }else {
                            alert("服务器繁忙！重置失败！");
                        }

                    }

                });


            });



        });



    </script>




</head>

<body>

<div class="place">
    <span>位置：</span>
    <ul class="placeul">
        <li><a href="#">用户详情</a></li>
    </ul>
</div>

<div class="formbody">

    <div class="formtitle"><span>基本信息</span></div>

    <form id="form1" action="saveuser.do" method="post">
        <input type="hidden" name="havelist" value="${user.havelist}">
        <input type="hidden" name="laterdisk" value="${user.laterdisk}">
        <input type="hidden" name="memory" value="${user.memory}">
    <ul class="forminfo">
        <li><label>账号</label><input id="userid" name="userid" type="text" value="${user.userid}" readonly class="dfinput" /><i>身份证号</i></li>
        <li><label>姓名</label><input name="name" readonly type="text" value="${user.name}" class="dfinput" /></li>
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
    </ul>
    <div class="formtitle"><span>权限设定</span></div>

        <ul class="forminfo">

            <li><label>身份</label><select name="shenfen" class="dfinput">
                <option value="普通用户">普通用户</option>
                <option value="教案管理员">教案管理员</option>
                <option value="档案管理员">档案管理员</option>
                <option value="高级用户">高级用户</option>
            </select><i>当前身份:&nbsp;${user.shenfen}&nbsp;&nbsp;高级用户可查看下载所有档案</i></li>
            <li><label>分组</label><input name="fenzu" type="text" value="${user.fenzu}" class="dfinput" /><i>分组应该和教案分组保持一直，取同样名字</i></li>
            <li><label>内存分配</label><input name="memoryflag" type="text" value="${user.memoryflag}" class="dfinput" />MB &nbsp;&nbsp;<i>当前使用:&nbsp;${user.memory} MB&nbsp;&nbsp;内存建议默认每人500MB</i></li>

            <li><label style="font-size: 16px;color: red">默认密码：</label><input type="text" hidden class="dfinput" value="123456"><i>密码重置后默认为123456</i><input id="password_set" type="button" class="btn" value="密码重置"/></li>
            <li><label>档案分配</label></li>
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
                            <td style="font-size: 16px"> <input id="${c.diskid}" style="width: 16px" type="checkbox" name="filebox" class="dfinput" value="${c.diskid}" ></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

            </div>
            <br>
            <br>
            <label>&nbsp;</label><input id="sub1" name="" type="button" class="btn"  value="确认修改"/><label>&nbsp;</label><label>&nbsp;</label><input name="" type="button" class="btn" onclick="back()" value="返回"/>
            <br>
            <br>
            <br>
            <br>
        </ul>
    </form>



</div>
</body>
</html>
