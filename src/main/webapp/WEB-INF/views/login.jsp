<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>CampusSnack Bar - Login</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="container">
    <h2>CampusSnack Bar Login</h2>

    <% if (request.getAttribute("errorMessage") != null) { %>
    <p style="color: red;"><%= request.getAttribute("errorMessage") %></p>
    <% } %>

    <% if (request.getParameter("error") != null && request.getParameter("error").equals("unauthorized")) { %>
    <p style="color: red;">Please log in to access your order page.</p>
    <% } %>

    <form action="${pageContext.request.contextPath}/login" method="post">
        <div>
            <label>Email:</label>
            <input type="email" name="email" required />
        </div>
        <div>
            <label>Password:</label>
            <input type="password" name="password" required />
        </div>
        <button type="submit">Login</button>
    </form>

    <p>New here? <a href="${pageContext.request.contextPath}/register">Create an account</a></p>
</div>
</body>
</html>