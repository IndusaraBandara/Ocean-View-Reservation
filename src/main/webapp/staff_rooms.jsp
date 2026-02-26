<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="includes/header.jsp" />

<div class="row mb-4">
    <div class="col-md-8">
        <h2 class="fw-bold"><i class="fas fa-door-open me-2 text-primary"></i>All Rooms</h2>
        <p class="text-muted">Browse every room with its status and rate. Staff view is read-only.</p>
    </div>
    <div class="col-md-4 text-end">
        <span class="badge bg-light text-primary border border-primary border-opacity-25 px-3 py-2"
            style="border-radius:12px;font-weight:700;">
            <i class="fas fa-info-circle me-1"></i> View only &mdash; no edits
        </span>
    </div>
</div>

<div class="row g-4" id="roomsContainer">
    <c:forEach var="room" items="${roomList}">
        <div class="col-12">
            <div class="premium-card overflow-hidden border-0 shadow-sm hover-elevate transition-all"
                style="border-radius: 24px; background: #fff;">
                <div class="row g-0">
                    <div class="col-md-4 position-relative">
                        <div class="room-image-container h-100" style="min-height: 220px;">
                            <c:choose>
                                <c:when test="${not empty room.roomImage && room.roomImage != 'default_room.png'}">
                                    <img src="${pageContext.request.contextPath}/assets/rooms/${room.roomImage}"
                                        class="img-fluid w-100 h-100 object-fit-cover" alt="Room ${room.roomNumber}">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/assets/rooms/${room.roomType.roomImage}"
                                        class="img-fluid w-100 h-100 object-fit-cover"
                                        alt="Default for ${room.roomType.typeName}">
                                </c:otherwise>
                            </c:choose>
                            <div class="room-number-overlay position-absolute top-0 start-0 m-3 px-3 py-2 bg-white bg-opacity-90 shadow-sm"
                                style="border-radius: 12px; backdrop-filter: blur(4px);">
                                <span class="small text-uppercase fw-bold text-muted d-block"
                                    style="font-size: 0.65rem; letter-spacing: 1px;">Room No</span>
                                <span class="fw-black h5 mb-0 text-primary" style="font-weight: 900;">#${room.roomNumber}</span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-8 p-4 d-flex flex-column justify-content-between">
                        <div>
                            <div class="d-flex justify-content-between align-items-start mb-2">
                                <div>
                                    <h4 class="fw-bold mb-1" style="color: #03045e;">${room.roomType.typeName}</h4>
                                    <div class="text-muted small">
                                        <i class="fas fa-bed me-1"></i> Premium Resort Class
                                    </div>
                                </div>
                                <c:choose>
                                    <c:when test="${not empty room.activeGuestName}">
                                        <span
                                            class="badge bg-danger bg-opacity-10 text-danger rounded-pill px-4 py-2 border border-danger border-opacity-25"
                                            style="font-size: 0.75rem; font-weight: 700;">
                                            <i class="fas fa-user-lock me-1"></i> BOOKED (until ${room.activeCheckoutDate})
                                        </span>
                                    </c:when>
                                    <c:when test="${room.status == 'AVAILABLE'}">
                                        <span
                                            class="badge bg-success bg-opacity-10 text-success rounded-pill px-4 py-2 border border-success border-opacity-25"
                                            style="font-size: 0.75rem; font-weight: 700;">
                                            <i class="fas fa-check-circle me-1"></i> AVAILABLE
                                        </span>
                                    </c:when>
                                    <c:when test="${room.status == 'OCCUPIED'}">
                                        <span
                                            class="badge bg-primary bg-opacity-10 text-primary rounded-pill px-4 py-2 border border-primary border-opacity-25"
                                            style="font-size: 0.75rem; font-weight: 700;">
                                            <i class="fas fa-user-lock me-1"></i> OCCUPIED
                                        </span>
                                    </c:when>
                                    <c:when test="${room.status == 'CLEANING'}">
                                        <span
                                            class="badge bg-warning bg-opacity-10 text-warning rounded-pill px-4 py-2 border border-warning border-opacity-25"
                                            style="font-size: 0.75rem; font-weight: 700;">
                                            <i class="fas fa-broom me-1"></i> CLEANING
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span
                                            class="badge bg-danger bg-opacity-10 text-danger rounded-pill px-4 py-2 border border-danger border-opacity-25"
                                            style="font-size: 0.75rem; font-weight: 700;">
                                            <i class="fas fa-tools me-1"></i> MAINTENANCE
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <c:if test="${not empty room.activeGuestName}">
                                <div class="text-muted small mt-1">
                                    <i class="fas fa-user me-1 text-danger"></i>
                                    Booked by <strong>${room.activeGuestName}</strong> • Checkout ${room.activeCheckoutDate}
                                </div>
                            </c:if>

                            <div class="row mt-4">
                                <div class="col-sm-5">
                                    <div class="p-3 bg-light rounded-4 border-0">
                                        <div class="small text-muted mb-1" style="font-size: 0.7rem;">RATE PER NIGHT</div>
                                        <div class="fw-bold text-dark" style="font-size: 1.1rem;">
                                            <span class="small text-muted">LKR</span>
                                            ${room.roomType.ratePerNight}0
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-7 d-flex align-items-center">
                                    <div class="px-3">
                                        <ul class="list-inline mb-0 text-muted small">
                                            <li class="list-inline-item me-3"><i class="fas fa-wifi me-1 text-primary"></i> Free WiFi</li>
                                            <li class="list-inline-item me-3"><i class="fas fa-snowflake me-1 text-primary"></i> AC</li>
                                            <li class="list-inline-item"><i class="fas fa-tv me-1 text-primary"></i> Smart TV</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="mt-4 border-top pt-3 d-flex justify-content-between align-items-center">
                            <div class="text-muted small">
                                Last status sync uses live bookings; physical “OCCUPIED” without booking shows as available.
                            </div>
                            <span class="badge bg-light text-primary border border-primary border-opacity-25 px-3 py-2"
                                style="border-radius:12px;font-weight:700;">
                                <i class="fas fa-eye me-1"></i> View only
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>

    <c:if test="${empty roomList}">
        <div class="col-12 text-center py-5">
            <div class="premium-card p-5 border-0 shadow-sm" style="border-radius: 24px;">
                <img src="https://img.icons8.com/clouds/200/000000/empty-box.png" class="mb-3">
                <h4 class="text-muted">No rooms found.</h4>
                <p class="text-muted small">Contact an admin to add rooms to the inventory.</p>
            </div>
        </div>
    </c:if>
</div>

<style>
    .hover-elevate {
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    }

    .hover-elevate:hover {
        transform: translateY(-5px);
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.08) !important;
    }

    .object-fit-cover {
        object-fit: cover;
    }

    .room-image-container:hover img {
        transform: scale(1.05);
    }
</style>

<jsp:include page="includes/footer.jsp" />

