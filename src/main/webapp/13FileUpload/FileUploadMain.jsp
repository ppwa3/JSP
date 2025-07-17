<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FileUpload</title>
</head>
<script>
	/*
	폼값을 submit(제출)할때 빈값에 대한 검증을 진행한다. 만약 빈값이
	발견되면 이번트 핸들러쪽으로 false를 반환한다.
	*/
	function validateForm(form) {
		if (form.title.value == "") {
			alert("제목을 입력하세요.");
			form.title.focus();
			return false;
		}
		if (form.ofile.value == "") {
			alert("첨부파일은 필수 입력입니다.");
			return false;
		}
	}
</script>
<body>
	<h3>파일 업로드</h3>
	<!-- request영역에 저장된 에러 메세지 출력. 서블릿에서 추가할 예정. -->
	<span style="color: red;">${errorMessage }</span>
	<!-- 
	파일첨부를 위한 <form>태그 구성시 2가지 필수사항
	1.method(전송방식)은 반드시 post로 지정
	2.enctype(인코딩방식)은 multipart/form-data로 지정.
	※만약 get방식으로 지정하면 파일이 전송되는게 아니라, 파일명만 전송됨.
	 -->
	<form name="fileForm" method="post"
	enctype="multipart/form-data"
	action="UploadProcess.do" onsubmit="return validateForm(this);">
	<!-- text타입으로 일반적인 한줄 입력상자 -->
	제목 : <input type="text" name="title" /><br />
	<!-- 파일 첨부를 위한 file타입 지정. 파일선택을 위한 버튼이
	생성됨 -->
	첨부파일 : <input type="file" name="ofile" /> <br />
	<input type="submit" value="전송하기" />
	</form>
</body>
</html>