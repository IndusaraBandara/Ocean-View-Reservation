package com.oceanview.filter;

import com.oceanview.model.User;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String homeURI = req.getContextPath() + "/";
        String indexURI = req.getContextPath() + "/index.jsp";
        String loginURI = req.getContextPath() + "/login";
        String staticAssets = req.getContextPath() + "/assets"; // CSS/JS/Images

        String requestURI = req.getRequestURI();
        // Remove trailing slash for comparison (except for the root context itself)
        if (requestURI.endsWith("/") && requestURI.length() > homeURI.length()) {
            requestURI = requestURI.substring(0, requestURI.length() - 1);
        }

        boolean loggedIn = session != null && session.getAttribute("user") != null;
        boolean isHome = requestURI.equals(homeURI) || requestURI.equals(homeURI.substring(0, homeURI.length() - 1))
                || requestURI.equals(indexURI);
        boolean loginRequest = requestURI.equals(loginURI);
        boolean staticRequest = requestURI.startsWith(staticAssets);

        if (loggedIn || isHome || loginRequest || staticRequest) {
            if (loggedIn && loginRequest) {
                // Already logged in, redirect to dashboard
                User user = (User) session.getAttribute("user");
                if ("ADMIN".equals(user.getRole())) {
                    res.sendRedirect(req.getContextPath() + "/admin/dashboard");
                } else {
                    res.sendRedirect(req.getContextPath() + "/staff/dashboard");
                }
            } else {
                // Check role-based access for /admin/ and /staff/ paths
                if (loggedIn) {
                    User user = (User) session.getAttribute("user");
                    String path = req.getRequestURI().substring(req.getContextPath().length());

                    if (path.startsWith("/admin/") && !"ADMIN".equals(user.getRole())) {
                        res.sendError(HttpServletResponse.SC_FORBIDDEN);
                        return;
                    } else if (path.startsWith("/staff/") && "ADMIN".equals(user.getRole())) {
                        res.sendRedirect(req.getContextPath() + "/admin/dashboard");
                        return;
                    }
                }
                chain.doFilter(request, response);
            }
        } else {
            res.sendRedirect(loginURI);
        }
    }
}
