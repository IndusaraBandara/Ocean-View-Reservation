package com.oceanview.dao;

import com.oceanview.model.RoomType;
import com.oceanview.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomTypeDAO {

    public List<RoomType> getAllRoomTypes() throws SQLException {
        List<RoomType> types = new ArrayList<>();
        String sql = "SELECT * FROM room_types";
        try (Connection conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                types.add(mapRoomType(rs));
            }
        }
        return types;
    }

    public void addRoomType(RoomType type) throws SQLException {
        String sql = "INSERT INTO room_types (type_name, rate_per_night) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, type.getTypeName());
            stmt.setDouble(2, type.getRatePerNight());
            stmt.executeUpdate();
        }
    }

    public void updateRoomType(RoomType type) throws SQLException {
        String sql = "UPDATE room_types SET type_name = ?, rate_per_night = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, type.getTypeName());
            stmt.setDouble(2, type.getRatePerNight());
            stmt.setInt(3, type.getId());
            stmt.executeUpdate();
        }
    }

    public void deleteRoomType(int id) throws SQLException {
        String sql = "DELETE FROM room_types WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    public RoomType getRoomTypeById(int id) throws SQLException {
        String sql = "SELECT * FROM room_types WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapRoomType(rs);
                }
            }
        }
        return null;
    }

    private RoomType mapRoomType(ResultSet rs) throws SQLException {
        return new RoomType(
                rs.getInt("id"),
                rs.getString("type_name"),
                rs.getDouble("rate_per_night"),
                rs.getString("room_image"));
    }
}
