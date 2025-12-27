<%@page import="java.sql.*"%>
<%@page import="com.myapp.profile.DBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String studentId = request.getParameter("studentId");

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    
    try {
        con = DBConnection.getConnection();
        String sql = "SELECT * FROM APP.PROFILES WHERE STUDENT_ID=?";
        ps = con.prepareStatement(sql);
        ps.setString(1, studentId);
        rs = ps.executeQuery();
        
        if (!rs.next()) {
            response.sendRedirect("viewProfiles.jsp");
            return;
        }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Profile</title>
    <link rel="stylesheet" href="styles/profile.css">
</head>
<body>

<div class="card">
    <h1>Edit Profile</h1>

    <form action="EditProfileServlet" method="post">
        <input type="hidden" name="studentId" value="<%= studentId %>">

        <p>Name:
            <input type="text" name="name" value="<%= rs.getString("NAME") %>" required>
        </p>

        <p>Program:
            <input type="text" name="program" value="<%= rs.getString("PROGRAM") %>" required>
        </p>

        <p>Email:
            <input type="email" name="email" value="<%= rs.getString("EMAIL") %>" required>
        </p>

        <p>Hobbies:
            <input type="text" name="hobbies" value="<%= rs.getString("HOBBIES") != null ? rs.getString("HOBBIES") : "" %>">
        </p>

        <p>Introduction:
            <textarea name="intro"><%= rs.getString("INTRO") != null ? rs.getString("INTRO") : "" %></textarea>
        </p>

        <div class="submit-container">
            <button type="submit">Update</button>
            <a href="viewProfiles.jsp" class="btn-cancel">
                Cancel
            </a>
        </div>
    </form>
</div>

</body>
</html>

<%
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("viewProfiles.jsp");
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (ps != null) try { ps.close(); } catch (Exception e) {}
        if (con != null) try { con.close(); } catch (Exception e) {}
    }
%>