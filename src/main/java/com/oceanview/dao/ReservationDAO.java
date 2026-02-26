package com.oceanview.dao;

import com.oceanview.model.*;
import com.oceanview.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {

    public void addReservation(Reservation reservation) throws SQLException {
        String sql = "INSERT INTO reservations (reservation_number, guest_id, room_id, check_in_date, check_out_date, total_cost, created_by) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, reservation.getReservationNumber());
            stmt.setInt(2, reservation.getGuestId());
            stmt.setInt(3, reservation.getRoomId());
            stmt.setDate(4, reservation.getCheckInDate());
            stmt.setDate(5, reservation.getCheckOutDate());
            stmt.setDouble(6, reservation.getTotalCost());
            stmt.setInt(7, reservation.getCreatedBy());
            stmt.executeUpdate();

            // Update room status
            updateRoomStatus(reservation.getRoomId(), "OCCUPIED");
        }
    }

    public Reservation getReservationDetails(String reservationNumber) throws SQLException {
        String sql = "SELECT r.*, g.name AS guest_name, g.contact_number, g.nic, rm.room_number, rt.type_name, rt.rate_per_night, u.full_name AS creator_name "
                + "FROM reservations r "
                + "JOIN guests g ON r.guest_id = g.id "
                + "JOIN rooms rm ON r.room_id = rm.id "
                + "JOIN room_types rt ON rm.room_type_id = rt.id "
                + "LEFT JOIN users u ON r.created_by = u.id "
                + "WHERE r.reservation_number = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, reservationNumber);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Reservation res = mapReservation(rs);

                    Guest g = new Guest();
                    g.setId(rs.getInt("guest_id"));
                    g.setName(rs.getString("guest_name"));
                    g.setContactNumber(rs.getString("contact_number"));
                    g.setNic(rs.getString("nic"));
                    res.setGuest(g);

                    Room rm = new Room();
                    rm.setId(rs.getInt("room_id"));
                    rm.setRoomNumber(rs.getString("room_number"));
                    RoomType rt = new RoomType();
                    rt.setTypeName(rs.getString("type_name"));
                    rt.setRatePerNight(rs.getDouble("rate_per_night"));
                    rm.setRoomType(rt);
                    res.setRoom(rm);

                    if (rs.getString("creator_name") != null) {
                        User u = new User();
                        u.setFullName(rs.getString("creator_name"));
                        res.setCreator(u);
                    }

                    return res;
                }
            }
        }
        return null;
    }

    public List<Reservation> getAllReservations() throws SQLException {
        List<Reservation> reservations = new ArrayList<>();
        String sql = "SELECT r.*, g.name AS guest_name, g.nic, u.full_name AS creator_name FROM reservations r "
                + "JOIN guests g ON r.guest_id = g.id "
                + "LEFT JOIN users u ON r.created_by = u.id "
                + "ORDER BY r.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Reservation res = mapReservation(rs);
                Guest g = new Guest();
                g.setName(rs.getString("guest_name"));
                g.setNic(rs.getString("nic"));
                res.setGuest(g);
                if (rs.getString("creator_name") != null) {
                    User u = new User();
                    u.setFullName(rs.getString("creator_name"));
                    res.setCreator(u);
                }
                reservations.add(res);
            }
        }
        return reservations;
    }

    private void updateRoomStatus(int roomId, String status) throws SQLException {
        String sql = "UPDATE rooms SET status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, roomId);
            stmt.executeUpdate();
        }
    }

    private Reservation mapReservation(ResultSet rs) throws SQLException {
        Reservation res = new Reservation();
        res.setReservationNumber(rs.getString("reservation_number"));
        res.setGuestId(rs.getInt("guest_id"));
        res.setRoomId(rs.getInt("room_id"));
        res.setCheckInDate(rs.getDate("check_in_date"));
        res.setCheckOutDate(rs.getDate("check_out_date"));
        res.setTotalCost(rs.getDouble("total_cost"));
        res.setStatus(rs.getString("status"));
        res.setCreatedBy(rs.getInt("created_by"));
        res.setCreatedAt(rs.getTimestamp("created_at"));
        return res;
    }

    public void updateReservationStatus(String reservationNumber, String status) throws SQLException {
        String sql = "UPDATE reservations SET status = ? WHERE reservation_number = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setString(2, reservationNumber);
            stmt.executeUpdate();

            // Release/hold room based on new status
            int roomId = fetchRoomId(conn, reservationNumber);
            if (roomId > 0) {
                if ("CANCELLED".equalsIgnoreCase(status) || "CHECKED_OUT".equalsIgnoreCase(status)) {
                    updateRoomStatus(roomId, "AVAILABLE");
                } else if ("BOOKED".equalsIgnoreCase(status) || "CHECKED_IN".equalsIgnoreCase(status)) {
                    updateRoomStatus(roomId, "OCCUPIED");
                }
            }
        }
    }

    private int fetchRoomId(Connection conn, String reservationNumber) throws SQLException {
        String lookup = "SELECT room_id FROM reservations WHERE reservation_number = ?";
        try (PreparedStatement st = conn.prepareStatement(lookup)) {
            st.setString(1, reservationNumber);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("room_id");
                }
            }
        }
        return 0;
    }
}
