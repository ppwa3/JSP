<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 첨부형 게시판</title>
</head>
<script type="text/javascript">
	function deleteItem() {
		const answer = confirm("정말 삭제하시겠습니까?");
		
	if (answer) {
  		console.log("사용자가 확인을 눌렀습니다.");
  		location.href='../mvcboard/delete.do?idx=${ param.idx}';
	} else {
  		console.log("사용자가 취소를 눌렀습니다.");
	}
}
</script>
<body>
<jsp:include page="../Common/Link.jsp" />
<h2>파일 첨부형 게시판 - 상세 보기(View)</h2>

<table border="1" width="90%">
    <colgroup>
        <col width="15%"/> <col width="35%"/>
        <col width="15%"/> <col width="*"/>
    </colgroup> 
    <tr>
        <td>번호</td> <td>${ dto.idx }</td>
        <td>작성자</td> <td>${ dto.name }</td>
    </tr>
    <tr>
        <td>작성일</td> <td>${ dto.postdate }</td>
        <td>조회수</td> <td>${ dto.visitcount }</td>
    </tr>
    <tr>
        <td>제목</td>
        <td colspan="3">${ dto.title }</td>
    </tr>
    <tr>
        <td>내용</td>
        <td colspan="3" height="100">
        ${ dto.content }
        <%-- 
        첨부파일이 이미지 인지 판단하는 로직 
        and isImage eq true 
        --%>
        	<!-- 첨부파일이 있다면 img태그로 이미지를 출력 -->
        	<c:if test="${ not empty dto.ofile
        		}">
        		<br /><img src="../Uploads/${ dto.sfile }"
        			style="max-width:100%;" />
        	</c:if>
        </td>
    </tr> 
    <tr>
        <td>첨부파일</td>
        <td>
        	<!-- 첨부파일이 있다면 다운로드 링크를 출력 -->            
            <c:if test="${ not empty dto.ofile }">
                ${ dto.ofile }
                <!-- 다운로드 링크에는 원본파일명, 저장된파일명, 
                일련번호를 파라미터로 전달한다. -->
                <a href="../mvcboard/download.do?ofile=${ dto.ofile }&sfile=${ dto.sfile }&idx=${ dto.idx }">
                	[다운로드]
                </a>
            </c:if>           
        </td>
         <td>다운로드수</td>
        <td>${ dto.downcount }</td>
    </tr> 
    <tr>
        <td colspan="4" align="center">
    <c:if test="${ not empty UserId and UserId eq dto.id }">
            <button type="button" onclick="
            location.href='../mvcboard/edit.do?idx=${ param.idx}';">
                수정하기
            </button>
            <button type="button" onclick="deleteItem()">
                삭제하기
            </button>
    </c:if>
            <button type="button" onclick="
            location.href='../mvcboard/list.do';">
                목록 바로가기
            </button>
        </td>
    </tr>
</table>
</body>
</html>
