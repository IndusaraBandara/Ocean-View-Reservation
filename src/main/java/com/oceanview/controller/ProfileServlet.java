package com.oceanview.controller;

import com.oceanview.dao.UserDAO;
import com.oceanview.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class ProfileServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        request.getRequestDispatcher("/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        try {
            if ("/profile/update".equals(path)) {
                updateProfile(request, response);
            } else if ("/profile/reset-password".equals(path)) {
                resetPassword(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        User currentUser = (User) session.getAttribute("user");

        String fullName = request.getParameter("fullName");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        Part filePart = request.getPart("profileImage");
        String fileName = null;

        if (filePart != null && filePart.getSize() > 0) {
            String uploadPath = getServletContext().getRealPath("") + File.separator + "assets/uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            fileName = System.currentTimeMillis() + "_" + extractFileName(filePart);
            filePart.write(uploadPath + File.separator + fileName);
            currentUser.setProfileImage(fileName);
        }

        if (username != null && !username.isBlank()) {
            currentUser.setUsername(username.trim());
        }
        currentUser.setFullName(fullName);
        if (email != null) {
            currentUser.setEmail(email.trim());
        }
        if (phoneNumber != null) {
            currentUser.setPhoneNumber(phoneNumber.trim());
        }
        userDAO.updateUser(currentUser);

        // Reload from DB to ensure session has fresh state
        User refreshed = userDAO.getUserById(currentUser.getId());
        session.setAttribute("user", refreshed != null ? refreshed : currentUser);
        response.sendRedirect(request.getContextPath() + "/profile?success=1");
    }

    private void resetPassword(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        User currentUser = (User) session.getAttribute("user");

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate confirm match
        if (confirmPassword == null || !confirmPassword.equals(newPassword)) {
            response.sendRedirect(request.getContextPath() + "/profile?pw_error=1&reason=confirm");
            return;
        }

        if (currentUser.getPassword().equals(currentPassword)) {
            userDAO.updatePassword(currentUser.getId(), newPassword);
            // refresh user from DB to keep session in sync
            User refreshed = userDAO.getUserById(currentUser.getId());
            if (refreshed != null) {
                session.setAttribute("user", refreshed);
            } else {
                currentUser.setPassword(newPassword);
                session.setAttribute("user", currentUser);
            }
            response.sendRedirect(request.getContextPath() + "/profile?pw_success=1");
        } else {
            response.sendRedirect(request.getContextPath() + "/profile?pw_error=1");
        }
    }

    private String extractFileName(Part part) {
        if (part == null) return "";
        String contentDisp = part.getHeader("content-disposition");
        if (contentDisp == null) return "";
        for (String s : contentDisp.split(";")) {
            if (s.trim().startsWith("filename")) {
                String name = s.substring(s.indexOf('=') + 1).trim().replace("\"", "");
                return name.substring(name.lastIndexOf(File.separator) + 1);
            }
        }
        return "";
    }
}
