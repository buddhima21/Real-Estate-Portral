<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 5/7/2025
  Time: 9:49 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.ico">
    <title>Search Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-glow: #0ea5e9;
            --secondary-glow: #6366f1;
            --accent-color: #10b981;
            --dark-bg: rgba(15, 23, 42, 0.8);
            --border-glow: rgba(14, 165, 233, 0.3);

            /* Keep original colors for components */
            --primary: #2c6e49;
            --primary-hover: #1e5631;
            --secondary: #4d6a6d;
            --light: #f8fafc;
            --dark: #1e293b;
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
            --border: rgba(255, 255, 255, 0.1);
        }

        body {
            font-family: 'Rajdhani', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #0f172a;
            color: rgba(255, 255, 255, 0.9);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            position: relative;
            padding-bottom: 2rem;
        }

        /* Geometric background elements */
        .geometric-bg {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            z-index: 0;
            opacity: 0.1;
            pointer-events: none;
        }

        .geometric-shape {
            position: absolute;
            border: 1px solid rgba(255, 255, 255, 0.2);
            pointer-events: none;
        }

        .shape-1 {
            width: 300px;
            height: 300px;
            top: 10%;
            left: 5%;
            border-color: var(--primary-glow);
            border-radius: 50%;
        }

        .shape-2 {
            width: 200px;
            height: 200px;
            bottom: 20%;
            right: 10%;
            border-color: var(--secondary-glow);
            transform: rotate(45deg);
        }

        .shape-3 {
            width: 150px;
            height: 150px;
            top: 40%;
            right: 20%;
            border-color: var(--accent-color);
            border-radius: 10px;
            transform: rotate(30deg);
        }

        .page-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 2rem 1rem;
            animation: fadeIn 0.6s ease-in-out;
            position: relative;
            z-index: 1;
        }

        .header-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            position: relative;
        }

        .header-section::before {
            content: "";
            position: absolute;
            top: 0;
            left: -20px;
            width: 5px;
            height: 40px;
            background: linear-gradient(to bottom, var(--primary-glow), var(--secondary-glow));
            border-radius: 0 4px 4px 0;
        }

        .page-title {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin: 0;
            color: rgba(255, 255, 255, 0.9);
            font-weight: 600;
            font-family: 'Orbitron', sans-serif;
        }

        .page-title i {
            color: var(--primary-glow);
            font-size: 1.75rem;
            filter: drop-shadow(0 0 8px var(--primary-glow));
        }

        .page-title::after {
            content: "";
            display: block;
            width: 100%;
            height: 3px;
            background: linear-gradient(90deg, var(--primary-glow), var(--secondary-glow), transparent);
            margin-top: 0.5rem;
        }

        .card {
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 16px;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.3);
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            background: rgba(30, 41, 59, 0.5);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            margin-bottom: 2rem;
        }

        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 30px rgba(14, 165, 233, 0.2);
            border-color: var(--primary-glow);
        }

        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 1px;
            background: linear-gradient(90deg, transparent, var(--primary-glow), transparent);
            z-index: 1;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .card:hover::before {
            opacity: 1;
        }

        .card-header {
            background: rgba(15, 23, 42, 0.7);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            padding: 1.25rem 1.5rem;
        }

        .card-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--primary-glow);
            margin: 0;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-family: 'Orbitron', sans-serif;
        }

        .card-title i {
            filter: drop-shadow(0 0 5px var(--primary-glow));
        }

        .card-body {
            padding: 1.5rem;
        }

        .result-item {
            display: flex;
            margin-bottom: 1rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .result-item:last-child {
            margin-bottom: 0;
            padding-bottom: 0;
            border-bottom: none;
        }

        .result-label {
            width: 120px;
            font-weight: 600;
            color: rgba(255, 255, 255, 0.7);
        }

        .result-value {
            flex: 1;
            font-weight: 500;
        }

        .admin-id {
            color: var(--primary-glow);
            font-weight: 600;
            text-shadow: 0 0 10px rgba(14, 165, 233, 0.3);
        }

        .admin-username {
            color: rgba(255, 255, 255, 0.9);
        }

        .admin-privileges {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.875rem;
            font-weight: 500;
            background-color: rgba(14, 165, 233, 0.1);
            color: var(--primary-glow);
            border: 1px solid rgba(14, 165, 233, 0.3);
        }

        .admin-privileges.full {
            background-color: rgba(16, 185, 129, 0.1);
            color: var(--accent-color);
            border: 1px solid rgba(16, 185, 129, 0.3);
        }

        .admin-privileges.moderate {
            background-color: rgba(245, 158, 11, 0.1);
            color: var(--warning);
            border: 1px solid rgba(245, 158, 11, 0.3);
        }

        .no-result {
            padding: 2rem;
            text-align: center;
            color: rgba(255, 255, 255, 0.6);
            font-size: 1.1rem;
        }

        .no-result i {
            font-size: 3rem;
            margin-bottom: 1rem;
            color: rgba(255, 255, 255, 0.2);
            filter: drop-shadow(0 0 10px rgba(14, 165, 233, 0.2));
        }

        .back-button {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            background: rgba(255, 255, 255, 0.1);
            color: white;
            border: 1px solid rgba(255, 255, 255, 0.2);
            padding: 0.625rem 1.25rem;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
            text-decoration: none;
            width: fit-content;
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
        }

        .back-button:hover {
            background-color: rgba(255, 255, 255, 0.15);
            border-color: var(--primary-glow);
            transform: translateX(-3px);
            color: white;
            box-shadow: 0 0 15px rgba(14, 165, 233, 0.2);
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .animate-card {
            animation: slideIn 0.4s ease-out forwards;
            opacity: 0;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateX(-20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .result-item {
                flex-direction: column;
                gap: 0.5rem;
            }

            .result-label {
                width: 100%;
            }
        }
    </style>
</head>
<body>
<div class="geometric-bg">
    <div class="geometric-shape shape-1"></div>
    <div class="geometric-shape shape-2"></div>
    <div class="geometric-shape shape-3"></div>
</div>

<div class="page-container">
    <div class="header-section">
        <h1 class="page-title">
            <i class="fas fa-search"></i>
            Search Result
        </h1>
    </div>

    <div class="card animate-card">
        <div class="card-header">
            <h2 class="card-title">
                <i class="fas fa-user-shield"></i>
                Admin Information
            </h2>
        </div>
        <div class="card-body">
            <c:if test="${admin != null}">
                <div class="result-item">
                    <div class="result-label">ID:</div>
                    <div class="result-value admin-id">${admin.id}</div>
                </div>
                <div class="result-item">
                    <div class="result-label">Username:</div>
                    <div class="result-value admin-username">${admin.username}</div>
                </div>
                <div class="result-item">
                    <div class="result-label">Privileges:</div>
                    <div class="result-value">
                        <span class="admin-privileges ${fn:toLowerCase(admin.privileges)}">${admin.privileges}</span>
                    </div>
                </div>
            </c:if>
            <c:if test="${admin == null}">
                <div class="no-result">
                    <i class="fas fa-search"></i>
                    <p>No admin found with the specified criteria.</p>
                </div>
            </c:if>
        </div>
    </div>

    <a href="${pageContext.request.contextPath}/admin/dashboard" class="back-button">
        <i class="fas fa-arrow-left"></i>
        Back to Dashboard
    </a>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Add privilege badge classes based on content
        const privilegeBadge = document.querySelector('.admin-privileges');
        if (privilegeBadge) {
            const privilege = privilegeBadge.textContent.trim().toLowerCase();
            if (privilege.includes('full')) {
                privilegeBadge.classList.add('full');
            } else if (privilege.includes('moderate')) {
                privilegeBadge.classList.add('moderate');
            }
        }
    });
</script>
</body>
</html>
