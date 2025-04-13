<%@ page import="java.sql.*" contentType="text/html;charset=EUC-KR" %>
<%
Connection dbconn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    String url = "jdbc:oracle:thin:@//192.168.200.166:1521/XE";
    dbconn = DriverManager.getConnection(url, "c##madang", "c##madang");

    String bookid = request.getParameter("bookid");
    if (bookid == null || bookid.trim().isEmpty()) {
        out.println("<p>���� ID�� �����ϴ�.</p>");
        return;
    }

    String sql = "SELECT * FROM Book WHERE bookid = ?";
    pstmt = dbconn.prepareStatement(sql);
    pstmt.setString(1, bookid);
    rs = pstmt.executeQuery();

    if (rs.next()) {
%>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=EUC-KR">
    <title>** Book VIEW **</title>
</head>
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
    <table border="1" cellspacing="0" width="400" bordercolor="#9AD2F7"
           bordercolordark="white" bordercolorlight="#B9E0FA">
        <tr>
            <td width="150" height="23" align="center"><span style="font-size:9pt;">å �� ��</span></td>
            <td width="513"><span style="font-size:9pt;"><%= rs.getString("BOOKNAME") %></span></td>
        </tr>
        <tr>
            <td width="150" height="23" align="center"><span style="font-size:9pt;">�� �� ��</span></td>
            <td width="513"><span style="font-size:9pt;"><%= rs.getString("PUBLISHER") %></span></td>
        </tr>
        <tr>
            <td width="150" height="23" align="center"><span style="font-size:9pt;">�� ��</span></td>
            <td width="513"><span style="font-size:9pt;"><%= rs.getString("PRICE") %></span></td>
        </tr>
    </table>

    <table cellpadding="0" cellspacing="0" width="400" height="23">
        <tr>
            <td width="150" align="right">
                <span style="font-size:9pt;">
                    <a href="booklist.jsp"><font color="black">���</font></a>
                </span>
            </td>
        </tr>
    </table>
<%
    } else {
        out.println("<p>�ش� å ������ ã�� �� �����ϴ�.</p>");
    }

} catch (Exception e) {
    out.println("<p>���� �߻�: " + e.toString() + "</p>");
    e.printStackTrace(new java.io.PrintWriter(out));
} finally {
    try { if (rs != null) rs.close(); } catch (Exception e) {}
    try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
    try { if (dbconn != null) dbconn.close(); } catch (Exception e) {}
}
%>
</body>
</html>
