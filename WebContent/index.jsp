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

    <!-- ===== Navbar ===== -->
    <nav class="sp-navbar navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">
                <span class="brand-icon-box"><i class="bi bi-car-front-fill"></i></span>
                <span class="brand-text"><strong>Smart</strong>Parking<small>System Online</small></span>
            </a>
            <div class="d-none d-md-flex align-items-center gap-1">
                <a class="nav-link active" href="index.jsp"><i class="bi bi-house-door me-1"></i>Home</a>
                <a class="nav-link" href="#"><i class="bi bi-receipt me-1"></i>Billing</a>
                <a class="nav-link" href="#"><i class="bi bi-truck-front me-1"></i>Vehicles</a>
                <a class="nav-link" href="#"><i class="bi bi-bar-chart-line me-1"></i>Reports</a>
            </div>
            <span class="badge-online d-none d-sm-flex"><span class="dot"></span> System Online</span>
        </div>
    </nav>

    <!-- ===== Hero Section ===== -->
    <section class="sp-hero">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-5">
                    <h1>SMART PARKING<br>BILLING ENGINE</h1>
                    <p class="hero-subtitle">Smart City Parking Management System</p>
                </div>
                <div class="col-lg-7 d-flex justify-content-lg-end mt-4 mt-lg-0">
                    <div class="rate-cards-row">
                        <div class="rate-card-item">
                            <div class="rc-icon"><i class="bi bi-car-front-fill"></i></div>
                            <div class="rc-type">Car</div>
                            <div class="rc-price">&#8377;40<small>/hr</small></div>
                        </div>
                        <div class="rate-card-item">
                            <div class="rc-icon"><i class="bi bi-bicycle"></i></div>
                            <div class="rc-type">Bike</div>
                            <div class="rc-price">&#8377;20<small>/hr</small></div>
                        </div>
                        <div class="rate-card-item">
                            <div class="rc-icon"><i class="bi bi-truck"></i></div>
                            <div class="rc-type">SUV</div>
                            <div class="rc-price">&#8377;60<small>/hr</small></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ===== Form Section ===== -->
    <div class="container">
        <div class="sp-form-card">
            
            <!-- Validation Error -->
            <% 
                String errorMessage = (String) request.getAttribute("errorMessage");
                if (errorMessage != null && !errorMessage.isEmpty()) {
            %>
                <div class="sp-alert">
                    <i class="bi bi-exclamation-triangle-fill"></i> <%= errorMessage %>
                </div>
            <% } %>

            <form action="calculateBill" method="POST">

                <!-- Vehicle and Parking Details -->
                <div class="form-section-header">
                    <span class="section-icon"><i class="bi bi-car-front"></i></span>
                    Vehicle and Parking Details
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Owner Name <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-person-fill"></i></span>
                            <input type="text" class="form-control" name="ownerName" placeholder="e.g., Rahul Sharma" required>
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Contact Number <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-telephone-fill"></i></span>
                            <input type="tel" class="form-control" name="contactNumber" placeholder="e.g., 9876543210" required>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Vehicle Number <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-car-front"></i></span>
                            <input type="text" class="form-control" name="vehicleNumber" placeholder="e.g., MH 12 AB 1234" required>
                        </div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Vehicle Type <span class="text-danger">*</span></label>
                        <select class="form-select" name="vehicleType" required>
                            <option value="Car">Car (&#8377;40/hr)</option>
                            <option value="Bike">Bike (&#8377;20/hr)</option>
                            <option value="SUV">SUV (&#8377;60/hr)</option>
                        </select>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Lost Ticket <span class="text-danger">*</span></label>
                        <select class="form-select" id="lostTicketSelect" name="lostTicket" onchange="toggleDates()">
                            <option value="No">No</option>
                            <option value="Yes">Yes (&#8377;500 Penalty)</option>
                        </select>
                    </div>
                </div>

                <div class="row mt-2">
                    <!-- Entry Details -->
                    <div class="col-md-4">
                        <div class="form-section-header">
                            <span class="section-icon"><i class="bi bi-box-arrow-in-right"></i></span>
                            Entry Details
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Entry Date <span class="text-danger">*</span></label>
                            <input type="date" class="form-control" id="entryDate" name="entryDate">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Entry Time <span class="text-danger">*</span></label>
                            <input type="time" class="form-control" id="entryTime" name="entryTime">
                        </div>
                    </div>

                    <!-- Exit Details -->
                    <div class="col-md-4">
                        <div class="form-section-header">
                            <span class="section-icon"><i class="bi bi-box-arrow-right"></i></span>
                            Exit Details
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Exit Date <span class="text-danger">*</span></label>
                            <input type="date" class="form-control" id="exitDate" name="exitDate">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Exit Time <span class="text-danger">*</span></label>
                            <input type="time" class="form-control" id="exitTime" name="exitTime">
                        </div>
                    </div>

                    <!-- Policy Reminder -->
                    <div class="col-md-4">
                        <div class="policy-card mt-md-5">
                            <h6><i class="bi bi-info-circle-fill"></i> Policy Reminder</h6>
                            <ul>
                                <li><i class="bi bi-clock-history"></i> Billing is calculated on part-hour basis</li>
                                <li><i class="bi bi-calendar-check"></i> Daily maximum charge will be applied</li>
                                <li><i class="bi bi-ticket-perforated"></i> Lost ticket will incur penalty charges</li>
                                <li><i class="bi bi-shield-check"></i> First 15 minutes free for all vehicles</li>
                            </ul>
                        </div>
                    </div>
                </div>

                <!-- Submit -->
                <div class="mt-2">
                    <button type="submit" class="btn-calculate">
                        <i class="bi bi-calculator-fill"></i> Calculate Bill
                    </button>
                </div>

            </form>
        </div>
    </div>

    <!-- ===== Footer ===== -->
    <footer class="sp-footer">
        <div class="container d-flex justify-content-between align-items-center">
            <p>&copy; 2026 Smart City Parking Management System</p>
            <p>Need help? <a href="#">Contact Support</a></p>
        </div>
    </footer>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function toggleDates() {
            var isLost = document.getElementById('lostTicketSelect').value === 'Yes';
            var ids = ['entryDate', 'entryTime', 'exitDate', 'exitTime'];
            for (var i = 0; i < ids.length; i++) {
                var el = document.getElementById(ids[i]);
                el.disabled = isLost;
                el.required = !isLost;
                el.style.opacity = isLost ? '0.4' : '1';
            }
        }
        window.onload = function() { toggleDates(); };
    </script>
</body>
</html>
