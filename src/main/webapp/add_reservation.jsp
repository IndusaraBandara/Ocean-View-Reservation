<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <jsp:include page="includes/header.jsp" />

        <div class="position-relative mb-4">
            <div class="rounded-4 p-4 p-md-5 text-white"
                style="background: linear-gradient(135deg, #0f172a, #1e3a8a); box-shadow: 0 18px 40px rgba(15, 23, 42, 0.35);">
                <div class="d-flex align-items-center justify-content-between flex-wrap gap-3">
                    <div>
                        <div class="badge bg-white text-primary fw-bold px-3 py-2 mb-2">Step 1 - Create Booking</div>
                        <h2 class="fw-bold mb-1"><i class="fas fa-calendar-plus me-2"></i>New Reservation</h2>
                        <p class="mb-0 opacity-75">Capture guest details, pick a room, and confirm dates in one flow.</p>
                    </div>
                    <div class="d-flex align-items-center gap-3">
                        <div class="text-center">
                            <div class="fs-3 fw-bold">01</div>
                            <div class="small text-uppercase opacity-75">Guest</div>
                        </div>
                        <div class="text-center">
                            <div class="fs-3 fw-bold">02</div>
                            <div class="small text-uppercase opacity-75">Room</div>
                        </div>
                        <div class="text-center">
                            <div class="fs-3 fw-bold">03</div>
                            <div class="small text-uppercase opacity-75">Review</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <c:if test="${not empty param.success}">
            <div class="toast-container position-fixed top-0 end-0 p-3" style="z-index: 9999;">
                <div class="toast align-items-center text-white bg-success border-0" role="alert" id="successToast">
                    <div class="d-flex">
                        <div class="toast-body">
                            <i class="fas fa-check-circle me-2"></i>
                            Reservation created successfully!
                            <c:if test="${not empty param.reservationNumber}">
                                <span class="fw-bold">Ref: ${param.reservationNumber}</span>
                            </c:if>
                        </div>
                        <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"
                            aria-label="Close"></button>
                    </div>
                </div>
            </div>
        </c:if>

        <c:if test="${fallbackRooms == true}">
            <div class="alert alert-warning shadow-sm border-0 mb-3" style="border-radius:12px;">
                <i class="fas fa-info-circle me-2"></i>No rooms marked available right now; showing all rooms instead.
                Please double-check status before confirming.
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

        <style>
            .glass-card {
                background: rgba(255, 255, 255, 0.75);
                backdrop-filter: blur(8px);
                border: 1px solid rgba(255, 255, 255, 0.35);
            }
            .section-label {
                letter-spacing: 0.08em;
                font-size: 0.72rem;
            }
            .mini-chip {
                border-radius: 12px;
                background: #fff;
                border: 1px solid #e2e8f0;
                padding: 10px 12px;
                box-shadow: 0 6px 16px rgba(15, 23, 42, 0.06);
                height: 100%;
            }
            .mini-chip .chip-label {
                display: block;
                font-size: 0.72rem;
                letter-spacing: 0.03em;
                color: #94a3b8;
                text-transform: uppercase;
            }
            .mini-chip .chip-value {
                display: block;
                font-weight: 700;
                color: #0f172a;
                margin-top: 2px;
            }
        </style>

        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="glass-card p-4 p-md-5 mb-4">
                    <form action="${pageContext.request.contextPath}/booking/add" method="post" id="reservationForm">

                        <div class="row g-4">
                            <!-- Guest card -->
                            <div class="col-lg-6">
                                <div class="premium-card h-100 p-4 border-0 shadow-sm" style="border-radius: 14px;">
                                    <div class="d-flex align-items-center mb-2">
                                        <div class="badge bg-primary bg-opacity-10 text-primary section-label me-2">Guest</div>
                                        <h5 class="fw-bold mb-0" style="color:#0f172a;">Guest Information</h5>
                                    </div>
                                    <div class="row g-3">
                                        <div class="col-12">
                                            <label class="form-label small fw-bold text-muted">Full Name</label>
                                            <input type="text" class="form-control" name="guestName" placeholder="Enter full name" required>
                                        </div>
                                        <div class="col-12">
                                            <label class="form-label small fw-bold text-muted">NIC / Passport</label>
                                            <input type="text" class="form-control" name="nic" placeholder="e.g. 991234567V or Passport #" required>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label small fw-bold text-muted">Contact Number</label>
                                            <input type="text" class="form-control" name="contactNumber" placeholder="+94 XX XXX XXXX" required>
                                        </div>
                                        <div class="col-12">
                                            <label class="form-label small fw-bold text-muted">Address</label>
                                            <textarea class="form-control" name="address" rows="2" placeholder="Full address"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Room card -->
                            <div class="col-lg-6">
                                <div class="premium-card h-100 p-4 border-0 shadow-sm" style="border-radius: 14px;">
                                    <div class="d-flex align-items-center mb-2">
                                        <div class="badge bg-primary bg-opacity-10 text-primary section-label me-2">Stay</div>
                                        <h5 class="fw-bold mb-0" style="color:#0f172a;">Room & Dates</h5>
                                    </div>
                                    <div class="row g-3">
                                        <div class="col-12">
                                            <label class="form-label small fw-bold text-muted">Room</label>
                                            <select class="form-select" name="roomId" id="roomSelect" required>
                                                <option value="">-- Select Room --</option>
                                                <c:forEach var="room" items="${availableRooms}">
                                                    <option value="${room.id}" data-rate="${room.roomType.ratePerNight}">
                                                        Room ${room.roomNumber} - ${room.roomType.typeName} (LKR ${room.roomType.ratePerNight}/night)
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label small fw-bold text-muted">Check-in</label>
                                            <input type="date" class="form-control" name="checkInDate" id="checkInDate" required>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label small fw-bold text-muted">Check-out</label>
                                            <input type="date" class="form-control" name="checkOutDate" id="checkOutDate" required>
                                        </div>
                                    </div>

                                    <div class="bg-light rounded-3 p-3 mt-3" id="costSummary" style="display: none;">
                                        <div class="row text-center g-2">
                                            <div class="col-4">
                                                <div class="small text-muted">Rate / Night</div>
                                                <div class="fw-bold text-primary" id="rateDisplay">LKR 0</div>
                                            </div>
                                            <div class="col-4">
                                                <div class="small text-muted">Nights</div>
                                                <div class="fw-bold" id="nightsDisplay">0</div>
                                            </div>
                                            <div class="col-4">
                                                <div class="small text-muted">Total</div>
                                                <div class="fw-bold text-success" id="totalDisplay">LKR 0</div>
                                            </div>
                                        </div>
                                    </div>
                                    <input type="hidden" name="totalCost" id="totalCostInput">
                                </div>
                            </div>
                        </div>

                        <!-- Reservation Details Preview -->
                        <div class="premium-card p-4 mt-4 border-0 shadow-sm" style="border-radius: 16px; background: linear-gradient(135deg, #f8fafc, #eef2ff);">
                            <div class="d-flex align-items-center justify-content-between mb-3">
                                <div>
                                    <div class="badge bg-secondary bg-opacity-10 text-secondary section-label me-2">Review</div>
                                    <h6 class="fw-bold mb-0" style="color: #0f172a;">Reservation Details to be Saved</h6>
                                    <small class="text-muted">Verify everything before you hit confirm.</small>
                                </div>
                                <div class="text-end">
                                    <div class="small text-muted">Status</div>
                                    <div class="badge bg-success bg-opacity-10 text-success px-3">Ready</div>
                                </div>
                            </div>

                            <div class="row g-3">
                                <div class="col-md-4">
                                    <div class="mini-chip">
                                        <span class="chip-label">Reservation #</span>
                                        <span class="chip-value" id="previewResNum">
                                            <c:choose>
                                                <c:when test="${not empty param.reservationNumber}">${param.reservationNumber}</c:when>
                                                <c:otherwise>Auto-generated</c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="mini-chip">
                                        <span class="chip-label">Guest Name</span>
                                        <span class="chip-value" id="previewGuestName">-</span>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="mini-chip">
                                        <span class="chip-label">Contact</span>
                                        <span class="chip-value" id="previewGuestContact">-</span>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="mini-chip">
                                        <span class="chip-label">NIC / Passport</span>
                                        <span class="chip-value" id="previewGuestNic">-</span>
                                    </div>
                                </div>
                                <div class="col-md-8">
                                    <div class="mini-chip">
                                        <span class="chip-label">Address</span>
                                        <span class="chip-value" id="previewGuestAddress">-</span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mini-chip">
                                        <span class="chip-label">Room Type / Room</span>
                                        <span class="chip-value" id="previewRoomType">-</span>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="mini-chip">
                                        <span class="chip-label">Check-in</span>
                                        <span class="chip-value" id="previewCheckIn">-</span>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="mini-chip">
                                        <span class="chip-label">Check-out</span>
                                        <span class="chip-value" id="previewCheckOut">-</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="d-flex justify-content-between align-items-center mt-4">
                            <a href="${pageContext.request.contextPath}/staff/dashboard"
                                class="btn btn-outline-secondary px-4">Cancel</a>
                            <button type="submit" class="btn btn-primary px-5 py-2">
                                <i class="fas fa-check-circle me-2"></i>Confirm Reservation
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const toastEl = document.getElementById('successToast');
                if (toastEl) {
                    const toast = new bootstrap.Toast(toastEl, { delay: 4000 });
                    toast.show();
                }

                const roomSelect = document.getElementById('roomSelect');
                const checkIn = document.getElementById('checkInDate');
                const checkOut = document.getElementById('checkOutDate');
                const costSummary = document.getElementById('costSummary');
                const previewResNum = document.getElementById('previewResNum');
                const previewGuestName = document.getElementById('previewGuestName');
                const previewGuestContact = document.getElementById('previewGuestContact');
                const previewGuestAddress = document.getElementById('previewGuestAddress');
                const previewGuestNic = document.getElementById('previewGuestNic');
                const previewRoomType = document.getElementById('previewRoomType');
                const previewCheckIn = document.getElementById('previewCheckIn');
                const previewCheckOut = document.getElementById('previewCheckOut');

                // Set minimum check-in date to today
                const today = new Date().toISOString().split('T')[0];
                checkIn.setAttribute('min', today);

                function calculateCost() {
                    const selectedOption = roomSelect.options[roomSelect.selectedIndex];
                    const rate = parseFloat(selectedOption.dataset.rate || 0);
                    const inDate = new Date(checkIn.value);
                    const outDate = new Date(checkOut.value);

                    if (rate > 0 && checkIn.value && checkOut.value && outDate > inDate) {
                        const nights = Math.ceil((outDate - inDate) / (1000 * 60 * 60 * 24));
                        const total = rate * nights;

                        document.getElementById('rateDisplay').innerText = 'LKR ' + rate.toLocaleString();
                        document.getElementById('nightsDisplay').innerText = nights;
                        document.getElementById('totalDisplay').innerText = 'LKR ' + total.toLocaleString();
                        document.getElementById('totalCostInput').value = total;
                        costSummary.style.display = 'block';
                    } else {
                        costSummary.style.display = 'none';
                        document.getElementById('totalCostInput').value = '';
                    }

                    // Snapshot preview
                    const nameVal = document.querySelector('input[name=\"guestName\"]').value || '-';
                    const contactVal = document.querySelector('input[name=\"contactNumber\"]').value || '-';
                    const addrVal = document.querySelector('textarea[name=\"address\"]').value || '-';
                    const roomVal = selectedOption && selectedOption.value ? selectedOption.textContent.trim() : '-';
                    const nicVal = document.querySelector('input[name=\"nic\"]').value || '-';
                    const inVal = checkIn.value || '-';
                    const outVal = checkOut.value || '-';

                    previewGuestName.textContent = nameVal;
                    previewGuestContact.textContent = contactVal;
                    previewGuestAddress.textContent = addrVal;
                    previewRoomType.textContent = roomVal;
                    previewCheckIn.textContent = inVal;
                    previewCheckOut.textContent = outVal;
                    previewGuestNic.textContent = nicVal;
                }

                roomSelect.addEventListener('change', calculateCost);
                checkIn.addEventListener('change', function () {
                    checkOut.setAttribute('min', checkIn.value);
                    calculateCost();
                });
                checkOut.addEventListener('change', calculateCost);
                document.querySelector('input[name=\"guestName\"]').addEventListener('input', calculateCost);
                document.querySelector('input[name=\"contactNumber\"]').addEventListener('input', calculateCost);
                document.querySelector('textarea[name=\"address\"]').addEventListener('input', calculateCost);

                document.getElementById('reservationForm').addEventListener('submit', function (e) {
                    if (!document.getElementById('totalCostInput').value) {
                        e.preventDefault();
                        alert('Please select a room and valid dates to calculate total cost.');
                    }
                });
            });
        </script>

        <jsp:include page="includes/footer.jsp" />




