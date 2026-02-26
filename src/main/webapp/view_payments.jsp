<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <jsp:include page="includes/header.jsp" />

            <div class="position-relative mb-4">
                <div class="rounded-4 p-4 p-md-5 text-white"
                    style="background: linear-gradient(135deg, #0f172a, #0ea5e9); box-shadow: 0 18px 40px rgba(15, 23, 42, 0.35);">
                    <div class="d-flex align-items-center justify-content-between flex-wrap gap-3">
                        <div>
                            <div class="badge bg-white text-primary fw-bold px-3 py-2 mb-2">Finance</div>
                            <h2 class="fw-bold mb-1"><i class="fas fa-history me-2"></i>Transaction History</h2>
                            <p class="mb-0 opacity-75">Review and export all recorded payments.</p>
                        </div>
                        <div class="d-flex flex-wrap gap-2">
                            <button onclick="window.location.reload()" class="btn btn-light text-primary fw-bold shadow-sm"
                                style="border-radius: 12px; background: #e0f2fe;">
                                <i class="fas fa-sync-alt me-2"></i> Refresh
                            </button>
                            <button class="btn btn-dark shadow-sm px-4" style="border-radius: 12px;" onclick="window.print()">
                                <i class="fas fa-print me-2"></i> Print / Save PDF
                            </button>
                            <button class="btn btn-outline-success shadow-sm px-4" style="border-radius: 12px;"
                                id="downloadPayments">
                                <i class="fas fa-file-download me-2"></i> Download CSV
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
                        <c:when test="${param.success == 'payment'}">Payment recorded successfully.</c:when>
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
                .payments-card {
                    border-radius: 22px;
                    background: linear-gradient(180deg, #ffffff 0%, #f8fafc 100%);
                    border: 1px solid #e2e8f0;
                }
                .method-pill {
                    font-size: 0.72rem;
                    font-weight: 700;
                    padding: 6px 12px;
                    border-radius: 999px;
                }
            </style>

            <div class="payments-card p-4 border-0 shadow-sm animate__animated animate__fadeInUp">
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr
                                style="font-size: 0.82rem; letter-spacing: 1px; text-transform: uppercase; color: #64748b; font-weight: 700;">
                                <th class="border-0 px-4">Transaction ID</th>
                                <th class="border-0">Reservation #</th>
                                <th class="border-0">Date & Time</th>
                                <th class="border-0 text-center">Method</th>
                                <th class="border-0 text-end px-4">Amount</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="p" items="${payments}">
                                <tr style="border-bottom: 1px solid #f1f5f9;">
                                    <td class="px-4">
                                        <span class="fw-bold text-dark">TRX-${p.id + 1000}</span>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/booking/view?id=${p.reservationNumber}"
                                            class="text-decoration-none fw-600 text-primary">
                                            ${p.reservationNumber}
                                        </a>
                                    </td>
                                    <td class="text-muted small">
                                        <i class="far fa-calendar-alt me-1"></i>
                                        <fmt:formatDate value="${p.paymentDate}" pattern="MMM dd, yyyy" /><br>
                                        <i class="far fa-clock me-1"></i>
                                        <fmt:formatDate value="${p.paymentDate}" pattern="HH:mm:ss" />
                                    </td>
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${p.paymentMethod == 'CASH'}">
                                                <span class="method-pill bg-success bg-opacity-10 text-success">
                                                    <i class="fas fa-money-bill-wave me-1"></i> CASH
                                                </span>
                                            </c:when>
                                            <c:when test="${p.paymentMethod == 'CARD'}">
                                                <span class="method-pill bg-primary bg-opacity-10 text-primary">
                                                    <i class="fas fa-credit-card me-1"></i> CARD
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="method-pill bg-info bg-opacity-10 text-info">
                                                    <i class="fas fa-exchange-alt me-1"></i> ${p.paymentMethod}
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-end px-4">
                                        <span class="fw-800 text-dark">LKR
                                            <fmt:formatNumber value="${p.amount}" pattern="#,###.00" />
                                        </span>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty payments}">
                                <tr>
                                    <td colspan="5" class="text-center py-5">
                                        <div class="py-4">
                                            <img src="https://img.icons8.com/isometric/100/no-transactions.png"
                                                style="width: 80px;" class="mb-3 opacity-50">
                                            <p class="text-muted fs-5 mb-0">No payment records found in the system.</p>
                                        </div>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>

            <jsp:include page="includes/footer.jsp" />

            <script>
                document.getElementById('downloadPayments')?.addEventListener('click', function () {
                    const rows = [['Transaction ID', 'Reservation #', 'Date', 'Time', 'Method', 'Amount (LKR)']];
                    document.querySelectorAll('table tbody tr').forEach(tr => {
                        const cells = Array.from(tr.querySelectorAll('td')).map(td => td.innerText.trim());
                        if (cells.length >= 5) rows.push(cells.slice(0, 5));
                    });
                    const csv = rows.map(r => r.map(v => `"${v}"`).join(',')).join('\\n');
                    const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' });
                    const url = URL.createObjectURL(blob);
                    const a = document.createElement('a');
                    a.href = url;
                    a.download = 'payments.csv';
                    document.body.appendChild(a);
                    a.click();
                    document.body.removeChild(a);
                    URL.revokeObjectURL(url);
                });
            </script>
