<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <title>Manage Properties</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
  <h1>Manage Properties</h1>
  <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary mb-3">Back to Dashboard</a>

  <table class="table table-striped">
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
        <td>${property.id}</td>
        <td>${property.title}</td>
        <td>${property.description}</td>
        <td>${property.price}</td>
        <td>${property.status}</td>
        <td>
          <c:if test="${property.status != 'approved'}">
            <form action="${pageContext.request.contextPath}/admin/property/approve" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to approve this property?')">
              <input type="hidden" name="id" value="${property.id}">
              <button type="submit" class="btn btn-sm btn-success">Approve</button>
            </form>
          </c:if>
          <a href="${pageContext.request.contextPath}/admin/property/edit?id=${property.id}" class="btn btn-sm btn-warning">Edit</a>
          <form action="${pageContext.request.contextPath}/admin/property/delete" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this property?')">
            <input type="hidden" name="id" value="${property.id}">
            <button type="submit" class="btn btn-sm btn-danger">Delete</button>
          </form>
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>
</div>
</body>
</html>