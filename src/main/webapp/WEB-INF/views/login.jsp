<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>CampusSnack Bar - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container min-vh-100 d-flex align-items-center justify-content-center">
    <div class="card shadow-sm border-0" style="width: 100%; max-width: 480px; border-radius: 20px;">
        <div class="card-body p-4 p-md-5">
            <h2 class="fw-bold mb-4 text-center">CampusSnack Login</h2>

            <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="alert alert-danger"><%= request.getAttribute("errorMessage") %></div>
            <% } %>

            <% if (request.getParameter("error") != null && request.getParameter("error").equals("unauthorized")) { %>
            <div class="alert alert-warning">Please log in to access your order page.</div>
            <% } %>

            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <input type="email" name="email" class="form-control" required />
                </div>
                <div class="mb-3">
                    <label class="form-label">Password</label>
                    <input type="password" name="password" class="form-control" required />
                </div>
                <button type="submit" class="btn btn-primary w-100">Login</button>
            </form>

            <p class="mt-3 text-center mb-0">New here? <a href="${pageContext.request.contextPath}/register">Create an account</a></p>
        </div>
    </div>
</div>
</body>
</html>