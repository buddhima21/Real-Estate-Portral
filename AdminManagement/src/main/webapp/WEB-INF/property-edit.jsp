<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Property</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <h1>Edit Property</h1>
    <form action="${pageContext.request.contextPath}/admin/property/edit" method="post">
        <input type="hidden" name="id" value="${property.id}">
        <div class="mb-3">
            <label for="title" class="form-label">Title</label>
            <input type="text" class="form-control" id="title" name="title" value="${property.title}" required>
        </div>
        <div class="mb-3">
            <label for="description" class="form-label">Description</label>
            <textarea class="form-control" id="description" name="description" required>${property.description}</textarea>
        </div>
        <div class="mb-3">
            <label for="price" class="form-label">Price</label>
            <input type="number" step="0.01" class="form-control" id="price" name="price" value="${property.price}" required>
        </div>
        <div class="mb-3">
            <label for="status" class="form-label">Status</label>
            <select class="form-control" id="status" name="status" required>
                <option value="pending" ${property.status == 'pending' ? 'selected' : ''}>Pending</option>
                <option value="approved" ${property.status == 'approved' ? 'selected' : ''}>Approved</option>
                <option value="rejected" ${property.status == 'rejected' ? 'selected' : ''}>Rejected</option>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">Save Changes</button>
        <a href="${pageContext.request.contextPath}/admin/manage-properties" class="btn btn-secondary">Cancel</a>
    </form>
</div>
</body>
</html>