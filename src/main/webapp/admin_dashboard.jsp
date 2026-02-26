<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Admin Dashboard — Ocean View Resort</title>
            <link
                href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700;800&family=Playfair+Display:wght@700&display=swap"
                rel="stylesheet">
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <style>
                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                }

                body {
                    font-family: 'Outfit', sans-serif;
                    background: #f0f4f8;
                    display: flex;
                    min-height: 100vh;
                }

                /* ── SIDEBAR ── */
                .sidebar {
                    width: 260px;
                    min-height: 100vh;
                    background: linear-gradient(180deg, #03045e 0%, #0077b6 100%);
                    display: flex;
                    flex-direction: column;
                    position: fixed;
                    top: 0;
                    left: 0;
                    z-index: 100;
                    transition: width 0.3s;
                }

                .sidebar-brand {
                    padding: 28px 24px 20px;
                    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
                }

                .sidebar-brand h4 {
                    font-family: 'Playfair Display', serif;
                    color: #fff;
                    font-size: 1.2rem;
                    margin: 0;
                }

                .sidebar-brand small {
                    color: rgba(255, 255, 255, 0.55);
                    font-size: 0.72rem;
                    letter-spacing: 1px;
                    text-transform: uppercase;
                }

                /* User chip */
                .sidebar-user {
                    padding: 16px 24px;
                    display: flex;
                    align-items: center;
                    gap: 12px;
                    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
                }

                .sidebar-avatar {
                    width: 40px;
                    height: 40px;
                    border-radius: 50%;
                    background: linear-gradient(135deg, #00b4d8, #90e0ef);
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    color: #fff;
                    font-weight: 800;
                    font-size: 1rem;
                    flex-shrink: 0;
                }

                .sidebar-user-name {
                    color: #fff;
                    font-weight: 700;
                    font-size: 0.88rem;
                    line-height: 1.2;
                }

                .sidebar-user-role {
                    color: rgba(255, 255, 255, 0.55);
                    font-size: 0.72rem;
                    text-transform: uppercase;
                    letter-spacing: 1px;
                }

                /* Nav */
                .sidebar-nav {
                    flex: 1;
                    padding: 16px 0;
                    overflow-y: auto;
                }

                .nav-section-label {
                    padding: 10px 24px 4px;
                    color: rgba(255, 255, 255, 0.4);
                    font-size: 0.65rem;
                    letter-spacing: 2px;
                    text-transform: uppercase;
                    font-weight: 700;
                }

                .sidebar-link {
                    display: flex;
                    align-items: center;
                    gap: 12px;
                    padding: 11px 24px;
                    color: rgba(255, 255, 255, 0.75);
                    text-decoration: none;
                    font-size: 0.9rem;
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
                    width: 18px;
                    text-align: center;
                    font-size: 0.95rem;
                }

                /* Logout at bottom */
                .sidebar-footer {
                    padding: 16px;
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
                    font-size: 0.88rem;
                    font-weight: 700;
                    text-decoration: none;
                    transition: all 0.2s;
                }

                .btn-logout:hover {
                    background: rgba(231, 76, 60, 0.3);
                    color: #ff6b6b;
                }

                /* ── MAIN CONTENT ── */
                .main-wrapper {
                    margin-left: 260px;
                    flex: 1;
                    display: flex;
                    flex-direction: column;
                    min-height: 100vh;
                }

                /* Top bar */
                .top-bar {
                    background: #fff;
                    padding: 16px 28px;
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.06);
                    position: sticky;
                    top: 0;
                    z-index: 50;
                }

                .top-bar h5 {
                    margin: 0;
                    font-weight: 800;
                    color: #03045e;
                    font-size: 1.1rem;
                }

                .top-bar small {
                    color: #6c757d;
                }

                .live-clock {
                    font-size: 0.88rem;
                    color: #0077b6;
                    font-weight: 700;
                }

                /* Page content */
                .page-content {
                    padding: 28px;
                    flex: 1;
                }

                /* Stats */
                .stat-card {
                    background: #fff;
                    border-radius: 16px;
                    padding: 24px;
                    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.06);
                    transition: transform 0.2s;
                }

                .stat-card:hover {
                    transform: translateY(-4px);
                }

                .stat-icon {
                    width: 52px;
                    height: 52px;
                    border-radius: 14px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 1.3rem;
                    margin-bottom: 14px;
                }

                .stat-value {
                    font-size: 2rem;
                    font-weight: 800;
                    color: #03045e;
                }

                .stat-label {
                    font-size: 0.82rem;
                    color: #6c757d;
                    font-weight: 600;
                    text-transform: uppercase;
                    letter-spacing: 0.5px;
                }

                /* Chart card */
                .chart-card {
                    background: #fff;
                    border-radius: 16px;
                    padding: 24px;
                    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.06);
                }

                /* Quick action buttons */
                .quick-btn {
                    display: flex;
                    align-items: center;
                    gap: 12px;
                    padding: 14px 18px;
                    border-radius: 12px;
                    text-decoration: none;
                    font-weight: 600;
                    font-size: 0.9rem;
                    transition: all 0.2s;
                    border: 2px solid transparent;
                }

                .quick-btn:hover {
                    transform: translateX(4px);
                }

                .quick-btn.primary {
                    background: #e8f4fd;
                    color: #0077b6;
                    border-color: #0077b6;
                }

                .quick-btn.success {
                    background: #e8f8f5;
                    color: #2a9d8f;
                    border-color: #2a9d8f;
                }

                .quick-btn.warning {
                    background: #fef9e7;
                    color: #f4a261;
                    border-color: #f4a261;
                }

                .quick-btn.danger {
                    background: #fef2f2;
                    color: #e63946;
                    border-color: #e63946;
                }

                /* ── SUCCESS TOAST ── */
                .toast-container-custom {
                    position: fixed;
                    top: 24px;
                    right: 24px;
                    z-index: 9999;
                }

                .login-toast {
                    background: linear-gradient(135deg, #0077b6, #00b4d8);
                    color: #fff;
                    border-radius: 16px;
                    padding: 20px 26px;
                    box-shadow: 0 10px 40px rgba(0, 119, 182, 0.4);
                    display: flex;
                    align-items: center;
                    gap: 16px;
                    min-width: 320px;
                    animation: slideInRight 0.5s ease, fadeOut 0.5s ease 3.5s forwards;
                }

                .toast-icon {
                    width: 44px;
                    height: 44px;
                    border-radius: 50%;
                    background: rgba(255, 255, 255, 0.2);
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 1.3rem;
                    flex-shrink: 0;
                }

                @keyframes slideInRight {
                    from {
                        opacity: 0;
                        transform: translateX(80px);
                    }

                    to {
                        opacity: 1;
                        transform: translateX(0);
                    }
                }

                @keyframes fadeOut {
                    to {
                        opacity: 0;
                        transform: translateX(80px);
                    }
                }
            </style>
        </head>

        <body>

            <!-- ── LOGIN SUCCESS TOAST ── -->
            <c:if test="${sessionScope.loginSuccess == true}">
                <div class="toast-container-custom" id="loginToast">
                    <div class="login-toast">
                        <div class="toast-icon"><i class="fas fa-check"></i></div>
                        <div>
                            <div style="font-weight:800;font-size:1rem;">Welcome back, ${sessionScope.user.fullName}!
                            </div>
                            <div style="font-size:0.83rem;opacity:0.85;">Successfully logged in as
                                <strong>Admin</strong>. Redirecting to dashboard…</div>
                        </div>
                    </div>
                </div>
                <% session.removeAttribute("loginSuccess"); %>
            </c:if>

            <!-- ── SIDEBAR ── -->
            <div class="sidebar">
                <!-- Brand -->
                <div class="sidebar-brand">
                    <h4><i class="fas fa-umbrella-beach me-2" style="color:#00b4d8;"></i>Ocean View</h4>
                    <small>Resort Management System</small>
                </div>

                <!-- User Chip -->
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
                        <div class="sidebar-user-role"><i class="fas fa-shield-alt me-1"></i>Administrator</div>
                    </div>
                </div>

                <!-- Navigation -->
                <nav class="sidebar-nav">
                    <div class="nav-section-label">Main</div>
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link active">
                        <i class="fas fa-tachometer-alt"></i> Dashboard
                    </a>

                    <div class="nav-section-label">Management</div>
                    <a href="${pageContext.request.contextPath}/admin/staff/list" class="sidebar-link">
                        <i class="fas fa-users-cog"></i> Staff
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

                <!-- Logout -->
                <div class="sidebar-footer">
                    <a href="${pageContext.request.contextPath}/logout" class="btn-logout">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                </div>
            </div>

            <!-- ── MAIN CONTENT ── -->
            <div class="main-wrapper">

                <!-- Top Bar -->
                <div class="top-bar">
                    <div>
                        <h5><i class="fas fa-tachometer-alt me-2 text-primary"></i>Admin Dashboard</h5>
                        <small>Welcome back, ${sessionScope.user.fullName} — Here's what's happening today</small>
                    </div>
                    <div class="text-end">
                        <div class="live-clock" id="liveTime">--:--</div>
                        <div style="font-size:0.78rem;color:#adb5bd;" id="liveDate"></div>
                    </div>
                </div>

                <!-- Dashboard Content -->
                <div class="page-content">

                    <!-- ── STAT CARDS ── -->
                    <div class="row g-4 mb-4">
                        <div class="col-6 col-xl-3">
                            <div class="stat-card">
                                <div class="stat-icon" style="background:#e0f0ff;"><i class="fas fa-users"
                                        style="color:#0077b6;"></i></div>
                                <div class="stat-value" id="statStaff">--</div>
                                <div class="stat-label">Total Staff</div>
                            </div>
                        </div>
                        <div class="col-6 col-xl-3">
                            <div class="stat-card">
                                <div class="stat-icon" style="background:#e8f5e9;"><i class="fas fa-door-open"
                                        style="color:#2a9d8f;"></i></div>
                                <div class="stat-value" id="statRooms">--</div>
                                <div class="stat-label">Rooms &nbsp;<span id="statAvailable"
                                        style="font-size:0.7rem;color:#2a9d8f;font-weight:700;"></span> Free</div>
                            </div>
                        </div>
                        <div class="col-6 col-xl-3">
                            <div class="stat-card">
                                <div class="stat-icon" style="background:#fff3e0;"><i class="fas fa-calendar-check"
                                        style="color:#f4a261;"></i></div>
                                <div class="stat-value" id="statReservations">--</div>
                                <div class="stat-label">Total Reservations</div>
                            </div>
                        </div>
                        <div class="col-6 col-xl-3">
                            <div class="stat-card">
                                <div class="stat-icon" style="background:#fce4ec;"><i class="fas fa-coins"
                                        style="color:#e63946;"></i></div>
                                <div class="stat-value" id="statTodayRev" style="font-size:1.3rem;">--</div>
                                <div class="stat-label">Today's Revenue</div>
                            </div>
                        </div>
                    </div>

                    <!-- ── CHARTS + QUICK ACTIONS ── -->
                    <div class="row g-4">
                        <!-- Chart -->
                        <div class="col-lg-8">
                            <div class="chart-card">
                                <h6 class="fw-bold mb-1" style="color:#03045e;">Reservation Trend</h6>
                                <small class="text-muted">Last 7 days</small>
                                <canvas id="reservationChart" height="200" class="mt-3"></canvas>
                            </div>
                        </div>

                        <!-- Quick Actions -->
                        <div class="col-lg-4">
                            <div class="chart-card h-100">
                                <h6 class="fw-bold mb-3" style="color:#03045e;">Quick Actions</h6>
                                <div class="d-flex flex-column gap-2">
                                    <a href="${pageContext.request.contextPath}/booking/add" class="quick-btn primary">
                                        <i class="fas fa-calendar-plus"></i> New Reservation
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/staff/list"
                                        class="quick-btn success">
                                        <i class="fas fa-users-cog"></i> Manage Staff
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/rooms/list"
                                        class="quick-btn warning">
                                        <i class="fas fa-door-open"></i> Manage Rooms
                                    </a>
                                    <a href="${pageContext.request.contextPath}/payment/list" class="quick-btn danger">
                                        <i class="fas fa-credit-card"></i> View Payments
                                    </a>
                                    <a href="${pageContext.request.contextPath}/reports" class="quick-btn primary"
                                        style="border-color:#7209b7;color:#7209b7;background:#f3e5ff;">
                                        <i class="fas fa-chart-bar"></i> Reports & Analytics
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Revenue Summary Row -->
                    <div class="row g-4 mt-1">
                        <div class="col-md-4">
                            <div class="stat-card d-flex align-items-center gap-3">
                                <div class="stat-icon" style="background:#e8f4fd;margin:0;flex-shrink:0;"><i
                                        class="fas fa-calendar-day" style="color:#0077b6;"></i></div>
                                <div>
                                    <div
                                        style="font-size:0.75rem;color:#6c757d;font-weight:600;text-transform:uppercase;">
                                        This Week</div>
                                    <div style="font-size:1.3rem;font-weight:800;color:#03045e;" id="statWeekRev">--
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="stat-card d-flex align-items-center gap-3">
                                <div class="stat-icon" style="background:#e8f5e9;margin:0;flex-shrink:0;"><i
                                        class="fas fa-calendar-alt" style="color:#2a9d8f;"></i></div>
                                <div>
                                    <div
                                        style="font-size:0.75rem;color:#6c757d;font-weight:600;text-transform:uppercase;">
                                        This Month</div>
                                    <div style="font-size:1.3rem;font-weight:800;color:#03045e;" id="statMonthRev">--
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="stat-card d-flex align-items-center gap-3">
                                <div class="stat-icon" style="background:#fff3e0;margin:0;flex-shrink:0;"><i
                                        class="fas fa-coins" style="color:#f4a261;"></i></div>
                                <div>
                                    <div
                                        style="font-size:0.75rem;color:#6c757d;font-weight:600;text-transform:uppercase;">
                                        All Time Revenue</div>
                                    <div style="font-size:1.3rem;font-weight:800;color:#03045e;" id="statTotalRev">--
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div><!-- /page-content -->
            </div><!-- /main-wrapper -->

            <!-- Bootstrap + Chart.js -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
            <script>
                // Live Clock
                function updateClock() {
                    const now = new Date();
                    document.getElementById('liveTime').textContent = now.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
                    document.getElementById('liveDate').textContent = now.toLocaleDateString([], { weekday: 'long', day: 'numeric', month: 'long', year: 'numeric' });
                }
                setInterval(updateClock, 1000);
                updateClock();

                // Auto-hide toast after 4 seconds
                setTimeout(() => {
                    const t = document.getElementById('loginToast');
                    if (t) t.style.display = 'none';
                }, 4500);

                // Live Stats from API
                fetch('${pageContext.request.contextPath}/api/dashboard-stats')
                    .then(r => r.json())
                    .then(data => {
                        document.getElementById('statStaff').textContent = data.totalStaff || 0;
                        document.getElementById('statRooms').textContent = data.totalRooms || 0;
                        document.getElementById('statAvailable').textContent = data.availableRooms || 0;
                        document.getElementById('statReservations').textContent = data.totalReservations || 0;
                        document.getElementById('statTodayRev').textContent = 'LKR ' + Number(data.todayRevenue || 0).toLocaleString();
                        document.getElementById('statWeekRev').textContent = 'LKR ' + Number(data.weekRevenue || 0).toLocaleString();
                        document.getElementById('statMonthRev').textContent = 'LKR ' + Number(data.monthRevenue || 0).toLocaleString();
                        document.getElementById('statTotalRev').textContent = 'LKR ' + Number(data.totalRevenue || 0).toLocaleString();

                        // Reservation Trend Chart
                        const daily = data.dailyReservations || [];
                        new Chart(document.getElementById('reservationChart').getContext('2d'), {
                            type: 'line',
                            data: {
                                labels: daily.map(d => d.day),
                                datasets: [{
                                    label: 'Reservations',
                                    data: daily.map(d => d.count),
                                    borderColor: '#0077b6',
                                    backgroundColor: 'rgba(0,119,182,0.08)',
                                    fill: true,
                                    tension: 0.4,
                                    pointBackgroundColor: '#00b4d8',
                                    pointRadius: 5
                                }]
                            },
                            options: {
                                responsive: true,
                                plugins: { legend: { display: false } },
                                scales: { y: { beginAtZero: true, ticks: { stepSize: 1 } } }
                            }
                        });
                    })
                    .catch(e => console.error('Dashboard stats error:', e));
            </script>
        </body>

        </html>