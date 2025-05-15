<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.ico">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.2.1/css/all.min.css">
    <style>
        :root {
            --primary-glow: #0ea5e9;
            --secondary-glow: #6366f1;
            --accent-color: #10b981;
            --dark-bg: rgba(15, 23, 42, 0.8);
            --border-glow: rgba(14, 165, 233, 0.3);

            /* Keep original dashboard colors for components */
            --primary: #2c6e49;
            --primary-hover: #1e5631;
            --secondary: #4d6a6d;
            --light: #f8fafc;
            --dark: #1e293b;
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
            --border: #e2e8f0;
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

        .dashboard-container {
            max-width: 1280px;
            margin: 40px auto;
            padding: 0 20px;
            animation: fadeIn 0.6s ease-in-out;
            position: relative;
            z-index: 1;
        }

        .dashboard-header {
            position: relative;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .dashboard-header::before {
            content: "";
            position: absolute;
            top: 0;
            left: -20px;
            width: 5px;
            height: 40px;
            background: linear-gradient(to bottom, var(--primary-glow), var(--secondary-glow));
            border-radius: 0 4px 4px 0;
        }

        .dashboard-title {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin: 0 0 1.5rem 0;
            color: rgba(255, 255, 255, 0.9);
            font-weight: 700;
            font-family: 'Orbitron', sans-serif;
        }

        .dashboard-title i {
            color: var(--primary-glow);
            font-size: 1.75rem;
            filter: drop-shadow(0 0 8px var(--primary-glow));
        }

        .dashboard-title::after {
            content: "";
            display: block;
            width: 100%;
            height: 3px;
            background: linear-gradient(90deg, var(--primary-glow), var(--secondary-glow), transparent);
            margin-top: 0.5rem;
        }

        .nav-buttons {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
            margin-top: 1.5rem;
        }

        .btn {
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .btn i {
            font-size: 1rem;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-glow), var(--secondary-glow));
            border: none;
            color: white;
            position: relative;
            overflow: hidden;
        }

        .btn-primary:hover {
            box-shadow: 0 0 20px rgba(14, 165, 233, 0.4);
            transform: translateY(-2px);
        }

        .btn-primary::after {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(rgba(255, 255, 255, 0.2), rgba(255, 255, 255, 0));
            transform: rotate(30deg);
            transition: transform 0.5s ease;
            opacity: 0;
        }

        .btn-primary:hover::after {
            transform: rotate(30deg) translate(10%, 10%);
            opacity: 1;
        }

        .btn-secondary {
            background-color: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: white;
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
        }

        .btn-secondary:hover {
            background-color: rgba(255, 255, 255, 0.15);
            border-color: var(--primary-glow);
            transform: translateY(-2px);
            box-shadow: 0 0 15px rgba(14, 165, 233, 0.2);
        }

        .btn-info {
            background: linear-gradient(135deg, #3b82f6, #2563eb);
            border: none;
            color: white;
        }

        .btn-info:hover {
            box-shadow: 0 0 20px rgba(59, 130, 246, 0.4);
            transform: translateY(-2px);
        }

        .btn-warning {
            background: linear-gradient(135deg, var(--warning), #d97706);
            border: none;
            color: white;
        }

        .btn-warning:hover {
            box-shadow: 0 0 20px rgba(245, 158, 11, 0.4);
            transform: translateY(-2px);
        }

        .btn-danger {
            background: linear-gradient(135deg, var(--danger), #dc2626);
            border: none;
            color: white;
        }

        .btn-danger:hover {
            box-shadow: 0 0 20px rgba(239, 68, 68, 0.4);
            transform: translateY(-2px);
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
            display: flex;
            justify-content: space-between;
            align-items: center;
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

        .table-container {
            overflow-x: auto;
        }

        .admin-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
        }

        .admin-table thead th {
            background-color: rgba(15, 23, 42, 0.9);
            color: rgba(255, 255, 255, 0.7);
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.75rem;
            letter-spacing: 0.05em;
            padding: 1rem 1.5rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            text-align: left;
        }

        .admin-table tbody tr {
            background-color: rgba(30, 41, 59, 0.3);
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .admin-table tbody tr:hover {
            background-color: rgba(30, 41, 59, 0.6);
            transform: translateY(-2px);
        }

        .admin-table td {
            padding: 1rem 1.5rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            vertical-align: middle;
        }

        .admin-id {
            font-weight: 600;
            color: var(--primary-glow);
        }

        .admin-username {
            font-weight: 500;
            color: rgba(255, 255, 255, 0.9);
        }

        .admin-password {
            font-family: monospace;
            color: rgba(255, 255, 255, 0.7);
        }

        .admin-privileges {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 500;
            background-color: rgba(14, 165, 233, 0.1);
            color: var(--primary-glow);
        }

        .admin-privileges.full {
            background-color: rgba(16, 185, 129, 0.1);
            color: var(--accent-color);
        }

        .admin-privileges.moderate {
            background-color: rgba(245, 158, 11, 0.1);
            color: var(--warning);
        }

        .action-buttons {
            display: flex;
            gap: 8px;
            align-items: center;
        }

        .btn-sm {
            padding: 0.375rem 0.75rem;
            font-size: 0.875rem;
        }

        .search-card {
            margin-top: 2rem;
        }

        .search-form {
            display: flex;
            gap: 1rem;
            align-items: center;
        }

        .search-input {
            flex: 1;
            position: relative;
        }

        .search-input i {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: rgba(255, 255, 255, 0.5);
        }

        .search-input input {
            padding-left: 2.5rem;
            border-radius: 8px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            width: 100%;
            height: 45px;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
            background-color: rgba(30, 41, 59, 0.3);
            color: rgba(255, 255, 255, 0.9);
        }

        .search-input input::placeholder {
            color: rgba(255, 255, 255, 0.5);
        }

        .search-input input:focus {
            border-color: var(--primary-glow);
            box-shadow: 0 0 15px rgba(14, 165, 233, 0.2);
            outline: none;
        }

        .search-button {
            height: 45px;
            min-width: 120px;
        }

        .animate-card {
            animation: slideIn 0.4s ease-out forwards;
            opacity: 0;
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
            .dashboard-container {
                margin: 20px auto;
            }

            .nav-buttons {
                flex-direction: column;
            }

            .btn {
                width: 100%;
                justify-content: flex-start;
            }

            .search-form {
                flex-direction: column;
            }

            .search-button {
                width: 100%;
            }

            .action-buttons {
                flex-direction: column;
                gap: 0.5rem;
            }

            .action-buttons .btn {
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

<div class="dashboard-container">
    <div class="dashboard-header">
        <h1 class="dashboard-title">
            <i class="fas fa-tachometer-alt"></i>
            Admin Dashboard
        </h1>

        <div class="nav-buttons">
            <a href="${pageContext.request.contextPath}/admin/add" class="btn btn-primary">
                <i class="fas fa-plus"></i>
                <span>Add New Admin</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/manage-users" class="btn btn-secondary">
                <i class="fas fa-users"></i>
                <span>Manage Users</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/manage-properties" class="btn btn-secondary">
                <i class="fas fa-building"></i>
                <span>Manage Properties</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/activity-logs" class="btn btn-info">
                <i class="fas fa-file-alt"></i>
                <span>View Activity Logs</span>
            </a>
        </div>
    </div>

    <div class="card animate-card" style="animation-delay: 0.1s;">
        <div class="card-header">
            <h2 class="card-title">
                <i class="fas fa-user-shield"></i>
                All Admins
            </h2>
        </div>
        <div class="card-body">
            <div class="table-container">
                <table class="admin-table">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Password</th>
                        <th>Privileges</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="admin" items="${admins}">
                        <tr>
                            <td class="admin-id">${admin.id}</td>
                            <td class="admin-username">${admin.username}</td>
                            <td class="admin-password">${admin.password}</td>
                            <td>
                                <span class="admin-privileges ${fn:toLowerCase(admin.privileges)}">${admin.privileges}</span>
                            </td>
                            <td class="action-buttons">
                                <a href="${pageContext.request.contextPath}/admin/update?id=${admin.id}" class="btn btn-sm btn-warning" onclick="return confirm('Are you sure you want to update this admin?')">
                                    <i class="fas fa-edit"></i>
                                    <span>Update</span>
                                </a>
                                <form action="${pageContext.request.contextPath}/admin/delete" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this admin?')">
                                    <input type="hidden" name="id" value="${admin.id}">
                                    <button type="submit" class="btn btn-sm btn-danger">
                                        <i class="fas fa-trash"></i>
                                        <span>Delete</span>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="card search-card animate-card" style="animation-delay: 0.2s;">
        <div class="card-header">
            <h2 class="card-title">
                <i class="fas fa-search"></i>
                Search Admins
            </h2>
        </div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/admin/search" method="get" class="search-form">
                <div class="search-input">
                    <i class="fas fa-search"></i>
                    <input type="text" name="searchTerm" class="form-control" placeholder="Search by ID or Username" required>
                </div>
                <button type="submit" class="btn btn-primary search-button">
                    <i class="fas fa-search"></i>
                    <span>Search</span>
                </button>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Add privilege badge classes based on content
        document.querySelectorAll('.admin-privileges').forEach(badge => {
            const privilege = badge.textContent.trim().toLowerCase();
            if (privilege.includes('full')) {
                badge.classList.add('full');
            } else if (privilege.includes('moderate')) {
                badge.classList.add('moderate');
            }
        });
    });
</script>
</body>
</html>