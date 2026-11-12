<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Order Confirmation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container min-vh-100 d-flex align-items-center justify-content-center">
    <div class="card shadow-sm border-0" style="width: 100%; max-width: 540px; border-radius: 20px;">
        <div class="card-body p-4 p-md-5">
            <h2 class="fw-bold text-success mb-3">Order Successful!</h2>
            <p class="text-secondary">Thank you for your order. Your snack is being prepared for pickup.</p>

            <ul class="list-group list-group-flush mb-4">
                <li class="list-group-item"><strong>Item:</strong> ${snackName}</li>
                <li class="list-group-item"><strong>Quantity:</strong> ${order.quantity}</li>
                <li class="list-group-item"><strong>Total Price:</strong> BWP <fmt:formatNumber value="${order.totalPrice}" minFractionDigits="2" maxFractionDigits="2"/></li>
                <li class="list-group-item"><strong>Status:</strong> ${order.status}</li>
            </ul>

            <a href="${pageContext.request.contextPath}/menu" class="btn btn-primary">Back to Menu</a>
        </div>
    </div>
</div>
</body>
</html>