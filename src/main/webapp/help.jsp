<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <jsp:include page="includes/header.jsp" />

        <div class="row mb-4">
            <div class="col">
                <h2 class="fw-bold"><i class="fas fa-question-circle me-2 text-primary"></i>Help & User Guide</h2>
                <p class="text-muted">Guidelines for new staff members on how to use the Ocean View Reservation System.
                </p>
            </div>
        </div>

        <div class="row g-4">
            <!-- Quick Actions Overview -->
            <div class="col-12">
                <div class="premium-card p-4 border-0 shadow-sm" style="border-radius: 18px;">
                    <h5 class="fw-bold mb-3" style="color: #03045e;">Essential Tasks (Quick Guide)</h5>
                    <ol class="text-muted mb-0">
                        <li class="mb-2"><strong>Add New Reservation:</strong> Capture reservation #, guest name, address, contact, room type, and stay dates. Navigate to <em>New Reservation</em>, fill details, and save.</li>
                        <li class="mb-2"><strong>Display Reservation Details:</strong> Open <em>All Reservations</em>, search the reservation number, and view the full booking card.</li>
                        <li class="mb-2"><strong>Calculate & Print Bill:</strong> From a reservation, click <em>Bill</em> or <em>Generate Invoice</em> to auto-calc nights × rate; print or download the invoice.</li>
                        <li class="mb-2"><strong>Help Section:</strong> Use this page anytime to review steps for staff onboarding.</li>
                        <li class="mb-2"><strong>Exit System:</strong> Click your name → <em>Logout</em> to end the session safely.</li>
                    </ol>
                </div>
            </div>
            <!-- Section 1: Getting Started -->
            <div class="col-md-6">
                <div class="premium-card p-4 h-100">
                    <div class="d-flex align-items-center mb-3">
                        <div class="bg-primary rounded-circle p-3 text-white me-3"><i class="fas fa-sign-in-alt"></i>
                        </div>
                        <h5 class="fw-bold mb-0">1. Logging In</h5>
                    </div>
                    <ul class="list-unstyled text-muted">
                        <li class="mb-2"><i class="fas fa-check-circle text-success me-2"></i>Enter your username and
                            password on the login page.</li>
                        <li class="mb-2"><i class="fas fa-check-circle text-success me-2"></i>Admin users are redirected
                            to the <strong>Admin Dashboard</strong>.</li>
                        <li class="mb-2"><i class="fas fa-check-circle text-success me-2"></i>Staff users are redirected
                            to the <strong>Operations Dashboard</strong>.</li>
                        <li><i class="fas fa-info-circle text-info me-2"></i>Contact your Admin if you forget your
                            password.</li>
                    </ul>
                </div>
            </div>

            <!-- Section 2: Making a Reservation -->
            <div class="col-md-6">
                <div class="premium-card p-4 h-100">
                    <div class="d-flex align-items-center mb-3">
                        <div class="bg-success rounded-circle p-3 text-white me-3"><i class="fas fa-calendar-plus"></i>
                        </div>
                        <h5 class="fw-bold mb-0">2. Creating a Reservation</h5>
                    </div>
                    <ul class="list-unstyled text-muted">
                        <li class="mb-2"><i class="fas fa-check-circle text-success me-2"></i>Click <strong>"New
                                Reservation"</strong> from the dashboard or navigation bar.</li>
                        <li class="mb-2"><i class="fas fa-check-circle text-success me-2"></i>Fill in guest details:
                            name, address, contact number.</li>
                        <li class="mb-2"><i class="fas fa-check-circle text-success me-2"></i>Select an available room
                            and pick check-in / check-out dates.</li>
                        <li><i class="fas fa-check-circle text-success me-2"></i>The system will auto-calculate the
                            total cost based on room rate and nights.</li>
                    </ul>
                </div>
            </div>

            <!-- Section 3: Viewing & Billing -->
            <div class="col-md-6">
                <div class="premium-card p-4 h-100">
                    <div class="d-flex align-items-center mb-3">
                        <div class="bg-warning rounded-circle p-3 text-white me-3"><i
                                class="fas fa-file-invoice-dollar"></i></div>
                        <h5 class="fw-bold mb-0">3. Billing & Payments</h5>
                    </div>
                    <ul class="list-unstyled text-muted">
                        <li class="mb-2"><i class="fas fa-check-circle text-success me-2"></i>Navigate to <strong>"All
                                Bookings"</strong> to find a reservation.</li>
                        <li class="mb-2"><i class="fas fa-check-circle text-success me-2"></i>Click
                            <strong>"Bill"</strong> to view the invoice for a reservation.</li>
                        <li class="mb-2"><i class="fas fa-check-circle text-success me-2"></i>Choose a payment method
                            (Cash, Credit Card, etc.) and click <strong>"Pay Now"</strong>.</li>
                        <li><i class="fas fa-check-circle text-success me-2"></i>You can print the bill using the
                            <strong>"Print Bill"</strong> button.</li>
                    </ul>
                </div>
            </div>

            <!-- Section 4: Admin Functions -->
            <div class="col-md-6">
                <div class="premium-card p-4 h-100">
                    <div class="d-flex align-items-center mb-3">
                        <div class="bg-danger rounded-circle p-3 text-white me-3"><i class="fas fa-user-shield"></i>
                        </div>
                        <h5 class="fw-bold mb-0">4. Admin Functions</h5>
                    </div>
                    <ul class="list-unstyled text-muted">
                        <li class="mb-2"><i class="fas fa-check-circle text-success me-2"></i><strong>Staff
                                Management</strong>: Add or remove staff members from the system.</li>
                        <li class="mb-2"><i class="fas fa-check-circle text-success me-2"></i><strong>Room
                                Management</strong>: Add new rooms, update types, or change room status.</li>
                        <li class="mb-2"><i class="fas fa-check-circle text-success me-2"></i><strong>Reports</strong>:
                            View daily, weekly, and monthly booking/payment analytics.</li>
                        <li><i class="fas fa-info-circle text-info me-2"></i>Only Admin users have access to these
                            pages.</li>
                    </ul>
                </div>
            </div>

            <!-- Section 5: Profile -->
            <div class="col-md-6">
                <div class="premium-card p-4 h-100">
                    <div class="d-flex align-items-center mb-3">
                        <div class="bg-info rounded-circle p-3 text-white me-3"><i class="fas fa-user-edit"></i></div>
                        <h5 class="fw-bold mb-0">5. Managing Your Profile</h5>
                    </div>
                    <ul class="list-unstyled text-muted">
                        <li class="mb-2"><i class="fas fa-check-circle text-success me-2"></i>Click your name in the top
                            right &rarr; <strong>"My Profile"</strong>.</li>
                        <li class="mb-2"><i class="fas fa-check-circle text-success me-2"></i>Update your display name
                            and upload a profile picture.</li>
                        <li><i class="fas fa-check-circle text-success me-2"></i>Use the <strong>"Security /
                                Password"</strong> tab to reset your password.</li>
                    </ul>
                </div>
            </div>

            <!-- Section 6: Logging Out -->
            <div class="col-md-6">
                <div class="premium-card p-4 h-100">
                    <div class="d-flex align-items-center mb-3">
                        <div class="bg-secondary rounded-circle p-3 text-white me-3"><i class="fas fa-sign-out-alt"></i>
                        </div>
                        <h5 class="fw-bold mb-0">6. Exiting the System</h5>
                    </div>
                    <ul class="list-unstyled text-muted">
                        <li class="mb-2"><i class="fas fa-check-circle text-success me-2"></i>Click your name in the
                            top-right corner.</li>
                        <li class="mb-2"><i class="fas fa-check-circle text-success me-2"></i>Select
                            <strong>"Logout"</strong> from the dropdown.</li>
                        <li><i class="fas fa-info-circle text-info me-2"></i>Your session is securely destroyed on
                            logout.</li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="premium-card p-4 mt-4 bg-primary text-white">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h5 class="fw-bold mb-1">Still need help?</h5>
                    <p class="mb-0 opacity-75">Contact your system administrator or the IT department for additional
                        support.</p>
                </div>
                <div class="col-md-4 text-end">
                    <span class="fs-5"><i class="fas fa-phone me-2"></i>+94 91 222 3333</span>
                </div>
            </div>
        </div>

        <jsp:include page="includes/footer.jsp" />
