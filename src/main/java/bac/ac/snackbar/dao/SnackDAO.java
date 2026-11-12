package bac.ac.snackbar.dao;

import bac.ac.snackbar.model.SnackItem;
import bac.ac.snackbar.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class SnackDAO {

    public List<SnackItem> getAllAvailableSnacks() {
        List<SnackItem> snacks = new ArrayList<>();
        String sql = "SELECT id, name, category, price, stock_quantity FROM snacks WHERE stock_quantity > 0";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                SnackItem snack = new SnackItem(
                        rs.getLong("id"),
                        rs.getString("name"),
                        rs.getString("category"),
                        rs.getDouble("price"),
                        rs.getInt("stock_quantity")
                );
                snacks.add(snack);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (snacks.isEmpty()) {
            return getFallbackMenu();
        }
        return snacks;
    }

    private List<SnackItem> getFallbackMenu() {
        return Arrays.asList(
                new SnackItem(1L, "Seswaa Plate", "Traditional", 52.00, 9),
                new SnackItem(2L, "Boerewors Roll", "Street Food", 28.00, 14),
                new SnackItem(3L, "Vetkoek & Mince", "Classic", 24.50, 12),
                new SnackItem(4L, "Morogo & Pap", "Traditional", 26.00, 10),
                new SnackItem(5L, "Chakalaka Burger", "Burger", 30.00, 11),
                new SnackItem(6L, "Botswana Beef Stew", "Hot Meal", 35.00, 8),
                new SnackItem(7L, "Chicken Mayo Wrap", "Wrap", 23.50, 13),
                new SnackItem(8L, "Beef Samosa", "Snack", 15.00, 18),
                new SnackItem(9L, "Fruit Salad Cup", "Healthy", 18.00, 16),
                new SnackItem(10L, "Ginger Beer", "Drink", 12.00, 24),
                new SnackItem(11L, "Café Mocha", "Drink", 14.50, 20),
                new SnackItem(12L, "Cheese Muffin", "Bakery", 10.50, 19)
        );
    }

    public SnackItem findById(long id) {
        String sql = "SELECT id, name, category, price, stock_quantity FROM snacks WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new SnackItem(
                            rs.getLong("id"),
                            rs.getString("name"),
                            rs.getString("category"),
                            rs.getDouble("price"),
                            rs.getInt("stock_quantity")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateStock(long snackId, int newQuantity) {
        String sql = "UPDATE snacks SET stock_quantity = ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, newQuantity);
            ps.setLong(2, snackId);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}