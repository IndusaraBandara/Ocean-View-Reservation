<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <jsp:include page="includes/header.jsp" />

            <div class="position-relative mb-4">
                <div class="rounded-4 p-4 p-md-5 text-white"
                    style="background: linear-gradient(135deg, #0f172a, #2563eb); box-shadow: 0 18px 40px rgba(15, 23, 42, 0.35);">
                    <div class="d-flex align-items-center justify-content-between flex-wrap gap-3">
                        <div>
                            <div class="badge bg-white text-primary fw-bold px-3 py-2 mb-2">Live Bookings</div>
                            <h2 class="fw-bold mb-1"><i class="fas fa-calendar-check me-2"></i>All Reservations</h2>
                            <p class="mb-0 opacity-75">Monitor bookings, guest details, and stay statuses in one place.</p>
                        </div>
                        <a href="${pageContext.request.contextPath}/booking/add" class="btn btn-light text-primary fw-bold shadow-sm"
                            style="border-radius: 12px; background: #e0f2fe;">
                            <i class="fas fa-plus me-1"></i> New Booking
                        </a>
                    </div>
                </div>
            </div>

            <c:if test="${not empty param.success}">
                <div class="toast-container position-fixed top-0 end-0 p-3" style="z-index: 9999;">
                    <div class="toast align-items-center text-white bg-success border-0" role="alert" id="resToast">
                        <div class="d-flex">
                            <div class="toast-body">
                                <i class="fas fa-check-circle me-2"></i>
                                <c:choose>
                                    <c:when test="${param.success == 'add'}">Booking created successfully!</c:when>
                                    <c:when test="${param.success == 'cancel'}">Reservation has been cancelled.</c:when>
                                    <c:otherwise>Operation completed successfully!</c:otherwise>
                                </c:choose>
                            </div>
                            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"
                                aria-label="Close"></button>
                        </div>
                    </div>
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

            <div class="glass-card p-4 border-0 shadow-sm" style="border-radius: 20px; background: #fff;">
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr
                                style="font-size: 0.82rem; letter-spacing: 0.5px; text-transform: uppercase; color: #6c757d;">
                                <th class="border-0 px-3">Res #</th>
                                <th class="border-0">Guest</th>
                                <th class="border-0">NIC/Passport</th>
                                <th class="border-0">Dates</th>
                                <th class="border-0">Created By</th>
                                <th class="border-0 text-center">Status</th>
                                <th class="border-0 text-end">Amount</th>
                                <th class="border-0 text-end px-3">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="res" items="${reservations}">
                                <tr style="border-bottom: 1px solid #f8f9fa;">
                                    <td class="px-3">
                                        <span class="fw-bold" style="color: #03045e;">${res.reservationNumber}</span>
                                    </td>
                                    <td>
                                        <div class="fw-bold" style="color: #495057;">${res.guest.name}</div>
                                        <small class="text-muted"><i class="fas fa-clock me-1"></i>Booked:
                                            <fmt:formatDate value="${res.createdAt}" pattern="MMM dd, HH:mm" />
                                        </small>
                                    </td>
                                    <td class="text-muted">
                                        <i class="fas fa-passport me-1"></i>
                                        <c:out value="${res.guest.nic}" default="—" />
                                    </td>
                                    <td>
                                        <div style="font-size: 0.88rem; color: #6c757d;">
                                            <i class="fas fa-sign-in-alt me-1 text-success"></i> ${res.checkInDate}<br>
                                            <i class="fas fa-sign-out-alt me-1 text-danger"></i> ${res.checkOutDate}
                                        </div>
                                    </td>
                                    <td>
                                        <div class="text-muted small">
                                            <i class="fas fa-user-circle me-1"></i>
                                            <c:choose>
                                                <c:when test="${not empty res.creator.fullName}">${res.creator.fullName}</c:when>
                                                <c:otherwise>System</c:otherwise>
                                            </c:choose>
                                        </div>
                                    </td>
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${res.status == 'BOOKED'}">
                                                <span
                                                    class="badge bg-primary bg-opacity-10 text-primary px-3 py-2 rounded-pill"
                                                    style="font-size: 0.72rem; font-weight: 700;">BOOKED</span>
                                            </c:when>
                                            <c:when test="${res.status == 'CHECKED_IN'}">
                                                <span
                                                    class="badge bg-info bg-opacity-10 text-info px-3 py-2 rounded-pill"
                                                    style="font-size: 0.72rem; font-weight: 700;">CHECKED IN</span>
                                            </c:when>
                                            <c:when test="${res.status == 'CHECKED_OUT'}">
                                                <span
                                                    class="badge bg-success bg-opacity-10 text-success px-3 py-2 rounded-pill"
                                                    style="font-size: 0.72rem; font-weight: 700;">CHECKED OUT</span>
                                            </c:when>
                                            <c:when test="${res.status == 'CANCELLED'}">
                                                <span
                                                    class="badge bg-danger bg-opacity-10 text-danger px-3 py-2 rounded-pill"
                                                    style="font-size: 0.72rem; font-weight: 700;">CANCELLED</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span
                                                    class="badge bg-secondary bg-opacity-10 text-secondary px-3 py-2 rounded-pill"
                                                    style="font-size: 0.72rem; font-weight: 700;">${res.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-end">
                                        <span class="fw-bold" style="color: #2a9d8f;">LKR
                                            <fmt:formatNumber value="${res.totalCost}" pattern="#,###.00" />
                                        </span>
                                    </td>
                                    <td class="text-end px-3">
                                        <div class="d-flex justify-content-end gap-2">
                                            <a href="${pageContext.request.contextPath}/booking/view?id=${res.reservationNumber}"
                                                class="btn btn-sm btn-light shadow-none"
                                                style="width: 32px; height: 32px; border-radius: 8px; color: #0077b6; background: #e8f4fd;">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            <c:if test="${res.status != 'CANCELLED' && res.status != 'CHECKED_OUT'}">
                                                <a href="${pageContext.request.contextPath}/booking/cancel?id=${res.reservationNumber}"
                                                    class="btn btn-sm btn-light shadow-none"
                                                    style="width: 32px; height: 32px; border-radius: 8px; color: #e63946; background: #fef2f2;"
                                                    onclick="return confirm('Are you sure you want to cancel this reservation?')">
                                                    <i class="fas fa-times"></i>
                                                </a>
                                            </c:if>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty reservations}">
                                <tr>
                                    <td colspan="6" class="text-center py-5">
                                        <span class="text-muted">No reservations found.</span>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>

            <jsp:include page="includes/footer.jsp" />




