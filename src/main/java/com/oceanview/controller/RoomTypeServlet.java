package com.oceanview.controller;

import com.oceanview.dao.RoomTypeDAO;
import com.oceanview.model.RoomType;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "RoomTypeServlet", urlPatterns = {
        "/admin/roomtypes/list", "/admin/roomtypes/add", "/admin/roomtypes/update", "/admin/roomtypes/delete",
        "/admin/roomtypes/get"
})
public class RoomTypeServlet extends HttpServlet {
    private RoomTypeDAO roomTypeDAO;

    @Override
    public void init() {
        roomTypeDAO = new RoomTypeDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        try {
            if (path.startsWith("/admin/") && !isAdmin(request)) {
                response.sendRedirect(request.getContextPath() + "/staff/dashboard?error=" + encode("Unauthorized: admin access required."));
                return;
            }
            if ("/admin/roomtypes/list".equals(path)) {
                List<RoomType> types = roomTypeDAO.getAllRoomTypes();
                request.setAttribute("roomTypes", types);
                request.getRequestDispatcher("/manage_room_types.jsp").forward(request, response);
            } else if ("/admin/roomtypes/delete".equals(path)) {
                int id = Integer.parseInt(request.getParameter("id"));
                roomTypeDAO.deleteRoomType(id);
                response.sendRedirect(request.getContextPath() + "/admin/roomtypes/list?success=delete");
            } else if ("/admin/roomtypes/get".equals(path)) {
                int id = Integer.parseInt(request.getParameter("id"));
                RoomType type = roomTypeDAO.getRoomTypeById(id);
                if (type != null) {
                    response.setContentType("application/json");
                    response.getWriter().write(String.format("{\"id\":%d, \"typeName\":\"%s\", \"ratePerNight\":%.2f}",
                            type.getId(), type.getTypeName(), type.getRatePerNight()));
                }
            }
        } catch (SQLException e) {
            String msg = URLEncoder.encode("Operation failed. Please try again.", StandardCharsets.UTF_8);
            response.sendRedirect(request.getContextPath() + "/admin/roomtypes/list?error=" + msg);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        try {
            if (path.startsWith("/admin/") && !isAdmin(request)) {
                response.sendRedirect(request.getContextPath() + "/staff/dashboard?error=" + encode("Unauthorized: admin access required."));
                return;
            }
            if ("/admin/roomtypes/add".equals(path)) {
                RoomType type = new RoomType();
                type.setTypeName(request.getParameter("typeName"));
                type.setRatePerNight(Double.parseDouble(request.getParameter("ratePerNight")));
                roomTypeDAO.addRoomType(type);
                response.sendRedirect(request.getContextPath() + "/admin/roomtypes/list?success=add");
            } else if ("/admin/roomtypes/update".equals(path)) {
                RoomType type = new RoomType();
                type.setId(Integer.parseInt(request.getParameter("id")));
                type.setTypeName(request.getParameter("typeName"));
                type.setRatePerNight(Double.parseDouble(request.getParameter("ratePerNight")));
                roomTypeDAO.updateRoomType(type);
                response.sendRedirect(request.getContextPath() + "/admin/roomtypes/list?success=update");
            }
        } catch (SQLException e) {
            String msg = URLEncoder.encode("Save failed. Please try again.", StandardCharsets.UTF_8);
            response.sendRedirect(request.getContextPath() + "/admin/roomtypes/list?error=" + msg);
        }
    }

    private boolean isAdmin(HttpServletRequest request) {
        javax.servlet.http.HttpSession session = request.getSession(false);
        if (session == null)
            return false;
        Object userObj = session.getAttribute("user");
        if (userObj instanceof com.oceanview.model.User) {
            return "ADMIN".equalsIgnoreCase(((com.oceanview.model.User) userObj).getRole());
        }
        return false;
    }

    private String encode(String msg) {
        return URLEncoder.encode(msg, StandardCharsets.UTF_8);
    }
}
