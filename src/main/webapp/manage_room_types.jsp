<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <jsp:include page="includes/header.jsp" />

            <div class="position-relative mb-4">
                <div class="rounded-4 p-4 p-md-5 text-white"
                    style="background: linear-gradient(135deg, #0f172a, #1d4ed8); box-shadow: 0 18px 40px rgba(15, 23, 42, 0.35);">
                    <div class="d-flex align-items-center justify-content-between flex-wrap gap-3">
                        <div>
                            <div class="badge bg-white text-primary fw-bold px-3 py-2 mb-2">Inventory</div>
                            <h2 class="fw-bold mb-1"><i class="fas fa-layer-group me-2"></i>Room Types</h2>
                            <p class="mb-0 opacity-75">Manage categories, rates, and keep your catalog clean.</p>
                        </div>
                        <div class="d-flex flex-wrap gap-2">
                            <div class="badge bg-white text-dark px-3 py-2 shadow-sm"
                                style="border-radius: 10px;">Total Types:
                                <strong>${fn:length(roomTypes)}</strong>
                            </div>
                            <button class="btn btn-light text-primary fw-bold shadow-sm"
                                style="border-radius: 12px; background: #e0f2fe;" data-bs-toggle="modal"
                                data-bs-target="#addTypeModal">
                                <i class="fas fa-plus me-1"></i> Add New Type
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <c:if test="${not empty param.success}">
                <div class="alert alert-success alert-dismissible fade show shadow-sm border-0 mb-4"
                    style="border-radius: 12px; background: #e8f5e9; color: #2e7d32;" role="alert">
                    <i class="fas fa-check-circle me-2"></i>
                    <c:choose>
                        <c:when test="${param.success == 'add'}">Room type created successfully!</c:when>
                        <c:when test="${param.success == 'update'}">Room type details updated!</c:when>
                        <c:when test="${param.success == 'delete'}">Room type deleted successfully!</c:when>
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
                .type-chip {
                    border-radius: 12px;
                    background: #eef2ff;
                    color: #4338ca;
                    font-weight: 700;
                    padding: 6px 10px;
                }
                .search-box {
                    max-width: 320px;
                }
            </style>

            <div class="premium-card p-4 border-0 shadow-sm" style="border-radius: 20px; background: #fff;">
                <div class="d-flex justify-content-between align-items-center flex-wrap gap-3 mb-3">
                    <input class="form-control search-box" id="typeSearch" placeholder="Search room types..." />
                    <div class="small text-muted">Click edit to update name/rate or delete to remove the type.</div>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover align-middle" id="typesTable">
                        <thead class="table-light">
                            <tr
                                style="font-size: 0.82rem; letter-spacing: 0.5px; text-transform: uppercase; color: #6c757d;">
                                <th class="border-0 px-3">#</th>
                                <th class="border-0">Room Type</th>
                                <th class="border-0 text-center">Base Rate / Night</th>
                                <th class="border-0 text-end px-3">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="type" items="${roomTypes}" varStatus="loop">
                                <tr style="border-bottom: 1px solid #f8f9fa;">
                                    <td class="px-3" style="color: #adb5bd; font-weight: 500;">${loop.count}</td>
                                    <td>
                                        <div class="d-flex align-items-center gap-3">
                                            <div class="icon-box"
                                                style="width: 44px; height: 44px; border-radius: 12px; background: #e0f2fe; display: flex; align-items: center; justify-content: center; color: #2563eb;">
                                                <i class="fas fa-bed"></i>
                                            </div>
                                            <div>
                                                <div class="fw-bold" style="color: #0f172a; font-size: 1.02rem;">${type.typeName}</div>
                                                <span class="type-chip">ID: ${type.id}</span>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="text-center">
                                        <span style="font-weight: 700; color: #16a34a; font-size: 1.05rem;">
                                            LKR <fmt:formatNumber value="${type.ratePerNight}" pattern="#,###.00" />
                                        </span>
                                    </td>
                                    <td class="text-end px-3">
                                        <div class="d-flex justify-content-end gap-2">
                                            <button class="btn btn-sm btn-light shadow-none"
                                                style="width: 36px; height: 36px; border-radius: 10px; color: #2563eb; background: #e0f2fe;"
                                                onclick="editType(${type.id})">
                                                <i class="fas fa-edit"></i>
                                            </button>
                                            <a href="${pageContext.request.contextPath}/admin/roomtypes/delete?id=${type.id}"
                                                class="btn btn-sm btn-light shadow-none"
                                                style="width: 36px; height: 36px; border-radius: 10px; color: #e11d48; background: #ffe4e6;"
                                                onclick="return confirm('Deleting this room type will affect all associated rooms. Continue?')">
                                                <i class="fas fa-trash"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty roomTypes}">
                                <tr>
                                    <td colspan="4" class="text-center py-5">
                                        <img src="https://img.icons8.com/bubbles/100/000000/empty-box.png"
                                            class="mb-3 opacity-50"><br>
                                        <span class="text-muted">No room types defined yet.</span>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Add Modal -->
            <div class="modal fade" id="addTypeModal" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content border-0 shadow" style="border-radius: 20px;">
                        <div class="modal-header border-0 px-4 pt-4">
                            <h5 class="modal-title fw-bold" style="color: #03045e;">Create New Room Type</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <form action="${pageContext.request.contextPath}/admin/roomtypes/add" method="post">
                            <div class="modal-body px-4">
                                <div class="mb-3">
                                    <label class="form-label small fw-bold text-muted">TYPE NAME</label>
                                    <input type="text" class="form-control bg-light border-0"
                                        style="border-radius: 10px;" name="typeName" placeholder="e.g. Deluxe Sea View"
                                        required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label small fw-bold text-muted">RATE PER NIGHT (LKR)</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light border-0">LKR</span>
                                        <input type="number" step="0.01" class="form-control bg-light border-0"
                                            name="ratePerNight" placeholder="0.00" required>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer border-0 px-4 pb-4">
                                <button type="button" class="btn btn-light px-4" style="border-radius: 10px;"
                                    data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-primary px-4" style="border-radius: 10px;">Save
                                    Type</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Edit Modal -->
            <div class="modal fade" id="editTypeModal" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content border-0 shadow" style="border-radius: 20px;">
                        <div class="modal-header border-0 px-4 pt-4">
                            <h5 class="modal-title fw-bold" style="color: #03045e;">Edit Room Type</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <form action="${pageContext.request.contextPath}/admin/roomtypes/update" method="post">
                            <input type="hidden" name="id" id="editTypeId">
                            <div class="modal-body px-4">
                                <div class="mb-3">
                                    <label class="form-label small fw-bold text-muted">TYPE NAME</label>
                                    <input type="text" class="form-control bg-light border-0"
                                        style="border-radius: 10px;" name="typeName" id="editTypeName" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label small fw-bold text-muted">RATE PER NIGHT (LKR)</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light border-0">LKR</span>
                                        <input type="number" step="0.01" class="form-control bg-light border-0"
                                            name="ratePerNight" id="editRate" required>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer border-0 px-4 pb-4">
                                <button type="button" class="btn btn-light px-4" style="border-radius: 10px;"
                                    data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-primary px-4" style="border-radius: 10px;">Update
                                    Changes</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <script>
                function editType(id) {
                    fetch('${pageContext.request.contextPath}/admin/roomtypes/get?id=' + id)
                        .then(r => r.json())
                        .then(data => {
                            document.getElementById('editTypeId').value = data.id;
                            document.getElementById('editTypeName').value = data.typeName;
                            document.getElementById('editRate').value = data.ratePerNight;
                            new bootstrap.Modal(document.getElementById('editTypeModal')).show();
                        })
                        .catch(e => alert('Error loading room type details'));
                }

                // Client-side filter for room types
                const searchInput = document.getElementById('typeSearch');
                if (searchInput) {
                    searchInput.addEventListener('input', () => {
                        const term = searchInput.value.toLowerCase();
                        document.querySelectorAll('#typesTable tbody tr').forEach(row => {
                            const text = row.innerText.toLowerCase();
                            row.style.display = text.includes(term) ? '' : 'none';
                        });
                    });
                }
            </script>

            <jsp:include page="includes/footer.jsp" />
