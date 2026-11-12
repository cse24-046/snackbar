<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>CampusSnack Bar</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #fffaf3, #eef7ff);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .hero {
            max-width: 760px;
            background: rgba(255,255,255,0.9);
            border-radius: 24px;
            box-shadow: 0 12px 32px rgba(0,0,0,0.08);
            padding: 3rem;
        }
        .badge {
            border-radius: 999px;
            padding: 0.45rem 0.9rem;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="hero text-center">
        <span class="badge bg-primary-subtle text-primary mb-3">CampusSnax</span>
        <h1 class="display-4 fw-bold mb-3">Welcome to CampusSnack Bar</h1>
        <p class="lead text-secondary mb-4">Your quick campus stop for breakfast bites, local favourites, and refreshing drinks.</p>

        <c:choose>
            <c:when test="${not empty sessionScope.currentUser}">
                <p class="fw-semibold fs-5 mb-4">Hello, <strong>${sessionScope.currentUser.fullName}</strong>!</p>
                <div class="d-flex justify-content-center gap-2 flex-wrap">
                    <a href="${pageContext.request.contextPath}/menu" class="btn btn-primary">Go to Snack Menu</a>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger">Logout</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="d-flex justify-content-center gap-2 flex-wrap">
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">Login</a>
                    <a href="${pageContext.request.contextPath}/register" class="btn btn-outline-primary">Create Account</a>
                    <a href="${pageContext.request.contextPath}/menu" class="btn btn-success">Browse Menu</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html>