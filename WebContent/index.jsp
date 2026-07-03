<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Smart City Parking Management System - Automated Billing Engine">
    <title>Smart Parking Billing Engine</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <!-- Navbar -->
    <div class="sp-navbar">
        <div class="container">
            <a class="brand" href="index.jsp">
                <span class="brand-badge"><i class="bi bi-car-front-fill"></i></span>
                SmartParking
            </a>
            <span class="status">
                <span class="dot"></span> System Online
            </span>
        </div>
    </div>

    <!-- Header -->
    <div class="sp-header">
        <div class="header-icon">
            <i class="bi bi-p-circle-fill"></i>
        </div>
        <h1>SMART PARKING BILLING ENGINE</h1>
        <p>Smart City Parking Management System</p>
    </div>

    <!-- Form Card -->
    <div class="container">
        <div style="max-width: 560px; margin: 0 auto;">
            <div class="sp-card">

                <!-- Rate Banner -->
                <div class="rate-banner">
                    <div class="rate-item">
                        <span class="r-icon">&#128663;</span>
                        <span class="r-type">Car</span>
                        <span class="r-price">&#8377;40/hr</span>
                    </div>
                    <div class="rate-item">
                        <span class="r-icon">&#127949;&#65039;</span>
                        <span class="r-type">Bike</span>
                        <span class="r-price">&#8377;20/hr</span>
                    </div>
                    <div class="rate-item">
                        <span class="r-icon">&#128665;</span>
                        <span class="r-type">SUV</span>
                        <span class="r-price">&#8377;60/hr</span>
                    </div>
                </div>

                <!-- Validation Error -->
                <% 
                    String errorMessage = (String) request.getAttribute("errorMessage");
                    if (errorMessage != null && !errorMessage.isEmpty()) {
                %>
                    <div class="sp-alert">
                        <i class="bi bi-exclamation-triangle-fill"></i> <%= errorMessage %>
                    </div>
                <% } %>

                <!-- Form -->
                <form action="calculateBill" method="POST">

                    <div class="section-title">Vehicle Details</div>

                    <div class="mb-16">
                        <label class="sp-label" for="vehicleNumber">Vehicle Number</label>
                        <input type="text" class="sp-input" id="vehicleNumber" name="vehicleNumber" placeholder="e.g., MH 12 AB 1234" required>
                    </div>

                    <div class="mb-24">
                        <label class="sp-label" for="vehicleType">Vehicle Type</label>
                        <select class="sp-select" id="vehicleType" name="vehicleType" required>
                            <option value="Car">Car (&#8377;40/hr)</option>
                            <option value="Bike">Bike (&#8377;20/hr)</option>
                            <option value="SUV">SUV (&#8377;60/hr)</option>
                        </select>
                    </div>

                    <div class="section-title">Parking Duration</div>

                    <div class="row-grid mb-16">
                        <div class="col-half">
                            <label class="sp-label" for="entryDate">Entry Date</label>
                            <input type="date" class="sp-input" id="entryDate" name="entryDate">
                        </div>
                        <div class="col-half">
                            <label class="sp-label" for="entryTime">Entry Time</label>
                            <input type="time" class="sp-input" id="entryTime" name="entryTime">
                        </div>
                    </div>

                    <div class="row-grid mb-24">
                        <div class="col-half">
                            <label class="sp-label" for="exitDate">Exit Date</label>
                            <input type="date" class="sp-input" id="exitDate" name="exitDate">
                        </div>
                        <div class="col-half">
                            <label class="sp-label" for="exitTime">Exit Time</label>
                            <input type="time" class="sp-input" id="exitTime" name="exitTime">
                        </div>
                    </div>

                    <div class="section-title">Lost Ticket</div>

                    <div class="lost-ticket-group">
                        <div class="lt-option">
                            <input type="radio" name="lostTicket" id="lostNo" value="No" checked onchange="toggleDates()">
                            <label class="lt-label" for="lostNo"><i class="bi bi-ticket-perforated"></i> No</label>
                        </div>
                        <div class="lt-option lt-danger">
                            <input type="radio" name="lostTicket" id="lostYes" value="Yes" onchange="toggleDates()">
                            <label class="lt-label" for="lostYes"><i class="bi bi-exclamation-diamond"></i> Yes (&#8377;500)</label>
                        </div>
                    </div>

                    <button type="submit" class="sp-submit">
                        <i class="bi bi-calculator-fill"></i> Calculate Bill
                    </button>
                </form>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="sp-footer">
        <p class="disclaimer">This bill is generated automatically based on the configured parking policy.</p>
        <p>&copy; 2026 Smart City Parking Management System</p>
    </footer>

    <script>
        function toggleDates() {
            var isLost = document.getElementById('lostYes').checked;
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
