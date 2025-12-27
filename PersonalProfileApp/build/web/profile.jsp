<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="profile" class="com.myapp.profile.ProfileBean" scope="request" />

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Profile — Display</title>
  <link rel="stylesheet" href="styles/profile.css">
  <style>
    .profile-actions {
        text-align: center;
        margin-top: 35px;
        padding-top: 25px;
        display: flex;
        gap: 20px;
        justify-content: center;
        flex-wrap: wrap;
    }
    
    .btn-submit-another {
        background: #9cc9d9;
        background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
        color: black;
        padding: 10px 25px;
        border: none;
        border-radius: 8px;
        font-size: 15px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        min-width: 140px;
        text-decoration: none;
        display: inline-block;
        text-align: center;
    }
    
    .btn-submit-another:hover {
        background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);
        text-decoration: none;
    }
    
    @media (max-width: 768px) {
        .profile-actions {
            flex-direction: column;
            align-items: center;
            gap: 15px;
        }
        
        .btn-submit-another {
            width: 100%;
            max-width: 200px;
        }
    }
  </style>
</head>
<body>

  <div class="card">
    <h1>Personal Profile</h1>

    <div class="profile-info">
      <div class="profile-item">
        <span class="profile-label">Full Name:</span>
        <span class="profile-value">${profile.name}</span>
      </div>

      <div class="profile-item">
        <span class="profile-label">Student ID:</span>
        <span class="profile-value">${profile.studentId}</span>
      </div>

      <div class="profile-item">
        <span class="profile-label">Program:</span>
        <span class="profile-value">${profile.program}</span>
      </div>

      <div class="profile-item">
        <span class="profile-label">Email:</span>
        <span class="profile-value">${profile.email}</span>
      </div>

      <div class="profile-item">
        <span class="profile-label">Hobbies:</span>
        <span class="profile-value">${profile.hobbies}</span>
      </div>
    </div>

    <div class="intro-section">
      <h3>Self-introduction</h3>
      <div class="intro-content">
        ${profile.intro}
      </div>
    </div>

    <div class="profile-actions">
      <a href="viewProfiles.jsp" class="btn-submit-another">
        Student Profile List
      </a>
      <a href="personal_profile.html" class="btn-submit-another">
        Back
      </a>
    </div>
  </div>

</body>
</html>