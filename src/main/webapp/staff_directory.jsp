<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="includes/header.jsp" />

<div class="d-flex flex-wrap justify-content-between align-items-center gap-2 mb-4">
    <div>
        <p class="text-muted small mb-1"><i class="fas fa-users me-2"></i>Team Directory</p>
        <h2 class="fw-bold mb-0">All Staff Members</h2>
        <p class="text-muted mb-0">Crisp photo cards with quick contact actions.</p>
    </div>
    <div class="d-flex gap-2">
        <a href="${pageContext.request.contextPath}/admin/staff/list" class="btn btn-outline-primary">
            <i class="fas fa-table me-2"></i>Table View
        </a>
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-light">
            <i class="fas fa-arrow-left me-1"></i> Dashboard
        </a>
    </div>
</div>

<c:if test="${empty staffList}">
    <div class="alert alert-info">No staff found. Add staff first.</div>
</c:if>

<style>
    .staff-card {
        border-radius: 18px;
        overflow: hidden;
        box-shadow: 0 16px 40px rgba(0,0,0,0.08);
        transition: transform 0.2s ease, box-shadow 0.2s ease;
    }
    .staff-card:hover {
        transform: translateY(-4px);
        box-shadow: 0 20px 48px rgba(0,0,0,0.12);
    }
    .avatar-frame {
        width: 76px;
        height: 76px;
        border-radius: 18px;
        overflow: hidden;
        background: linear-gradient(135deg, #e0f2fe, #f8fafc);
        display: flex;
        align-items: center;
        justify-content: center;
    }
</style>

<div class="row g-3">
    <c:forEach var="staff" items="${staffList}">
        <div class="col-md-4 col-lg-3">
            <div class="card border-0 h-100 staff-card">
                <div class="card-body">
                    <div class="d-flex align-items-center mb-3">
                        <div class="avatar-frame me-3">
                            <c:choose>
                                <c:when test="${not empty staff.profileImage}">
                                    <img src="${pageContext.request.contextPath}/assets/uploads/${staff.profileImage}"
                                        alt="avatar" style="width:100%;height:100%;object-fit:cover;">
                                </c:when>
                                <c:otherwise>
                                    <span class="fw-bold text-primary" style="font-size:1.4rem;">
                                        ${staff.fullName.substring(0,1).toUpperCase()}
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div>
                            <div class="fw-bold" style="color:#0f172a;">${staff.fullName}</div>
                            <div class="text-muted small">${staff.username}</div>
                            <span class="badge bg-primary bg-opacity-10 text-primary mt-1">Staff</span>
                        </div>
                    </div>
                    <div class="small text-muted mb-2"><i class="fas fa-envelope me-2"></i>${staff.email}</div>
                    <div class="small text-muted mb-3"><i class="fas fa-phone me-2"></i>${staff.phoneNumber}</div>
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
