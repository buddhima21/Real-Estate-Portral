<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Activity Logs</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <h1>Activity Logs</h1>
    <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary mb-3">Back to Dashboard</a>

    <table class="table table-striped">
        <thead>
        <tr>
            <th>Admin ID</th>
            <th>Action</th>
            <th>Timestamp</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="log" items="${logs}">
            <tr>
                <td>${log.adminId}</td>
                <td>${log.action}</td>
                <td>${log.formattedTimestamp}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>
