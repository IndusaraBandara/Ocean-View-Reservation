<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <jsp:include page="includes/header.jsp" />

        <div class="row justify-content-center">
            <div class="col-lg-9">
                <div class="premium-card p-0 overflow-hidden shadow-lg" style="border-radius: 22px;">
                    <!-- Hero -->
                    <div class="p-5 text-white position-relative"
                        style="background: radial-gradient(circle at 20% 20%, #4cc9f0 0, #4361ee 35%, #3a0ca3 100%);">
                        <div class="d-flex flex-column flex-md-row align-items-center gap-4">
                            <div class="position-relative">
                                <img src="${pageContext.request.contextPath}/assets/uploads/${empty sessionScope.user.profileImage ? 'default_avatar.png' : sessionScope.user.profileImage}"
                                    alt="Profile" class="rounded-4 shadow-lg"
                                    style="width: 140px; height: 140px; object-fit: cover; border: 4px solid rgba(255,255,255,0.4);">
                                <label for="imgUpload"
                                    class="position-absolute bottom-0 end-0 bg-white text-primary rounded-circle p-2 shadow-sm"
                                    style="cursor: pointer; border: 2px solid #3a0ca3;">
                                    <i class="fas fa-camera"></i>
                                </label>
                            </div>
                            <div class="flex-grow-1 text-md-start text-center">
                                <div class="badge bg-light text-primary rounded-pill px-3 py-2 mb-2 fw-bold">${sessionScope.user.role}
                                    MEMBER</div>
                                <h2 class="fw-bold mb-1">${sessionScope.user.fullName}</h2>
                                <p class="mb-0 opacity-75"><i class="fas fa-user me-1"></i>${sessionScope.user.username}</p>
                            </div>
                        </div>
                        <div class="position-absolute top-0 end-0 p-4 text-white-50 small">
                            <i class="fas fa-shield-alt me-1"></i> Secure profile area
                        </div>
                    </div>

                    <!-- Alerts -->
                    <div class="p-4 pb-0">
                        <c:if test="${param.success == '1'}">
                            <div class="alert alert-success alert-dismissible fade show shadow-sm border-0 mb-3"
                                style="border-radius: 12px; background: #e8f5e9; color: #2e7d32;">
                                <i class="fas fa-check-circle me-2"></i> Profile updated successfully!
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>
                        <c:if test="${param.pw_success == '1'}">
                            <div class="alert alert-success alert-dismissible fade show shadow-sm border-0 mb-3"
                                style="border-radius: 12px; background: #e8f5e9; color: #2e7d32;">
                                <i class="fas fa-check-circle me-2"></i> Password reset successfully!
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>
                        <c:if test="${param.pw_error == '1'}">
                            <div class="alert alert-danger alert-dismissible fade show shadow-sm border-0 mb-3"
                                style="border-radius: 12px; background: #fff4f4; color: #c1121f;">
                                <i class="fas fa-exclamation-triangle me-2"></i>
                                <c:choose>
                                    <c:when test="${param.reason == 'confirm'}">New passwords do not match.</c:when>
                                    <c:otherwise>Current password is incorrect.</c:otherwise>
                                </c:choose>
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>
                    </div>

                    <!-- Tabs -->
                    <div class="p-4 pt-0">
                        <ul class="nav nav-pills mb-4" id="pills-tab" role="tablist">
                            <li class="nav-item">
                                <button class="nav-link active px-4" data-bs-toggle="pill"
                                    data-bs-target="#edit-profile"><i class="fas fa-id-badge me-1"></i> Profile Details</button>
                            </li>
                            <li class="nav-item">
                                <button class="nav-link px-4" data-bs-toggle="pill"
                                    data-bs-target="#change-password"><i class="fas fa-lock me-1"></i> Security</button>
                            </li>
                        </ul>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <div class="premium-card p-3 h-100">
                                    <div class="text-muted small fw-bold">EMAIL</div>
                                    <div class="fw-bold" style="color:#03045e;">${empty sessionScope.user.email ? 'Not set' : sessionScope.user.email}</div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="premium-card p-3 h-100">
                                    <div class="text-muted small fw-bold">PHONE NUMBER</div>
                                    <div class="fw-bold" style="color:#03045e;">${empty sessionScope.user.phoneNumber ? 'Not set' : sessionScope.user.phoneNumber}</div>
                                </div>
                            </div>
                        </div>

                        <div class="tab-content" id="pills-tabContent">
                            <!-- Edit Profile -->
                            <div class="tab-pane fade show active" id="edit-profile">
                                <form action="${pageContext.request.contextPath}/profile/update" method="post" enctype="multipart/form-data" class="row g-3">
                                    <input type="file" id="imgUpload" name="profileImage" style="display: none;"
                                        onchange="this.form.submit()">
                                    <div class="col-12">
                                        <label class="form-label text-muted small fw-bold">USERNAME</label>
                                        <input type="text" class="form-control bg-light border-0" name="username"
                                            value="${sessionScope.user.username}" required>
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label text-muted small fw-bold">FULL NAME</label>
                                        <input type="text" class="form-control bg-light border-0" name="fullName"
                                            value="${sessionScope.user.fullName}" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label text-muted small fw-bold">EMAIL</label>
                                        <input type="email" class="form-control bg-light border-0" name="email"
                                            value="${sessionScope.user.email}" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label text-muted small fw-bold">PHONE NUMBER</label>
                                        <input type="tel" class="form-control bg-light border-0" name="phoneNumber"
                                            value="${sessionScope.user.phoneNumber}" required>
                                    </div>
                                    <div class="col-12 d-flex gap-2">
                                        <button type="submit" class="btn btn-primary px-4 shadow-sm"
                                            style="border-radius: 10px;">Save Changes</button>
                                        <label for="imgUpload" class="btn btn-outline-primary px-4"
                                            style="border-radius: 10px; cursor: pointer;">
                                            <i class="fas fa-camera me-1"></i> Update Photo
                                        </label>
                                    </div>
                                </form>
                            </div>

                            <!-- Change Password -->
                            <div class="tab-pane fade" id="change-password">
                                <form action="${pageContext.request.contextPath}/profile/reset-password" method="post" class="row g-3">
                                    <div class="col-12">
                                        <label class="form-label text-muted small fw-bold">CURRENT PASSWORD</label>
                                        <input type="password" class="form-control bg-light border-0" name="currentPassword" required>
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label text-muted small fw-bold">NEW PASSWORD</label>
                                        <input type="password" class="form-control bg-light border-0" name="newPassword" required>
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label text-muted small fw-bold">CONFIRM NEW PASSWORD</label>
                                        <input type="password" class="form-control bg-light border-0" name="confirmPassword" required>
                                    </div>
                                    <div class="col-12">
                                        <button type="submit" class="btn btn-dark px-4 shadow-sm"
                                            style="border-radius: 10px;">Reset Password</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="includes/footer.jsp" />
