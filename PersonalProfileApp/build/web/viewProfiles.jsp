<%@page import="java.sql.*"%>
<%@page import="com.myapp.profile.DBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Student Profiles</title>
    <link rel="stylesheet" href="styles/profile.css">
    <style>
    .search-filter-box {
        background: white;
        padding: 20px;
        border-radius: 12px;
        box-shadow: 0 8px 20px rgba(0,0,0,0.08);
        margin-bottom: 25px;

        display: grid;
        grid-template-columns: 1fr 1fr 1fr auto; 
        gap: 15px;
        align-items: center;
    }

    .search-filter-box input,
    .search-filter-box select {
        width: 100%;
        padding: 10px 12px;
        border-radius: 8px;
        border: 2px solid #ecf0f1;
        font-size: 14px;
    }

    .search-filter-box button {
        padding: 10px 20px;
        border-radius: 8px;
        font-weight: 600;
        cursor: pointer;
        white-space: nowrap;
        background: #9cc9d9;
        border: none;
    }

    .add-student-container {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin: 20px 0 20px 0;
        padding: 15px 0;
        border-top: 1px solid #eaeaea;
        border-bottom: 1px solid #eaeaea;
    }
    
    .add-student-btn {
        background: #22C1C3;
        color: white;
        padding: 8px 16px;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 8px;
    }
    
    .add-student-btn:hover {
        transform: translateY(-2px);
        color: white;
        text-decoration: none;
        box-shadow: 0 5px 15px rgba(34, 193, 195, 0.3);
    }
    
    @media (max-width: 768px) {
        .search-filter-box {
            grid-template-columns: 1fr;
        }
    }
    
    table {
        border-collapse: collapse;
        width: 100%;
        margin-top: 20px;
    }
    
    table th, table td {
        border: 1px solid #ddd;
        padding: 10px;
        text-align: left;
        vertical-align: top;           
    }

    table th {
        background: #f0f0f0;
        color: #2c3e50;
    }

    .action-btn {
        padding: 6px 14px;
        border-radius: 6px;
        font-size: 14px;
        font-weight: 600;
        text-decoration: none;
        display: inline-block;
        margin: 2px 0;
        transition: all 0.3s ease;
    }

    .btn-edit {
        background: linear-gradient(135deg, #f6d365, #fda085);
        color: #2c3e50;
    }

    .btn-edit:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 12px rgba(243, 156, 18, 0.4);
    }

    .btn-delete {
        background: linear-gradient(135deg, #ff6a6a, #ee0979);
        color: white;
    }

    .btn-delete:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 12px rgba(231, 76, 60, 0.5);
    }
    
    .intro-cell {
        max-width: 250px;
        white-space: pre-wrap;
        font-size: 14px;
        color: #555;
    }
    
    .no-data {
        text-align: center;
        padding: 40px;
        color: #666;
        font-style: italic;
    }
   </style>
</head>
<body>

<div class="profile">
    <h2>Student Profiles</h2>

    <!-- SEARCH / FILTER FORM -->
    <form method="get" action="viewProfiles.jsp" class="search-filter-box">
        <input type="text" name="keyword" placeholder="Search name / student ID"
               value="<%= request.getParameter("keyword") != null ? request.getParameter("keyword") : "" %>">

        <select name="program">
            <option value="">-- Program --</option>
            <option value="Computer Science">Computer Science</option>
            <option value="Information Technology">Information Technology</option>
            <option value="Software Engineering">Software Engineering</option>
            <option value="Computer Network">Computer Network</option>
            <option value="Multimedia Computing">Multimedia Computing</option>
        </select>

        <input type="text" name="hobby" placeholder="Hobby"
               value="<%= request.getParameter("hobby") != null ? request.getParameter("hobby") : "" %>">

        <button type="submit">Search</button>
    </form>

    <a href="personal_profile.html" class="add-student-btn">+ Add New Student</a>

    <%
        String keyword = request.getParameter("keyword");
        String programFilter = request.getParameter("program");
        String hobbyFilter = request.getParameter("hobby");

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();

            StringBuilder sql = new StringBuilder(
                "SELECT * FROM APP.PROFILES WHERE 1=1 "
            );

            if (keyword != null && !keyword.trim().isEmpty()) {
                sql.append("AND (NAME LIKE ? OR STUDENT_ID LIKE ?) ");
            }
            if (programFilter != null && !programFilter.trim().isEmpty()) {
                sql.append("AND PROGRAM = ? ");
            }
            if (hobbyFilter != null && !hobbyFilter.trim().isEmpty()) {
                sql.append("AND HOBBIES LIKE ? ");
            }

            ps = con.prepareStatement(sql.toString());

            int i = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(i++, "%" + keyword + "%");
                ps.setString(i++, "%" + keyword + "%");
            }
            if (programFilter != null && !programFilter.trim().isEmpty()) {
                ps.setString(i++, programFilter);
            }
            if (hobbyFilter != null && !hobbyFilter.trim().isEmpty()) {
                ps.setString(i++, "%" + hobbyFilter + "%");
            }

            rs = ps.executeQuery();

            boolean hasData = false;
    %>

    <table>
        <tr>
            <th>Name</th>
            <th>Student ID</th>
            <th>Program</th>
            <th>Email</th>
            <th>Hobbies</th>
            <th>Introduction</th>
            <th>Action</th>
        </tr>

    <%
            while (rs.next()) {
                hasData = true;
    %>
        <tr>
            <td><%= rs.getString("NAME") %></td>
            <td><%= rs.getString("STUDENT_ID") %></td>
            <td><%= rs.getString("PROGRAM") %></td>
            <td><%= rs.getString("EMAIL") %></td>
            <td><%= rs.getString("HOBBIES") %></td>
            <td><%= rs.getString("INTRO") %></td>
            <td>
                <a class="action-btn btn-edit"
                   href="editProfile.jsp?studentId=<%= rs.getString("STUDENT_ID") %>">Edit</a>

                <a class="action-btn btn-delete"
                   href="DeleteProfileServlet?studentId=<%= rs.getString("STUDENT_ID") %>"
                   onclick="return confirm('Delete this profile?');">Delete</a>
            </td>
        </tr>
    <%
            }
    %>
    </table>

    <%
            if (!hasData) {
    %>
        <div class="no-data">No student profiles found.</div>
    <%
            }

        } catch (Exception e) {
            out.println("ERROR: " + e.getMessage());
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception e) {}
            if (ps != null) try { ps.close(); } catch (Exception e) {}
            if (con != null) try { con.close(); } catch (Exception e) {}
        }
    %>

</div>
</body>
</html>