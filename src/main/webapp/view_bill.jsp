<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <jsp:include page="includes/header.jsp" />

            <div class="row mb-4 no-print">
                <div class="col-md-6">
                    <h2 class="fw-bold text-dark"><i class="fas fa-file-invoice me-2 text-primary"></i>Tax Invoice</h2>
                    <p class="text-muted">Review and print the formal billing statement for this reservation.</p>
                </div>
                <div class="col-md-6 text-end d-flex justify-content-end gap-2 flex-wrap">
                    <button onclick="window.print()" class="btn btn-dark shadow-sm px-4" style="border-radius: 12px;">
                        <i class="fas fa-print me-2"></i> Print / Save PDF
                    </button>
                    <button id="downloadInvoice" class="btn btn-outline-primary shadow-sm px-4"
                        style="border-radius: 12px;">
                        <i class="fas fa-file-download me-2"></i> Download CSV
                    </button>
                    <a href="${pageContext.request.contextPath}/booking/view?id=${reservation.reservationNumber}"
                        class="btn btn-light shadow-sm px-4" style="border-radius: 12px;">
                        <i class="fas fa-arrow-left me-2"></i> Back
                    </a>
                </div>
            </div>

            <div class="invoice-container mb-5">
                <div class="premium-card p-0 overflow-hidden shadow-lg border-0"
                    style="border-radius: 25px; background: #fff;">
                    <!-- Header -->
                    <div class="p-5" style="background: linear-gradient(135deg, #03045e 0%, #0077b6 100%);">
                        <div class="row align-items-center">
                            <div class="col-md-6 text-white">
                                <h2 class="fw-800 mb-1"
                                    style="font-family: 'Playfair Display', serif; letter-spacing: 1px;">OCEAN VIEW
                                    RESORT</h2>
                                <p class="mb-0 opacity-75 small">Coastal Road, Galle, Sri Lanka <br> +94 91 234 5678 |
                                    info@oceanviewresort.com</p>
                            </div>
                            <div class="col-md-6 text-md-end text-white mt-4 mt-md-0">
                                <h4 class="fw-bold mb-0 text-uppercase" style="letter-spacing: 2px;">Invoice</h4>
                                <div class="opacity-75 small">#${reservation.reservationNumber}</div>
                            </div>
                        </div>
                    </div>

                    <div class="p-5">
                        <!-- Client & Date Details -->
                        <div class="row mb-5">
                            <div class="col-md-6">
                                <h6 class="text-muted small fw-800 text-uppercase mb-3" style="letter-spacing: 1px;">
                                    Invoiced To</h6>
                                <h4 class="fw-bold text-dark mb-1">${reservation.guest.name}</h4>
                                <p class="text-muted mb-0 small">
                                    ${reservation.guest.address} <br>
                                    Contact: ${reservation.guest.contactNumber}
                                </p>
                            </div>
                            <div class="col-md-6 text-md-end">
                                <div class="mb-3">
                                    <h6 class="text-muted small fw-800 text-uppercase mb-1"
                                        style="letter-spacing: 1px;">Issue Date</h6>
                                    <div class="fw-bold text-dark">
                                        <fmt:formatDate value="<%= new java.util.Date() %>" pattern="MMMM dd, yyyy" />
                                    </div>
                                </div>
                                <div>
                                    <h6 class="text-muted small fw-800 text-uppercase mb-1"
                                        style="letter-spacing: 1px;">Payment Method</h6>
                                    <div class="badge bg-light text-dark px-3 py-2 fw-bold" style="border-radius: 8px;">
                                        CASH / CARD</div>
                                </div>
                            </div>
                        </div>

                        <!-- Table -->
                        <div class="table-responsive mb-5">
                            <table class="table table-borderless">
                                <thead>
                                    <tr class="border-bottom"
                                        style="color: #64748b; font-size: 0.8rem; font-weight: 700; text-transform: uppercase; letter-spacing: 1px;">
                                        <th class="pb-3 text-start">Description</th>
                                        <th class="pb-3 text-center">Stay Dates</th>
                                        <th class="pb-3 text-center">Nights</th>
                                        <th class="pb-3 text-end text-nowrap">Unit Price</th>
                                        <th class="pb-3 text-end">Total</th>
                                    </tr>
                                </thead>
                                <tbody class="border-bottom">
                                    <tr>
                                        <td class="py-4">
                                            <div class="fw-bold text-dark fs-5">Room Reservation</div>
                                            <div class="text-muted small">Room ${reservation.room.roomNumber} -
                                                ${reservation.room.roomType.typeName}</div>
                                        </td>
                                        <td class="py-4 text-center text-muted">
                                            ${reservation.checkInDate} &rarr; ${reservation.checkOutDate}
                                        </td>
                                        <td class="py-4 text-center text-dark">
                                            <jsp:useBean id="now" class="java.util.Date" />
                                            <fmt:parseDate value="${reservation.checkInDate}" var="d1"
                                                pattern="yyyy-MM-dd" />
                                            <fmt:parseDate value="${reservation.checkOutDate}" var="d2"
                                                pattern="yyyy-MM-dd" />
                                            <c:set var="diff" value="${d2.time - d1.time}" />
                                            <fmt:formatNumber value="${diff / (1000 * 60 * 60 * 24)}" pattern="#" />
                                            Nights
                                        </td>
                                        <td class="py-4 text-end text-muted">
                                            LKR
                                            <fmt:formatNumber value="${reservation.room.roomType.ratePerNight}"
                                                pattern="#,###.00" />
                                        </td>
                                        <td class="py-4 text-end fw-bold text-dark">
                                            LKR
                                            <fmt:formatNumber value="${reservation.totalCost}" pattern="#,###.00" />
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <!-- Totals -->
                        <div class="row justify-content-end text-end">
                            <div class="col-md-4">
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="text-muted">Subtotal</span>
                                    <span class="fw-bold">LKR
                                        <fmt:formatNumber value="${reservation.totalCost}" pattern="#,###.00" />
                                    </span>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="text-muted">Taxes & Fees (Included)</span>
                                    <span class="fw-bold">LKR 0.00</span>
                                </div>
                                <hr class="my-3">
                                <div class="d-flex justify-content-between align-items-center">
                                    <span class="fw-800 h4 mb-0 text-dark">Grand Total</span>
                                    <span class="fw-800 h3 mb-0 text-primary">LKR
                                        <fmt:formatNumber value="${reservation.totalCost}" pattern="#,###.00" />
                                    </span>
                                </div>
                            </div>
                        </div>

                        <!-- Footer Note -->
                        <div class="mt-5 pt-5 border-top text-center text-muted small">
                            <p class="mb-1 fw-bold">Thank you for staying at Ocean View Resort!</p>
                            <p class="mb-0">This is a computer-generated invoice and does not require a physical
                                signature.</p>
                        </div>
                    </div>

                    <!-- Bottom Bar -->
                    <div style="height: 10px; background: #03045e;"></div>
                </div>
            </div>

            <style>
                @media print {

                    .no-print,
                    .sidebar,
                    .staff-navbar {
                        display: none !important;
                    }

                    .main-content,
                    .main-content-staff {
                        margin: 0 !important;
                        padding: 0 !important;
                    }

                    body {
                        background: #fff !important;
                    }

                    .invoice-container {
                        margin-top: 0 !important;
                    }

                    .premium-card {
                        box-shadow: none !important;
                        border: 1px solid #eee !important;
                    }
                }
            </style>

            <jsp:include page="includes/footer.jsp" />

            <script>
                // Simple CSV download for the invoice summary
                document.getElementById('downloadInvoice')?.addEventListener('click', function () {
                    const rows = [
                        ['Invoice', '${reservation.reservationNumber}'],
                        ['Guest', '${reservation.guest.name}'],
                        ['Room', '${reservation.room.roomNumber} (${reservation.room.roomType.typeName})'],
                        ['Check-in', '${reservation.checkInDate}'],
                        ['Check-out', '${reservation.checkOutDate}'],
                        ['Total (LKR)', '${reservation.totalCost}']
                    ];
                    const csv = rows.map(r => r.map(v => `"${v}"`).join(',')).join('\\n');
                    const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' });
                    const url = URL.createObjectURL(blob);
                    const a = document.createElement('a');
                    a.href = url;
                    a.download = `invoice-${'${reservation.reservationNumber}'}.csv`;
                    document.body.appendChild(a);
                    a.click();
                    document.body.removeChild(a);
                    URL.revokeObjectURL(url);
                });
            </script>
