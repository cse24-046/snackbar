<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Order Confirmation</title>
</head>
<body>
<div class="container">
    <h2>Order Successful!</h2>
    <p>Thank you for your order. Your snack is being prepared for pickup.</p>

    <ul>
        <li><strong>Item:</strong> ${snackName}</li>
        <li><strong>Quantity:</strong> ${order.quantity}</li>
        <li><strong>Total Price:</strong> $${order.totalPrice}</li>
        <li><strong>Status:</strong> ${order.status}</li>
    </ul>

    <br>
    <a href="${pageContext.request.contextPath}/menu">Back to Menu</a>
</div>
</body>
</html>