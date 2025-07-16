<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="common.Person"%>
<%@page import="java.util.LinkedList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL - forEach 2</title>
</head>
<body>
	<h4>List 컬렉션 사용하기</h4>
	<%
	//리스트 생성
	LinkedList<Person> lists = new LinkedList<Person>();
	//Person 인스턴스 저장
	lists.add(new Person("맹사성", 34));
	lists.add(new Person("장영실", 44));
	lists.add(new Person("신숙주", 54));
	%>
	<!-- set태그로 page영역에 속성 저장 -->
	<c:set var="lists" value="<%= lists %>" />
	<!-- 
	저장한 변수를 통해 확장 for문을 실행한다. items에 지정한 컬렉션에
	저장된 인스턴스의 갯수만큼 반복해서 전달된다. -->
	<c:forEach items="${ lists }" var="list">
	<li>
		<!-- 저장된 순서대로 Person 인스턴스를 변수 list에 저장한 후
		getter를 통해 값을 출력한다. -->
		이름 : ${ list.name }, 나이 : ${ list.age }
	</li>
	</c:forEach>
	
	<h4>Java 코드를 통한 출력</h4>
	<%
	/* Java코드를 사용하면 출력할 인스턴스 명시 후 getter를 직접
	호출해야한다. */
	for( Person per : lists){
		out.print("이름:"+ per.getName() +", 나이:"+
					per.getAge()+"<br>");	
	}
	%>
	<h4>Map 컬렉션 사용하기</h4>
	<%
	//Map 컬렉션 생성. Key는 String, Value는 Person으로 지정.
	Map<String,Person> maps = new HashMap<String,Person>();
	maps.put("1st", new Person("맹사성", 34));
	maps.put("2st", new Person("장영실", 44));
	maps.put("3st", new Person("신숙주", 54));
	%>
	<!-- 변수 선언 -->
	<c:set var="maps" value="<%= maps %>" />
	<!-- Map 사용시 key를 별도로 얻어올 필요없이 변수명.key 혹은
	변수명.value를 통해 인스턴스를 얻어와서 출력할 수 있다. -->
	<c:forEach items="${ maps }" var="map">
		<li>Key => ${ map.key } <br />
			Value => 이름 : ${ map.value.name }, 나이 : ${ map.value.age }</li>
	</c:forEach>
	
	<h4>Java 코드를 통한 출력</h4>
	<%
	//Map은 항상 Key값을 먼저 얻어와야한다.
	Set<String> keys = maps.keySet();
	//얻어온 Key값을 통해 갯수만큼 반복한다.
	for(String key : keys){
		//key를 통해 value를 얻어온다.
		Person per = maps.get(key);
		//값 출력시 getter메서드를 호출한다.
		out.print("Key => "+ key +"<br>");
		out.print("Value => "+ per.getName() +", "+
					per.getAge()+"<br>");
	}
	//JSTL의 확장for문을 사용하면 Key를 별도로 얻어오지 않아도 되므로
	//편리하다.
	%>
</body>
</html>