package bac.ac.snackbar.controller;

import bac.ac.snackbar.dao.OrderDAO;
import bac.ac.snackbar.dao.SnackDAO;
import bac.ac.snackbar.model.Order;
import bac.ac.snackbar.model.SnackItem;
import bac.ac.snackbar.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {

    private final SnackDAO snackDAO = new SnackDAO();
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login?error=unauthorized");
            return;
        }
        User user = (User) session.getAttribute("currentUser");

        try {
            long snackId = Long.parseLong(request.getParameter("snackId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            if (quantity <= 0) {
                throw new NumberFormatException("Quantity must be positive");
            }

            SnackItem snack = snackDAO.findById(snackId);
            if (snack == null || snack.getStockQuantity() < quantity) {
                response.sendRedirect(request.getContextPath() + "/menu?error=invalid-order");
                return;
            }

            double totalPrice = snack.getPrice() * quantity;

            Order order = new Order();
            order.setUserId(user.getId());
            order.setSnackId(snackId);
            order.setQuantity(quantity);
            order.setTotalPrice(totalPrice);
            order.setOrderTime(LocalDateTime.now());
            order.setStatus("PENDING");

            boolean success = orderDAO.createOrder(order);

            if (success) {
                request.setAttribute("order", order);
                request.setAttribute("snackName", snack.getName());
                request.getRequestDispatcher("/WEB-INF/views/order-success.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to process order.");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/menu?error=invalid-order");
        }
    }
}