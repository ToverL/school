<%--
  Created by IntelliJ IDEA.
  User: 刘佳伟
  Date: 2018/4/8
  Time: 10:15
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


        $(function () {

            $("#sub1").click(function () {
               if($("#userid").val()==''){
                   alert("请填写账号！");
               }else if($("#name").val()==''){
                   alert("请输入姓名！");
               }else  if ($("#fenzu").val()==''){
                   alert("请输入分组！");
               } else {
                   alert("提交成功！");

                   $("#form1").submit();

               }

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
        <input type="hidden" name="havelist" value="0">
        <input type="hidden" name="laterdisk" value="-2">
        <ul class="forminfo">
            <li><label>账号</label><input id="userid" name="userid" type="text" value="" class="dfinput" /><i style="color: red">必填</i><i>身份证号(核对清楚，一经设定无法修改)</i></li>
            <li><label>姓名</label><input id="name" name="name" type="text" value="" class="dfinput" /><i style="color: red">必填项</i></li>
            <li><label>性别</label><input name="sex" type="text"  class="dfinput" /></li>
            <li><label>民族</label><input name="nation" type="text"  class="dfinput" /></li>
            <li><label>学校</label><input name="workschool" type="text"  class="dfinput" /></li>
            <li><label>工作时间</label><input name="worktime" type="date"  class="dfinput" /></li>
            <li><label>问题程序</label><input name="wentichenxu" type="text"  class="dfinput" /></li>
            <li><label>职务</label><input name="zhiwu" type="text"  class="dfinput" /></li>
            <li><label>职称</label><input name="zhichen" type="text"  class="dfinput" /></li>
            <li><label>专任教师</label><input name="zhuanrenjiaoshi" type="text"  class="dfinput" /></li>
            <li><label>科目</label><input name="kemu" type="text"  class="dfinput" /></li>
            <li><label>年级</label><input name="nianji" type="text"  class="dfinput" /></li>
            <li><label>班级</label><input name="banji" type="text"  class="dfinput" /></li>
            <li><label>班主任</label><input name="banzhuren" type="text" class="dfinput" /></li>
            <li><label>电话</label><input name="phone" type="text" class="dfinput" /></li>
            <li><label>备注</label><textarea name="tip" cols="" rows=""  class="textinput">无</textarea></li>
        </ul>
        <div class="formtitle"><span>权限设定</span></div>

        <ul class="forminfo">

            <li><label>身份</label><select name="shenfen" class="dfinput">
                <option value="普通用户">普通用户</option>
                <option value="教案管理员">教案管理员</option>
                <option value="档案管理员">档案管理员</option>
                <option value="高级用户">高级用户</option>
            </select><br><i style="color: red">&nbsp;&nbsp;普通用户：仅可对自己文件操作，其他文件只能浏览下载，非本组档案不可见；教案管理员：可对所有教案操作，非本组档案不可见；档案管理员：可对所有档案操作；高级用户：所有教案档案都可操作</i></li>
            <li><label>分组</label><input id="fenzu" name="fenzu" type="text"  class="dfinput" value="" /><i style="color: red">必填</i><i>分组应该和教案分组保持一直，取同样名字</i></li>
            <li><label>内存分配</label><input name="memoryflag" type="text" value="500" class="dfinput" />MB <i>&nbsp;&nbsp;内存建议默认每人500MB</i></li>

            <li><label style="color: red">默认密码：</label><input type="text" name="password" readonly class="dfinput" value="123456"></li>
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
            <label>&nbsp;</label><input id="sub1" name="" type="button" class="btn"  value="确认添加"/><label>&nbsp;</label><label>&nbsp;</label><input name="" type="button" class="btn" onclick="back()" value="返回"/>
            <br>
            <br>
            <br>
            <br>
        </ul>
    </form>



</div>
</body>
</html>

