package com.oceanview.dao;

import com.oceanview.model.Payment;
import com.oceanview.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAO {

    public void addPayment(Payment payment) throws SQLException {
        String sql = "INSERT INTO payments (reservation_number, amount, payment_method) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, payment.getReservationNumber());
            stmt.setDouble(2, payment.getAmount());
            stmt.setString(3, payment.getPaymentMethod());
            stmt.executeUpdate();

            /* Update reservation status to CHECKED_OUT or similar if applicable */
            updateReservationStatus(payment.getReservationNumber(), "CHECKED_OUT");
        }
    }

    private void updateReservationStatus(String resNum, String status) throws SQLException {
        String sql = "UPDATE reservations SET status = ? WHERE reservation_number = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setString(2, resNum);
            stmt.executeUpdate();
        }
    }

    public List<Payment> getAllPayments() throws SQLException {
        List<Payment> payments = new ArrayList<>();
        String sql = "SELECT * FROM payments ORDER BY payment_date DESC";
        try (Connection conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Payment p = new Payment();
                p.setId(rs.getInt("id"));
                p.setReservationNumber(rs.getString("reservation_number"));
                p.setAmount(rs.getDouble("amount"));
                p.setPaymentDate(rs.getTimestamp("payment_date"));
                p.setPaymentMethod(rs.getString("payment_method"));
                payments.add(p);
            }
        }
        return payments;
    }

    public Payment getLatestByReservation(String reservationNumber) throws SQLException {
        String sql = "SELECT * FROM payments WHERE reservation_number = ? ORDER BY payment_date DESC LIMIT 1";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, reservationNumber);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Payment p = new Payment();
                    p.setId(rs.getInt("id"));
                    p.setReservationNumber(rs.getString("reservation_number"));
                    p.setAmount(rs.getDouble("amount"));
                    p.setPaymentDate(rs.getTimestamp("payment_date"));
                    p.setPaymentMethod(rs.getString("payment_method"));
                    return p;
                }
            }
        }
        return null;
    }
}
