<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>CampusSnack Bar - Register</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="container">
    <h2>Create an Account</h2>

    <% if (request.getAttribute("errorMessage") != null) { %>
    <p style="color: red;"><%= request.getAttribute("errorMessage") %></p>
    <% } %>

    <form action="${pageContext.request.contextPath}/register" method="post">
        <div>
            <label>Full Name:</label>
            <input type="text" name="fullName" required />
        </div>
        <div>
            <label>Email:</label>
            <input type="email" name="email" required />
        </div>
        <div>
            <label>Password:</label>
            <input type="password" name="password" required />
        </div>
        <button type="submit">Register</button>
    </form>

    <p>Already have an account? <a href="${pageContext.request.contextPath}/login">Login here</a></p>
</div>
</body>
</html>
