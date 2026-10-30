package bac.ac.snackbar.dao;

import bac.ac.snackbar.model.SnackItem;
import bac.ac.snackbar.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
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
        return snacks;
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