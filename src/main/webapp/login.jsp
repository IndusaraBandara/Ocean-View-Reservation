<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Login â€” Ocean View Resort Portal</title>
            <link
                href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&family=Playfair+Display:wght@700&display=swap"
                rel="stylesheet">
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <style>
                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                }

                body {
                    font-family: 'Outfit', sans-serif;
                    min-height: 100vh;
                    display: flex;
                    overflow: hidden;
                }

                /* â”€â”€ LEFT PANEL (image) â”€â”€ */
                .login-image-panel {
                    flex: 1;
                    background: url('${pageContext.request.contextPath}/assets/images/resort_hero_bg.jpg') center center / cover no-repeat;
                    position: relative;
                    display: none;
                    /* hidden on mobile */
                }

                @media (min-width: 992px) {
                    .login-image-panel {
                        display: block;
                    }
                }

                .login-image-panel::before {
                    content: '';
                    position: absolute;
                    inset: 0;
                }

                .image-panel-content {
                    position: absolute;
                    inset: 0;
                    display: flex;
                    flex-direction: column;
                    justify-content: flex-end;
                    padding: 50px;
                    color: #fff;
                }

                .image-panel-content h2 {
                    font-family: 'Playfair Display', serif;
                    font-size: 2.6rem;
                    font-weight: 700;
                    line-height: 1.2;
                    margin-bottom: 14px;
                }

                .image-panel-content p {
                    color: rgba(255, 255, 255, 0.75);
                    font-size: 1rem;
                    max-width: 380px;
                    line-height: 1.7;
                }

                .panel-badge {
                    display: inline-flex;
                    align-items: center;
                    gap: 8px;
                    background: rgba(255, 255, 255, 0.15);
                    border: 1px solid rgba(255, 255, 255, 0.25);
                    border-radius: 50px;
                    padding: 8px 20px;
                    font-size: 0.8rem;
                    letter-spacing: 2px;
                    text-transform: uppercase;
                    margin-bottom: 20px;
                    width: fit-content;
                }

                /* â”€â”€ RIGHT PANEL (form) â”€â”€ */
                .login-form-panel {
                    width: 100%;
                    max-width: 480px;
                    min-height: 100vh;
                    background: #fff;
                    display: flex;
                    flex-direction: column;
                    justify-content: flex-start;
                    padding: 60px 50px;
                    position: relative;
                    overflow-y: auto;
                    gap: 12px;
                }

                @media (max-width: 991px) {
                    .login-form-panel {
                        max-width: 100%;
                        padding: 40px 24px;
                    }
                }

                .login-logo {
                    display: flex;
                    align-items: center;
                    gap: 10px;
                    margin-bottom: 40px;
                }

                .login-logo-icon {
                    width: 46px;
                    height: 46px;
                    background: linear-gradient(135deg, #0077b6, #00b4d8);
                    border-radius: 12px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    color: #fff;
                    font-size: 1.2rem;
                }

                .login-logo-text {
                    font-weight: 800;
                    font-size: 1.2rem;
                    color: #03045e;
                    letter-spacing: 0.5px;
                }

                .login-logo-text small {
                    display: block;
                    font-size: 0.7rem;
                    font-weight: 400;
                    color: #6c757d;
                    letter-spacing: 1px;
                    text-transform: uppercase;
                }

                h1.login-title {
                    font-weight: 800;
                    font-size: 2rem;
                    color: #03045e;
                    margin-bottom: 6px;
                }

                .login-sub {
                    color: #6c757d;
                    font-size: 0.95rem;
                    margin-bottom: 36px;
                }

                .form-label {
                    font-size: 0.78rem;
                    font-weight: 700;
                    color: #6c757d;
                    letter-spacing: 1px;
                    text-transform: uppercase;
                    margin-bottom: 6px;
                }

                .form-control {
                    border: 2px solid #e9ecef;
                    border-radius: 12px;
                    padding: 14px 16px;
                    font-size: 0.98rem;
                    font-family: 'Outfit', sans-serif;
                    color: #03045e;
                    transition: all 0.2s;
                }

                .form-control:focus {
                    border-color: #00b4d8;
                    box-shadow: 0 0 0 4px rgba(0, 180, 216, 0.12);
                }

                .input-group-icon {
                    position: relative;
                }

                .input-group-icon .form-control {
                    padding-left: 48px;
                }

                .input-group-icon .input-icon {
                    position: absolute;
                    left: 16px;
                    top: 50%;
                    transform: translateY(-50%);
                    color: #adb5bd;
                    z-index: 5;
                }

                .btn-login {
                    background: linear-gradient(45deg, #0077b6, #00b4d8);
                    border: none;
                    border-radius: 12px;
                    padding: 15px;
                    font-size: 1rem;
                    font-weight: 700;
                    letter-spacing: 0.5px;
                    color: #fff;
                    width: 100%;
                    transition: all 0.3s;
                    box-shadow: 0 6px 20px rgba(0, 180, 216, 0.35);
                    font-family: 'Outfit', sans-serif;
                }

                .btn-login:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 10px 30px rgba(0, 180, 216, 0.5);
                }

                .back-link {
                    display: inline-flex;
                    align-items: center;
                    gap: 6px;
                    color: #6c757d;
                    text-decoration: none;
                    font-size: 0.88rem;
                    margin-bottom: 32px;
                    transition: color 0.2s;
                }

                .back-link:hover {
                    color: #0077b6;
                }

                .divider {
                    border: 0;
                    border-top: 1px solid #e9ecef;
                    margin: 24px 0;
                }

                .alert-danger {
                    border-radius: 12px;
                    border: 0;
                    padding: 12px 16px;
                    background: #fff5f5;
                    color: #c62828;
                    font-size: 0.9rem;
                }

                .login-footer {
                    margin-top: 32px;
                    color: #adb5bd;
                    font-size: 0.8rem;
                    text-align: center;
                }
            </style>
        </head>

        <body>

            <!-- â”€â”€ LEFT: Resort Image Panel â”€â”€ -->
            <div class="login-image-panel">
                <div class="image-panel-content">
                    <div class="panel-badge">
                        <i class="fas fa-star"></i> 5-Star Luxury Resort
                    </div>
                    <h2>Your Gateway to<br>Coastal Paradise</h2>
                    <p>Manage reservations, guests, and resort operations with ease. The complete hotel management
                        system for Ocean View Resort, Galle.</p>

                    <hr style="border-color:rgba(255,255,255,0.2); margin: 30px 0;">

                    <div class="d-flex gap-4">
                        <div>
                            <div style="font-size:1.6rem;font-weight:800;">500+</div>
                            <div style="font-size:0.8rem;opacity:0.7;">Happy Guests</div>
                        </div>
                        <div>
                            <div style="font-size:1.6rem;font-weight:800;">42</div>
                            <div style="font-size:0.8rem;opacity:0.7;">Luxury Rooms</div>
                        </div>
                        <div>
                            <div style="font-size:1.6rem;font-weight:800;">5â˜…</div>
                            <div style="font-size:0.8rem;opacity:0.7;">Rating</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- â”€â”€ RIGHT: Login Form Panel â”€â”€ -->
            <div class="login-form-panel">

                <!-- Back to home -->
                <a href="${pageContext.request.contextPath}/" class="back-link">
                    <i class="fas fa-arrow-left"></i> Back to Home
                </a>

                <!-- Logo -->
                <div class="login-logo">
                    <div class="login-logo-icon"><i class="fas fa-umbrella-beach"></i></div>
                    <div class="login-logo-text">
                        OCEAN VIEW
                        <small>Resort Management</small>
                    </div>
                </div>

                <h1 class="login-title">Welcome back</h1>
                <p class="login-sub">Sign in to access the Staff & Admin Management System.</p>

                <!-- Error -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger mb-4">
                        <i class="fas fa-exclamation-circle me-2"></i>${error}
                    </div>
                </c:if>
                <c:if test="${param.logout == '1'}">
                    <div class="alert alert-success mb-4">
                        <i class="fas fa-check-circle me-2"></i>You have been logged out safely. See you soon!
                    </div>
                </c:if>

                <!-- Form -->
                <form action="${pageContext.request.contextPath}/login" method="post" autocomplete="on">
                    <div class="mb-4">
                        <label class="form-label">Username</label>
                        <div class="input-group-icon">
                            <i class="fas fa-user input-icon"></i>
                            <input type="text" class="form-control" name="username" placeholder="Enter your username"
                                required autofocus>
                        </div>
                    </div>
                    <div class="mb-4">
                        <label class="form-label">Password</label>
                        <div class="input-group-icon">
                            <i class="fas fa-lock input-icon"></i>
                            <input type="password" class="form-control" name="password"
                                placeholder="Enter your password" required>
                        </div>
                    </div>

                    <button type="submit" class="btn-login">
                        <i class="fas fa-sign-in-alt me-2"></i> SIGN IN
                    </button>
                </form>

                <div class="login-footer">
                    &copy; 2026 Ocean View Resort &nbsp;Â·&nbsp;
                    <i class="fas fa-shield-alt me-1"></i> Secure Login
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>
