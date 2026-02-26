<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Ocean View Resort — Management</title>
            <link
                href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700;800&family=Playfair+Display:wght@700&display=swap"
                rel="stylesheet">
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
            <style>
                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                }

                body {
                    font-family: 'Outfit', sans-serif;
                    background: #f0f4f8;
                }

                /* ── SIDEBAR ── */
                .sidebar {
                    width: 240px;
                    min-height: 100vh;
                    background: linear-gradient(180deg, #03045e 0%, #0077b6 100%);
                    display: flex;
                    flex-direction: column;
                    position: fixed;
                    top: 0;
                    left: 0;
                    z-index: 100;
                }

                .sidebar-brand {
                    padding: 22px 20px 16px;
                    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
                }

                .sidebar-brand h4 {
                    font-family: 'Playfair Display', serif;
                    color: #fff;
                    font-size: 1.1rem;
                    margin: 0;
                }

                .sidebar-brand small {
                    color: rgba(255, 255, 255, 0.5);
                    font-size: 0.68rem;
                    letter-spacing: 1px;
                    text-transform: uppercase;
                }

                .sidebar-user {
                    padding: 12px 20px;
                    display: flex;
                    align-items: center;
                    gap: 10px;
                    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
                }

                .sidebar-avatar {
                    width: 36px;
                    height: 36px;
                    border-radius: 50%;
                    background: linear-gradient(135deg, #00b4d8, #90e0ef);
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    color: #fff;
                    font-weight: 800;
                    font-size: 0.9rem;
                    flex-shrink: 0;
                }

                .sidebar-user-name {
                    color: #fff;
                    font-weight: 700;
                    font-size: 0.82rem;
                    line-height: 1.2;
                }

                .sidebar-user-role {
                    color: rgba(255, 255, 255, 0.5);
                    font-size: 0.68rem;
                    text-transform: uppercase;
                    letter-spacing: 1px;
                }

                .sidebar-nav {
                    flex: 1;
                    padding: 12px 0;
                    overflow-y: auto;
                }

                .nav-section-label {
                    padding: 8px 20px 2px;
                    color: rgba(255, 255, 255, 0.35);
                    font-size: 0.62rem;
                    letter-spacing: 2px;
                    text-transform: uppercase;
                    font-weight: 700;
                }

                .sidebar-link {
                    display: flex;
                    align-items: center;
                    gap: 10px;
                    padding: 10px 20px;
                    color: rgba(255, 255, 255, 0.72);
                    text-decoration: none;
                    font-size: 0.87rem;
                    font-weight: 500;
                    transition: all 0.2s;
                    border-left: 3px solid transparent;
                }

                .sidebar-link:hover,
                .sidebar-link.active {
                    color: #fff;
                    background: rgba(255, 255, 255, 0.1);
                    border-left-color: #00b4d8;
                }

                .sidebar-link i {
                    width: 16px;
                    text-align: center;
                    font-size: 0.9rem;
                }

                .sidebar-footer {
                    padding: 12px;
                    border-top: 1px solid rgba(255, 255, 255, 0.1);
                }

                .btn-logout {
                    display: flex;
                    align-items: center;
                    gap: 10px;
                    width: 100%;
                    background: rgba(231, 76, 60, 0.15);
                    border: 1px solid rgba(231, 76, 60, 0.4);
                    border-radius: 10px;
                    padding: 10px 16px;
                    color: #ff6b6b;
                    font-size: 0.85rem;
                    font-weight: 700;
                    text-decoration: none;
                    transition: all 0.2s;
                }

                .btn-logout:hover {
                    background: rgba(231, 76, 60, 0.3);
                    color: #ff6b6b;
                }

                /* Staff top navbar (no sidebar) */
                .staff-navbar {
                    background: linear-gradient(90deg, #03045e, #0077b6);
                    padding: 14px 28px;
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                }

                .staff-navbar .brand {
                    font-family: 'Playfair Display', serif;
                    color: #fff;
                    font-size: 1.1rem;
                    text-decoration: none;
                }

                .staff-navbar nav a {
                    color: rgba(255, 255, 255, 0.8);
                    text-decoration: none;
                    font-size: 0.88rem;
                    font-weight: 500;
                    margin-left: 20px;
                    transition: color 0.2s;
                }

                .staff-navbar nav a:hover {
                    color: #fff;
                }

                /* Main area offset for admin sidebar */
                .main-content {
                    margin-left: 240px;
                    padding: 28px;
                    min-height: 100vh;
                }

                /* Staff gets no sidebar offset */
                .main-content-staff {
                    padding: 28px;
                    min-height: 100vh;
                }
            </style>
        </head>

        <body>

            <c:choose>
                <%--=====ADMIN: Sidebar Layout=====--%>
                    <c:when test="${sessionScope.user.role == 'ADMIN'}">

                        <div class="sidebar">
                            <div class="sidebar-brand">
                                <h4><i class="fas fa-umbrella-beach me-2" style="color:#00b4d8;"></i>Ocean View</h4>
                                <small>Resort Management</small>
                            </div>
                            <div class="sidebar-user">
                                <div class="sidebar-avatar">
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.user.fullName}">
                                            ${sessionScope.user.fullName.substring(0,1).toUpperCase()}</c:when>
                                        <c:otherwise>A</c:otherwise>
                                    </c:choose>
                                </div>
                                <div>
                                    <div class="sidebar-user-name">${sessionScope.user.fullName}</div>
                                    <div class="sidebar-user-role"><i class="fas fa-shield-alt me-1"></i>Administrator
                                    </div>
                                </div>
                            </div>
                            <nav class="sidebar-nav">
                                <div class="nav-section-label">Main</div>
                                <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link">
                                    <i class="fas fa-tachometer-alt"></i> Dashboard
                                </a>
                                <div class="nav-section-label">Management</div>
                                <a href="${pageContext.request.contextPath}/admin/staff/list" class="sidebar-link">
                                    <i class="fas fa-users-cog"></i> Staff
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/staff/cards" class="sidebar-link">
                                    <i class="fas fa-id-badge"></i> Staff Directory
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/rooms/list" class="sidebar-link">
                                    <i class="fas fa-door-open"></i> Rooms
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/roomtypes/list" class="sidebar-link">
                                    <i class="fas fa-layer-group"></i> Room Types
                                </a>
                                <div class="nav-section-label">Reservations</div>
                                <a href="${pageContext.request.contextPath}/booking/list" class="sidebar-link">
                                    <i class="fas fa-calendar-check"></i> Reservations
                                </a>
                                <a href="${pageContext.request.contextPath}/booking/add" class="sidebar-link">
                                    <i class="fas fa-calendar-plus"></i> New Booking
                                </a>
                                <div class="nav-section-label">Finance</div>
                                <a href="${pageContext.request.contextPath}/payment/list" class="sidebar-link">
                                    <i class="fas fa-credit-card"></i> Payments
                                </a>
                                <a href="${pageContext.request.contextPath}/booking/list" class="sidebar-link">
                                    <i class="fas fa-file-invoice-dollar"></i> Bills
                                </a>
                                <a href="${pageContext.request.contextPath}/reports" class="sidebar-link">
                                    <i class="fas fa-chart-bar"></i> Reports
                                </a>
                                <div class="nav-section-label">Account</div>
                                <a href="${pageContext.request.contextPath}/profile" class="sidebar-link">
                                    <i class="fas fa-user-circle"></i> My Profile
                                </a>
                                <a href="${pageContext.request.contextPath}/help" class="sidebar-link">
                                    <i class="fas fa-question-circle"></i> Help Guide
                                </a>
                            </nav>
                            <div class="sidebar-footer">
                                <a href="${pageContext.request.contextPath}/logout" class="btn-logout">
                                    <i class="fas fa-sign-out-alt"></i> Logout
                                </a>
                            </div>
                        </div>
                        <div class="main-content">

                    </c:when>
                    <%--=====STAFF: Top Navbar Layout=====--%>
                        <c:otherwise>

                            <div class="staff-navbar">
                                <a href="${pageContext.request.contextPath}/staff/dashboard" class="brand">
                                    <i class="fas fa-umbrella-beach me-2" style="color:#00b4d8;"></i>Ocean View Resort
                                </a>
                                <nav>
                                    <a href="${pageContext.request.contextPath}/staff/dashboard">Dashboard</a>
                                    <a href="${pageContext.request.contextPath}/staff/rooms">Rooms</a>
                                    <a href="${pageContext.request.contextPath}/booking/add">New Booking</a>
                                    <a href="${pageContext.request.contextPath}/booking/list">Reservations</a>
                                    <a href="${pageContext.request.contextPath}/staff/team">Team</a>
                                    <a href="${pageContext.request.contextPath}/reports">Reports</a>
                                    <a href="${pageContext.request.contextPath}/payment/list">Payments</a>
                                    <a href="${pageContext.request.contextPath}/profile">My Profile</a>
                                    <a href="${pageContext.request.contextPath}/help">Help</a>
                                    <a href="${pageContext.request.contextPath}/logout"
                                        style="color:#ff6b6b;margin-left:24px;">
                                        <i class="fas fa-sign-out-alt me-1"></i>Logout
                                    </a>
                                </nav>
                            </div>
                            <div class="main-content-staff">

                        </c:otherwise>
            </c:choose>
