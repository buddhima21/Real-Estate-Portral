<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.ico">
    <title>Activity Logs</title>
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
            max-width: 1200px;
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

        .back-button {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            background: rgba(255, 255, 255, 0.1);
            color: white;
            border: 1px solid rgba(255, 255, 255, 0.2);
            padding: 0.5rem 1rem;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
            text-decoration: none;
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

        .card {
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 16px;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.3);
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            background: rgba(30, 41, 59, 0.5);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
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
            padding: 1rem 1.5rem;
        }

        .search-filter {
            display: flex;
            gap: 1rem;
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

        .form-select {
            background-color: rgba(30, 41, 59, 0.3);
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: rgba(255, 255, 255, 0.9);
            border-radius: 8px;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24' fill='none' stroke='white' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E");
        }

        .form-select:focus {
            border-color: var(--primary-glow);
            box-shadow: 0 0 15px rgba(14, 165, 233, 0.2);
            outline: none;
        }

        .form-select option {
            background-color: #1e293b;
            color: white;
        }

        .table-container {
            overflow-x: auto;
        }

        .activity-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
        }

        .activity-table th {
            background-color: rgba(15, 23, 42, 0.9);
            color: rgba(255, 255, 255, 0.7);
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.75rem;
            letter-spacing: 0.05em;
            padding: 1rem 1.5rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .activity-table td {
            padding: 1rem 1.5rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            vertical-align: middle;
        }

        .activity-table tbody tr {
            background-color: rgba(30, 41, 59, 0.3);
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .activity-table tbody tr:hover {
            background-color: rgba(30, 41, 59, 0.6);
            transform: translateY(-2px);
        }

        .admin-id {
            font-weight: 600;
            color: var(--primary-glow);
        }

        .action-cell {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .action-badge {
            padding: 0.25rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 500;
        }

        .action-badge.create {
            background-color: rgba(16, 185, 129, 0.1);
            color: var(--accent-color);
            border: 1px solid rgba(16, 185, 129, 0.3);
        }

        .action-badge.update {
            background-color: rgba(245, 158, 11, 0.1);
            color: var(--warning);
            border: 1px solid rgba(245, 158, 11, 0.3);
        }

        .action-badge.delete {
            background-color: rgba(239, 68, 68, 0.1);
            color: var(--danger);
            border: 1px solid rgba(239, 68, 68, 0.3);
        }

        .action-badge.login {
            background-color: rgba(99, 102, 241, 0.1);
            color: var(--secondary-glow);
            border: 1px solid rgba(99, 102, 241, 0.3);
        }

        .timestamp {
            color: rgba(255, 255, 255, 0.6);
            font-size: 0.875rem;
        }

        .card-footer {
            background: rgba(15, 23, 42, 0.7);
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            padding: 1rem 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .pagination {
            display: flex;
            gap: 0.25rem;
            margin: 0;
        }

        .pagination .page-item .page-link {
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: rgba(255, 255, 255, 0.9);
            padding: 0.375rem 0.75rem;
            transition: all 0.3s ease;
            background-color: rgba(30, 41, 59, 0.3);
        }

        .pagination .page-item.active .page-link {
            background: linear-gradient(135deg, var(--primary-glow), var(--secondary-glow));
            border-color: var(--primary-glow);
            color: white;
            box-shadow: 0 0 10px rgba(14, 165, 233, 0.3);
        }

        .pagination .page-item .page-link:hover:not(.active) {
            background-color: rgba(30, 41, 59, 0.6);
            color: var(--primary-glow);
            border-color: var(--primary-glow);
        }

        .pagination .page-item.disabled .page-link {
            background-color: rgba(30, 41, 59, 0.1);
            color: rgba(255, 255, 255, 0.4);
            border-color: rgba(255, 255, 255, 0.05);
        }

        .page-info {
            color: rgba(255, 255, 255, 0.6);
            font-size: 0.875rem;
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

        .animate-row {
            animation: slideIn 0.3s ease-out forwards;
            opacity: 0;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .header-section {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }

            .search-filter {
                width: 100%;
                flex-direction: column;
            }

            .card-footer {
                flex-direction: column;
                gap: 1rem;
            }
        }

        .page-title::after {
            content: "";
            display: block;
            width: 100%;
            height: 3px;
            background: linear-gradient(90deg, var(--primary-glow), var(--secondary-glow), transparent);
            margin-top: 0.5rem;
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
            <i class="fas fa-history"></i>
            Activity Logs
        </h1>
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="back-button">
            <i class="fas fa-arrow-left"></i>
            Back to Dashboard
        </a>
    </div>

    <div class="card">
        <div class="card-header">
            <div class="search-filter">
                <div class="search-input">
                    <i class="fas fa-search"></i>
                    <label for="searchInput"></label><input type="text" class="form-control" placeholder="Search logs..." id="searchInput">
                </div>
                <label for="actionFilter"></label><select class="form-select" style="max-width: 200px;" id="actionFilter">
                <option value="">All Actions</option>
                <option value="login">Login</option>
                <option value="create">Create</option>
                <option value="update">Update</option>
                <option value="delete">Delete</option>
            </select>
            </div>
        </div>

        <div class="table-container">
            <table class="activity-table">
                <thead>
                <tr>
                    <th>Admin ID</th>
                    <th>Action</th>
                    <th>Timestamp</th>
                </tr>
                </thead>
                <tbody id="logsTableBody">
                <c:forEach var="log" items="${logs}" varStatus="status">
                    <tr class="animate-row" style="animation-delay: ${status.index * 0.05}s">
                        <td class="admin-id">${log.adminId}</td>
                        <td>
                            <div class="action-cell">
                                <span class="action-badge ${fn:toLowerCase(fn:substring(log.action, 0, 6))}">
                                        ${log.action}
                                </span>
                            </div>
                        </td>
                        <td class="timestamp">${log.formattedTimestamp}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="card-footer">
            <div class="page-info">
                Showing <span id="startRecord">1</span> to <span id="endRecord">10</span> of <span id="totalRecords">100</span> entries
            </div>
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li class="page-item disabled">
                        <a class="page-link" href="#" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                    <li class="page-item active"><a class="page-link" href="#">1</a></li>
                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                    <li class="page-item">
                        <a class="page-link" href="#" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</div>

<script>
    // Animation for table rows
    document.addEventListener('DOMContentLoaded', function() {
        // Search functionality
        const searchInput = document.getElementById('searchInput');
        const actionFilter = document.getElementById('actionFilter');
        const tableRows = document.querySelectorAll('#logsTableBody tr');

        function filterTable() {
            const searchTerm = searchInput.value.toLowerCase();
            const actionTerm = actionFilter.value.toLowerCase();

            tableRows.forEach(row => {
                const adminId = row.querySelector('.admin-id').textContent.toLowerCase();
                const action = row.querySelector('.action-badge').textContent.toLowerCase();
                const timestamp = row.querySelector('.timestamp').textContent.toLowerCase();

                const matchesSearch = adminId.includes(searchTerm) ||
                    action.includes(searchTerm) ||
                    timestamp.includes(searchTerm);

                const matchesAction = actionTerm === '' || action.includes(actionTerm);

                if (matchesSearch && matchesAction) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });

            updatePaginationInfo();
        }

        function updatePaginationInfo() {
            const visibleRows = document.querySelectorAll('#logsTableBody tr:not([style*="display: none"])');
            document.getElementById('startRecord').textContent = visibleRows.length > 0 ? '1' : '0';
            document.getElementById('endRecord').textContent = visibleRows.length;
            document.getElementById('totalRecords').textContent = tableRows.length;
        }

        if (searchInput) {
            searchInput.addEventListener('input', filterTable);
        }

        if (actionFilter) {
            actionFilter.addEventListener('change', filterTable);
        }

        // Initialize pagination info
        updatePaginationInfo();

        // Add action badge classes based on content
        document.querySelectorAll('.action-badge').forEach(badge => {
            const action = badge.textContent.trim().toLowerCase();
            if (action.includes('login')) {
                badge.classList.add('login');
            } else if (action.includes('creat')) {
                badge.classList.add('create');
            } else if (action.includes('updat')) {
                badge.classList.add('update');
            } else if (action.includes('delet')) {
                badge.classList.add('delete');
            }
        });
    });
</script>
</body>
</html>

