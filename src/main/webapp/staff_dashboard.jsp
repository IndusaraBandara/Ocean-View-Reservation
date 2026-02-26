<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="includes/header.jsp" />

<!-- Staff login success toast -->
<style>
    .toast-container-custom {
        position: fixed;
        top: 24px;
        right: 24px;
        z-index: 9999;
    }

    .login-toast {
        background: linear-gradient(135deg, #00b4d8, #48cae4);
        color: #fff;
        border-radius: 16px;
        padding: 18px 22px;
        box-shadow: 0 10px 40px rgba(0, 180, 216, 0.35);
        display: flex;
        align-items: center;
        gap: 14px;
        min-width: 300px;
        animation: slideInRight 0.5s ease, fadeOut 0.5s ease 3.5s forwards;
    }

    .toast-icon {
        width: 42px;
        height: 42px;
        border-radius: 50%;
        background: rgba(255, 255, 255, 0.2);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.2rem;
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

<c:if test="${sessionScope.loginSuccess == true}">
    <div class="toast-container-custom" id="loginToast">
        <div class="login-toast">
            <div class="toast-icon"><i class="fas fa-check"></i></div>
            <div>
                <div style="font-weight:800;font-size:1rem;">Welcome back, ${sessionScope.user.fullName}!</div>
                <div style="font-size:0.83rem;opacity:0.9;">Successfully logged in as <strong>Staff</strong>.</div>
            </div>
        </div>
    </div>
    <% session.removeAttribute("loginSuccess"); %>
</c:if>

        <div class="row mb-4">
            <div class="col-md-6">
                <h1 class="fw-bold">Operations <span class="text-secondary">Dashboard</span></h1>
                <p class="text-muted">Hello, ${sessionScope.user.fullName}. Manage your guest bookings efficiently.</p>
            </div>
            <div class="col-md-6 text-end">
                <a href="${pageContext.request.contextPath}/booking/add" class="btn btn-primary lg-btn">
                    <i class="fas fa-plus me-2"></i> NEW RESERVATION
                </a>
                <a href="${pageContext.request.contextPath}/reports" class="btn btn-outline-primary ms-2">
                    <i class="fas fa-chart-bar me-1"></i> Reports
                </a>
            </div>
        </div>

        <div class="row g-4 mb-4">
            <div class="col-md-4">
                <div class="premium-card p-4 border-start border-primary border-4">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <div class="stat-label">Today's Check-ins</div>
                            <div class="stat-value">12</div>
                        </div>
                        <i class="fas fa-sign-in-alt fa-2x text-primary opacity-25"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="premium-card p-4 border-start border-success border-4">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <div class="stat-label">Available Rooms</div>
                            <div class="stat-value">18</div>
                        </div>
                        <i class="fas fa-bed fa-2x text-success opacity-25"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="premium-card p-4 border-start border-warning border-4">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <div class="stat-label">Pending Invoices</div>
                            <div class="stat-value">04</div>
                        </div>
                        <i class="fas fa-file-invoice-dollar fa-2x text-warning opacity-25"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-12">
                <div class="premium-card p-4">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h5 class="fw-bold mb-0">Recent Reservations</h5>
                        <a href="${pageContext.request.contextPath}/booking/list"
                            class="btn btn-sm btn-link text-decoration-none">View All</a>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>Reservation #</th>
                                    <th>Guest Name</th>
                                    <th>Check In</th>
                                    <th>Check Out</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="res" items="${reservations}">
                                    <tr>
                                        <td><span class="fw-bold">${res.reservationNumber}</span></td>
                                        <td>${res.guest.name}</td>
                                        <td>${res.checkInDate}</td>
                                        <td>${res.checkOutDate}</td>
                                        <td>
                                            <span class="badge ${res.status == 'BOOKED' ? 'bg-info' : 'bg-success'}">
                                                ${res.status}
                                            </span>
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/booking/view?id=${res.reservationNumber}"
                                                class="btn btn-sm btn-outline-primary">View</a>
                                            <a href="${pageContext.request.contextPath}/payment/bill?id=${res.reservationNumber}"
                                                class="btn btn-sm btn-outline-success">Bill</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty reservations}">
                                    <tr>
                                        <td colspan="6" class="text-center py-4 text-muted">No recent reservations
                                            found.</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div class="row mt-4">
            <div class="col-md-6">
                <div class="premium-card p-4 bg-primary text-white">
                    <h5 class="fw-bold"><i class="fas fa-question-circle me-2"></i> Need Help?</h5>
                    <p class="small opacity-75">Check the system guidelines for new staff members and operational
                        procedures.</p>
                    <a href="#" class="btn btn-sm btn-light mt-2">Open Help Guide</a>
                </div>
            </div>
        </div>

        <script>
            // Auto-hide login toast after 4.5s
            setTimeout(() => {
                const t = document.getElementById('loginToast');
                if (t) t.style.display = 'none';
            }, 4500);
        </script>

        <jsp:include page="includes/footer.jsp" />
