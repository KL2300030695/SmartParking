<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SMART PARKING BILLING ENGINE</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">
                <i class="bi bi-car-front-fill me-2"></i>SmartCity Parking
            </a>
        </div>
    </nav>

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="glass-card">
                    <i class="bi bi-p-circle-fill icon-parking"></i>
                    <h2 class="title">SMART PARKING BILLING ENGINE</h2>
                    <p class="subtitle">Smart City Parking Management System</p>
                    
                    <% 
                        String errorMessage = (String) request.getAttribute("errorMessage");
                        if (errorMessage != null && !errorMessage.isEmpty()) {
                    %>
                        <div class="alert alert-danger" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i> <%= errorMessage %>
                        </div>
                    <% } %>

                    <form action="calculateBill" method="POST">
                        <div class="mb-3">
                            <label for="vehicleNumber" class="form-label">Vehicle Number</label>
                            <input type="text" class="form-control" id="vehicleNumber" name="vehicleNumber" placeholder="e.g., MH 12 AB 1234" required>
                        </div>
                        
                        <div class="mb-3">
                            <label for="vehicleType" class="form-label">Vehicle Type</label>
                            <select class="form-select" id="vehicleType" name="vehicleType" required>
                                <option value="Car">Car (₹40/hr)</option>
                                <option value="Bike">Bike (₹20/hr)</option>
                                <option value="SUV">SUV (₹60/hr)</option>
                            </select>
                        </div>

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
                            <div class="col-md-6 mb-3">
                                <label for="exitTime" class="form-label">Exit Time</label>
                                <input type="time" class="form-control" id="exitTime" name="exitTime">
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label d-block">Lost Ticket</label>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="lostTicket" id="lostTicketNo" value="No" checked onchange="toggleDates()">
                                <label class="form-check-label" for="lostTicketNo">No</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="lostTicket" id="lostTicketYes" value="Yes" onchange="toggleDates()">
                                <label class="form-check-label" for="lostTicketYes">Yes (₹500 Penalty)</label>
                            </div>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-smart btn-lg">
                                <i class="bi bi-calculator me-2"></i>Calculate Bill
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <footer class="footer">
        <div class="container">
            <p>This bill is generated automatically based on the configured parking policy.</p>
            <p>&copy; 2026 Smart City Parking</p>
        </div>
    </footer>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function toggleDates() {
            const isLost = document.getElementById('lostTicketYes').checked;
            document.getElementById('entryDate').disabled = isLost;
            document.getElementById('entryTime').disabled = isLost;
            document.getElementById('exitDate').disabled = isLost;
            document.getElementById('exitTime').disabled = isLost;
            
            if(isLost) {
                document.getElementById('entryDate').required = false;
                document.getElementById('entryTime').required = false;
                document.getElementById('exitDate').required = false;
                document.getElementById('exitTime').required = false;
            } else {
                document.getElementById('entryDate').required = true;
                document.getElementById('entryTime').required = true;
                document.getElementById('exitDate').required = true;
                document.getElementById('exitTime').required = true;
            }
        }
        
        // Initialize state on load
        window.onload = function() {
            toggleDates();
        };
    </script>
</body>
</html>
