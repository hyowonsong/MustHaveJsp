<%@ page import="board.BoardDAO"%>
<%@ page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String num = request.getParameter("num");  // 일련번호 받기

BoardDAO dao = new BoardDAO(application);  // DAO 생성
dao.updateVisitCount(num);                 // 조회수 증가
BoardDTO dto = dao.selectView(num);        // 게시물 가져오기
dao.close();                               // DB 연결 해제
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원제 게시판 - 내용 보기</title>
<link rel="stylesheet" href="../css/styles.css">
<script>
function deletePost() {
    var confirmed = confirm("정말로 삭제하겠습니까?");
    if (confirmed) {
        var form = document.writeFrm;
        form.method = "post";
        form.action = "DeleteProcess.jsp";
        form.submit();
    }
}
</script>
</head>
<body>
<jsp:include page="../Common/Link.jsp" />
<h2>회원제 게시판 - 내용 보기(View)</h2>
<form name="writeFrm">
    <input type="hidden" name="num" value="<%= num %>" />
    <table class="data-table">
        <tr>
            <td>번호</td>
            <td><%= dto.getNum() %></td>
            <td>작성자</td>
            <td><%= dto.getName() %></td>
        </tr>
        <tr>
            <td>작성일</td>
            <td><%= dto.getPostdate() %></td>
            <td>조회수</td>
            <td><%= dto.getVisitcount() %></td>
        </tr>
        <tr>
            <td>제목</td>
            <td colspan="3"><%= dto.getTitle() %></td>
        </tr>
        <tr>
            <td>내용</td>
            <td colspan="3" class="content-cell">
                <%= dto.getContent().replace("\r\n", "<br/>") %></td>
        </tr>
        <tr>
            <td colspan="4" class="form-actions">
                <%
                if (session.getAttribute("UserId") != null && session.getAttribute("UserId").toString().equals(dto.getId())) {
                %>
                <button type="button" class="btn" onclick="location.href='Edit.jsp?num=<%= dto.getNum() %>';">수정하기</button>
                <button type="button" class="btn" onclick="deletePost();">삭제하기</button>
                <%
                }
                %>
                <button type="button" class="btn" onclick="location.href='List.jsp';">목록 보기</button>
            </td>
        </tr>
    </table>
</form>
</body>
</html>
