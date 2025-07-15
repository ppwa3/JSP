<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.LocalDate" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 
HTML주석 - 소스보기 시 화면에 출력된다.
 -->
<%--
JSP주석 - 소스보기 하더라도 화면에 출력되지 않는다.
 Tomcat 웹서버 내에서 이 부분은 처리된 후 화면에 표시하지
 않기 때문이다.
--%>
<%
LocalDate today = LocalDate.now(); //오늘 날짜
LocalDateTime tomorrow = LocalDateTime.now().plusDays(1); //내일 날짜
%> 