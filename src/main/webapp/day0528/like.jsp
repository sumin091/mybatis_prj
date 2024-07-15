<%@page import="kr.co.sist.domain.EmpDomain"%>
<%@page import="java.util.List"%>
<%@page import="day0527.ExamMapper4DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="like 조회"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<form name="frm" action="index.jsp">
	<input type="hidden" name="link" value="day0528/like"/>
	<h2>입력되는 문자가 들어있는 사원명 조회</h2>
	<label>이름</label>
	<input type="text" name="ename"/>
	<input type="text" style="display: none"/>
	<input type="submit" value="검색" class="btn btn-success btn-sm"/>
</form>
<div>
<c:if test="${not empty param.ename }">
입력하신 문자 [<strong><c:out value="${param.ename}"/></strong>$]가 포함된 사원명 검색결과<br>
<c:catch var="e">
<%
String ename=request.getParameter("ename");
ExamMapper4DAO em4DAO=ExamMapper4DAO.getInstance();
List<EmpDomain> list=em4DAO.like(ename);
pageContext.setAttribute("list", list);
%>
<c:if test="${empty list }">
사원이 존재하지 않는 부서
</c:if>
<table>
<tr> 
<th style="width: 80px">사원번호</th>
<th style="width: 200px">사원명</th>
<th style="width: 120px">사원직무</th>
<th style="width: 120px">연봉</th>
<th style="width: 300px">입사일</th>
</tr>
<c:if test="${empty list }">
<tr>
<td colspan="5" style="text-align: center">
문자를 포함하는 사원정보 없음
</td>
</tr>
</c:if>
<c:forEach var="ed" items="${list }" varStatus="i" >
<tr>
<td><c:out value="${ed.empno }"/></td>
<td><c:out value="${ed.ename }"/></td>
<td><c:out value="${ed.job }"/></td>
<td><c:out value="${ed.sal }"/></td>
<td><c:out value="${ed.hiredateStr }"/></td>
</tr>
</c:forEach>
</table>
<option value="${empno }"><c:out value="${i.count}.${empno }" /></option>
</c:catch>
<c:if test="${not empty e}">
문제발생
</c:if>
</c:if>
</div>
