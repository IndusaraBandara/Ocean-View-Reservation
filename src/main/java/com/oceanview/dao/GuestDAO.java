package com.oceanview.dao;

import com.oceanview.model.Guest;
import com.oceanview.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class GuestDAO {

    public int addGuest(Guest guest) throws SQLException {
        String sql = "INSERT INTO guests (name, address, contact_number, nic) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, guest.getName());
            stmt.setString(2, guest.getAddress());
            stmt.setString(3, guest.getContactNumber());
            stmt.setString(4, guest.getNic());
            stmt.executeUpdate();
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return -1;
    }

    public Guest getGuestById(int id) throws SQLException {
        String sql = "SELECT * FROM guests WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Guest(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("address"),
                            rs.getString("contact_number"),
                            rs.getString("nic"),
                            rs.getTimestamp("created_at"));
                }
            }
        }
        return null;
    }

    public List<Guest> getAllGuests() throws SQLException {
        List<Guest> guests = new ArrayList<>();
        String sql = "SELECT * FROM guests";
        try (Connection conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                guests.add(new Guest(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("address"),
                        rs.getString("contact_number"),
                        rs.getString("nic"),
                        rs.getTimestamp("created_at")));
            }
        }
        return guests;
    }

    public void updateGuest(Guest guest) throws SQLException {
        String sql = "UPDATE guests SET name = ?, address = ?, contact_number = ?, nic = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, guest.getName());
            stmt.setString(2, guest.getAddress());
            stmt.setString(3, guest.getContactNumber());
            stmt.setString(4, guest.getNic());
            stmt.setInt(5, guest.getId());
            stmt.executeUpdate();
        }
    }

    public void deleteGuest(int id) throws SQLException {
        String sql = "DELETE FROM guests WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }
}
