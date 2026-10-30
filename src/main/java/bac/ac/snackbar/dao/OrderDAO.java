package bac.ac.snackbar.dao;

import bac.ac.snackbar.model.Order;
import bac.ac.snackbar.util.DBConnection;

import java.sql.*;

public class OrderDAO {

    public boolean createOrder(Order order) {
        String insertOrderSQL = "INSERT INTO orders (user_id, snack_id, quantity, total_price, status) VALUES (?, ?, ?, ?, ?)";
        String updateStockSQL = "UPDATE snacks SET stock_quantity = stock_quantity - ? WHERE id = ? AND stock_quantity >= ?";

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Begin transaction

            // 1. Decrement stock safely with condition check
            try (PreparedStatement psStock = conn.prepareStatement(updateStockSQL)) {
                psStock.setInt(1, order.getQuantity());
                psStock.setLong(2, order.getSnackId());
                psStock.setInt(3, order.getQuantity());

                int rowsAffected = psStock.executeUpdate();
                if (rowsAffected == 0) {
                    conn.rollback();
                    return false; // Out of stock or invalid item
                }
            }

            // 2. Insert order record
            try (PreparedStatement psOrder = conn.prepareStatement(insertOrderSQL, Statement.RETURN_GENERATED_KEYS)) {
                psOrder.setLong(1, order.getUserId());
                psOrder.setLong(2, order.getSnackId());
                psOrder.setInt(3, order.getQuantity());
                psOrder.setDouble(4, order.getTotalPrice());
                psOrder.setString(5, order.getStatus());

                int affectedRows = psOrder.executeUpdate();
                if (affectedRows == 0) {
                    conn.rollback();
                    return false;
                }

                try (ResultSet generatedKeys = psOrder.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        order.setId(generatedKeys.getLong(1));
                    }
                }
            }

            conn.commit(); // Commit transaction
            return true;

        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}