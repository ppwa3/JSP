<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Session</title>
</head>
<body>
	<!-- 
	JSP에서 인클루드는 2가지 방식이 있다.
	1.include 지시어를 이용한 방법
	2.액션태그를 사용한 방버
	 -->
	 <!-- 방법1 -->
	<jsp:include page="../Common/Link.jsp" />
	<!-- 방법2 -->
	<%--@ include file="../Common/Link.jsp" --%>
	
	<h2>로그인 페이지</h2>
	<!-- 
	로그인을 위해 폼값을 전송한 후 만약 조건에 맞는 회원정보가 없다면
	request영역에 에러메세지를 저장한 후 현재페이지로 forward한다.
	request영역은 forward된 페이지까지는 데이터를 공유하므로 아래
	메세지를 출력할 수 있다.
	 -->
	<span style="color: red; font-size: 1.2em;">
		<%= request.getAttribute("LoginErrMsg") == null ?
				"" : request.getAttribute("LoginErrMsg") %>
	</span>
	<%
	if (session.getAttribute("UserId") == null) {
		/*
		session영역에 해당 속성이 있는지 확인한다. 만약 영역에 저장된 
		정보가 없다면 '로그아웃' 상태이므로 로그인 폼을 웹브라우저에 출력해야
		한다. */
	%>
	<script>
	//로그인폼의 입력값이 있는지 확인
	function validateForm(form) {
		if (!form.user_id.value) {
			alert("아이디를 입력하세요.");
			form.user_id.focus();
			return false;
		}
		if (form.user_pw.value == "") {
			alert("패스워드를 입력하세요.");
			form.user_pw.focus();
			return false;
		}
	}
	</script>
	<!-- 
	로그인을 위한 <form>태그로 전송방식은 POST로 지정하고, submit 이벤트
	발생시 폼값 검증을 위해 JS함수를 호출한다. -->
	<form action="LoginProcess.jsp"method="post" name="loginFrm"
		onsubmit="return validateForm(this);">
		아이디 : <input type="text" name="user_id" /><br />
		패스워드 : <input type="password" name="user_pw" /><br />
		<input type="submit" value="로그인하기" />
	</form>
	<%
	} else {
	%>
		<!-- session영역에 속성값이 있다면 로그인에 성공한 상태이므로
		회원의 이름과 로그아웃 버튼을 출력한다. -->
		<%= session.getAttribute("UserName") %> 회원님, 로그인하셨습니다.<br />
		<a href="Logout.jsp">[로그아웃]</a>
	<%
	}
	%>
</body>
</html>