package com.myapp.profile;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.*;
import javax.servlet.http.*;

public class ProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Read form data
        String name = request.getParameter("name");
        String studentId = request.getParameter("studentId");
        String program = request.getParameter("program");
        String email = request.getParameter("email");
        String hobbies = request.getParameter("hobbies");
        String intro = request.getParameter("intro");

        System.out.println("=== DEBUG START ===");
        System.out.println("Form Data Received:");
        System.out.println("Name: " + name);
        System.out.println("Student ID: " + studentId);
        System.out.println("Program: " + program);
        System.out.println("Email: " + email);
        System.out.println("Hobbies: " + hobbies);
        System.out.println("Intro: " + intro);

        // 2. Create Bean
        ProfileBean profile = new ProfileBean();
        profile.setName(name);
        profile.setStudentId(studentId);
        profile.setProgram(program);
        profile.setEmail(email);
        profile.setHobbies(hobbies);
        profile.setIntro(intro);

        // 3. Insert into Database
        Connection con = null;
        PreparedStatement ps = null;
        
        try {
    con = DBConnection.getConnection();

    String sql = "INSERT INTO APP.PROFILES (NAME, STUDENT_ID, PROGRAM, EMAIL, HOBBIES, INTRO) " +
                 "VALUES (?, ?, ?, ?, ?, ?)";

    ps = con.prepareStatement(sql);
    ps.setString(1, name);
    ps.setString(2, studentId);
    ps.setString(3, program);
    ps.setString(4, email);
    ps.setString(5, hobbies);
    ps.setString(6, intro);

    ps.executeUpdate();   // ✅ AUTO-COMMIT SAVES DATA

} catch (Exception e) {
    e.printStackTrace();
}


        // 4. Forward to profile.jsp
        request.setAttribute("profile", profile);
        request.getRequestDispatcher("profile.jsp")
               .forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.sendRedirect("personal_profile.html");
    }
}