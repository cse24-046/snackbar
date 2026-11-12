<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>CampusSnack Bar - Register</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container min-vh-100 d-flex align-items-center justify-content-center">
    <div class="card shadow-sm border-0" style="width: 100%; max-width: 520px; border-radius: 20px;">
        <div class="card-body p-4 p-md-5">
            <h2 class="fw-bold mb-4 text-center">Create an Account</h2>

            <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="alert alert-danger"><%= request.getAttribute("errorMessage") %></div>
            <% } %>

            <form action="${pageContext.request.contextPath}/register" method="post">
                <div class="mb-3">
                    <label class="form-label">Full Name</label>
                    <input type="text" name="fullName" class="form-control" required />
                </div>
                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <input type="email" name="email" class="form-control" required />
                </div>
                <div class="mb-3">
                    <label class="form-label">Password</label>
                    <input type="password" name="password" class="form-control" required />
                </div>
                <button type="submit" class="btn btn-primary w-100">Register</button>
            </form>

            <p class="mt-3 text-center mb-0">Already have an account? <a href="${pageContext.request.contextPath}/login">Login here</a></p>
        </div>
    </div>
</div>
</body>
</html>
