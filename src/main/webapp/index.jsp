<%--
  Created by IntelliJ IDEA.
  User: 刘佳伟
  Date: 2018/3/30
  Time: 23:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" isELIgnored="false" %>
<%@ page pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta charset="utf-8">
    <title>上传图片</title>
    <link href="Dropzone/css/basic.css" rel="stylesheet" />
    <link href="Dropzone/css/dropzone.css" rel="stylesheet" />
    <script src="Dropzone/dropzone.min.js"></script>
</head>
<body>
<form action="upload.do" method="post" enctype="multipart/form-data"
      class="dropzone" id="dropzoneForm">
    <!-- <input type="file" name="file" />
    <input type="submit" value="Submit" />
     -->
    <input type="hidden" name="path"value="${sessionScope.diskfather}">
    <input type="hidden" name="userid" value="${sessionScope.user.userid}">
    <input type="hidden" name="diskfather" value="${diskfather}">
</form>
<script type="text/javascript">
    Dropzone.options.dropzoneForm = {
        init : function() {
            this.on("complete", function(data) {
                var res = eval('(' + data.xhr.responseText + ')');
                alert(" success : "+ res.success +"\n" + " msg : "+ res.msg +"\n" + " path : "+ res.path +"\n" + " md5_name : "+ res.md5_name+"\n" + " ori_name : "+ res.ori_name+"\n" + " url : "+ res.url);

            });
        }
    };
</script>
</body>
</html>