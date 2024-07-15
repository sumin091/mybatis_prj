<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="메일전송 폼"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="http://192.168.10.225/mybatis_prj/common/favicon.ico"/>
<!--bootstrap 시작-->
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<!--bootstrap 끝-->
<link rel="stylesheet" href="http://192.168.10.225/mybatis_prj/common/css/main.css" type="text/css" media="all" />
<link rel="stylesheet" href="http://192.168.10.225/mybatis_prj/common/css/board.css" type="text/css" media="all" />

<!--jQuery CDN 시작-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!--jQuery CDN 끝-->

<style type="text/css">
	.margin {margin-bottom:10px}
</style>
<script type="text/javascript">
	$(function(){
		$("#btn").click(function(){
			$("#frm").submit();
		});
	});//ready
</script>
</head>
<body>
<div>
<h2>메일전송</h2>
	<form action="email_process.jsp" method="post" id="frm">
	<div style="margin-bottom:10px">
	<label>수신</label>
	<input type="text" name="email" style="width: 300px" autofocus="autofocus"/><br>
	</div>
	<div style="margin-bottom:10px">
	<label>제목</label>
	<input type="text" name="subject" style="width: 500px"/><br>
	</div>
	<div style="margin-bottom:10px">
	<label>내용</label>
	<textarea style="width:500px; height: 100px" name="content"></textarea><br>
	<input type="button" value="전송" id="btn" class="btn btn-sm btn-info" />
	</div>
	</form>
</div>
</body>
</html>