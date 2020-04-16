<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="board.dto.BoardDto"%>

<%!
	//List<BoardDto> boardList = new ArrayList<BoardDto>();
%>
<%
	// 데이터 준비 과정
	List<BoardDto> boardList = new ArrayList<BoardDto>();
	for (int i = 0; i < 10; i++) {
		BoardDto boardDto = new BoardDto();
		boardDto.setUserName("name"+i);
		boardDto.setTitle("title"+i);
		boardList.add(boardDto);
	}
%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</head>
<body>

<div class="container">
  <br>
  <h2>Basic Table</h2>
  <p>The .table class adds basic styling (light padding and horizontal dividers) to a table:</p>            
  <table class="table">
    <thead>
      <tr>
        <th>이름</th>
        <th>제목</th>
      </tr>
    </thead>
    <tbody>
<%
	for (BoardDto dto : boardList) {
%>
      <tr>
        <td><%= dto.getUserName() %></td>
        <td><%= dto.getTitle() %></td>
      </tr>
<%
	}
%>
    </tbody>
  </table>
</div>

</body>
</html>
