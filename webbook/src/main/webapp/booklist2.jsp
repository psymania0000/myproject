<%@ page import="java.sql.*" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
Connection dbconn = null;
Statement stmt = null;
ResultSet rs = null;

try {
    // 드라이버 로딩
    Class.forName("oracle.jdbc.driver.OracleDriver");

    // DB 접속 정보
  String url = "jdbc:oracle:thin:@//192.168.200.166:1521/XE";

    String user = "c##madang";
    String password = "c##madang";

    // DB 연결
    dbconn = DriverManager.getConnection(url, user, password);

    // SQL 실행
    String sql = "SELECT * FROM Book ORDER BY BOOKID";
    stmt = dbconn.createStatement();
    rs = stmt.executeQuery(sql);
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>** Book List **</title>
    <style>
        table {
            border-collapse: collapse;
            width: 600px;
        }
        th, td {
            border: 1px solid #9AD2F7;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #EAF6FF;
        }
        body {
            font-family: '맑은 고딕', sans-serif;
        }
    </style>
</head>
<body>
    <h3>📚 도서 목록</h3>
    <table>
        <tr>
            <th>번호</th>
            <th>책 제목</th>
            <th>출판사</th>
            <th>가격</th>
        </tr>
<%
    while (rs.next()) {
        int bookid = rs.getInt("BOOKID");
        String bookname = rs.getString("BOOKNAME");
        String publisher = rs.getString("PUBLISHER");
        int price = rs.getInt("PRICE");
%>
        <tr>
            <td><%= bookid %></td>
            <td><a href="bookview.jsp?bookid=<%=bookid%>"><%= bookname %></a></td>
            <td><%= publisher %></td>
            <td><%= String.format("%,d", price) %>원</td>
        </tr>
<%
    }
%>
    </table>
<%
} catch (ClassNotFoundException e) {
    out.println("<p>드라이버를 찾을 수 없습니다. : " + e.getMessage() + "</p>");
} catch (SQLException e) {
    out.println("<p>데이터베이스 오류가 발생했습니다. : " + e.getMessage() + "</p>");
} catch (Exception e) {
    out.println("<p>예기치 못한 오류가 발생했습니다. : " + e.getMessage() + "</p>");
} finally {
    try { if (rs != null) rs.close(); } catch(Exception e) {}
    try { if (stmt != null) stmt.close(); } catch(Exception e) {}
    try { if (dbconn != null) dbconn.close(); } catch(Exception e) {}
}
%>
</body>
</html>
