<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="includes/header.jsp" />

<div class="d-flex flex-wrap justify-content-between align-items-center gap-2 mb-4">
    <div>
        <p class="text-muted small mb-1"><i class="fas fa-users me-2"></i>Team Directory</p>
        <h2 class="fw-bold mb-0">Our Staff</h2>
        <p class="text-muted mb-0">Side-by-side photo cards with quick contact actions.</p>
    </div>
    <a href="${pageContext.request.contextPath}/staff/dashboard" class="btn btn-light">
        <i class="fas fa-arrow-left me-1"></i> Back to Dashboard
    </a>
</div>

<c:if test="${empty staffList}">
    <div class="alert alert-info">No staff found.</div>
</c:if>

<style>
    .staff-card {
        border-radius: 16px;
        overflow: hidden;
        box-shadow: 0 14px 36px rgba(0,0,0,0.08);
        transition: transform 0.2s ease, box-shadow 0.2s ease;
        background: #fff;
        display: flex;
        flex-direction: row;
        min-height: 180px;
    }
    .staff-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 18px 44px rgba(0,0,0,0.12);
    }
    .staff-photo-wrap {
        width: 42%;
        background: #f1f5f9;
        min-height: 220px;
    }
    .staff-photo {
        width: 100%;
        height: 220px;
        object-fit: cover;
        display: block;
    }
</style>

<div class="row g-3">
    <c:forEach var="staff" items="${staffList}">
        <div class="col-md-6">
            <div class="staff-card">
                <div class="staff-photo-wrap">
                    <c:choose>
                        <c:when test="${not empty staff.profileImage}">
                            <img src="${pageContext.request.contextPath}/assets/uploads/${staff.profileImage}"
                                alt="avatar" class="staff-photo">
                        </c:when>
                        <c:otherwise>
                            <div class="d-flex align-items-center justify-content-center h-100"
                                style="font-size:2rem; color:#0ea5e9; background: linear-gradient(135deg,#e0f2fe,#eff6ff);">
                                ${staff.fullName.substring(0,1).toUpperCase()}
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="p-3 flex-grow-1 d-flex flex-column justify-content-between">
                    <div>
                        <div class="fw-bold" style="color:#0f172a;font-size:1.05rem;">${staff.fullName}</div>
                        <div class="text-muted small mb-2">${staff.username}</div>
                        <span class="badge bg-primary bg-opacity-10 text-primary mb-2">Staff</span>
                        <div class="small text-muted"><i class="fas fa-envelope me-2"></i>${staff.email}</div>
                        <div class="small text-muted mb-2"><i class="fas fa-phone me-2"></i>${staff.phoneNumber}</div>
                    </div>
                    <div class="d-flex gap-2">
                        <a class="btn btn-sm btn-primary text-white flex-fill"
                            href="mailto:${staff.email}" style="border-radius:10px;"><i class="fas fa-paper-plane me-1"></i>Email</a>
                        <a class="btn btn-sm btn-outline-secondary flex-fill"
                            href="tel:${staff.phoneNumber}" style="border-radius:10px;"><i class="fas fa-phone-alt me-1"></i>Call</a>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
</div>

<jsp:include page="includes/footer.jsp" />
