<%-- 
    Document   : display_profile
    Created on : Nov 20, 2025, 11:03:34 PM
    Author     : ASUS
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Profile — Display</title>
  <link rel="stylesheet" href="styles/profile.css">
</head>
<body>
  <div class="profile">
    <h2>Personal Profile</h2>

    <div class="profile-info">
      <div class="profile-item">
        <span class="profile-label">Full Name:</span>
        <span class="profile-value">${name}</span>
      </div>
      <div class="profile-item">
        <span class="profile-label">Student ID:</span>
        <span class="profile-value">${studentId}</span>
      </div>
      <div class="profile-item">
        <span class="profile-label">Program:</span>
        <span class="profile-value">${program}</span>
      </div>
      <div class="profile-item">
        <span class="profile-label">Email:</span>
        <span class="profile-value">${email}</span>
      </div>
      <div class="profile-item">
        <span class="profile-label">Hobbies:</span>
        <span class="profile-value">${hobbies}</span>
      </div>
    </div>

    <div class="intro-section">
      <h3>Self-introduction</h3>
      <div class="intro-content">
        ${intro}
      </div>
    </div>

    <div class="profile-actions">
      <a href="personal_profile.html" class="btn-submit-another">
        Submit Another Profile
      </a>
    </div>
  </div>
</body>
</html>