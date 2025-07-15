<%@page import="common.Person"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!-- Tomcat8 이전에 사용되는 지시어. http로 시작하는 url를 사용한다. -->
<%--@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL - set 1</title>
</head>
<body>
<!-- 
set태그(내가 원하는 영역에 저장할때 사용)
: 변수를 선언할때 사용. JSP의 setAttribute() 메서드와 동일한 기능으로
4가지 영역에 속성을 저장한다.
	var : 속성명(변수명)을 지정.
	value : 속성에 저장할 값
	scope : 4가지 영역명을 지정. 생략시 page영역이 지정됨.
	target : set태그를 통해 생성된 자바빈의 이름을 지정함.
	property : target으로 지정한 자바빈의 멤버변수값을 지정.
 -->
 
 	<!-- 
 	변수선언 : 여기서는 가장 좁은 page영역에 저장된다.
 		value에는 일반값, EL, 표현식을 모두 사용할 수 있다.
 		또한 태그 사이에 value를 삽입할 수 있다.
 	 -->
 	 
 	 <%-- <c:set> -> JSP태그 --%>
	<c:set var="directVar" value="100" />
	<c:set var="elVar" value="${ directVar mod 5 }" />
	<c:set var="expVar" value="<%= new Date() %>" />
	<c:set var="betweenVar">변수값 요렇게 설정</c:set>
	
	
	<!-- 속성명이 중복되지 않는다면 영역을 표시하는 내장객체는
	생략할 수 있다. -->
	<h4>EL을 이용해 변수 출력</h4>
	<ul>
		<li>directVar : ${ pageScope.directVar }</li>
		<li>elVar : ${ elVar }</li>
		<li>expVar : ${ expVar }</li>
		<li>betweenVar : ${ betweenVar }</li>
	</ul>
	
	<h4>자바빈즈 생성 1 - 생성자 사용</h4>
	<!-- 
	클래스의 생성자를 통해 인스턴스를 생성한 후 request영역에 저장
	 -->
	<c:set var="personVar1" value='<%= new Person("박문수", 50) %>'
			scope="request" />
	<!-- 
	자바빈의 getter 메서드를 통해 멤버변수의 값이 출력된다.
	-->
	<ul>
		<li>이름 : ${ requestScope.personVar1.name }</li>
		<li>나이 : ${ personVar1.age }</li>
	</ul>
	
	<h4>자바빈즈 생성 2 - target, property 사용</h4>
	<!-- 
	인스턴스를 먼저 생성한 후 target, property를 통해 멤버변수의 값을
	초기화한다. 이때는 자바빈의 setter 메서드가 사용된다.
	 -->
	<c:set var="personVar2" value="<%= new Person() %>" scope="request" />
	<c:set target="${personVar2 }" property="name" value="정약용" />
	<c:set target="${personVar2 }" property="age" value="60" />
	<ul>
		<li>이름 : ${ personVar2.name }</li>
		<li>나이 : ${ requestScope.personVar2.age }</li>
	</ul>
</body>
</html>