<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Ocean View Resort — Beachside Luxury, Galle Sri Lanka</title>
        <meta name="description"
            content="Experience luxury at its finest at Ocean View Resort, Galle. Book your room online, fast and easy.">
        <!-- Google Fonts -->
        <link
            href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800;900&family=Playfair+Display:wght@400;700&display=swap"
            rel="stylesheet">
        <!-- Bootstrap 5 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Outfit', sans-serif;
                background: #03045e;
                color: #fff;
                overflow-x: hidden;
            }

            /* ── HERO ── */
            .hero {
                position: relative;
                height: 100vh;
                min-height: 600px;
                background: url('${pageContext.request.contextPath}/assets/images/resort_hero_bg.jpg') center center / cover no-repeat;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                text-align: center;
            }

            /* Dark gradient overlay */
            .hero::before {
                content: '';
                position: absolute;
                inset: 0;
                
            }

            /* Shimmer animation overlay */
            .hero::after {
                content: '';
                position: absolute;
                inset: 0;
                background: linear-gradient(90deg,
                        transparent 0%,
                        rgba(255, 255, 255, 0.04) 50%,
                        transparent 100%);
                animation: shimmer 6s ease-in-out infinite;
            }

            @keyframes shimmer {

                0%,
                100% {
                    opacity: 0;
                    transform: translateX(-100%);
                }

                50% {
                    opacity: 1;
                    transform: translateX(100%);
                }
            }

            .hero-content {
                position: relative;
                z-index: 2;
                max-width: 820px;
                padding: 0 20px;
                animation: fadeInUp 1.2s ease both;
            }

            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(40px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .hero-badge {
                display: inline-block;
                background: rgba(10, 25, 70, 0.85);
                backdrop-filter: blur(10px);
                border: 1px solid rgba(255, 255, 255, 0.25);
                border-radius: 50px;
                padding: 8px 24px;
                font-size: 0.82rem;
                letter-spacing: 3px;
                text-transform: uppercase;
                margin-bottom: 24px;
                color: #caf0f8;
            }

            .hero h1 {
                font-family: 'Playfair Display', serif;
                font-size: clamp(2.8rem, 7vw, 5.5rem);
                font-weight: 700;
                line-height: 1.1;
                margin-bottom: 20px;
                text-shadow: 0 4px 30px rgba(0, 0, 0, 0.4);
            }

            .hero h1 span {
                background: linear-gradient(90deg, #0D0D3C, #191970);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            .hero p {
                font-size: clamp(1rem, 2.5vw, 1.25rem);
                color: rgba(255, 255, 255, 0.85);
                max-width: 560px;
                margin: 0 auto 40px;
                line-height: 1.7;
            }

            /* ── BUTTONS ── */
            .btn-hero-primary {
                display: inline-flex;
                align-items: center;
                gap: 10px;
                background: linear-gradient(45deg, #0077b6, #00b4d8);
                color: #fff;
                border: none;
                border-radius: 50px;
                padding: 16px 42px;
                font-size: 1.05rem;
                font-weight: 700;
                letter-spacing: 0.5px;
                text-decoration: none;
                transition: all 0.3s ease;
                box-shadow: 0 8px 30px rgba(0, 180, 216, 0.45);
            }

            .btn-hero-primary:hover {
                background: linear-gradient(45deg, #00b4d8, #0077b6);
                transform: translateY(-3px);
                box-shadow: 0 14px 40px rgba(0, 180, 216, 0.6);
                color: #fff;
            }

            .btn-hero-secondary {
                display: inline-flex;
                align-items: center;
                gap: 10px;
                background: rgba(255, 255, 255, 0.12);
                backdrop-filter: blur(10px);
                color: #fff;
                border: 2px solid rgba(255, 255, 255, 0.35);
                border-radius: 50px;
                padding: 14px 36px;
                font-size: 1.05rem;
                font-weight: 600;
                text-decoration: none;
                transition: all 0.3s ease;
                margin-left: 14px;
            }

            .btn-hero-secondary:hover {
                background: rgba(255, 255, 255, 0.22);
                border-color: rgba(255, 255, 255, 0.6);
                transform: translateY(-3px);
                color: #fff;
            }

            /* Scroll indicator */
            .scroll-indicator {
                position: absolute;
                bottom: 36px;
                left: 50%;
                transform: translateX(-50%);
                z-index: 2;
                animation: bounce 2s ease infinite;
            }

            @keyframes bounce {

                0%,
                100% {
                    transform: translateX(-50%) translateY(0);
                }

                50% {
                    transform: translateX(-50%) translateY(-10px);
                }
            }

            .scroll-indicator i {
                font-size: 1.6rem;
                color: rgba(255, 255, 255, 0.6);
            }

            /* ── FLOATING NAVBAR ── */
            .top-nav {
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                z-index: 10;
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 24px 48px;
                background: linear-gradient(to bottom, rgba(3, 4, 94, 0.7), transparent);
            }

            .top-nav-brand {
                font-family: 'Playfair Display', serif;
                font-size: 1.5rem;
                font-weight: 700;
                color: #fff;
                text-decoration: none;
            }

            .top-nav-brand span {
                color: #00b4d8;
            }

            .top-nav a.nav-login-btn {
                background: rgba(255, 255, 255, 0.15);
                backdrop-filter: blur(10px);
                border: 1px solid rgba(255, 255, 255, 0.3);
                border-radius: 50px;
                padding: 9px 28px;
                color: #fff;
                text-decoration: none;
                font-weight: 600;
                font-size: 0.9rem;
                transition: all 0.3s;
            }

            .top-nav a.nav-login-btn:hover {
                background: rgba(0, 180, 216, 0.5);
                border-color: #00b4d8;
            }

            /* ── FEATURES ── */
            .features {
                background: #f0f7fb;
                color: #03045e;
                padding: 90px 0 70px;
            }

            .features h2 {
                font-family: 'Playfair Display', serif;
                font-size: 2.4rem;
                font-weight: 700;
                text-align: center;
                margin-bottom: 12px;
            }

            .features .sub {
                text-align: center;
                color: #6c757d;
                margin-bottom: 60px;
                font-size: 1.05rem;
            }

            .feature-card {
                background: #fff;
                border-radius: 20px;
                padding: 36px 28px;
                text-align: center;
                box-shadow: 0 6px 30px rgba(0, 0, 0, 0.07);
                transition: transform 0.3s, box-shadow 0.3s;
                height: 100%;
            }

            .feature-card:hover {
                transform: translateY(-8px);
                box-shadow: 0 16px 50px rgba(0, 119, 182, 0.15);
            }

            .feature-icon {
                width: 72px;
                height: 72px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 22px;
                font-size: 1.8rem;
            }

            .feature-card h5 {
                font-weight: 700;
                margin-bottom: 10px;
                font-size: 1.1rem;
            }

            .feature-card p {
                color: #6c757d;
                font-size: 0.95rem;
                line-height: 1.6;
            }

            /* ── ROOM TYPES ── */
            .rooms-section {
                background: #03045e;
                padding: 90px 0;
                color: #fff;
            }

            .rooms-section h2 {
                font-family: 'Playfair Display', serif;
                font-size: 2.4rem;
                text-align: center;
                margin-bottom: 10px;
            }

            .room-card {
                background: rgba(255, 255, 255, 0.06);
                border: 1px solid rgba(255, 255, 255, 0.1);
                backdrop-filter: blur(8px);
                border-radius: 20px;
                padding: 36px 28px;
                text-align: center;
                transition: all 0.3s;
            }

            .room-card:hover {
                background: rgba(0, 180, 216, 0.15);
                border-color: #00b4d8;
                transform: translateY(-6px);
            }

            .room-price {
                font-size: 2rem;
                font-weight: 800;
                color: #00b4d8;
            }

            .room-price small {
                font-size: 0.85rem;
                color: rgba(255, 255, 255, 0.6);
            }

            /* ── CTA ── */
            .cta-section {
                background: linear-gradient(135deg, #0077b6, #00b4d8);
                padding: 80px 0;
                text-align: center;
                color: #fff;
            }

            .cta-section h2 {
                font-family: 'Playfair Display', serif;
                font-size: 2.5rem;
                margin-bottom: 16px;
            }

            .btn-cta {
                display: inline-flex;
                align-items: center;
                gap: 10px;
                background: #fff;
                color: #0077b6;
                border-radius: 50px;
                padding: 16px 48px;
                font-size: 1.1rem;
                font-weight: 800;
                text-decoration: none;
                transition: all 0.3s;
                box-shadow: 0 8px 30px rgba(0, 0, 0, 0.2);
            }

            .btn-cta:hover {
                transform: translateY(-3px);
                box-shadow: 0 14px 40px rgba(0, 0, 0, 0.3);
                color: #0077b6;
            }

            /* ── FOOTER ── */
            footer {
                background: #020318;
                color: rgba(255, 255, 255, 0.5);
                text-align: center;
                padding: 28px;
                font-size: 0.88rem;
            }

            footer span {
                color: #00b4d8;
            }
        </style>
    </head>

    <body>

        <!-- ── FLOATING NAV ── -->
        <div class="top-nav">
            <a href="#" class="top-nav-brand"><i class="fas fa-umbrella-beach me-2"></i>OCEAN <span>VIEW</span></a>
            <a href="${pageContext.request.contextPath}/login" class="nav-login-btn">
                <i class="fas fa-sign-in-alt me-1"></i> Staff & Admin Login
            </a>
        </div>

        <!-- ── HERO SECTION ── -->
        <section class="hero">
            <div class="hero-content">
                <div class="hero-badge"><i class="fas fa-star me-1"></i> 5-Star Luxury Resort · Galle, Sri Lanka</div>

                <h1>Where the Ocean<br>Meets <span>Luxury</span></h1>

                <p>Discover the finest beachside retreat in Galle. Breathtaking ocean views, world-class amenities, and
                    unforgettable experiences await you.</p>

                <div class="d-flex flex-wrap justify-content-center gap-3">
                    <a href="${pageContext.request.contextPath}/login" class="btn-hero-primary">
                        <i class="fas fa-calendar-check"></i> Reserve Your Room
                    </a>
                    <a href="#features" class="btn-hero-secondary">
                        <i class="fas fa-info-circle"></i> Explore Resort
                    </a>
                </div>
            </div>

            <!-- Scroll down indicator -->
            <div class="scroll-indicator">
                <i class="fas fa-chevron-down"></i>
            </div>
        </section>

        <!-- ── FEATURES ── -->
        <section class="features" id="features">
            <div class="container">
                <h2>Why Choose <span style="color:#0077b6;">Ocean View?</span></h2>
                <p class="sub">Every detail crafted for an extraordinary stay</p>
                <div class="row g-4">
                    <div class="col-md-4">
                        <div class="feature-card">
                            <div class="feature-icon" style="background:#e0f7fc;">
                                <i class="fas fa-water" style="color:#00b4d8;"></i>
                            </div>
                            <h5>Beachfront Location</h5>
                            <p>Wake up to the sound of ocean waves. Our resort sits directly on the golden sands of
                                Galle's most pristine beach.</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="feature-card">
                            <div class="feature-icon" style="background:#e8f5e9;">
                                <i class="fas fa-concierge-bell" style="color:#2a9d8f;"></i>
                            </div>
                            <h5>24/7 Concierge Service</h5>
                            <p>Our dedicated staff are available around the clock to ensure every wish is fulfilled
                                during your stay.</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="feature-card">
                            <div class="feature-icon" style="background:#fff3e0;">
                                <i class="fas fa-utensils" style="color:#f4a261;"></i>
                            </div>
                            <h5>Fine Dining</h5>
                            <p>Savour authentic Sri Lankan cuisine and international dishes prepared by our
                                award-winning chefs.</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="feature-card">
                            <div class="feature-icon" style="background:#fce4ec;">
                                <i class="fas fa-spa" style="color:#e63946;"></i>
                            </div>
                            <h5>Luxury Spa</h5>
                            <p>Rejuvenate your body and mind at our award-winning spa with traditional Ayurvedic
                                treatments.</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="feature-card">
                            <div class="feature-icon" style="background:#ede7f6;">
                                <i class="fas fa-swimming-pool" style="color:#7209b7;"></i>
                            </div>
                            <h5>Infinity Pool</h5>
                            <p>Swim in our stunning infinity pool that seamlessly blends into the horizon of the Indian
                                Ocean.</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="feature-card">
                            <div class="feature-icon" style="background:#e3f2fd;">
                                <i class="fas fa-wifi" style="color:#0077b6;"></i>
                            </div>
                            <h5>Smart Connectivity</h5>
                            <p>High-speed Wi-Fi throughout the resort, smart room controls, and online reservation
                                management.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- ── ROOM TYPES ── -->
        <section class="rooms-section" id="rooms">
            <div class="container">
                <h2>Our <span style="color:#00b4d8;">Rooms</span></h2>
                <p class="text-center opacity-75 mb-5">Select the perfect room for your getaway</p>
                <div class="row g-4 justify-content-center">
                    <div class="col-md-4">
                        <div class="room-card">
                            <i class="fas fa-bed fa-2x mb-3" style="color:#00b4d8;"></i>
                            <h5 class="fw-bold mb-2">Single Room</h5>
                            <p class="opacity-75 mb-3">Cozy and comfortable room for a solo traveler with ocean view
                                balcony.</p>
                            <div class="room-price">LKR 5,000 <small>/ night</small></div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="room-card" style="border-color:#00b4d8; background:rgba(0,180,216,0.12);">
                            <i class="fas fa-star fa-2x mb-3" style="color:#00b4d8;"></i>
                            <h5 class="fw-bold mb-2">Double Room</h5>
                            <p class="opacity-75 mb-3">Spacious double room perfect for couples with sea-facing
                                panoramic views.</p>
                            <div class="room-price">LKR 8,000 <small>/ night</small></div>
                            <span class="badge bg-primary mt-2" style="font-size:0.75rem;">MOST POPULAR</span>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="room-card">
                            <i class="fas fa-crown fa-2x mb-3" style="color:#ffd700;"></i>
                            <h5 class="fw-bold mb-2">Luxury Suite</h5>
                            <p class="opacity-75 mb-3">The ultimate in luxury — private plunge pool, butler service, and
                                premium amenities.</p>
                            <div class="room-price">LKR 15,000 <small>/ night</small></div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- ── CTA ── -->
        <section class="cta-section">
            <div class="container">
                <h2>Ready for Your Dream Getaway?</h2>
                <p class="opacity-90 mb-4 fs-5">Join thousands of satisfied guests who've experienced paradise at Ocean
                    View Resort.</p>
                <a href="${pageContext.request.contextPath}/login" class="btn-cta">
                    <i class="fas fa-calendar-check"></i> Book Your Stay Now
                </a>
                <div class="mt-4 opacity-75 small">
                    <i class="fas fa-lock me-1"></i> Staff & Admin Portal &nbsp;|&nbsp;
                    <i class="fas fa-phone me-1"></i> +94 91 222 3333 &nbsp;|&nbsp;
                    <i class="fas fa-map-marker-alt me-1"></i> Galle, Sri Lanka
                </div>
            </div>
        </section>

        <!-- ── FOOTER ── -->
        <footer>
            &copy; 2026 <span>Ocean View Resort</span>. All Rights Reserved. | Designed for CIS 6003 Advanced
            Programming Assignment
        </footer>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Smooth scroll -->
        <script>
            document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                anchor.addEventListener('click', function (e) {
                    e.preventDefault();
                    const target = document.querySelector(this.getAttribute('href'));
                    if (target) target.scrollIntoView({ behavior: 'smooth' });
                });
            });
        </script>
    </body>

    </html>