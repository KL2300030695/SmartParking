<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.ParkingBill" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SMART PARKING RECEIPT</title>
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
            <div class="col-md-8 col-lg-5">
                <div class="glass-card">
                    <%
                        ParkingBill bill = (ParkingBill) request.getAttribute("bill");
                        if (bill == null) {
                            response.sendRedirect("index.jsp");
                            return;
                        }
                        
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a");
                        
                        String entryDisplay = bill.isLostTicket() ? "N/A (Lost Ticket)" : bill.getEntryTime().format(formatter);
                        String exitDisplay = bill.isLostTicket() ? "N/A (Lost Ticket)" : bill.getExitTime().format(formatter);
                        String durationDisplay = bill.isLostTicket() ? "N/A" : bill.getTotalDurationMinutes() + " Minutes";
                    %>
                    <div class="receipt-header">
                        <i class="bi bi-receipt icon-parking" style="font-size: 2.5rem; margin-bottom: 5px;"></i>
                        <h3 class="title" style="margin-bottom: 5px;">PARKING RECEIPT</h3>
                        <p class="text-muted" style="margin-bottom: 0;">Smart City Parking Management System</p>
                    </div>

                    <div class="receipt-body">
                        <div class="receipt-row">
                            <span class="text-muted">Vehicle Number:</span>
                            <span class="fw-bold"><%= bill.getVehicleNumber() %></span>
                        </div>
                        <div class="receipt-row">
                            <span class="text-muted">Vehicle Type:</span>
                            <span class="fw-bold"><%= bill.getVehicleType() %></span>
                        </div>
                        <div class="receipt-row">
                            <span class="text-muted">Entry Date and Time:</span>
                            <span class="fw-bold"><%= entryDisplay %></span>
                        </div>
                        <div class="receipt-row">
                            <span class="text-muted">Exit Date and Time:</span>
                            <span class="fw-bold"><%= exitDisplay %></span>
                        </div>
                        <div class="receipt-row">
                            <span class="text-muted">Parking Duration:</span>
                            <span class="fw-bold"><%= durationDisplay %></span>
                        </div>
                        
                        <% if (!bill.isLostTicket()) { %>
                        <div class="receipt-row">
                            <span class="text-muted">Grace Applied (15 mins):</span>
                            <span class="fw-bold"><%= bill.isGraceApplied() ? "Yes" : "No" %></span>
                        </div>
                        <div class="receipt-row">
                            <span class="text-muted">Billable Hours:</span>
                            <span class="fw-bold"><%= bill.getBillableHours() %> Hour(s)</span>
                        </div>
                        <div class="receipt-row">
                            <span class="text-muted">Hourly Rate:</span>
                            <span class="fw-bold">₹<%= String.format("%.2f", bill.getHourlyRate()) %></span>
                        </div>
                        <div class="receipt-row">
                            <span class="text-muted">Parking Fee:</span>
                            <span class="fw-bold">₹<%= String.format("%.2f", bill.getParkingFee()) %></span>
                        </div>
                        <div class="receipt-row">
                            <span class="text-muted">Daily Cap Applied (₹300):</span>
                            <span class="fw-bold"><%= bill.isDailyCapApplied() ? "Yes" : "No" %></span>
                        </div>
                        <% } %>
                        
                        <div class="receipt-row">
                            <span class="text-muted">Lost Ticket Penalty:</span>
                            <span class="fw-bold text-danger"><%= bill.isLostTicket() ? "Yes (₹500)" : "No" %></span>
                        </div>
                        
                        <div class="receipt-row total">
                            <span>TOTAL AMOUNT:</span>
                            <span>₹<%= String.format("%.2f", bill.getTotalAmount()) %></span>
                        </div>
                    </div>
                    
                    <div class="text-center mt-4">
                        <p class="text-success fw-bold"><i class="bi bi-check-circle-fill me-1"></i> Thank You for Parking!</p>
                    </div>

                    <div class="d-grid gap-2 mt-4 d-print-none">
                        <button onclick="window.print()" class="btn btn-smart">
                            <i class="bi bi-printer-fill me-2"></i>Print Receipt
                        </button>
                        <a href="index.jsp" class="btn btn-outline-smart">
                            <i class="bi bi-arrow-left-circle-fill me-2"></i>New Calculation
                        </a>
                    </div>
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
</body>
</html>
