package com.oceanview.controller;

import com.oceanview.util.DBConnection;
import com.google.gson.Gson;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet(name = "DashboardServlet", urlPatterns = { "/api/dashboard-stats", "/reports" })
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();

        if ("/api/dashboard-stats".equals(path)) {
            getStatsJson(request, response);
        } else if ("/reports".equals(path)) {
            request.getRequestDispatcher("/reports.jsp").forward(request, response);
        }
    }

    private void getStatsJson(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Map<String, Object> stats = new HashMap<>();

        try (Connection conn = DBConnection.getConnection()) {

            // Total counts
            stats.put("totalRooms", getCount(conn, "SELECT COUNT(*) FROM rooms"));
            stats.put("availableRooms", getCount(conn, "SELECT COUNT(*) FROM rooms WHERE status='AVAILABLE'"));
            stats.put("totalStaff", getCount(conn, "SELECT COUNT(*) FROM users WHERE role='STAFF'"));
            stats.put("totalReservations", getCount(conn, "SELECT COUNT(*) FROM reservations"));
            stats.put("totalPayments", getCount(conn, "SELECT COUNT(*) FROM payments"));

            // Revenue
            stats.put("totalRevenue", getSum(conn, "SELECT COALESCE(SUM(amount),0) FROM payments"));
            stats.put("todayRevenue",
                    getSum(conn, "SELECT COALESCE(SUM(amount),0) FROM payments WHERE DATE(payment_date) = CURDATE()"));
            stats.put("weekRevenue", getSum(conn,
                    "SELECT COALESCE(SUM(amount),0) FROM payments WHERE YEARWEEK(payment_date, 1) = YEARWEEK(CURDATE(), 1)"));
            stats.put("monthRevenue", getSum(conn,
                    "SELECT COALESCE(SUM(amount),0) FROM payments WHERE MONTH(payment_date) = MONTH(CURDATE()) AND YEAR(payment_date) = YEAR(CURDATE())"));

            // Daily reservations for the last 7 days
            List<Map<String, Object>> dailyRes = new ArrayList<>();
            String dailySql = "SELECT DATE(created_at) as day, COUNT(*) as cnt FROM reservations WHERE created_at >= DATE_SUB(CURDATE(), INTERVAL 7 DAY) GROUP BY DATE(created_at) ORDER BY day";
            try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(dailySql)) {
                while (rs.next()) {
                    Map<String, Object> row = new HashMap<>();
                    row.put("day", rs.getString("day"));
                    row.put("count", rs.getInt("cnt"));
                    dailyRes.add(row);
                }
            }
            stats.put("dailyReservations", dailyRes);

            // Monthly revenue for the last 6 months
            List<Map<String, Object>> monthlyRev = new ArrayList<>();
            String monthlySql = "SELECT DATE_FORMAT(payment_date, '%Y-%m') as month, SUM(amount) as total FROM payments WHERE payment_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH) GROUP BY DATE_FORMAT(payment_date, '%Y-%m') ORDER BY month";
            try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(monthlySql)) {
                while (rs.next()) {
                    Map<String, Object> row = new HashMap<>();
                    row.put("month", rs.getString("month"));
                    row.put("total", rs.getDouble("total"));
                    monthlyRev.add(row);
                }
            }
            stats.put("monthlyRevenue", monthlyRev);

        } catch (SQLException e) {
            stats.put("error", e.getMessage());
        }

        response.getWriter().write(new Gson().toJson(stats));
    }

    private int getCount(Connection conn, String sql) throws SQLException {
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    private double getSum(Connection conn, String sql) throws SQLException {
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            return rs.next() ? rs.getDouble(1) : 0.0;
        }
    }
}
