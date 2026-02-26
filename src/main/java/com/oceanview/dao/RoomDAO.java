package com.oceanview.dao;

import com.oceanview.model.Room;
import com.oceanview.model.RoomType;
import com.oceanview.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomDAO {

    public List<Room> getAllRooms() throws SQLException {
        List<Room> rooms = new ArrayList<>();
        String sql = "SELECT r.*, rt.type_name, rt.rate_per_night, rt.room_image AS type_image," +
                " (SELECT res.reservation_number FROM reservations res" +
                "   WHERE res.room_id = r.id AND res.status IN ('BOOKED','CHECKED_IN')" +
                "     AND CURDATE() BETWEEN res.check_in_date AND res.check_out_date" +
                "   ORDER BY res.check_in_date DESC LIMIT 1) AS active_res_num," +
                " (SELECT g.name FROM reservations res" +
                "   JOIN guests g ON res.guest_id = g.id" +
                "   WHERE res.room_id = r.id AND res.status IN ('BOOKED','CHECKED_IN')" +
                "     AND CURDATE() BETWEEN res.check_in_date AND res.check_out_date" +
                "   ORDER BY res.check_in_date DESC LIMIT 1) AS active_guest," +
                " (SELECT res.check_out_date FROM reservations res" +
                "   WHERE res.room_id = r.id AND res.status IN ('BOOKED','CHECKED_IN')" +
                "     AND CURDATE() BETWEEN res.check_in_date AND res.check_out_date" +
                "   ORDER BY res.check_in_date DESC LIMIT 1) AS active_checkout" +
                " FROM rooms r JOIN room_types rt ON r.room_type_id = rt.id";
        try (Connection conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Room room = mapRoom(rs);
                RoomType type = new RoomType(rs.getInt("room_type_id"), rs.getString("type_name"),
                        rs.getDouble("rate_per_night"), rs.getString("type_image"));
                room.setRoomType(type);
                room.setActiveReservationNumber(rs.getString("active_res_num"));
                room.setActiveGuestName(rs.getString("active_guest"));
                room.setActiveCheckoutDate(rs.getDate("active_checkout"));
                // If no live booking overlaps today, fall back to physical status
                if (room.getActiveGuestName() == null && "OCCUPIED".equalsIgnoreCase(room.getStatus())) {
                    room.setStatus("AVAILABLE");
                }
                rooms.add(room);
            }
        }
        return rooms;
    }

    public List<RoomType> getAllRoomTypes() throws SQLException {
        List<RoomType> types = new ArrayList<>();
        String sql = "SELECT * FROM room_types";
        try (Connection conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                types.add(new RoomType(
                        rs.getInt("id"),
                        rs.getString("type_name"),
                        rs.getDouble("rate_per_night"),
                        rs.getString("room_image")));
            }
        }
        return types;
    }

    public void addRoom(Room room) throws SQLException {
        String sql = "INSERT INTO rooms (room_number, room_type_id, status, room_image) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, room.getRoomNumber());
            stmt.setInt(2, room.getRoomTypeId());
            stmt.setString(3, room.getStatus());
            stmt.setString(4, room.getRoomImage());
            stmt.executeUpdate();
        }
    }

    public void updateRoom(Room room) throws SQLException {
        String sql = "UPDATE rooms SET room_type_id = ?, status = ?, room_image = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, room.getRoomTypeId());
            stmt.setString(2, room.getStatus());
            stmt.setString(3, room.getRoomImage());
            stmt.setInt(4, room.getId());
            stmt.executeUpdate();
        }
    }

    public void deleteRoom(int id) throws SQLException {
        String sql = "DELETE FROM rooms WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    public List<Room> getAvailableRooms() throws SQLException {
        List<Room> rooms = new ArrayList<>();
        String sql = "SELECT r.*, rt.type_name, rt.rate_per_night, rt.room_image AS type_image " +
                "FROM rooms r JOIN room_types rt ON r.room_type_id = rt.id " +
                "WHERE r.status = 'AVAILABLE' " +
                "AND r.id NOT IN (SELECT res.room_id FROM reservations res WHERE res.status IN ('BOOKED','CHECKED_IN') " +
                "AND CURDATE() BETWEEN res.check_in_date AND res.check_out_date)";
        try (Connection conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Room room = mapRoom(rs);
                RoomType type = new RoomType(rs.getInt("room_type_id"), rs.getString("type_name"),
                        rs.getDouble("rate_per_night"), rs.getString("type_image"));
                room.setRoomType(type);
                rooms.add(room);
            }
        }
        return rooms;
    }

    private Room mapRoom(ResultSet rs) throws SQLException {
        return new Room(
                rs.getInt("id"),
                rs.getString("room_number"),
                rs.getInt("room_type_id"),
                rs.getString("status"),
                rs.getString("room_image"));
    }

    public Room getRoomById(int id) throws SQLException {
        String sql = "SELECT * FROM rooms WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapRoom(rs);
                }
            }
        }
        return null;
    }
}
