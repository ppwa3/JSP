<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>session 영역</title>
</head>
<body>
	<h2>페이지 이동 후 session 영역의 속성 읽기</h2>
	<%
	/*
	웹브라우저를 완전히 닫을때까지는 session영역이 공유되므로 저장된
	리스트를 읽을 수 있다.
	*/
	ArrayList<String> lists = (ArrayList<String>)session.getAttribute("lists");
	for (String str : lists)
		out.print(str + "<br/>");
	/*
	모든 실행창(웹브라우저)를 닫은 후 해당 페이지를 단독으로 실행하면
	NullPointerException이 발생된다. session영역은 웹 브라우저를 
	닫으면 모두 소멸된다.
	*/
	%>
</body>
</html>