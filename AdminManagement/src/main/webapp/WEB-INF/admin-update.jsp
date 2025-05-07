<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <h1>Update Admin</h1>
    <form action="${pageContext.request.contextPath}/admin/update" method="post">
        <input type="hidden" name="id" value="${admin.id}">
        <div class="mb-3">
            <label for="username" class="form-label">Username</label>
            <input type="text" class="form-control" id="username" name="username" value="${admin.username}" required>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" id="password" name="password" value="${admin.password}" required>
        </div>
        <div class="mb-3">
            <label for="privileges" class="form-label">Privileges</label>
            <select class="form-select" id="privileges" name="privileges" required>
                <option value="full" ${admin.privileges == 'full' ? 'selected' : ''}>Full Access</option>
                <option value="moderate" ${admin.privileges == 'moderate' ? 'selected' : ''}>Moderate Access</option>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">Update Admin</button>
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary">Back</a>
    </form>
</div>
</body>
</html>