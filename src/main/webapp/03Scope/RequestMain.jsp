<%@page import="common.Person"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
/*
request 영역
	: 클라이언트가 요청을 할때마다 새로운 request객체가 생성되어 같은
	요청을 처리하는데 사용되는 모든 JSP페이지가 영역을 공유한다.
	즉 request영역에 저장된 정보는 현재페이지와 포워드된 페이지까지
	공유된다.
*/
//리퀘스트 영역에 2개의 속성을 저장
request.setAttribute("requestString", "request 영역의 문자열");//문자열
request.setAttribute("requestPerson", new Person("안중근", 31));//인스턴스
request.setAttribute("requestPerson1", new Person("림진석", 29));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>request 영역</title>
</head>
<body>
	<h2>request 영역의 속성값 삭제하기</h2>
	<%
		//리퀘스트 영역에 저장되어 있으므로 정상적으로 삭제됨.
		request.removeAttribute("requestString");
		//없는 속성이므로 삭제되지 않음. 또한 에러도 발생하지 않음.
		request.removeAttribute("requestInteger");
	%>
	<h2>request 영역의 속성값 읽기</h2>
	<%
	/*
	Person인스턴스는 아직 저장되어 있으므로 값을 얻어온 후 Person타입으로
	형변환한다. 4가지 영역은 Object를 기반으로 데이터를 저장하므로 값을
	읽을때는 반드시 해당 타입으로 형변환 해야한다. */
	Person rPerson = (Person)(request.getAttribute("requestPerson1"));
	%>
	<ul>
	 	<!-- 앞에서 삭제했으므로 null이 출력된다. -->
		<li>String 객체 : <%= request.getAttribute("requestString") %></li>
		<!-- 
		멤버변수는 private으로 정보은닉되어 있으므로 getter메서드를 
		이용해서 값을 출력해야한다 -->
		<li>Person 객체 : <%= rPerson.getName() %>, <%= rPerson.getAge() %></li>
	</ul>
	<h2>포워드된 페이지에서 request 영역 속성값 읽기</h2>
	<%
	/*
	포워드 : 현재 페이지로 들어온 요청을 다음 페이지로 보내는 기능을 말한다.
		즉 하나의 요청을 둘 이상의 페이지가 공유할 수 있다.
		포워드 명령을 만나기 전까지의 모든 내용은 버퍼에서 삭제되고,
		포워드된 페이지의 내용만 화면에 출력하는 특징을 가진다.
		즉 포워드란 현재 페이지로 들어온 요청을 다른 페이지에서도 공유할 수
		있도록 전달하는것으로, 주소줄에는 최초 요청을 받은 페이지명이 나오고
		웹브라우저에는 요청을 전달된 페이지가 출력된다.
	*/
	request
	.getRequestDispatcher("RequestForward.jsp?paramHan=한굴&paramEng=English")
	.forward(request, response);
	/*
	포워드시 2개의 파라미터를 전달한다. 또한 request영역에 저장된 속성도
	함께 공유된다.
	*/
	%>
</body>
</html>