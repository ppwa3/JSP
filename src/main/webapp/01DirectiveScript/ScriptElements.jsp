<!-- 지시어 -->
<%@page import="test.HelloJava"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 
선언부(Declaration)
: 스크립트렛이나 표현식에서 사용할 메서드를 선언할때 사용한다.
 -->
<%!
//선언부는 !로 시작한다.
public int add(int num1, int num2) {
	//두 정수의 합을 반환
	return num1 + num2;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스크립트 요소</title>
</head>
<body> 
<%
/*
스트립트렛(Scriptlet)
: 주로 JSP코드나 Java코드를 작성하고 실행할때 사용한다. 스크립트렛은
<body>, <head>태그 어디서든 사용할 수 있다. 또한 <script>, <style>
태그 내부에서도 사용할 수 있다.
*/
int result = add(10, 20);
%>
<!--
표현식(Exoression)
: 변수를 웹브라우저상 출력할때 사용한다. JS의 document.write()와
동일하다. 표현식을 사용할 때는 문장의 끝에 세미콜론을 붙이지 않는다.
-->
덧셈 결과 1 : <%= result %> <br />
덧셈 결과 2 : <%= add(30, 40) %>

<h2>내가 만든 Java 클래스의 멤버메서드 호출하기</h2>
<%
	//인스턴스 생성. import 지시어는 자동으로 추가됨.
	HelloJava helloJava = new HelloJava();
	//일반적인 멤버메서드는 인스턴스 변수를 통해 호출
	out.print("1~100까지의합:");
	out.print(helloJava.myFx(1,100));
%>
<br />
<!-- static으로 선언된 정적메서드는 클래스명으로 직접 호출 -->
1~10까지의합 : <%= HelloJava.myFx() %>
<!-- 
	JSP에서 선언부는 거의 사용되지 않는다. 주로 Java클래스를
	만든 후 이와같이 호출하는 경우가 더 많다.
 -->
</body>
</html>