package com.myapp.profile;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private static final String URL = "jdbc:derby://localhost:1527/ProfileDB";
    private static final String USER = "app";
    private static final String PASS = "app";

    public static Connection getConnection() throws Exception {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection conn = DriverManager.getConnection(URL, USER, PASS);
        conn.setAutoCommit(true);  // ADD THIS LINE
        return conn;
    }
}