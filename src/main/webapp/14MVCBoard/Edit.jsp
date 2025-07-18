<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 첨부형 게시판</title>
<script type="text/javascript">
	//빈값 체크를 위한 JS함수
    function validateForm(form) {
        if (form.title.value == "") {
            alert("제목을 입력하세요.");
            form.title.focus();
            return false;
        }
        if (form.content.value == "") {
            alert("내용을 입력하세요.");
            form.content.focus();
            return false;
        }
    }
</script>
</head>
<body>
<jsp:include page="../Common/Link.jsp" />
<h2>파일 첨부형 게시판 - 수정하기(Edit)</h2>
<form name="writeFrm" method="post" enctype="multipart/form-data" action="../mvcboard/edit.do" onsubmit="return validateForm(this);">
<!-- 수정할 게시물의 일련번호 설정 -->
<input type="hidden" name="idx" value="${ dto.idx }"/>
<!-- 작성자 아이디 -->
<input type="hidden" name="id" value="${ dto.id }"/>
<!-- 기존 등록한 파일명(새로운 파일을 첨부하지 않는 경우에 사용) -->
<input type="hidden" name="prevOfile" value="${ dto.ofile }" />
<input type="hidden" name="prevSfile" value="${ dto.sfile }" />
    
<table border="1" width="90%">
    <tr>
        <td>제목</td>
        <td>
            <input type="text" name="title" style="width:90%;" value="${ dto.title }" />
        </td>
    </tr>
    <tr>
        <td>내용</td>
        <td>
            <textarea name="content" style="width:90%;height:100px;">${ dto.content }</textarea>
        </td>
    </tr>
    <tr>
        <td>첨부 파일</td>
        <td>
        	<!-- <input>의 type이 file인 경우에는 value속성은
        	의미가 없다. 속성을 추가하더라도 적용되지 않는다. -->
            <input type="file" name="ofile" />
        </td>
    </tr>
    <tr>
        <td colspan="2" align="center">
            <button type="submit">작성 완료</button>
            <button type="reset">RESET</button>
            <button type="button" onclick="location.href='../mvcboard/list.do';">
                목록 바로가기
            </button>
        </td>
    </tr>
</table>    
</form>
</body>
</html>

