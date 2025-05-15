<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.ico">
  <title>Manage Properties</title>
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
      max-width: 1280px;
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
      padding: 0;
    }

    .table-container {
      overflow-x: auto;
    }

    .property-table {
      width: 100%;
      border-collapse: separate;
      border-spacing: 0;
      margin-bottom: 0;
    }

    .property-table thead th {
      background-color: rgba(15, 23, 42, 0.9);
      color: rgba(255, 255, 255, 0.7);
      font-weight: 600;
      text-transform: uppercase;
      font-size: 0.75rem;
      letter-spacing: 0.05em;
      padding: 1rem 1.5rem;
      border-bottom: 1px solid rgba(255, 255, 255, 0.1);
      text-align: left;
      white-space: nowrap;
    }

    .property-table tbody tr {
      background-color: rgba(30, 41, 59, 0.3);
      transition: background-color 0.3s ease, transform 0.2s ease;
    }

    .property-table tbody tr:hover {
      background-color: rgba(30, 41, 59, 0.6);
      transform: translateY(-2px);
    }

    .property-table td {
      padding: 1rem 1.5rem;
      border-bottom: 1px solid rgba(255, 255, 255, 0.1);
      vertical-align: middle;
    }

    .property-id {
      font-weight: 600;
      color: var(--primary-glow);
      text-shadow: 0 0 10px rgba(14, 165, 233, 0.3);
    }

    .property-title {
      font-weight: 500;
      color: rgba(255, 255, 255, 0.9);
    }

    .property-description {
      color: rgba(255, 255, 255, 0.7);
      max-width: 300px;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }

    .property-price {
      font-weight: 600;
      color: rgba(255, 255, 255, 0.9);
    }

    .property-status {
      display: inline-block;
      padding: 0.25rem 0.75rem;
      border-radius: 9999px;
      font-size: 0.75rem;
      font-weight: 500;
      text-transform: capitalize;
    }

    .property-status.pending {
      background-color: rgba(245, 158, 11, 0.1);
      color: var(--warning);
      border: 1px solid rgba(245, 158, 11, 0.3);
    }

    .property-status.approved {
      background-color: rgba(16, 185, 129, 0.1);
      color: var(--accent-color);
      border: 1px solid rgba(16, 185, 129, 0.3);
    }

    .property-status.rejected {
      background-color: rgba(239, 68, 68, 0.1);
      color: var(--danger);
      border: 1px solid rgba(239, 68, 68, 0.3);
    }

    .action-buttons {
      display: flex;
      gap: 0.5rem;
      align-items: center;
      flex-wrap: wrap;
    }

    .btn {
      padding: 0.5rem 1rem;
      border-radius: 8px;
      font-weight: 500;
      transition: all 0.3s ease;
      display: inline-flex;
      align-items: center;
      gap: 0.5rem;
    }

    .btn-sm {
      padding: 0.375rem 0.75rem;
      font-size: 0.875rem;
    }

    .btn-success {
      background: linear-gradient(135deg, var(--accent-color), #059669);
      border: none;
      color: white;
      position: relative;
      overflow: hidden;
    }

    .btn-success:hover {
      box-shadow: 0 0 20px rgba(16, 185, 129, 0.4);
      transform: translateY(-2px);
    }

    .btn-warning {
      background: linear-gradient(135deg, var(--warning), #d97706);
      border: none;
      color: white;
      position: relative;
      overflow: hidden;
    }

    .btn-warning:hover {
      box-shadow: 0 0 20px rgba(245, 158, 11, 0.4);
      transform: translateY(-2px);
    }

    .btn-danger {
      background: linear-gradient(135deg, var(--danger), #dc2626);
      border: none;
      color: white;
      position: relative;
      overflow: hidden;
    }

    .btn-danger:hover {
      box-shadow: 0 0 20px rgba(239, 68, 68, 0.4);
      transform: translateY(-2px);
    }

    .btn::after {
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

    .btn:hover::after {
      transform: rotate(30deg) translate(10%, 10%);
      opacity: 1;
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
    @media (max-width: 992px) {
      .property-description {
        max-width: 200px;
      }
    }

    @media (max-width: 768px) {
      .header-section {
        flex-direction: column;
        align-items: flex-start;
        gap: 1rem;
      }

      .property-description {
        max-width: 150px;
      }

      .action-buttons {
        flex-direction: column;
        align-items: flex-start;
      }

      .action-buttons .btn,
      .action-buttons form {
        width: 100%;
      }
    }

    @media (max-width: 576px) {
      .property-table {
        display: block;
      }

      .property-table thead {
        display: none;
      }

      .property-table tbody,
      .property-table tr,
      .property-table td {
        display: block;
        width: 100%;
      }

      .property-table tr {
        margin-bottom: 1rem;
        border: 1px solid rgba(255, 255, 255, 0.1);
        border-radius: 0.5rem;
        overflow: hidden;
      }

      .property-table td {
        position: relative;
        padding-left: 50%;
        text-align: right;
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
      }

      .property-table td:before {
        content: attr(data-label);
        position: absolute;
        left: 1rem;
        width: 45%;
        white-space: nowrap;
        font-weight: 600;
        text-align: left;
        color: rgba(255, 255, 255, 0.7);
      }

      .property-description {
        max-width: none;
      }

      .action-buttons {
        justify-content: flex-end;
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
      <i class="fas fa-building"></i>
      Manage Properties
    </h1>
    <a href="${pageContext.request.contextPath}/admin/dashboard" class="back-button">
      <i class="fas fa-arrow-left"></i>
      Back to Dashboard
    </a>
  </div>

  <div class="card animate-card">
    <div class="card-header">
      <h2 class="card-title">
        <i class="fas fa-home"></i>
        Property Listings
      </h2>
    </div>
    <div class="card-body">
      <div class="table-container">
        <table class="property-table">
          <thead>
          <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Description</th>
            <th>Price</th>
            <th>Status</th>
            <th>Actions</th>
          </tr>
          </thead>
          <tbody>
          <c:forEach var="property" items="${properties}">
            <tr>
              <td data-label="ID" class="property-id">${property.id}</td>
              <td data-label="Title" class="property-title">${property.title}</td>
              <td data-label="Description" class="property-description">${property.description}</td>
              <td data-label="Price" class="property-price">$${property.price}</td>
              <td data-label="Status">
                <span class="property-status ${fn:toLowerCase(property.status)}">${property.status}</span>
              </td>
              <td data-label="Actions" class="action-buttons">
                <c:if test="${property.status != 'approved'}">
                  <form action="${pageContext.request.contextPath}/admin/property/approve" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to approve this property?')">
                    <input type="hidden" name="id" value="${property.id}">
                    <button type="submit" class="btn btn-sm btn-success">
                      <i class="fas fa-check"></i>
                      <span>Approve</span>
                    </button>
                  </form>
                </c:if>
                <a href="${pageContext.request.contextPath}/admin/property/edit?id=${property.id}" class="btn btn-sm btn-warning">
                  <i class="fas fa-edit"></i>
                  <span>Edit</span>
                </a>
                <form action="${pageContext.request.contextPath}/admin/property/delete" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this property?')">
                  <input type="hidden" name="id" value="${property.id}">
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
</div>

<script>
  document.addEventListener('DOMContentLoaded', function() {
    // Add status badge classes based on content
    document.querySelectorAll('.property-status').forEach(badge => {
      const status = badge.textContent.trim().toLowerCase();
      if (status.includes('approved')) {
        badge.classList.add('approved');
      } else if (status.includes('pending')) {
        badge.classList.add('pending');
      } else if (status.includes('rejected')) {
        badge.classList.add('rejected');
      }
    });

    // Add responsive data labels for mobile view
    if (window.innerWidth <= 576) {
      const table = document.querySelector('.property-table');
      if (table) {
        const headers = Array.from(table.querySelectorAll('thead th')).map(th => th.textContent.trim());

        table.querySelectorAll('tbody tr').forEach(row => {
          Array.from(row.querySelectorAll('td')).forEach((cell, index) => {
            if (headers[index]) {
              cell.setAttribute('data-label', headers[index]);
            }
          });
        });
      }
    }
  });
</script>
</body>
</html>