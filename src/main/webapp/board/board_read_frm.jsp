<%@page import="org.apache.catalina.Session"%>
<%@page import="org.apache.ibatis.exceptions.PersistenceException"%>
<%@page import="kr.co.sist.user.member.WebMemberVO"%>
<%@page import="kr.co.sist.user.board.BoardDomain"%>
<%@page import="java.util.List"%>  
<%@page import="kr.co.sist.user.board.BoardDAO"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info="게시판 글 읽기"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- //로그인했을경우일때만 사용
<%
//개발의 편의성을 위해 로그인 한 것처럼 코드를 작성한 후 작업진행
WebMemberVO wmVO= new WebMemberVO();
wmVO.setId("kim");

session.setAttribute("loginData", wmVO);

%> 
<c:if test="${empty sessionScope.loginData }">
<c:redirect url="http//192.168.10.225/mybatis_prj/index.jsp"/>
</c:if>
--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="http://192.168.10.225/mybatis_prj/common/favicon.ico" />
<!--bootstrap 시작-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<!--bootstrap 끝-->
<link rel="stylesheet"
	href="http://192.168.10.225/mybatis_prj/common/css/main.css"
	type="text/css" media="all" />
<link rel="stylesheet"
	href="http://192.168.10.225/mybatis_prj/common/css/board.css"
	type="text/css" media="all" />

<!--jQuery CDN 시작-->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!--jQuery CDN 끝-->

<!-- summer note 시작 -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
<!-- summer note 끝 -->

<style type="text/css">
#wrap {
	width: 1462;
	height: 749;
	margin: 0px auto;
}

#header {
	height: 100px;
	background: #ffffff url('http://localhost/mybatis_prj/common/header.png') no-repeat;}
	#reply_wrap{height:200px; margin-top: 20px}
	#replyContent{height:170px; overflow: auto; margin-top: 10px}
		
</style>
<script type="text/javascript">
	$(function() {
		$("#btnList").click(function(){
			//history.back(); //cnt 올라간게 안보임
			
			location.href="http://192.168.10.225/mybatis_prj/board/board_list.jsp?currentPage=${param.currentPage}";
		});
		$("#btnUpdate").click(function(){
			if(confirm("글을 수정하시겠습니까?")){
				chkNull();
			}//end if
		});
		$("#btnDelete").click(function(){
			if(confirm("글을 정말 삭제하시겠습니까?")){
				//<fotm태그의 action 변경
				//var frm=document.frmDetail.action="백엔드 url"
				$("#frmDetail")[0].action="board_delete_process.jsp";
			
				$("#frmDetail").submit();
			}//end if
		});
		
		$("#btnWrite").click(function(){
			var content=$("#rContent").val();
			var writer=$("rWriter").val();
			
			if(content == ""){
				alert("댓글의 내용은 필수 입력입니다.");
				$("#rContent").focus();
				return;
			}
			
			if(writer == ""){
				alert("작성자는 필수 입력입니다.");
				$("#rWriter").focus();
				return;
			}
			
			var param={num: $("#seq").val(), content:content, writer:writer};
			$.ajax({
				url:"add_reply.jsp",
				type: "POST",
				data: param,
				
				dataType: "JSON",
				error: function(xhr){
					alert("잠시 후 다시 시도해주세요");
					console.log(xhr.status);
				},
				success: function(jsonObj){
					var msg="댓글작성 실패";
					if(jsonObj.flag){
						
						msg="댓글을 작성하였습니다.";
						$("#rContent").val("");
						$("#rWriter").val("");
						
						var menuText=$("#replyMenu").text();
						
						if(menuText == "열기"){
							menuText="닫기";
						$("#replyContent").toggle();
						}
						searchReply();
						
						$("#replyMenu").text(menuText);
					}//end if
					alert(msg);
				}//success
			});
		});//click
		
		$("#replyMenu").click(function(){
			replyShow();
		});		
				
	});//ready
	
 	function replyShow(){
		var menuText=$("#replyMenu").text();
		
		if(menuText == "열기"){
			menuText="닫기";
		}else{
			menuText="열기";
		}//end else
		searchReply();
		
		$("#replyContent").toggle();
		$("#replyMenu").text(menuText);
	}; 
	
		
	function searchReply(){
		var param={refNum: $("#seq").val()};
		$.ajax({
			url:"reply_search.jsp",
			type:"POST",
			data: param,
			
			dataType:"JSON",
			async:false,
			error: function(xhr){
				alert("죄송합니다.");
				console.log(xhr.status)
			},
			success: function(jsonObj){
				var output="";
				if(jsonObj.flag){
					if(jsonObj.dataSize == 0){
						output="작성된 댓글이 없습니다.";
					}
					$.each(jsonObj.data, function(i, jsonTemp){
						output+="<div><strong>내용</strong> : "+jsonTemp.content+"<br>";
						output+="<strong>작성자</strong> : "+jsonTemp.writer
						+"<strong>작성일</strong>"+jsonTemp.input_date+"<strong>ip</strong>"+jsonTemp.ip+
						"<input type='button' value='삭제' class='btn btn-warning btn-sm' onclick='removeReply("+jsonTemp.num+")'>"
						+jsonTemp.ip+"</div>";
					});//each
				}//end if
				$("#replyContent").html(output);
			}
		});//ajax
		
	}//searchReply
	
	function removeReply(num){
		if(confirm("댓글을 삭제하시겠습니까?")){
			var param={num:num};
			
			$.ajax({
				url:"remove_reply.jsp",
				type:"POST",
				data: param,
				dataType: "JSON",
				error: function(xhr){
					alert("죄송합니다.");
					console.log(xhr.status);
				},
				success: function(jsonObj){
					var output="댓글이 삭제되지 않았습니다.";
					if(jsonObj.result){
						output="댓글이 삭제되었습니다.";
					}
					searchReply();
					alert(output);
				}//success
			})
		}//end if
	}//removeReply
	
	
	function chkNull(){
		if($("#title").val().trim() == ""){
			alert("글제목은 필수입력");
			$("#title").focus();
			return;
		}//end if
		
		if($("#content").val().trim()==""){
			alert("내용은 필수입력");
			$("#content").focus();
			return;
		}//end if
		
		if($("#content").val().trim()==""){
			alert("내용은 필수입력");
			$("#content").focus();
			return;
		}//end if
		
		if($("#cnt").val().trim()==""){
			$("#cnt").val(0);
		}
		
		$("#frmDetail")[0].action="board_update_process.jsp";
		alert($("#frmDetail")[0].action);
		$("#frmDetail").submit();
	}//chkNull
</script>

<script>
$(function(){
      $('#content').summernote({
        tabsize: 2,
        width:600,
        height: 200,
        toolbar: [
          ['style', ['style']],
          ['font', ['bold', 'underline', 'clear']],
          ['color', ['color']],
          ['para', ['ul', 'ol', 'paragraph']],
          ['table', ['table']],
          ['insert', ['link', 'picture', 'video']],
          ['view', ['fullscreen', 'codeview', 'help']]
        ]
      });
});//ready
    </script>


</head>
<body>
	<div id="wrap">
		<div id="header"></div>
		<div id="boardContent">
		<%
		BoardDAO bDAO= BoardDAO.getInstance();
				try{
			String seq= request.getParameter("seq");
			
			//조회수를 올릴수 있는 세션을 사용
			Object cntSession=session.getAttribute("cntFlag");
			
			boolean cntFlag=false;
			if(cntSession != null){
				//cntFlag=((Boolean)cntSession).booleanValue();
				//cntFlag=(boolean)cntSession;
				cntFlag=((String)cntSession).contains(seq);
			}//end if
			
			if(!cntFlag){
				bDAO.updateCnt(Integer.parseInt(seq));
				session.setAttribute("cntFlag", session.getAttribute("cntFlag")+","+seq);
			}//end if
			
			BoardDomain bVO=bDAO.selectDetailBoard(Integer.parseInt(seq));
			//bDAO.updateCnt(Integer.parseInt(seq));
			
			pageContext.setAttribute("bVO", bVO);
				}catch(NumberFormatException nfe){
		%>
			<c:redirect url="board_list.jsp"/>
			<%
		}catch(PersistenceException se){
			se.printStackTrace();
		%>
		<script type="text/javascript">
		location.href="http://192.168.10.225/mybatis_prj/err/err_500.html";
		</script>
		<% }//end catch 
		
		%>
		<form method="post" name="frmDetail" id="frmDetail"> <!-- 썸머노트는 post만  -->
		<input type="hidden" name="num" value="${param.seq }"/>
		<input type="hidden" name="currentPage" value="${param.currentPage }"/>
			<table>
				<tr>
					<td colspan="2"><h3>글읽기</h3></td>
				</tr>	
				<tr>
					<td>제목</td>
					<td>
					<input type="text" name="title" id="title" style="width:600px" value="${bVO.title }"/>
					</td>
				</tr>
				<tr>
					<td>내용</td>
					<td>
					<textarea id="content" name="content">${bVO.content }</textarea>
					</td>
				</tr>
				<tr>
					<td>조회수</td>
					<td>
					<input type="text" name="cnt" id="cnt" value="${bVO.cnt }" style="width:600px"/>
					</td>
				</tr>
				<tr>
					<td>작성자</td>
					<td><strong><fmt:formatDate value="${bVO.input_date }" pattern="yyyy-MM-dd EEEE HH:mm:ss"/></strong></td>
				</tr>
				<tr>
					<td>작성일</td>
					<td><strong><c:out value="${bVO.id }"/></strong></td>
				</tr>
				<tr>
					<td colspan="2" style="text-align:center;">
					<input type="button" value="글수정" class="btn btn-success btn-sm" id="btnUpdate"/>
					<!-- {not empty sessionScope.loginData} -->
					<input type="button" value="글삭제" class="btn btn-warning btn-sm" id="btnDelete"/>
					<input type="button" value="글목록" class="btn btn-info btn-sm" id="btnList"/>
					
					</td>
				</tr>
			</table>
			
		</form>
		</div>
		<div id="reply_wrap">
			<div id="reply_frm">
			<input type="hidden" name="seq" id="seq" value="${param.seq }"/>
				내용<input type="text" name="rContent" id="rContent" style="width:300px"/>
				작성자<input type="text" name="rWriter" id="rWriter" style="width:100px"/>
				<input type="button" value="댓글작성" id="btnWrite" class="btn btn-success btn-sm"/>
			</div>
			<a href="#void" id="replyMenu">열기</a>
			<div id="replyContent" style="display:none">
			
			</div>
		</div>
	</div>
</body>
</html>