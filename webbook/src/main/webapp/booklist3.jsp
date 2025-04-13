<%@ page import="java.sql.*" contentType="text/html; charset=EUC-KR" %>
<%
Connection dbconn = null;
Statement stmt = null;
ResultSet rs = null;

try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    String url = "jdbc:oracle:thin:@//192.168.200.166:1521/XE";
    dbconn = DriverManager.getConnection(url, "c##madang", "c##madang");

    stmt = dbconn.createStatement();
    rs = stmt.executeQuery("SELECT * FROM Book ORDER BY bookid");
%>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=EUC-KR">
    <title>** BOOK LIST **</title>
</head>
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
    <table border="1" cellspacing="0" width="400" bordercolor="#9AD2F7"
           bordercolordark="white" bordercolorlight="#B9E0FA">
        <tr bgcolor="#D2E9F9">
            <td width="150" height="20" align="center"><b><span style="font-size:8pt;">BOOKNAME</span></b></td>
            <td width="150" height="20" align="center"><b><span style="font-size:8pt;">PUBLISHER</span></b></td>
            <td width="50" height="20" align="center"><b><span style="font-size:8pt;">PRICE</span></b></td>
        </tr>

<%
    while (rs.next()) {
        String bookid = rs.getString("bookid");
        String bookname = rs.getString("bookname");
        String publisher = rs.getString("publisher");
        String price = rs.getString("price");
%>
        <tr>
            <td align="center"><span style="font-size:8pt;">
                <a href="bookview.jsp?bookid=<%=bookid%>"><%=bookname%></a>
            </span></td>
            <td align="center"><span style="font-size:8pt;"><%=publisher%></span></td>
            <td align="center"><span style="font-size:8pt;"><%=price%></span></td>
        </tr>
<%
    }
%>
    </table>
</body>
</html>
<%
} catch (Exception e) {
    out.println("<p>에러 발생: " + e.toString() + "</p>");
    e.printStackTrace(new java.io.PrintWriter(out)); // 디버깅용 출력
} finally {
    try { if (rs != null) rs.close(); } catch (Exception e) {}
    try { if (stmt != null) stmt.close(); } catch (Exception e) {}
    try { if (dbconn != null) dbconn.close(); } catch (Exception e) {}
}
%>
