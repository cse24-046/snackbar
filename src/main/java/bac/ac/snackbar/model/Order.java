package bac.ac.snackbar.model;

import java.time.LocalDateTime;

public class Order {
    private long id;
    private long userId;
    private long snackId;
    private int quantity;
    private double totalPrice;
    private LocalDateTime orderTime;
    private String status;

    public Order() {}

    public Order(long id, long userId, long snackId, int quantity, double totalPrice, LocalDateTime orderTime, String status) {
        this.id = id;
        this.userId = userId;
        this.snackId = snackId;
        this.quantity = quantity;
        this.totalPrice = totalPrice;
        this.orderTime = orderTime;
        this.status = status;
    }

    public long getId() { return id; }
    public void setId(long id) { this.id = id; }

    public long getUserId() { return userId; }
    public void setUserId(long userId) { this.userId = userId; }

    public long getSnackId() { return snackId; }
    public void setSnackId(long snackId) { this.snackId = snackId; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public double getTotalPrice() { return totalPrice; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }

    public LocalDateTime getOrderTime() { return orderTime; }
    public void setOrderTime(LocalDateTime orderTime) { this.orderTime = orderTime; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}