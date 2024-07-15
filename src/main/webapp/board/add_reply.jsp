<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.SQLException"%>
<%@page import="kr.co.sist.user.board.ReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="리플추가" trimDirectiveWhitespaces="true"%>
    <%request.setCharacterEncoding("UTF-8"); %>
    <jsp:useBean id="rVO" class="kr.co.sist.user.board.ReplyVO" scope="page"/>
    <jsp:setProperty property="*" name="rVO"/>
 <%
 rVO.setIp(request.getRemoteAddr());
 
 JSONObject jsonObj= new JSONObject();
 jsonObj.put("flag", false);
 try{
	ReplyDAO rDAO= ReplyDAO.getInstance();
	rDAO.insertReply(rVO);
	jsonObj.put("flag",true);
 }catch(SQLException se){
	 se.printStackTrace();
 }
 %>
 <%=jsonObj.toJSONString() %>