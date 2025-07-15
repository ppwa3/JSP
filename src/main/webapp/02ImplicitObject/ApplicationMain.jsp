<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내장 객체 - application</title>
</head>
<body>
	<!-- web.xml에 <context-param>으로 설정한 값을 내장객체를
	통해 읽어올 수 있다. -->
	<h2>web.xml에 설정한 내용 읽어오기</h2>
	초기화 매개변수 : <%= application.getInitParameter("INIT_PARAM") %>
	
	
	<!-- 
	사용하는 OS(운영체제)에 따라 경로를 표시하는 방법이 다르므로
	application 내장객체를 통해 절대경로(물리적경로)를 얻어올 수 있다.
	이렇게 얻어온 경로를 통해 파일업로드/다운로드를 구현할 수 있다.
	 -->
	<h2>서버의 물리적 경로 얻어오기</h2>
	application 내장 객체 : <%= application.getRealPath("/02ImplicitObject") %>
	
	<h2>선언부에서 application 내장 객체 사용하기</h2>
	<%!
	public String useImplicitObject() {
		return this.getServletContext().getRealPath("/02ImplicitObject");
	}
	/*
	메서드에서 application 내장객체를 사용하려면 매개변수를 통해 전달해야
	한다. 이때 ServletContext 타입의 매개변수를 통해 받은 후 사용할 수 
	있다. */
	public String useImplicitObject(ServletContext app) {
		return app.getRealPath("/02ImplicitObject");
	} 
	%>
	<ul>
		<li>this 사용 : <%= useImplicitObject() %></li>
		<li>내장 객체를 인수로 전달 : <%= useImplicitObject(application) %></li>
	</ul>
</body>
</html>