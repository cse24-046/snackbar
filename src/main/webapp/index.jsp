<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>CampusSnack Bar</title>
</head>
<body>
<div style="text-align: center; margin-top: 50px;">
    <h1>Welcome to CampusSnack Bar</h1>
    <p>Your quick campus portal for snacks, pastries, and drinks!</p>

    <br/>

    <!-- Navigation options based on session state -->
    <c:choose>
        <c:when test="${not empty sessionScope.currentUser}">
            <p>Hello, <strong>${sessionScope.currentUser.fullName}</strong>!</p>
            <a href="${pageContext.request.contextPath}/menu">Go to Snack Menu</a> |
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </c:when>
        <c:otherwise>
            <a href="${pageContext.request.contextPath}/login">Login</a> |
            <a href="${pageContext.request.contextPath}/register">Create Account</a> |
            <a href="${pageContext.request.contextPath}/menu">Browse Menu</a>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>