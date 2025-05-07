<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 5/7/2025
  Time: 9:49 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Search Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <h1>Search Result</h1>
    <c:if test="${admin != null}">
        <p>ID: ${admin.id}</p>
        <p>Username: ${admin.username}</p>
        <p>Privileges: ${admin.privileges}</p>
    </c:if>
    <c:if test="${admin == null}">
        <p>No admin found.</p>
    </c:if>
    <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary">Back to Dashboard</a>
</div>
</body>
</html>
