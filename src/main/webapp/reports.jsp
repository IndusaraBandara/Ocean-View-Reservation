<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <jsp:include page="includes/header.jsp" />

            <div class="row mb-5 animate__animated animate__fadeIn">
                <div class="col-md-6">
                    <h2 class="fw-bold text-dark"><i class="fas fa-chart-line me-2 text-primary"></i>Executive Reports
                    </h2>
                    <p class="text-muted">Analyze resort performance, revenue trends, and occupancy metrics.</p>
                </div>
                <div class="col-md-6 text-end">
                    <div class="d-flex justify-content-end gap-2 flex-wrap">
                        <button onclick="window.print()" class="btn btn-dark shadow-sm px-4" style="border-radius: 12px;">
                            <i class="fas fa-file-pdf me-2"></i> Print / Save PDF
                        </button>
                        <button class="btn btn-outline-success shadow-sm px-4" style="border-radius: 12px;"
                            id="downloadReportCsv">
                            <i class="fas fa-file-download me-2"></i> Download CSV
                        </button>
                    </div>
                </div>
            </div>

            <!-- Key Performance Indicators -->
            <div class="row g-4 mb-5 animate__animated animate__fadeInUp">
                <div class="col-md-3">
                    <div class="premium-card p-4 text-center"
                        style="border-radius: 20px; border-bottom: 4px solid #0077b6;">
                        <div class="small fw-bold text-muted text-uppercase mb-2">Total Revenue</div>
                        <div class="h3 fw-800 text-dark mb-0">LKR 465,000</div>
                        <div class="small text-success mt-2"><i class="fas fa-arrow-up me-1"></i> 12.5%</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="premium-card p-4 text-center"
                        style="border-radius: 20px; border-bottom: 4px solid #f59e0b;">
                        <div class="small fw-bold text-muted text-uppercase mb-2">Occupancy Rate</div>
                        <div class="h3 fw-800 text-dark mb-0">78.4%</div>
                        <div class="small text-success mt-2"><i class="fas fa-arrow-up me-1"></i> 3.2%</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="premium-card p-4 text-center"
                        style="border-radius: 20px; border-bottom: 4px solid #10b981;">
                        <div class="small fw-bold text-muted text-uppercase mb-2">Avg. Nightly Rate</div>
                        <div class="h3 fw-800 text-dark mb-0">LKR 9,250</div>
                        <div class="small text-muted mt-2">Target met</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="premium-card p-4 text-center"
                        style="border-radius: 20px; border-bottom: 4px solid #ef4444;">
                        <div class="small fw-bold text-muted text-uppercase mb-2">Cancellations</div>
                        <div class="h3 fw-800 text-dark mb-0">14</div>
                        <div class="small text-danger mt-2"><i class="fas fa-arrow-up me-1"></i> 2 new</div>
                    </div>
                </div>
            </div>

            <style>
                /* Ensure charts always render with visible height */
                .chart-box canvas {
                    width: 100% !important;
                    height: 320px !important;
                }
                .chart-box-small canvas {
                    width: 100% !important;
                    height: 220px !important;
                }
            </style>

            <!-- Timeframe Switcher -->
            <div class="premium-card p-4 mb-4" style="border-radius: 20px;">
                <div class="d-flex align-items-center justify-content-between flex-wrap gap-3">
                    <div>
                        <h5 class="fw-bold mb-1" style="color: #03045e;">Timeframe Insights</h5>
                        <p class="text-muted small mb-0">Toggle to view daily, weekly, and monthly performance.</p>
                    </div>
                    <div class="btn-group" role="group">
                        <button class="btn btn-outline-primary active" id="btnDaily">Daily</button>
                        <button class="btn btn-outline-primary" id="btnWeekly">Weekly</button>
                        <button class="btn btn-outline-primary" id="btnMonthly">Monthly</button>
                    </div>
                </div>
            </div>

            <div class="row g-4 mb-5">
                <!-- Revenue Chart -->
                <div class="col-lg-7 animate__animated animate__fadeInLeft">
                    <div class="premium-card p-4 chart-box" style="border-radius: 25px;">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5 class="fw-bold mb-0" style="color: #03045e;">Revenue Trend</h5>
                            <span class="badge bg-primary bg-opacity-10 text-primary" id="revLabel">Monthly</span>
                        </div>
                        <canvas id="revenueChart" height="300"></canvas>
                    </div>
                </div>

                <!-- Occupancy / ADR -->
                <div class="col-lg-5 animate__animated animate__fadeInRight">
                    <div class="premium-card p-4 mb-4 chart-box-small" style="border-radius: 20px;">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <h6 class="fw-bold mb-0" style="color: #03045e;">Occupancy & ADR</h6>
                            <span class="badge bg-success bg-opacity-10 text-success" id="occLabel">Monthly</span>
                        </div>
                        <canvas id="occChart" height="180"></canvas>
                    </div>
                    <div class="premium-card p-4 chart-box-small" style="border-radius: 20px;">
                        <h6 class="fw-bold mb-3" style="color: #03045e;">Room Popularity</h6>
                        <canvas id="roomTypeChart" height="180"></canvas>
                    </div>
                </div>
            </div>

            <div class="row g-4 mb-5">
                <div class="col-lg-6">
                    <div class="premium-card p-4 chart-box" style="border-radius: 22px;">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h6 class="fw-bold mb-0" style="color: #03045e;">Daily Booking Pace</h6>
                            <span class="badge bg-warning bg-opacity-10 text-warning">Last 14 days</span>
                        </div>
                        <canvas id="bookingPaceChart" height="240"></canvas>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="premium-card p-4 chart-box" style="border-radius: 22px;">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h6 class="fw-bold mb-0" style="color: #03045e;">Cancellation vs Payment</h6>
                            <span class="badge bg-danger bg-opacity-10 text-danger">This quarter</span>
                        </div>
                        <canvas id="cxlChart" height="240"></canvas>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
            <script>
                // Fallback if CDN fails (Chart undefined): show a friendly notice.
                function ensureChartAvailable() {
                    if (typeof Chart === 'undefined') {
                        const warn = document.createElement('div');
                        warn.className = 'alert alert-warning mt-3';
                        warn.textContent = 'Charts could not load (offline?). Please reconnect and reload.';
                        document.querySelector('.premium-card')?.prepend(warn);
                        return false;
                    }
                    return true;
                }
            </script>
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    if (!ensureChartAvailable()) return;
                    // Dataset presets
                    const dataSets = {
                        daily: {
                            revenue: { labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'], data: [52000, 61000, 48000, 73000, 82000, 91000, 87000] },
                            occ: { labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'], occ: [68, 70, 66, 74, 82, 88, 85], adr: [8900, 9100, 8700, 9400, 9800, 10500, 10100] }
                        },
                        weekly: {
                            revenue: { labels: ['W1', 'W2', 'W3', 'W4', 'W5'], data: [420000, 510000, 465000, 560000, 590000] },
                            occ: { labels: ['W1', 'W2', 'W3', 'W4', 'W5'], occ: [72, 74, 73, 79, 81], adr: [9000, 9100, 9050, 9500, 9700] }
                        },
                        monthly: {
                            revenue: { labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'], data: [120000, 150000, 135000, 210000, 245000, 220000, 280000, 310000, 290000, 340000, 380000, 465000] },
                            occ: { labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'], occ: [62, 65, 68, 70, 72, 75, 78, 80, 77, 79, 81, 83], adr: [8200, 8400, 8600, 8800, 9000, 9200, 9500, 9700, 9600, 9900, 10100, 10300] }
                        }
                    };

                    const roomPopularity = { labels: ['Suites', 'Double', 'Single'], data: [42, 35, 23] };
                    const bookingPace = { labels: Array.from({ length: 14 }, (_, i) => 'D-' + (14 - i)), data: [14, 11, 16, 18, 19, 17, 21, 23, 20, 22, 24, 26, 25, 28] };
                    const cxl = { labels: ['Jan', 'Feb', 'Mar'], cancels: [6, 5, 4], payments: [180, 210, 240] };

                    // Revenue Chart
                    const revCtx = document.getElementById('revenueChart').getContext('2d');
                    const revenueChart = new Chart(revCtx, {
                        type: 'line',
                        data: {
                            labels: dataSets.monthly.revenue.labels,
                            datasets: [{
                                label: 'Revenue (LKR)',
                                data: dataSets.monthly.revenue.data,
                                borderColor: '#0077b6',
                                backgroundColor: 'rgba(0, 119, 182, 0.1)',
                                fill: true,
                                tension: 0.35,
                                pointRadius: 4,
                                pointHoverRadius: 7
                            }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: { legend: { display: false } },
                            scales: {
                                y: { grid: { borderDash: [5, 5] }, ticks: { callback: v => 'LKR ' + (v / 1000) + 'K' } },
                                x: { grid: { display: false } }
                            }
                        }
                    });

                    // Occupancy & ADR Chart
                    const occCtx = document.getElementById('occChart').getContext('2d');
                    const occChart = new Chart(occCtx, {
                        type: 'bar',
                        data: {
                            labels: dataSets.monthly.occ.labels,
                            datasets: [{
                                label: 'Occupancy %',
                                data: dataSets.monthly.occ.occ,
                                backgroundColor: 'rgba(67, 97, 238, 0.25)',
                                borderColor: '#4361ee',
                                borderWidth: 1,
                                yAxisID: 'y'
                            }, {
                                label: 'ADR (LKR)',
                                type: 'line',
                                data: dataSets.monthly.occ.adr,
                                borderColor: '#f59e0b',
                                backgroundColor: 'rgba(245, 158, 11, 0.15)',
                                tension: 0.35,
                                yAxisID: 'y1'
                            }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: { legend: { display: false } },
                            scales: {
                                y: { position: 'left', max: 100, ticks: { callback: v => v + '%' } },
                                y1: { position: 'right', grid: { drawOnChartArea: false }, ticks: { callback: v => 'LKR ' + v } },
                                x: { grid: { display: false } }
                            }
                        }
                    });

                    // Room Distribution Chart
                    const roomCtx = document.getElementById('roomTypeChart').getContext('2d');
                    const roomChart = new Chart(roomCtx, {
                        type: 'doughnut',
                        data: {
                            labels: roomPopularity.labels,
                            datasets: [{
                                data: roomPopularity.data,
                                backgroundColor: ['#03045e', '#0077b6', '#00b4d8'],
                                borderWidth: 0,
                                hoverOffset: 15
                            }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: { legend: { display: false } },
                            cutout: '70%'
                        }
                    });

                    // Booking Pace
                    const paceCtx = document.getElementById('bookingPaceChart').getContext('2d');
                    const paceChart = new Chart(paceCtx, {
                        type: 'bar',
                        data: {
                            labels: bookingPace.labels,
                            datasets: [{
                                label: 'Bookings',
                                data: bookingPace.data,
                                backgroundColor: '#00b4d8'
                            }]
                        },
                        options: {
                            plugins: { legend: { display: false } },
                            scales: { x: { grid: { display: false } }, y: { grid: { borderDash: [5, 5] } } },
                            responsive: true,
                            maintainAspectRatio: false
                        }
                    });

                    // Cancellations vs Payments
                    const cxlCtx = document.getElementById('cxlChart').getContext('2d');
                    const cxlChart = new Chart(cxlCtx, {
                        data: {
                            labels: cxl.labels,
                            datasets: [{
                                type: 'bar',
                                label: 'Payments',
                                data: cxl.payments,
                                backgroundColor: '#10b981'
                            }, {
                                type: 'bar',
                                label: 'Cancellations',
                                data: cxl.cancels,
                                backgroundColor: '#ef4444'
                            }]
                        },
                        options: {
                            plugins: { legend: { display: true } },
                            responsive: true,
                            maintainAspectRatio: false,
                            scales: { x: { grid: { display: false } }, y: { grid: { borderDash: [5, 5] } } }
                        }
                    });

                    // Toggle handlers
                    const btnDaily = document.getElementById('btnDaily');
                    const btnWeekly = document.getElementById('btnWeekly');
                    const btnMonthly = document.getElementById('btnMonthly');
                    const revLabel = document.getElementById('revLabel');
                    const occLabel = document.getElementById('occLabel');

                    function activate(btn) {
                        [btnDaily, btnWeekly, btnMonthly].forEach(b => b.classList.remove('active'));
                        btn.classList.add('active');
                    }

                    function updateCharts(key) {
                        const set = dataSets[key];
                        revenueChart.data.labels = set.revenue.labels;
                        revenueChart.data.datasets[0].data = set.revenue.data;
                        revenueChart.update();

                        occChart.data.labels = set.occ.labels;
                        occChart.data.datasets[0].data = set.occ.occ;
                        occChart.data.datasets[1].data = set.occ.adr;
                        occChart.update();

                        revLabel.textContent = key.charAt(0).toUpperCase() + key.slice(1);
                        occLabel.textContent = key.charAt(0).toUpperCase() + key.slice(1);
                    }

                    btnDaily.addEventListener('click', () => { activate(btnDaily); updateCharts('daily'); });
                    btnWeekly.addEventListener('click', () => { activate(btnWeekly); updateCharts('weekly'); });
                    btnMonthly.addEventListener('click', () => { activate(btnMonthly); updateCharts('monthly'); });

                    // CSV export for current timeframe (revenue + occupancy + room mix + booking pace)
                    document.getElementById('downloadReportCsv')?.addEventListener('click', () => {
                        const activeKey = document.querySelector('.btn-group .btn.active')?.id?.replace('btn','').toLowerCase() || 'monthly';
                        const set = dataSets[activeKey] || dataSets.monthly;
                        const rows = [];

                        rows.push(['Revenue & Occupancy (' + activeKey + ')']);
                        rows.push(['Label', 'Revenue (LKR)', 'Occupancy %', 'ADR (LKR)']);
                        set.revenue.labels.forEach((label, idx) => {
                            const revenue = set.revenue.data[idx] ?? '';
                            const occ = set.occ.occ[idx] ?? '';
                            const adr = set.occ.adr[idx] ?? '';
                            rows.push([label, revenue, occ, adr]);
                        });
                        rows.push(['']); // spacer

                        rows.push(['Room Popularity']);
                        rows.push(['Label', 'Share %']);
                        roomPopularity.labels.forEach((label, idx) => {
                            rows.push([label, roomPopularity.data[idx]]);
                        });
                        rows.push(['']);

                        rows.push(['Booking Pace (last 14 days)']);
                        rows.push(['Day', 'Bookings']);
                        bookingPace.labels.forEach((label, idx) => rows.push([label, bookingPace.data[idx]]));
                        rows.push(['']);

                        rows.push(['Cancellations vs Payments']);
                        rows.push(['Month', 'Payments', 'Cancellations']);
                        cxl.labels.forEach((label, idx) => rows.push([label, cxl.payments[idx], cxl.cancels[idx]]));

                        const csv = rows.map(r => r.map(v => '\"' + (v ?? '') + '\"').join(',')).join('\\n');
                        const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' });
                        const url = URL.createObjectURL(blob);
                        const a = document.createElement('a');
                        a.href = url;
                        a.download = 'reports-' + activeKey + '.csv';
                        document.body.appendChild(a);
                        a.click();
                        document.body.removeChild(a);
                        URL.revokeObjectURL(url);
                    });
                });
            </script>

            <jsp:include page="includes/footer.jsp" />
