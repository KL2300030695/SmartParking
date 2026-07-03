<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Smart City Parking Management System - Automated Billing Engine">
    <title>Smart Parking Billing Engine</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <!-- Floating Background Orbs -->
    <div class="orb orb-1"></div>
    <div class="orb orb-2"></div>
    <div class="orb orb-3"></div>

    <!-- Navbar -->
    <nav class="smart-navbar navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">
                <span class="brand-icon"><i class="bi bi-car-front-fill"></i></span>
                SmartParking
            </a>
            <span class="nav-badge">
                <span class="pulse-dot"></span> System Online
            </span>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="main-content">
        <div class="container">

            <!-- Page Header -->
            <div class="page-header">
                <div class="icon-wrapper">
                    <i class="bi bi-p-circle-fill"></i>
                </div>
                <h1>SMART PARKING BILLING ENGINE</h1>
                <p class="subtitle">Smart City Parking Management System</p>
            </div>

            <div class="row justify-content-center">
                <div class="col-md-8 col-lg-6">
                    <div class="glass-card">

                        <!-- Rate Cards -->
                        <div class="rate-cards">
                            <div class="rate-card">
                                <div class="rate-icon">🚗</div>
                                <div class="rate-label">Car</div>
                                <div class="rate-price">&#8377;40/hr</div>
                            </div>
                            <div class="rate-card">
                                <div class="rate-icon">🏍️</div>
                                <div class="rate-label">Bike</div>
                                <div class="rate-price">&#8377;20/hr</div>
                            </div>
                            <div class="rate-card">
                                <div class="rate-icon">🚙</div>
                                <div class="rate-label">SUV</div>
                                <div class="rate-price">&#8377;60/hr</div>
                            </div>
                        </div>

                        <!-- Validation Error -->
                        <% 
                            String errorMessage = (String) request.getAttribute("errorMessage");
                            if (errorMessage != null && !errorMessage.isEmpty()) {
                        %>
                            <div class="alert-modern">
                                <i class="bi bi-exclamation-triangle-fill"></i> <%= errorMessage %>
                            </div>
                        <% } %>

                        <!-- Billing Form -->
                        <form action="calculateBill" method="POST" id="billingForm">

                            <!-- Vehicle Details -->
                            <div class="form-section-title">Vehicle Details</div>

                            <div class="mb-3">
                                <label for="vehicleNumber" class="form-label">Vehicle Number</label>
                                <input type="text" class="form-control" id="vehicleNumber" name="vehicleNumber" placeholder="e.g., MH 12 AB 1234" required>
                            </div>

                            <div class="mb-4">
                                <label for="vehicleType" class="form-label">Vehicle Type</label>
                                <select class="form-select" id="vehicleType" name="vehicleType" required>
                                    <option value="Car">Car (&#8377;40/hr)</option>
                                    <option value="Bike">Bike (&#8377;20/hr)</option>
                                    <option value="SUV">SUV (&#8377;60/hr)</option>
                                </select>
                            </div>

                            <!-- Parking Duration -->
                            <div class="form-section-title">Parking Duration</div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="entryDate" class="form-label">Entry Date</label>
                                    <input type="date" class="form-control" id="entryDate" name="entryDate">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="entryTime" class="form-label">Entry Time</label>
                                    <input type="time" class="form-control" id="entryTime" name="entryTime">
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="exitDate" class="form-label">Exit Date</label>
                                    <input type="date" class="form-control" id="exitDate" name="exitDate">
                                </div>
                                <div class="col-md-6 mb-4">
                                    <label for="exitTime" class="form-label">Exit Time</label>
                                    <input type="time" class="form-control" id="exitTime" name="exitTime">
                                </div>
                            </div>

                            <!-- Lost Ticket -->
                            <div class="form-section-title">Lost Ticket</div>

                            <div class="radio-group mb-4">
                                <div class="radio-option">
                                    <input type="radio" name="lostTicket" id="lostNo" value="No" checked onchange="toggleDates()">
                                    <label for="lostNo"><i class="bi bi-ticket-perforated"></i> No</label>
                                </div>
                                <div class="radio-option danger-option">
                                    <input type="radio" name="lostTicket" id="lostYes" value="Yes" onchange="toggleDates()">
                                    <label for="lostYes"><i class="bi bi-exclamation-diamond"></i> Yes (&#8377;500)</label>
                                </div>
                            </div>

                            <!-- Submit -->
                            <button type="submit" class="btn-primary-glow">
                                <i class="bi bi-calculator"></i> Calculate Bill
                            </button>
                        </form>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="smart-footer">
        <div class="container">
            <p class="disclaimer">This bill is generated automatically based on the configured parking policy.</p>
            <p>&copy; 2026 Smart City Parking Management System</p>
        </div>
    </footer>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function toggleDates() {
            const isLost = document.getElementById('lostYes').checked;
            const dateFields = ['entryDate', 'entryTime', 'exitDate', 'exitTime'];
            
            dateFields.forEach(function(id) {
                const el = document.getElementById(id);
                el.disabled = isLost;
                el.required = !isLost;
                el.style.opacity = isLost ? '0.4' : '1';
            });
        }

        window.onload = function() {
            toggleDates();
        };
    </script>
</body>
</html>
