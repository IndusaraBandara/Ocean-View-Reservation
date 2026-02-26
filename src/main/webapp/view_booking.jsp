<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <jsp:include page="includes/header.jsp" />

            <div class="row mb-4 animate__animated animate__fadeIn">
                <div class="col">
                    <a href="${pageContext.request.contextPath}/booking/list"
                        class="text-decoration-none text-muted small hover-translate">
                        <i class="fas fa-arrow-left me-1"></i> Back to Reservations
                    </a>
                    <h2 class="fw-bold mt-2"><i class="fas fa-bookmark me-2 text-primary"></i>Reservation Detail</h2>
                </div>
            </div>

            <c:if test="${not empty param.success}">
                <div class="alert alert-success alert-dismissible fade show shadow-sm border-0 mb-4"
                    style="border-radius: 12px; background: #e8f5e9; color: #2e7d32;" role="alert">
                    <i class="fas fa-check-circle me-2"></i>
                    <c:choose>
                        <c:when test="${param.success == 'payment'}">Payment completed and booking marked as paid.</c:when>
                        <c:when test="${param.success == 'add'}">Reservation created successfully.</c:when>
                    </c:choose>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <c:if test="${not empty param.error}">
                <div class="alert alert-danger alert-dismissible fade show shadow-sm border-0 mb-4"
                    style="border-radius: 12px; background: #fff4f4; color: #c1121f;" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i>
                    ${param.error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <c:if test="${not empty reservation}">
                <div class="row g-4 pb-5">
                    <!-- Reservation Dossier -->
                    <div class="col-lg-8 animate__animated animate__fadeInUp">
                        <div class="premium-card overflow-hidden"
                            style="border-radius: 25px; box-shadow: 0 15px 35px rgba(0,0,0,0.05);">
                            <div class="p-5">
                                <div class="d-flex justify-content-between align-items-start mb-4">
                                    <div>
                                        <c:choose>
                                            <c:when test="${reservation.status == 'BOOKED'}">
                                                <span
                                                    class="badge bg-warning bg-opacity-10 text-warning px-3 py-2 rounded-pill mb-3"
                                                    style="font-size: 0.75rem; font-weight: 700;">
                                                    <i class="fas fa-clock me-1"></i> PENDING PAYMENT
                                                </span>
                                            </c:when>
                                            <c:when test="${reservation.status == 'CHECKED_IN'}">
                                                <span
                                                    class="badge bg-info bg-opacity-10 text-info px-3 py-2 rounded-pill mb-3"
                                                    style="font-size: 0.75rem; font-weight: 700;">
                                                    <i class="fas fa-key me-1"></i> GUEST CHECKED IN
                                                </span>
                                            </c:when>
                                            <c:when test="${reservation.status == 'CHECKED_OUT'}">
                                                <span
                                                    class="badge bg-success bg-opacity-10 text-success px-3 py-2 rounded-pill mb-3"
                                                    style="font-size: 0.75rem; font-weight: 700;">
                                                    <i class="fas fa-file-invoice-dollar me-1"></i> COMPLETED & PAID
                                                </span>
                                            </c:when>
                                            <c:when test="${reservation.status == 'CANCELLED'}">
                                                <span
                                                    class="badge bg-danger bg-opacity-10 text-danger px-3 py-2 rounded-pill mb-3"
                                                    style="font-size: 0.75rem; font-weight: 700;">
                                                    <i class="fas fa-times-circle me-1"></i> CANCELLED
                                                </span>
                                            </c:when>
                                        </c:choose>
                                        <h1 class="fw-800 mb-0 text-dark" style="letter-spacing: -1px;">
                                            ${reservation.reservationNumber}</h1>
                                    </div>
                                    <div class="text-end">
                                        <div class="text-muted small fw-bold text-uppercase">Creation Date</div>
                                        <div class="fw-bold lead" style="color: #03045e;">
                                            <fmt:formatDate value="${reservation.createdAt}" pattern="MMM dd, yyyy" />
                                        </div>
                                    </div>
                                </div>

                                <div class="row g-5">
                                    <div class="col-md-6">
                                        <div class="p-4 bg-light bg-opacity-50"
                                            style="border-radius: 20px; border: 1px solid #f1f5f9;">
                                            <h6 class="text-muted small fw-800 text-uppercase mb-3"
                                                style="letter-spacing: 1px;">Guest Profile</h6>
                                            <div class="d-flex align-items-center mb-2">
                                                <div class="avatar-sm me-3 bg-white shadow-sm"
                                                    style="width: 48px; height: 48px; border-radius: 12px; display: flex; align-items: center; justify-content: center; color: #7e22ce;">
                                                    <i class="fas fa-id-card fa-lg"></i>
                                                </div>
                                                <div>
                                                    <div class="fw-bold fs-5" style="color: #1e293b;">
                                                        ${reservation.guest.name}</div>
                                                    <div class="text-muted small"><i class="fas fa-phone-alt me-1"></i>
                                                        ${reservation.guest.contactNumber}</div>
                                                    <div class="text-muted small"><i class="fas fa-passport me-1"></i>
                                                        ${reservation.guest.nic}</div>
                                                </div>
                                            </div>
                                            <div class="mt-3 text-muted small p-2 rounded bg-white border border-light">
                                                <i class="fas fa-map-marker-alt me-2"></i> ${reservation.guest.address}
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="p-4 bg-light bg-opacity-50"
                                            style="border-radius: 20px; border: 1px solid #f1f5f9;">
                                            <h6 class="text-muted small fw-800 text-uppercase mb-3"
                                                style="letter-spacing: 1px;">Room Allocation</h6>
                                            <div class="d-flex align-items-center mb-2">
                                                <div class="avatar-sm me-3 bg-white shadow-sm"
                                                    style="width: 48px; height: 48px; border-radius: 12px; display: flex; align-items: center; justify-content: center; color: #f59e0b;">
                                                    <i class="fas fa-door-closed fa-lg"></i>
                                                </div>
                                                <div>
                                                    <div class="fw-bold fs-5" style="color: #1e293b;">Room
                                                        ${reservation.room.roomNumber}</div>
                                                    <div class="badge bg-warning bg-opacity-10 text-warning px-2 py-1 rounded small"
                                                        style="font-weight: 700; font-size: 0.65rem;">
                                                        ${reservation.room.roomType.typeName.toUpperCase()}
                                                    </div>
                                                </div>
                                            </div>
                                            <div
                                                class="mt-3 text-muted small p-2 rounded bg-white border border-light d-flex justify-content-between">
                                                <span><i class="fas fa-tag me-1 text-muted"></i> Nightly Rate</span>
                                                <span class="fw-bold text-dark">LKR
                                                    <fmt:formatNumber value="${reservation.room.roomType.ratePerNight}"
                                                        pattern="#,###.00" />
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <c:if test="${reservation.status == 'BOOKED'}">
                                    <div class="alert alert-warning bg-warning bg-opacity-10 border-0 mt-4"
                                        style="border-radius: 14px; color: #d97706;">
                                        <i class="fas fa-info-circle me-2"></i>
                                        Payment is pending. Please complete payment to confirm the stay and mark as paid.
                                    </div>
                                </c:if>

                                <div class="row g-4 mt-2">
                                    <div class="col-md-4">
                                        <div class="card border-0 bg-success bg-opacity-10 p-3 text-center"
                                            style="border-radius: 18px;">
                                            <div class="small fw-bold text-success text-uppercase mb-1">Check-In</div>
                                            <div class="fs-5 fw-800 text-success">${reservation.checkInDate}</div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="card border-0 bg-danger bg-opacity-10 p-3 text-center"
                                            style="border-radius: 18px;">
                                            <div class="small fw-bold text-danger text-uppercase mb-1">Check-Out</div>
                                            <div class="fs-5 fw-800 text-danger">${reservation.checkOutDate}</div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="card border-0 bg-primary p-3 text-center text-white"
                                            style="border-radius: 18px; box-shadow: 0 10px 20px rgba(0, 119, 182, 0.2);">
                                            <div class="small fw-bold opacity-75 text-uppercase mb-1">Total Due</div>
                                            <div class="fs-5 fw-800">LKR
                                                <fmt:formatNumber value="${reservation.totalCost}" pattern="#,###.00" />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="mt-3 text-muted small">
                                    <i class="fas fa-user-edit me-1 text-primary"></i>
                                    Created by
                                    <strong>
                                        <c:choose>
                                            <c:when test="${not empty reservation.creator.fullName}">${reservation.creator.fullName}</c:when>
                                            <c:otherwise>System</c:otherwise>
                                        </c:choose>
                                    </strong>
                                    on <fmt:formatDate value="${reservation.createdAt}" pattern="MMM dd, yyyy HH:mm" />
                                </div>
                            </div>

                            <!-- Bottom Decorative Bar -->
                            <div style="height: 6px; background: linear-gradient(90deg, #03045e, #00b4d8);"></div>
                        </div>
                    </div>

                    <!-- Lateral Control Panel -->
                    <div class="col-lg-4 animate__animated animate__fadeInRight">
                        <div class="premium-card p-4 h-100" style="border-radius: 25px;">
                            <h5 class="fw-bold mb-4" style="color: #03045e;">Operation Center</h5>

                            <c:if test="${not empty payment}">
                                <div class="alert alert-success bg-success bg-opacity-10 border-0 mb-4"
                                    style="border-radius: 14px; color: #2e7d32;">
                                    <div class="fw-bold mb-1"><i class="fas fa-receipt me-2"></i>Last Payment</div>
                                    <div class="small text-muted">Method: <strong>${payment.paymentMethod}</strong></div>
                                    <div class="small text-muted">Amount: <strong>LKR
                                            <fmt:formatNumber value="${payment.amount}" pattern="#,###.00" /></strong>
                                    </div>
                                    <c:if test="${not empty payment.paymentDate}">
                                        <div class="small text-muted">Date:
                                            <fmt:formatDate value="${payment.paymentDate}" pattern="MMM dd, yyyy HH:mm" />
                                        </div>
                                    </c:if>
                                </div>
                            </c:if>

                            <div class="d-grid gap-3">
                                <a href="${pageContext.request.contextPath}/payment/bill?id=${reservation.reservationNumber}"
                                    class="btn btn-outline-primary py-3 w-100 d-flex align-items-center justify-content-center"
                                    style="border-radius: 15px; border-width: 2px; font-weight: 700;">
                                    <i class="fas fa-file-invoice-dollar me-3 fa-lg"></i> Generate Tax Invoice
                                </a>

                                <c:if test="${reservation.status == 'BOOKED'}">
                                    <button
                                        class="btn btn-success py-3 w-100 d-flex align-items-center justify-content-center shadow-sm"
                                        style="border-radius: 15px; font-weight: 700;" data-bs-toggle="modal"
                                        data-bs-target="#paymentModal">
                                        <i class="fas fa-credit-card me-3 fa-lg"></i> Complete Payment
                                    </button>
                                </c:if>

                                <c:if test="${reservation.status == 'BOOKED'}">
                                    <a href="${pageContext.request.contextPath}/booking/cancel?id=${reservation.reservationNumber}"
                                        class="btn btn-light py-3 w-100 d-flex align-items-center justify-content-center text-danger"
                                        style="border-radius: 15px; font-weight: 700; background: #fff5f5;"
                                        onclick="return confirm('Immediately cancel this reservation?')">
                                        <i class="fas fa-ban me-3 fa-lg"></i> Cancel Booking
                                    </a>
                                </c:if>

                                <hr class="my-3">

                                <a href="${pageContext.request.contextPath}/booking/list"
                                    class="btn btn-light py-2 w-100 d-flex align-items-center justify-content-center text-muted"
                                    style="border-radius: 12px; font-weight: 600;">
                                    <i class="fas fa-list-ul me-2"></i> All Reservations
                                </a>
                            </div>

                            <div class="mt-5 p-4 bg-light rounded-4 text-center">
                                <img src="https://img.icons8.com/isometric/100/hospitality--v1.png" style="width: 80px;"
                                    class="mb-3 opacity-75">
                                <p class="small text-muted mb-0">Manage stay status and financial records with ease. All
                                    actions are logged for audit purposes.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Payment Modal -->
            <div class="modal fade" id="paymentModal" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content border-0 shadow-lg" style="border-radius: 25px; background: #fff;">
                        <div class="modal-header border-0 px-4 pt-4">
                            <h5 class="modal-title fw-800" style="color: #03045e;">Process Transaction</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <form action="${pageContext.request.contextPath}/payment/process" method="post">
                            <input type="hidden" name="reservationNumber" value="${reservation.reservationNumber}">
                            <input type="hidden" name="amount" value="${reservation.totalCost}">
                            <div class="modal-body px-4">
                                <div class="p-4 bg-primary bg-opacity-10 rounded-4 mb-4 text-center">
                                    <div class="small text-muted fw-bold text-uppercase mb-1">Final Amount Due</div>
                                    <div class="h2 fw-800 text-primary mb-0">LKR
                                        <fmt:formatNumber value="${reservation.totalCost}" pattern="#,###.00" />
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label small fw-bold text-muted">PAYMENT METHOD</label>
                                    <select class="form-select bg-light border-0 py-3" style="border-radius: 12px;"
                                        name="paymentMethod" required>
                                        <option value="CASH">Cash Payment</option>
                                        <option value="CARD">Credit / Debit Card</option>
                                        <option value="ONLINE">Online Transfer</option>
                                    </select>
                                </div>

                                <div class="p-3 bg-light rounded-3 d-flex align-items-center">
                                    <i class="fas fa-info-circle text-muted me-3 fa-lg"></i>
                                    <small class="text-muted">By confirming, the reservation status will be updated to
                                        <b>CHECKED OUT</b> automatically.</small>
                                </div>
                            </div>
                            <div class="modal-footer border-0 px-4 pb-4">
                                <button type="button" class="btn btn-light px-4 py-2" data-bs-dismiss="modal"
                                    style="border-radius: 12px;">Review Later</button>
                                <button type="submit" class="btn btn-primary px-5 py-2 shadow-sm"
                                    style="border-radius: 12px; font-weight: 700;">Confirm & Pay</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <jsp:include page="includes/footer.jsp" />
