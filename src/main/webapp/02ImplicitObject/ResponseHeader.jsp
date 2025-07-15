<%@page import="java.util.Collection"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//날짜와 시간의 서식 지정
SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd HH:mm");
//String 타입의 폼값을 날짜 형식으로 변경한 후 타임스템프로 변경한다.
long add_date = s.parse(request.getParameter("add_date")).getTime();
//숫자형식으로 전송된 값은 정수로 변환
int add_int = Integer.parseInt(request.getParameter("add_int"));
//문자형은 그대로 사용한다.
String add_str = request.getParameter("add_str");
// 날짜 형식의 응답헤더 추가
response.addDateHeader("myBirthday", add_date);
//숫자형식추가
response.addIntHeader("myNumber", add_int);
response.addIntHeader("myNumber", 1004);
//문자형식추가
response.addHeader("myName", add_str);
//앞에서 추가한 값을 '안중근'으로 수정한다.
response.setHeader("myName", "안중근");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내장 객체 - response</title>
</head>
<body>
	<h2>응답 헤더 정보 출력하기</h2>
	<%
	//응답헤더명 전체를 얻어옴
	Collection<String> headerNames = response.getHeaderNames();
	for (String hName : headerNames) {
		//응답헤더명을 통해 헤더값을 인출해서 출력한다.
		String hValue = response.getHeader(hName);
	%>
		<li><%= hName %> : <%= hValue %></li>
	<%
	}
	%>
	
	<h2>myNumber만 출력하기</h2>
	<%
	/*
	첫번째 출력결과에서 myNumber라는 헤더명이 2번 출력되는데 이때 동일한
	값 8282가 출력된다. getHeader() 메서드를 통해 출력하면 처음 입력한
	헤더값만 출력되게 된다.
	따라서 이 경우에는 getHeaders()를 통해 해당값을 얻어온 후 반복해서
	출력하면 각각의 값이 출력된다. */
	Collection<String> myNumber = response.getHeaders("myNumber");
	for (String myNum : myNumber) {
	%>
		<li>myNumber : <%= myNum %></li>
	<%
	}
	%>
</body>
</html>