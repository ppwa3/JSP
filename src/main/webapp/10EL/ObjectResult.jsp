<%@page import="common.Person"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>표현 언어(EL) - 객체 매개변수</title>
</head>
<body>
 	<!-- 
 	영역에 저장된 속성에 EL로 접근할때는 속성명이 중복되지 않는다면
 	EL내장객체없이 속성명 안으로 접근할 수 있다.
 	즉 requestScope.personObj.name 형태로 기술하지 않아도 된다.
 	 -->
	<h2>영역을 통해 전달된 객체 읽기</h2>
	<!-- 
	"속성명.멤버변수" 형태로 기술하면 클래스에 선언된 getter를 
	자동으로 호출하여 값을 출력한다. 즉 아래 문장은 getter를
	호출하므로 Person클래스에서 getName()을 주석처리하고시
	 -->
	<ul>
		<li>Person 객체 => 이름 : ${ personObj.name },
							나이 : ${ personObj.age }</li>
		<li>String 객체 => ${ requestScope.stringObj }</li>
		<li>Integer 객체 => ${ integerObj }</li>
	</ul>
	
	<h3>JSP 내장객체를 통해 영역의 값 읽어오기</h3>
	<%
	//영역에는 인스턴스가 Object 타입으로 저장된다.
	Object object = request.getAttribute("personObj");
	//따라서 영역에서 꺼낸후 원래의 타입으로 형변환한다.
	Person person = (Person) object;
	//출력시에는 멤버변수에 접근을 위해 getter를 호출해야한다.
	out.println("이름:"+ person.getName());
	%>
	
	<!-- 
	파라미터로 전달되는 값은 항상 String타입으로 변환된다.
	따라서 산술연산을 하려면 숫자형식으로 변환해야한다. 하지만 EL에서는
	자동으로 숫자형식으로 변환되므로 아래와 같이 연산의 결과를 출력할 수 있다.
	 -->
	<h2>매개변수로 전달된 값 읽기</h2>
	<ul>
		<li>${ param.firstNum + param['secondNum'] }</li>
		<li>${ param.firstNum  } + ${param["secondNum"] }</li>
	</ul>
</body>
</html>