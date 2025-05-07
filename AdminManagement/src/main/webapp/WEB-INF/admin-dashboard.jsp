<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <h1>Admin Dashboard</h1>
    <a href="${pageContext.request.contextPath}/admin/add" class="btn btn-primary mb-3">Add New Admin</a>
    <a href="${pageContext.request.contextPath}/admin/manage-users" class="btn btn-secondary mb-3">Manage Users</a>
    <a href="${pageContext.request.contextPath}/admin/manage-properties" class="btn btn-secondary mb-3">Manage Properties</a>
    <a href="${pageContext.request.contextPath}/admin/activity-logs" class="btn btn-info mb-3">View Activity Logs</a>

    <h2>All Admins</h2>
    <table class="table table-striped">
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
                <td>${admin.id}</td>
                <td>${admin.username}</td>
                <td>${admin.password}</td>
                <td>${admin.privileges}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/update?id=${admin.id}" class="btn btn-sm btn-warning" onclick="return confirm('Are you sure you want to update this admin?')">Update</a>
                    <form action="${pageContext.request.contextPath}/admin/delete" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this admin?')">
                        <input type="hidden" name="id" value="${admin.id}">
                        <button type="submit" class="btn btn-sm btn-danger">Delete</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <form action="${pageContext.request.contextPath}/admin/search" method="get" class="mt-3">
        <div class="input-group">
            <input type="text" name="searchTerm" class="form-control" placeholder="Search by ID or Username" required>
            <button type="submit" class="btn btn-primary">Search</button>
        </div>
    </form>
</div>
</body>
</html>