<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CampusSnack Bar - Menu</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #fff8f1, #f3f4f6);
            min-height: 100vh;
        }
        .card {
            border: none;
            box-shadow: 0 10px 25px rgba(0,0,0,0.07);
            border-radius: 18px;
        }
        .price-pill {
            background: #eafbf0;
            color: #0d6efd;
            border-radius: 999px;
            padding: 0.35rem 0.8rem;
            font-weight: 600;
        }
        .badge-category {
            background: #fff3cd;
            color: #8a5b00;
            border-radius: 999px;
        }
    </style>
</head>
<body>
<div class="container py-5">
    <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-3">
        <div>
            <p class="text-uppercase text-primary fw-semibold mb-1">CampusSnack</p>
            <h1 class="display-6 fw-bold mb-0">Fresh picks for your break</h1>
        </div>
        <div class="d-flex align-items-center gap-2">
            <c:if test="${not empty sessionScope.currentUser}">
                <span class="text-dark fw-semibold">Hello, ${sessionScope.currentUser.fullName}</span>
            </c:if>
            <a href="${pageContext.request.contextPath}/" class="btn btn-outline-secondary btn-sm">Home</a>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm">Logout</a>
        </div>
    </div>

    <c:if test="${param.error == 'invalid-order'}">
        <div class="alert alert-warning" role="alert">
            Please select a valid snack and quantity before placing your order.
        </div>
    </c:if>

    <div class="row row-cols-1 row-cols-md-2 row-cols-xl-4 g-4">
        <c:forEach var="snack" items="${snackList}">
            <div class="col">
                <div class="card h-100">
                    <div class="card-body d-flex flex-column">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <span class="badge badge-category text-dark px-3 py-2">${snack.category}</span>
                            <span class="price-pill">BWP <fmt:formatNumber value="${snack.price}" minFractionDigits="2" maxFractionDigits="2"/></span>
                        </div>

                        <h5 class="card-title fw-bold mb-3">${snack.name}</h5>
                        <p class="text-muted mb-4">${snack.stockQuantity} left in stock</p>

                        <form action="${pageContext.request.contextPath}/order" method="post" class="mt-auto">
                            <input type="hidden" name="snackId" value="${snack.id}" />
                            <div class="input-group">
                                <input type="number" name="quantity" value="1" min="1" max="${snack.stockQuantity}" class="form-control" aria-label="Quantity" />
                                <button type="submit" class="btn btn-primary">Order</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <c:if test="${empty snackList}">
        <div class="alert alert-warning mt-4" role="alert">
            No snacks are available right now. Please check back later.
        </div>
    </c:if>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>