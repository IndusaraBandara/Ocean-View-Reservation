<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <jsp:include page="includes/header.jsp" />

            <div class="row mb-4">
                <div class="col-md-6">
                    <h2 class="fw-bold"><i class="fas fa-user-friends me-2 text-primary"></i>Guest Management</h2>
                    <p class="text-muted">View and manage registered guests in the system.</p>
                </div>
            </div>

            <c:if test="${not empty param.success}">
                <div class="alert alert-success alert-dismissible fade show shadow-sm border-0 mb-4"
                    style="border-radius: 12px; background: #e8f5e9; color: #2e7d32;" role="alert">
                    <i class="fas fa-check-circle me-2"></i>
                    <c:choose>
                        <c:when test="${param.success == 'update'}">Guest details updated successfully!</c:when>
                        <c:when test="${param.success == 'delete'}">Guest record removed from the system.</c:when>
                    </c:choose>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <div class="premium-card p-4 border-0 shadow-sm" style="border-radius: 20px; background: #fff;">
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr
                                style="font-size: 0.82rem; letter-spacing: 0.5px; text-transform: uppercase; color: #6c757d;">
                                <th class="border-0 px-3">#</th>
                                <th class="border-0">Guest Name</th>
                                <th class="border-0">Contact Number</th>
                                <th class="border-0">Address</th>
                                <th class="border-0 text-end px-3">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="guest" items="${guests}" varStatus="loop">
                                <tr style="border-bottom: 1px solid #f8f9fa;">
                                    <td class="px-3" style="color: #adb5bd; font-weight: 500;">${loop.count}</td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div class="icon-box me-3"
                                                style="width: 40px; height: 40px; border-radius: 10px; background: #f3e8ff; display: flex; align-items: center; justify-content: center; color: #7e22ce;">
                                                <i class="fas fa-user"></i>
                                            </div>
                                            <div>
                                                <div class="fw-bold" style="color: #03045e; font-size: 1rem;">
                                                    ${guest.name}</div>
                                                <small class="text-muted">Registered:
                                                    <fmt:formatDate value="${guest.createdAt}" pattern="MMM dd, yyyy" />
                                                </small>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <span class="badge bg-light text-dark px-3 py-2"
                                            style="border-radius: 8px; font-weight: 500;">
                                            <i class="fas fa-phone-alt me-2 text-muted"></i>${guest.contactNumber}
                                        </span>
                                    </td>
                                    <td class="text-muted" style="font-size: 0.9rem;">
                                        ${guest.address}
                                    </td>
                                    <td class="text-end px-3">
                                        <div class="d-flex justify-content-end gap-2">
                                            <button class="btn btn-sm btn-light shadow-none"
                                                style="width: 32px; height: 32px; border-radius: 8px; color: #0077b6; background: #e8f4fd;"
                                                onclick="editGuest(${guest.id})">
                                                <i class="fas fa-edit"></i>
                                            </button>
                                            <a href="${pageContext.request.contextPath}/admin/guests/delete?id=${guest.id}"
                                                class="btn btn-sm btn-light shadow-none"
                                                style="width: 32px; height: 32px; border-radius: 8px; color: #e63946; background: #fef2f2;"
                                                onclick="return confirm('Remove guest ${guest.name} and all their history?')">
                                                <i class="fas fa-trash"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty guests}">
                                <tr>
                                    <td colspan="5" class="text-center py-5">
                                        <span class="text-muted">No guests registered yet.</span>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Edit Guest Modal -->
            <div class="modal fade" id="editGuestModal" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content border-0 shadow" style="border-radius: 20px;">
                        <div class="modal-header border-0 px-4 pt-4">
                            <h5 class="modal-title fw-bold" style="color: #03045e;">Edit Guest Details</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <form action="${pageContext.request.contextPath}/admin/guests/update" method="post">
                            <input type="hidden" name="id" id="editGuestId">
                            <div class="modal-body px-4">
                                <div class="mb-3">
                                    <label class="form-label small fw-bold text-muted">FULL NAME</label>
                                    <input type="text" class="form-control bg-light border-0" name="name"
                                        id="editGuestName" style="border-radius: 10px;" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label small fw-bold text-muted">CONTACT NUMBER</label>
                                    <input type="text" class="form-control bg-light border-0" name="contactNumber"
                                        id="editGuestContact" style="border-radius: 10px;" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label small fw-bold text-muted">ADDRESS</label>
                                    <textarea class="form-control bg-light border-0" name="address"
                                        id="editGuestAddress" style="border-radius: 10px;" rows="3" required></textarea>
                                </div>
                            </div>
                            <div class="modal-footer border-0 px-4 pb-4">
                                <button type="button" class="btn btn-light px-4" data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-primary px-4">Save Changes</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <script>
                function editGuest(id) {
                    fetch('${pageContext.request.contextPath}/admin/guests/get?id=' + id)
                        .then(r => r.json())
                        .then(data => {
                            document.getElementById('editGuestId').value = data.id;
                            document.getElementById('editGuestName').value = data.name;
                            document.getElementById('editGuestContact').value = data.contactNumber;
                            document.getElementById('editGuestAddress').value = data.address;
                            new bootstrap.Modal(document.getElementById('editGuestModal')).show();
                        })
                        .catch(e => alert('Error loading guest data'));
                }
            </script>

            <jsp:include page="includes/footer.jsp" />