<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <jsp:include page="includes/header.jsp" />

        <div class="row mb-4">
            <div class="col-md-6">
                <h2 class="fw-bold"><i class="fas fa-door-open me-2 text-primary"></i>Room Management</h2>
                <p class="text-muted">Manage the inventory, availability and status of individual rooms.</p>
            </div>
            <div class="col-md-6 text-end">
                <button class="btn btn-primary shadow-sm" style="border-radius: 10px;" data-bs-toggle="modal"
                    data-bs-target="#addRoomModal">
                    <i class="fas fa-plus me-1"></i> Add Individual Room
                </button>
            </div>
        </div>

        <c:if test="${not empty param.success}">
            <div class="alert alert-success alert-dismissible fade show shadow-sm border-0 mb-4"
                style="border-radius: 12px; background: #e8f5e9; color: #2e7d32;" role="alert">
                <i class="fas fa-check-circle me-2"></i>
                <c:choose>
                    <c:when test="${param.success == 'add'}">Room added to inventory successfully!</c:when>
                    <c:when test="${param.success == 'update'}">Room status/type updated!</c:when>
                    <c:when test="${param.success == 'delete'}">Room removed from system.</c:when>
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

        <div class="row g-4" id="roomsContainer">
            <c:forEach var="room" items="${roomList}">
                <div class="col-12">
                    <div class="premium-card overflow-hidden border-0 shadow-sm hover-elevate transition-all"
                        style="border-radius: 24px; background: #fff;">
                        <div class="row g-0">
                            <div class="col-md-4 position-relative">
                                <div class="room-image-container h-100" style="min-height: 220px;">
                                    <c:choose>
                                        <c:when
                                            test="${not empty room.roomImage && room.roomImage != 'default_room.png'}">
                                            <img src="${pageContext.request.contextPath}/assets/rooms/${room.roomImage}"
                                                class="img-fluid w-100 h-100 object-fit-cover"
                                                alt="Room ${room.roomNumber}">
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
                                        <span class="fw-black h5 mb-0 text-primary"
                                            style="font-weight: 900;">#${room.roomNumber}</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-8 p-4 d-flex flex-column justify-content-between">
                                <div>
                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                        <div>
                                            <h4 class="fw-bold mb-1" style="color: #03045e;">${room.roomType.typeName}
                                            </h4>
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
                                                <div class="small text-muted mb-1" style="font-size: 0.7rem;">RATE PER
                                                    NIGHT</div>
                                                <div class="fw-bold text-dark" style="font-size: 1.1rem;">
                                                    <span class="small text-muted">LKR</span>
                                                    ${room.roomType.ratePerNight}0
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-7 d-flex align-items-center">
                                            <div class="px-3">
                                                <ul class="list-inline mb-0 text-muted small">
                                                    <li class="list-inline-item me-3"><i
                                                            class="fas fa-wifi me-1 text-primary"></i> Free WiFi</li>
                                                    <li class="list-inline-item me-3"><i
                                                            class="fas fa-snowflake me-1 text-primary"></i> AC</li>
                                                    <li class="list-inline-item"><i
                                                            class="fas fa-tv me-1 text-primary"></i> Smart TV</li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="mt-4 d-flex justify-content-end gap-2 border-top pt-3">
                                    <button class="btn btn-light rounded-3 px-4 shadow-none"
                                        style="color: #0077b6; background: #e8f4fd; border: none; font-weight: 600;"
                                        onclick="editRoom(${room.id})">
                                        <i class="fas fa-edit me-2"></i> Edit & Image
                                    </button>
                                    <a href="${pageContext.request.contextPath}/admin/rooms/delete?id=${room.id}"
                                        class="btn btn-light rounded-3 px-4 shadow-none"
                                        style="color: #e63946; background: #fef2f2; border: none; font-weight: 600;"
                                        onclick="return confirm('Remove Room ${room.roomNumber} from inventory?')">
                                        <i class="fas fa-trash me-2"></i> Delete
                                    </a>
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
                        <h4 class="text-muted">No rooms in your inventory yet.</h4>
                        <p class="text-muted small">Start by adding individual rooms to your resort.</p>
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

        <!-- Add Room Modal -->
        <div class="modal fade" id="addRoomModal" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content border-0 shadow-lg" style="border-radius: 24px;">
                    <div class="modal-header border-0 px-4 pt-4">
                        <h5 class="modal-title fw-bold" style="color: #03045e;">Add New Room</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/admin/rooms/add" method="post"
                        enctype="multipart/form-data">
                        <div class="modal-body px-4">
                            <div class="mb-3">
                                <label class="form-label small fw-bold text-muted text-uppercase"
                                    style="letter-spacing: 1px;">Room Number</label>
                                <input type="text" class="form-control bg-light border-0 py-2" name="roomNumber"
                                    placeholder="e.g. 101" required style="border-radius: 12px;">
                            </div>
                            <div class="mb-3">
                                <label class="form-label small fw-bold text-muted text-uppercase"
                                    style="letter-spacing: 1px;">Room Type</label>
                                <select class="form-select bg-light border-0 py-2" name="roomTypeId" required
                                    style="border-radius: 12px;">
                                    <option value="" disabled selected>Select Category</option>
                                    <c:forEach var="type" items="${roomTypes}">
                                        <option value="${type.id}">${type.typeName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="mb-0">
                                <label class="form-label small fw-bold text-muted text-uppercase"
                                    style="letter-spacing: 1px;">Room Image (Optional)</label>
                                <div class="upload-area p-3 bg-light rounded-4 text-center border-2 border-dashed"
                                    style="border: 2px dashed #dee2e6;">
                                    <input type="file" class="form-control d-none" name="roomImage" id="addRoomImg"
                                        accept="image/*" onchange="previewImg(this, 'addPreview')">
                                    <label for="addRoomImg" class="m-0 cursor-pointer" style="cursor: pointer;">
                                        <i class="fas fa-cloud-upload-alt text-primary h3 mb-2 d-block"></i>
                                        <span class="small text-muted">Click to upload premium room photo</span>
                                    </label>
                                    <img id="addPreview" class="img-fluid rounded-3 mt-2 d-none"
                                        style="max-height: 120px;">
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer border-0 px-4 pb-4">
                            <button type="button" class="btn btn-light px-4 py-2 fw-bold" data-bs-dismiss="modal"
                                style="border-radius: 12px;">Cancel</button>
                            <button type="submit" class="btn btn-primary px-4 py-2 fw-bold shadow-sm"
                                style="border-radius: 12px; background: linear-gradient(135deg, #023e8a, #0077b6);">
                                <i class="fas fa-plus-circle me-1"></i> Create Room
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Edit Room Modal -->
        <div class="modal fade" id="editRoomModal" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content border-0 shadow-lg" style="border-radius: 24px;">
                    <div class="modal-header border-0 px-4 pt-4">
                        <h5 class="modal-title fw-bold" style="color: #03045e;">Update Room Inventory</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/admin/rooms/update" method="post"
                        enctype="multipart/form-data">
                        <input type="hidden" name="id" id="editRoomId">
                        <div class="modal-body px-4">
                            <div class="mb-3 text-center">
                                <img id="editPreview" class="img-fluid rounded-4 shadow-sm mb-3 object-fit-cover"
                                    style="height: 140px; width: 100%;"
                                    src="${pageContext.request.contextPath}/assets/rooms/default_room.png">
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label small fw-bold text-muted text-uppercase">Room No</label>
                                    <input type="text" class="form-control bg-light border-0" id="editRoomNumber"
                                        disabled style="border-radius: 12px;">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label
                                        class="form-label small fw-bold text-muted text-uppercase">Availability</label>
                                    <select class="form-select bg-light border-0" name="status" id="editRoomStatus"
                                        required style="border-radius: 12px;">
                                        <option value="AVAILABLE">Available</option>
                                        <option value="OCCUPIED">Occupied</option>
                                        <option value="CLEANING">Cleaning</option>
                                        <option value="MAINTENANCE">Maintenance</option>
                                    </select>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label small fw-bold text-muted text-uppercase">Category
                                    Update</label>
                                <select class="form-select bg-light border-0" name="roomTypeId" id="editRoomTypeId"
                                    required style="border-radius: 12px;">
                                    <c:forEach var="type" items="${roomTypes}">
                                        <option value="${type.id}">${type.typeName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="mb-0">
                                <label class="form-label small fw-bold text-muted text-uppercase">Update Photo</label>
                                <input type="file" class="form-control bg-light border-0" name="roomImage"
                                    accept="image/*" onchange="previewImg(this, 'editPreview')"
                                    style="border-radius: 12px;">
                            </div>
                        </div>
                        <div class="modal-footer border-0 px-4 pb-4">
                            <button type="button" class="btn btn-light px-4" data-bs-dismiss="modal"
                                style="border-radius: 12px;">Dismiss</button>
                            <button type="submit" class="btn btn-dark px-4 shadow-sm fw-bold"
                                style="border-radius: 12px;">Save Changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script>
            function previewImg(input, targetId) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        var img = document.getElementById(targetId);
                        img.src = e.target.result;
                        img.classList.remove('d-none');
                    }
                    reader.readAsDataURL(input.files[0]);
                }
            }

            function editRoom(id) {
                fetch('${pageContext.request.contextPath}/admin/rooms/get?id=' + id)
                    .then(r => r.json())
                    .then(data => {
                        document.getElementById('editRoomId').value = data.id;
                        document.getElementById('editRoomNumber').value = data.roomNumber;
                        document.getElementById('editRoomTypeId').value = data.roomTypeId;
                        document.getElementById('editRoomStatus').value = data.status;

                        // Set current image preview
                        const imgPath = data.roomImage && data.roomImage !== 'default_room.png'
                            ? '${pageContext.request.contextPath}/assets/rooms/' + data.roomImage
                            : '${pageContext.request.contextPath}/assets/rooms/default_room.png';
                        document.getElementById('editPreview').src = imgPath;

                        new bootstrap.Modal(document.getElementById('editRoomModal')).show();
                    })
                    .catch(e => alert('Error loading room data'));
            }
        </script>

        <jsp:include page="includes/footer.jsp" />
