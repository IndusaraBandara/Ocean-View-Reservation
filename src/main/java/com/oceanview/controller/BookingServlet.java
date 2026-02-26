package com.oceanview.controller;

import com.oceanview.dao.GuestDAO;
import com.oceanview.dao.ReservationDAO;
import com.oceanview.dao.RoomDAO;
import com.oceanview.dao.UserDAO;
import com.oceanview.dao.PaymentDAO;
import com.oceanview.model.Guest;
import com.oceanview.model.Reservation;
import com.oceanview.model.Room;
import com.oceanview.model.User;
import com.oceanview.model.Payment;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;
import java.util.UUID;

public class BookingServlet extends HttpServlet {
    private ReservationDAO reservationDAO;
    private GuestDAO guestDAO;
    private RoomDAO roomDAO;
    private PaymentDAO paymentDAO;
    private UserDAO userDAO;

    @Override
    public void init() {
        reservationDAO = new ReservationDAO();
        guestDAO = new GuestDAO();
        roomDAO = new RoomDAO();
        paymentDAO = new PaymentDAO();
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = getFullPath(request);
        try {
            switch (path) {
                case "/staff/dashboard":
                case "/booking/list":
                    showBookings(request, response);
                    break;
                case "/staff/rooms":
                    showRoomsForStaff(request, response);
                    break;
                case "/staff/team":
                    showStaffTeam(request, response);
                    break;
                case "/booking/add":
                    showAddBookingForm(request, response);
                    break;
                case "/booking/view":
                    viewBookingDetails(request, response);
                    break;
                case "/booking/cancel":
                    cancelBooking(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/staff/dashboard");
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = getFullPath(request);
        if ("/booking/add".equals(path)) {
            processBooking(request, response);
        }
    }

    private void showBookings(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        List<Reservation> reservations = reservationDAO.getAllReservations();
        request.setAttribute("reservations", reservations);

        String target = request.getServletPath().contains("dashboard") ? "/staff_dashboard.jsp"
                : "/view_reservations.jsp";
        request.getRequestDispatcher(target).forward(request, response);
    }

    private void showAddBookingForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<Room> availableRooms = roomDAO.getAvailableRooms();
        if (availableRooms.isEmpty()) {
            // fall back so staff can still book if statuses are stale; flag the UI
            availableRooms = roomDAO.getAllRooms();
            request.setAttribute("fallbackRooms", true);
        }
        request.setAttribute("availableRooms", availableRooms);
        request.getRequestDispatcher("/add_reservation.jsp").forward(request, response);
    }

    private void showRoomsForStaff(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        User user = (User) session.getAttribute("user");
        if ("ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }

        List<Room> rooms = roomDAO.getAllRooms();
        request.setAttribute("roomList", rooms);
        request.getRequestDispatcher("/staff_rooms.jsp").forward(request, response);
    }

    private void showStaffTeam(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        List<User> staffList = userDAO.getAllStaff();
        request.setAttribute("staffList", staffList);
        request.getRequestDispatcher("/staff_team.jsp").forward(request, response);
    }

    private void processBooking(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("user");

            // 1. Create Guest
            Guest guest = new Guest();
            guest.setName(request.getParameter("guestName"));
            guest.setAddress(request.getParameter("address"));
            guest.setContactNumber(request.getParameter("contactNumber"));
            guest.setNic(request.getParameter("nic"));
            int guestId = guestDAO.addGuest(guest);

            // 2. Create Reservation
            Reservation res = new Reservation();
            res.setReservationNumber("RES-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase());
            res.setGuestId(guestId);
            res.setRoomId(Integer.parseInt(request.getParameter("roomId")));
            res.setCheckInDate(Date.valueOf(request.getParameter("checkInDate")));
            res.setCheckOutDate(Date.valueOf(request.getParameter("checkOutDate")));
            res.setTotalCost(Double.parseDouble(request.getParameter("totalCost")));
            res.setCreatedBy(currentUser.getId());

            reservationDAO.addReservation(res);

            String resNum = URLEncoder.encode(res.getReservationNumber(), StandardCharsets.UTF_8);
            response.sendRedirect(request.getContextPath() + "/booking/add?success=add&reservationNumber=" + resNum);
        } catch (SQLException e) {
            String msg = URLEncoder.encode("Could not create reservation. Please try again.", StandardCharsets.UTF_8);
            response.sendRedirect(request.getContextPath() + "/booking/add?error=" + msg);
        }
    }

    private void cancelBooking(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String resNum = request.getParameter("id");
        try {
            reservationDAO.updateReservationStatus(resNum, "CANCELLED");
            response.sendRedirect(request.getContextPath() + "/booking/list?success=cancel");
        } catch (SQLException e) {
            String msg = URLEncoder.encode("Could not cancel reservation. Please try again.", StandardCharsets.UTF_8);
            response.sendRedirect(request.getContextPath() + "/booking/list?error=" + msg);
        }
    }

    private void viewBookingDetails(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String resNum = request.getParameter("id");
        Reservation res = reservationDAO.getReservationDetails(resNum);
        if (res != null) {
            Payment payment = paymentDAO.getLatestByReservation(resNum);
            request.setAttribute("payment", payment);
            request.setAttribute("reservation", res);
            request.getRequestDispatcher("/view_booking.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    /**
     * Returns servletPath + pathInfo (if present) so pattern /booking/* resolves to /booking/add etc.
     */
    private String getFullPath(HttpServletRequest request) {
        String path = request.getServletPath();
        String info = request.getPathInfo();
        if (info != null) {
            path += info;
        }
        return path;
    }
}
