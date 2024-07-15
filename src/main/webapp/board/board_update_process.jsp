<%@page import="org.apache.ibatis.exceptions.PersistenceException"%>
<%@page import="kr.co.sist.user.member.WebMemberVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="kr.co.sist.user.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="글 변경 페이지"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="http://192.168.10.225/jsp_prj/common/favicon.ico"/>
<!--bootstrap 시작-->
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<!--bootstrap 끝-->
<link rel="stylesheet" href="http://192.168.10.225/jsp_prj/common/css/main.css" type="text/css" media="all" />
<link rel="stylesheet" href="http://192.168.10.225/jsp_prj/common/css/board.css" type="text/css" media="all" />

<!--jQuery CDN 시작-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!--jQuery CDN 끝-->

<style type="text/css">
	
</style>
<% request.setCharacterEncoding("UTF-8"); %>
<!-- parameter 받기 -->
<jsp:useBean id="bVO" class="kr.co.sist.user.board.BoardVO" scope="page"/>
<jsp:setProperty property="*" name="bVO"/>
<script type="text/javascript">
	<% 
	try{
	//아이디는 세션에 저장된 값을 받아서 설정. 외부에서 조작 불가하다		
	bVO.setId("kim");
	//bVO.setId(((WebMemberVO)session.getAttribute("loginData")).getId());
		
	BoardDAO bDAO= BoardDAO.getInstance();
	int cnt= bDAO.updateBoard(bVO);
	
	if(cnt == 1){
	%>
	alert("글을 수정하였습니다.");
	location.href="http://192.168.10.225/mybatis_prj/board/board_list.jsp?currentPage=${param.currentPage}";
	<%
		
	}else{
	%>
	alert("글 수정 실패");
	history.back();
	<%
	}//end else
		
	}catch(PersistenceException se){
		se.printStackTrace();
		%>
		location.href="http://192.168.10.225/jsp_prj/err/err_500.html";
		<%
	}//end catch
	
	%>
	$(function(){
		
	});//ready
</script>
</head>
<body>
<div>
	
</div>
</body>
</html>