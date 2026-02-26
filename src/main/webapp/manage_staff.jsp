<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <jsp:include page="includes/header.jsp" />

        <div class="row mb-4">
            <div class="col-md-6">
                <h2 class="fw-bold"><i class="fas fa-users-cog me-2 text-primary"></i>Staff Management</h2>
                <p class="text-muted">Manage your resort's staff members, their access and information.</p>
            </div>
            <div class="col-md-6 text-end">
                <button class="btn btn-primary shadow-sm" data-bs-toggle="modal" data-bs-target="#addStaffModal">
                    <i class="fas fa-user-plus me-2"></i> Add New Staff
                </button>
            </div>
        </div>

        <c:if test="${not empty param.success}">
            <div class="alert alert-success alert-dismissible fade show shadow-sm border-0 mb-4"
                style="border-radius: 12px; background: #e8f5e9; color: #2e7d32;" role="alert">
                <i class="fas fa-check-circle me-2"></i>
                <c:choose>
                    <c:when test="${param.success == 'add'}">Staff member added successfully!</c:when>
                    <c:when test="${param.success == 'update'}">Staff information updated successfully!</c:when>
                    <c:when test="${param.success == 'delete'}">Staff member removed successfully!</c:when>
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

        <style>
            .staff-card {
                border-radius: 18px;
                border: 1px solid #e5e7eb;
                padding: 14px;
                background: linear-gradient(135deg, #ffffff 0%, #f8fafc 100%);
                box-shadow: 0 10px 24px rgba(15, 23, 42, 0.08);
            }
            .avatar-medium {
                width: 96px;
                height: 96px;
                border-radius: 18px;
                overflow: hidden;
                background: #f0f4f8;
                border: 1px solid #e2e8f0;
            }
        </style>

        <div class="premium-card p-4 border-0 shadow-sm" style="border-radius: 20px; background: #fff;">
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr
                            style="font-size: 0.82rem; letter-spacing: 0.5px; text-transform: uppercase; color: #6c757d;">
                            <th class="border-0 px-3">#</th>
                            <th class="border-0">Staff Detail</th>
                            <th class="border-0">Email</th>
                            <th class="border-0">Phone</th>
                            <th class="border-0 text-center">Username</th>
                            <th class="border-0 text-center">Status</th>
                            <th class="border-0 text-center">Joined</th>
                            <th class="border-0 text-end px-3">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="staff" items="${staffList}" varStatus="loop">
                            <tr style="border-bottom: 1px solid #f8f9fa;">
                                <td class="px-3" style="color: #adb5bd; font-weight: 500;">${loop.count}</td>
                                <td>
                                    <div class="staff-card d-flex align-items-center gap-3">
                                        <div class="avatar-medium">
                                            <img src="${pageContext.request.contextPath}/assets/uploads/${staff.profileImage}"
                                                onerror="this.src='https://ui-avatars.com/api/?name=${staff.fullName}&background=f0f4f8&color=0077b6&bold=true'"
                                                style="width:100%; height:100%; object-fit:cover;">
                                        </div>
                                        <div>
                                            <div class="fw-bold" style="color: #03045e;">${staff.fullName}</div>
                                            <small class="text-muted">
                                                <i class="fas fa-shield-alt me-1" style="font-size: 0.75rem;"></i>
                                                ${staff.role}
                                            </small>
                                        </div>
                                    </div>
                                </td>
                                <td class="text-muted">
                                    <i class="fas fa-envelope me-1 text-primary"></i>
                                    <c:out value="${staff.email}" default="—" />
                                </td>
                                <td class="text-muted">
                                    <i class="fas fa-phone-alt me-1 text-success"></i>
                                    <c:out value="${staff.phoneNumber}" default="—" />
                                </td>
                                <td class="text-center">
                                    <span class="badge rounded-pill"
                                        style="background: #e8f4fd; color: #0077b6; font-weight: 600; font-family: monospace; padding: 6px 12px;">
                                        ${staff.username}
                                    </span>
                                </td>
                                <td class="text-center">
                                    <span class="badge bg-success bg-opacity-10 text-success rounded-pill px-3 py-2"
                                        style="font-size: 0.75rem; font-weight: 700;">
                                        <i class="fas fa-circle me-1" style="font-size: 0.5rem;"></i> Active
                                    </span>
                                </td>
                                <td class="text-center text-muted" style="font-size: 0.88rem;">
                                    <c:set var="datePart" value="${staff.createdAt.toString().split(' ')[0]}" />
                                    ${datePart}
                                </td>
                                <td class="text-end px-3">
                                    <div class="d-flex justify-content-end gap-2">
                                        <button class="btn btn-sm btn-light shadow-none"
                                            style="width: 32px; height: 32px; border-radius: 8px; color: #0077b6; background: #e8f4fd;"
                                            onclick="editStaff(${staff.id})">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <a href="${pageContext.request.contextPath}/admin/staff/delete?id=${staff.id}"
                                            class="btn btn-sm btn-light shadow-none"
                                            style="width: 32px; height: 32px; border-radius: 8px; color: #e63946; background: #fef2f2;"
                                            onclick="return confirm('Are you sure you want to remove this staff member?')">
                                            <i class="fas fa-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty staffList}">
                            <tr>
                                <td colspan="8" class="text-center py-5">
                                    <img src="https://img.icons8.com/bubbles/100/000000/empty-box.png"
                                        class="mb-3 opacity-50"><br>
                                    <span class="text-muted">No staff members found in the system.</span>
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Add Staff Modal -->
        <div class="modal fade" id="addStaffModal" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content border-0 shadow" style="border-radius: 20px;">
                    <div class="modal-header border-0 px-4 pt-4">
                        <h5 class="modal-title fw-bold" style="color: #03045e;">Add New Staff Member</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/admin/staff/add" method="post">
                        <div class="modal-body px-4">
                            <div class="mb-3">
                                <label class="form-label small fw-bold text-muted">FULL NAME</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-0"><i
                                            class="fas fa-user-tag text-muted"></i></span>
                                    <input type="text" class="form-control bg-light border-0" name="fullName"
                                        placeholder="e.g. John Smith" required>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label small fw-bold text-muted">USERNAME</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-0"><i
                                            class="fas fa-at text-muted"></i></span>
                                    <input type="text" class="form-control bg-light border-0" name="username"
                                        placeholder="Choose a username" required>
                                </div>
                            </div>
                            <div class="mb-4">
                                <label class="form-label small fw-bold text-muted">PASSWORD</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-0"><i
                                            class="fas fa-key text-muted"></i></span>
                                    <input type="password" class="form-control bg-light border-0" name="password"
                                        placeholder="Create a password" required>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label small fw-bold text-muted">EMAIL</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-0"><i
                                            class="fas fa-envelope text-muted"></i></span>
                                    <input type="email" class="form-control bg-light border-0" name="email"
                                        placeholder="staff@example.com">
                                </div>
                            </div>
                            <div class="mb-1">
                                <label class="form-label small fw-bold text-muted">PHONE</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-0"><i
                                            class="fas fa-phone text-muted"></i></span>
                                    <input type="text" class="form-control bg-light border-0" name="phoneNumber"
                                        placeholder="+94 XX XXX XXXX">
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer border-0 px-4 pb-4">
                            <button type="button" class="btn btn-light px-4" style="border-radius: 10px;"
                                data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary px-4" style="border-radius: 10px;">Create
                                Account</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Edit Staff Modal -->
        <div class="modal fade" id="editStaffModal" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content border-0 shadow" style="border-radius: 20px;">
                    <div class="modal-header border-0 px-4 pt-4">
                        <h5 class="modal-title fw-bold" style="color: #03045e;">Edit Staff Member</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/admin/staff/update" method="post">
                        <input type="hidden" name="id" id="editStaffId">
                        <div class="modal-body px-4">
                            <div class="mb-3">
                                <label class="form-label small fw-bold text-muted">FULL NAME</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-0"><i
                                            class="fas fa-user-tag text-muted"></i></span>
                                    <input type="text" class="form-control bg-light border-0" name="fullName"
                                        id="editFullName" required>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label small fw-bold text-muted">USERNAME</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-0"><i
                                            class="fas fa-at text-muted"></i></span>
                                    <input type="text" class="form-control bg-light border-0" name="username"
                                        id="editUsername" required>
                                </div>
                            </div>
                            <div class="mb-4">
                                <label class="form-label small fw-bold text-muted">PASSWORD (Update if needed)</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-0"><i
                                            class="fas fa-key text-muted"></i></span>
                                    <input type="password" class="form-control bg-light border-0" name="password"
                                        id="editPassword" placeholder="New password" required>
                                </div>
                                <small class="text-muted" style="font-size: 0.72rem;">* Please re-confirm password to
                                    save changes.</small>
                            </div>
                            <div class="mb-3">
                                <label class="form-label small fw-bold text-muted">EMAIL</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-0"><i
                                            class="fas fa-envelope text-muted"></i></span>
                                    <input type="email" class="form-control bg-light border-0" name="email"
                                        id="editEmail" placeholder="staff@example.com">
                                </div>
                            </div>
                            <div class="mb-1">
                                <label class="form-label small fw-bold text-muted">PHONE</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-0"><i
                                            class="fas fa-phone text-muted"></i></span>
                                    <input type="text" class="form-control bg-light border-0" name="phoneNumber"
                                        id="editPhoneNumber" placeholder="+94 XX XXX XXXX">
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer border-0 px-4 pb-4">
                            <button type="button" class="btn btn-light px-4" style="border-radius: 10px;"
                                data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary px-4" style="border-radius: 10px;">Save
                                Changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script>
            function editStaff(id) {
                fetch('${pageContext.request.contextPath}/admin/staff/get?id=' + id)
                    .then(response => response.json())
                    .then(data => {
                        document.getElementById('editStaffId').value = data.id;
                        document.getElementById('editFullName').value = data.fullName;
                        document.getElementById('editUsername').value = data.username;
                        document.getElementById('editPassword').value = data.password;
                        document.getElementById('editEmail').value = data.email || '';
                        document.getElementById('editPhoneNumber').value = data.phoneNumber || '';

                        var editModal = new bootstrap.Modal(document.getElementById('editStaffModal'));
                        editModal.show();
                    })
                    .catch(error => {
                        console.error('Error fetching staff details:', error);
                        alert('Could not fetch staff details. Please try again.');
                    });
            }
        </script>

        <jsp:include page="includes/footer.jsp" />
