<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>CampusSnack Bar - Menu</title>
</head>
<body>
<div class="container">
    <h2>Available Snacks</h2>
    <p>Welcome, ${sessionScope.currentUser.fullName} | <a href="${pageContext.request.contextPath}/logout">Logout</a></p>

    <table border="1" cellpadding="10">
        <thead>
        <tr>
            <th>Name</th>
            <th>Category</th>
            <th>Price ($)</th>
            <th>Stock</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="snack" items="${snackList}">
            <tr>
                <td>${snack.name}</td>
                <td>${snack.category}</td>
                <td>${snack.price}</td>
                <td>${snack.stockQuantity}</td>
                <td>
                    <form action="${pageContext.request.contextPath}/order" method="post">
                        <input type="hidden" name="snackId" value="${snack.id}" />
                        <input type="number" name="quantity" value="1" min="1" max="${snack.stockQuantity}" style="width: 50px;" />
                        <button type="submit">Order</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>