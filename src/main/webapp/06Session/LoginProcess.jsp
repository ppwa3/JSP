<%@page import="membership.MemberDTO"%>
<%@page import="membership.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//사용자가 입력한 아이디/비번을 파라미터로 받음
String userId = request.getParameter("user_id");
String userPwd = request.getParameter("user_pw");

//web.xml에 등록한 컨텍스트 파라미터를 읽어욤(DB 접속정보)
String oracleDriver = application.getInitParameter("OracleDriver");
String oracleURL = application.getInitParameter("OracleURL");
String oracleId = application.getInitParameter("OracleId");
String oraclePwd = application.getInitParameter("OraclePwd");

//오라클에 연결하기 위해 DAO인스턴스 생성
MemberDAO dao = new MemberDAO(oracleDriver, oracleURL, oracleId, oraclePwd);
//입력받은 아이디, 비번을 인수로 전달해서 인증을 위한 메서드 실행
MemberDTO memberDTO = dao.getMemberDTO(userId, userPwd);
//DB 연결 종료
dao.close();

//만약 DTO에 아이디가 저장되어 있다면 로그인에 성공한 것으로 판단
if (memberDTO.getId() != null) {
	//session영역에 회원정보 저장
	session.setAttribute("UserId", memberDTO.getId());
	session.setAttribute("UserName", memberDTO.getName());
	/*
	session영역에 저장된 정보는 페이지를 이동하더라도 소멸되지 않고
	유지되므로, 로그인 페이지로 이동한다. 또한 이 정보는 웹브라우저를
	닫을때까지 유지된다. */
	response.sendRedirect("LoginForm.jsp");
}
else {
	//로그인에 실패한 경우에는 request영역에 에러메세지를 저장
	request.setAttribute("LoginErrMsg", "로그인 오류입니다.");
	request.getRequestDispatcher("LoginForm.jsp").forward(request, response);
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>