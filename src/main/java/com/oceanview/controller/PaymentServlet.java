package com.oceanview.controller;

import com.oceanview.dao.PaymentDAO;
import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Payment;
import com.oceanview.model.Reservation;
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

@WebServlet(name = "PaymentServlet", urlPatterns = { "/payment/process", "/payment/bill", "/payment/list" })
public class PaymentServlet extends HttpServlet {
    private PaymentDAO paymentDAO;
    private ReservationDAO reservationDAO;

    @Override
    public void init() {
        paymentDAO = new PaymentDAO();
        reservationDAO = new ReservationDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        try {
            if ("/payment/bill".equals(path)) {
                showBill(request, response);
            } else if ("/payment/list".equals(path)) {
                listPayments(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if ("/payment/process".equals(request.getServletPath())) {
            processPayment(request, response);
        }
    }

    private void showBill(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String resNum = request.getParameter("id");
        Reservation res = reservationDAO.getReservationDetails(resNum);
        if (res != null) {
            request.setAttribute("reservation", res);
            request.getRequestDispatcher("/view_bill.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void processPayment(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Payment p = new Payment();
        p.setReservationNumber(request.getParameter("reservationNumber"));
        p.setAmount(Double.parseDouble(request.getParameter("amount")));
        p.setPaymentMethod(request.getParameter("paymentMethod"));

        try {
            paymentDAO.addPayment(p);
            String resNum = URLEncoder.encode(p.getReservationNumber(), StandardCharsets.UTF_8);
            response.sendRedirect(
                    request.getContextPath() + "/booking/view?id=" + resNum + "&success=payment");
        } catch (SQLException e) {
            String msg = URLEncoder.encode("Payment failed. Please try again.", StandardCharsets.UTF_8);
            String resNum = URLEncoder.encode(p.getReservationNumber(), StandardCharsets.UTF_8);
            response.sendRedirect(
                    request.getContextPath() + "/booking/view?id=" + resNum + "&error=" + msg);
        }
    }

    private void listPayments(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Payment> payments = paymentDAO.getAllPayments();
        request.setAttribute("payments", payments);
        request.getRequestDispatcher("/view_payments.jsp").forward(request, response);
    }
}
