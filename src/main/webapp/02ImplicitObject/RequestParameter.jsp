<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내장 객체 - request</title>
</head>
<body>
<%
/*
Tomcat 이전 버전에서는 POST방식으로 한글을 전송하는 경우 깨짐현상이
발생되어 아래와 같이 인코딩 처리를 해야한다. 10.1.x 이후는 문제가 없으므로
필요한 경우에만 사용하면된다.*/
request.setCharacterEncoding("UTF-8");
/*
getParameter()
	: input태그의 text, radio 타입처럼 하나의 값이 전송되는 경우에
	사용한다. 입력값이 문자, 숫자에 상관없이 String타입으로 저장된다.
getParameterValues()
	: checkbox와 같이 2개 이상의 값의 전송되는 경우에 사용한다.
	이 값은 String타입의 배열로 저장된다.
*/
String id = request.getParameter("id");
String sex = request.getParameter("sex");
String[] favo = request.getParameterValues("favo");
String favoStr = "";
if(favo != null) {
	//배열의 크기만큼 반복해서 변수에 값을 추가
	for (int i = 0; i< favo.length; i++){
		favoStr += favo[i] + " ";
	}
}
/*
<textarea>는 2줄 이상 입력이 가능하므로 엔터를 추가하는 경우 \r\n으로
저장된다. 웹브라우저 출력시에는 <br>태그로 변경해야 줄바꿈 처리된다. */
String intro = request.getParameter("intro").replace("\r\n", "<br/>");
%>
<ul>
	<li>아이디 : <%= id %></li>
	<li>성별 : <%= sex %></li>
	<li>관심사항 : <%= favoStr %></li>
	<li>자기소개 : <%= intro %></li>
	<!-- select 태그 추가 -->
	<li>학력 : <%= request.getParameter("grade") %></li>
</ul>
</body>
</html>