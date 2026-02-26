package com.oceanview.controller;

import com.oceanview.dao.GuestDAO;
import com.oceanview.dao.RoomDAO;
import com.oceanview.dao.UserDAO;
import com.oceanview.model.Guest;
import com.oceanview.model.Room;
import com.oceanview.model.User;
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

@WebServlet(name = "AdminServlet", urlPatterns = {
        "/admin/dashboard",
        "/admin/staff/add", "/admin/staff/delete", "/admin/staff/list", "/admin/staff/cards", "/admin/staff/update", "/admin/staff/get",
        "/admin/rooms/add", "/admin/rooms/update", "/admin/rooms/delete", "/admin/rooms/list", "/admin/rooms/get",
        "/admin/guests/list", "/admin/guests/get", "/admin/guests/update", "/admin/guests/delete"
})
@javax.servlet.annotation.MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class AdminServlet extends HttpServlet {
    private UserDAO userDAO;
    private RoomDAO roomDAO;
    private GuestDAO guestDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
        roomDAO = new RoomDAO();
        guestDAO = new GuestDAO();
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
            switch (path) {
                case "/admin/dashboard":
                    showDashboard(request, response);
                    break;
                case "/admin/staff/list":
                    listStaff(request, response);
                    break;
                case "/admin/staff/cards":
                    listStaffCards(request, response);
                    break;
                case "/admin/rooms/list":
                    listRooms(request, response);
                    break;
                case "/admin/staff/delete":
                    deleteStaff(request, response);
                    break;
                case "/admin/rooms/delete":
                    deleteRoom(request, response);
                    break;
                case "/admin/rooms/get":
                    getRoomDetails(request, response);
                    break;
                case "/admin/staff/get":
                    getStaffDetails(request, response);
                    break;
                case "/admin/guests/list":
                    listGuests(request, response);
                    break;
                case "/admin/guests/get":
                    getGuestDetails(request, response);
                    break;
                case "/admin/guests/delete":
                    deleteGuest(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
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
            switch (path) {
                case "/admin/staff/add":
                    addStaff(request, response);
                    break;
                case "/admin/staff/update":
                    updateStaff(request, response);
                    break;
                case "/admin/guests/update":
                    updateGuest(request, response);
                    break;
                case "/admin/rooms/add":
                    addRoom(request, response);
                    break;
                case "/admin/rooms/update":
                    updateRoom(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("totalStaff", userDAO.getAllStaff().size());
            request.setAttribute("totalRooms", roomDAO.getAllRooms().size());
            request.setAttribute("totalGuests", guestDAO.getAllGuests().size());
        } catch (SQLException e) {
            // Fallback if DB column is missing or query fails
            request.setAttribute("totalStaff", 0);
            request.setAttribute("totalRooms", 0);
            request.setAttribute("totalGuests", 0);
            request.setAttribute("dbError", e.getMessage());
        }

        // Final dashboard statistics (Mock/Placeholder for now)
        request.setAttribute("totalReservations", 12);
        request.setAttribute("totalRevenue", 125000.00);

        request.getRequestDispatcher("/admin_dashboard.jsp").forward(request, response);
    }

    private void listStaff(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        List<User> staffList = userDAO.getAllStaff();
        request.setAttribute("staffList", staffList);
        request.getRequestDispatcher("/manage_staff.jsp").forward(request, response);
    }

    private void listStaffCards(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        List<User> staffList = userDAO.getAllStaff();
        request.setAttribute("staffList", staffList);
        request.getRequestDispatcher("/staff_directory.jsp").forward(request, response);
    }

    private void addStaff(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            User user = new User();
            user.setUsername(request.getParameter("username"));
            user.setPassword(request.getParameter("password"));
            user.setFullName(request.getParameter("fullName"));
            user.setEmail(request.getParameter("email"));
            user.setPhoneNumber(request.getParameter("phoneNumber"));
            user.setRole("STAFF");
            userDAO.addUser(user);
            response.sendRedirect(request.getContextPath() + "/admin/staff/list?success=add");
        } catch (SQLException e) {
            String msg = URLEncoder.encode("Could not add staff member. Please try again.", StandardCharsets.UTF_8);
            response.sendRedirect(request.getContextPath() + "/admin/staff/list?error=" + msg);
        }
    }

    private void updateStaff(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            User user = new User();
            user.setId(Integer.parseInt(request.getParameter("id")));
            user.setUsername(request.getParameter("username"));
            user.setPassword(request.getParameter("password"));
            user.setFullName(request.getParameter("fullName"));
            user.setEmail(request.getParameter("email"));
            user.setPhoneNumber(request.getParameter("phoneNumber"));
            userDAO.updateStaff(user);
            response.sendRedirect(request.getContextPath() + "/admin/staff/list?success=update");
        } catch (SQLException e) {
            String msg = URLEncoder.encode("Could not update staff member. Please try again.", StandardCharsets.UTF_8);
            response.sendRedirect(request.getContextPath() + "/admin/staff/list?error=" + msg);
        }
    }

    private void deleteStaff(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            userDAO.deleteUser(id);
            response.sendRedirect(request.getContextPath() + "/admin/staff/list?success=delete");
        } catch (SQLException e) {
            String msg = URLEncoder.encode("Could not delete staff member. Please try again.", StandardCharsets.UTF_8);
            response.sendRedirect(request.getContextPath() + "/admin/staff/list?error=" + msg);
        }
    }

    private void getStaffDetails(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        User user = userDAO.getUserById(id);
        if (user != null) {
            response.setContentType("application/json");
            response.getWriter()
                    .write(String.format(
                            "{\"id\":%d, \"username\":\"%s\", \"password\":\"%s\", \"fullName\":\"%s\", \"email\":\"%s\", \"phoneNumber\":\"%s\"}",
                            user.getId(), user.getUsername(), user.getPassword(), user.getFullName(),
                            user.getEmail() == null ? "" : user.getEmail(),
                            user.getPhoneNumber() == null ? "" : user.getPhoneNumber()));
        }
    }

    private void listRooms(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        List<Room> roomList = roomDAO.getAllRooms();
        request.setAttribute("roomList", roomList);
        request.setAttribute("roomTypes", roomDAO.getAllRoomTypes());
        request.getRequestDispatcher("/manage_rooms.jsp").forward(request, response);
    }

    private void addRoom(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        Room room = new Room();
        room.setRoomNumber(request.getParameter("roomNumber"));
        room.setRoomTypeId(Integer.parseInt(request.getParameter("roomTypeId")));
        room.setStatus("AVAILABLE");

        // Handle Image Upload
        javax.servlet.http.Part filePart = request.getPart("roomImage");
        String fileName = "default_room.png";
        if (filePart != null && filePart.getSize() > 0) {
            fileName = System.currentTimeMillis() + "_" + getFileName(filePart);
            String uploadPath = getServletContext().getRealPath("/assets/rooms");
            java.io.File uploadDir = new java.io.File(uploadPath);
            if (!uploadDir.exists())
                uploadDir.mkdirs();
            filePart.write(uploadPath + java.io.File.separator + fileName);
        }
        room.setRoomImage(fileName);

        roomDAO.addRoom(room);
        response.sendRedirect(request.getContextPath() + "/admin/rooms/list?success=add");
    }

    private void updateRoom(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        Room room = roomDAO.getRoomById(id);
        if (room != null) {
            room.setRoomTypeId(Integer.parseInt(request.getParameter("roomTypeId")));
            room.setStatus(request.getParameter("status"));

            // Handle Image Update
            javax.servlet.http.Part filePart = request.getPart("roomImage");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = System.currentTimeMillis() + "_" + getFileName(filePart);
                String uploadPath = getServletContext().getRealPath("/assets/rooms");
                filePart.write(uploadPath + java.io.File.separator + fileName);
                room.setRoomImage(fileName);
            }

            roomDAO.updateRoom(room);
        }
        response.sendRedirect(request.getContextPath() + "/admin/rooms/list?success=update");
    }

    private String getFileName(javax.servlet.http.Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }

    private boolean isAdmin(HttpServletRequest request) {
        javax.servlet.http.HttpSession session = request.getSession(false);
        if (session == null)
            return false;
        Object userObj = session.getAttribute("user");
        if (userObj instanceof User) {
            return "ADMIN".equalsIgnoreCase(((User) userObj).getRole());
        }
        return false;
    }

    private String encode(String msg) {
        return URLEncoder.encode(msg, StandardCharsets.UTF_8);
    }

    private void deleteRoom(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        roomDAO.deleteRoom(id);
        response.sendRedirect(request.getContextPath() + "/admin/rooms/list?success=delete");
    }

    private void getRoomDetails(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Room room = roomDAO.getRoomById(id);
        if (room != null) {
            response.setContentType("application/json");
            response.getWriter()
                    .write(String.format(
                            "{\"id\":%d, \"roomNumber\":\"%s\", \"roomTypeId\":%d, \"status\":\"%s\", \"roomImage\":\"%s\"}",
                            room.getId(), room.getRoomNumber(), room.getRoomTypeId(), room.getStatus(),
                            room.getRoomImage()));
        }
    }

    // GUEST MANAGEMENT
    private void listGuests(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Guest> guests = guestDAO.getAllGuests();
        request.setAttribute("guests", guests);
        request.getRequestDispatcher("/manage_guests.jsp").forward(request, response);
    }

    private void getGuestDetails(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Guest guest = guestDAO.getGuestById(id);
        if (guest != null) {
            response.setContentType("application/json");
            response.getWriter()
                    .write(String.format("{\"id\":%d, \"name\":\"%s\", \"address\":\"%s\", \"contactNumber\":\"%s\"}",
                            guest.getId(), guest.getName(), guest.getAddress(), guest.getContactNumber()));
        }
    }

    private void updateGuest(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        Guest guest = new Guest();
        guest.setId(Integer.parseInt(request.getParameter("id")));
        guest.setName(request.getParameter("name"));
        guest.setAddress(request.getParameter("address"));
        guest.setContactNumber(request.getParameter("contactNumber"));
        guestDAO.updateGuest(guest);
        response.sendRedirect(request.getContextPath() + "/admin/guests/list?success=update");
    }

    private void deleteGuest(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        guestDAO.deleteGuest(id);
        response.sendRedirect(request.getContextPath() + "/admin/guests/list?success=delete");
    }
}
