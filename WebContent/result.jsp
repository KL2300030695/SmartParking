<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.ParkingBill" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Smart Parking Receipt</title>
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
                <a class="nav-link" href="index.jsp"><i class="bi bi-house-door me-1"></i>Home</a>
                <a class="nav-link active" href="#"><i class="bi bi-receipt me-1"></i>Billing</a>
                <a class="nav-link" href="#"><i class="bi bi-truck-front me-1"></i>Vehicles</a>
                <a class="nav-link" href="#"><i class="bi bi-bar-chart-line me-1"></i>Reports</a>
            </div>
            <span class="badge-online d-none d-sm-flex"><span class="dot"></span> System Online</span>
        </div>
    </nav>

    <%
        ParkingBill bill = (ParkingBill) request.getAttribute("bill");
        if (bill == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        DateTimeFormatter dateFmt = DateTimeFormatter.ofPattern("dd MMM yyyy");
        DateTimeFormatter timeFmt = DateTimeFormatter.ofPattern("hh:mm a");

        String entryStr = bill.isLostTicket() ? "N/A (Lost Ticket)" : bill.getEntryTime().format(dateFmt) + ", " + bill.getEntryTime().format(timeFmt);
        String exitStr  = bill.isLostTicket() ? "N/A (Lost Ticket)" : bill.getExitTime().format(dateFmt) + ", " + bill.getExitTime().format(timeFmt);

        long totalMins = bill.getTotalDurationMinutes();
        String durationStr;
        if (bill.isLostTicket()) {
            durationStr = "N/A";
        } else if (totalMins < 60) {
            durationStr = totalMins + " min";
        } else {
            long hrs = totalMins / 60;
            long mins = totalMins % 60;
            durationStr = hrs + " hr " + mins + " min";
        }
    %>

    <!-- ===== Hero Section ===== -->
    <section class="sp-hero">
        <div class="container text-center">
            <h1>PARKING RECEIPT</h1>
            <p class="hero-subtitle">Transaction Complete</p>
        </div>
    </section>

    <!-- ===== Receipt Card ===== -->
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-6 col-md-8">
                <div class="receipt-wrapper">

                    <div class="receipt-top-bar">
                        <h3><i class="bi bi-p-circle-fill me-2"></i>SmartParking</h3>
                        <p>Smart City Parking Management</p>
                    </div>

                    <div class="receipt-content">
                        <div class="rcpt-row">
                            <span class="rcpt-label">Vehicle Number</span>
                            <span class="rcpt-value"><%= bill.getVehicleNumber().toUpperCase() %></span>
                        </div>
                        <div class="rcpt-row">
                            <span class="rcpt-label">Vehicle Type</span>
                            <span class="rcpt-value"><%= bill.getVehicleType() %></span>
                        </div>
                        <div class="rcpt-row">
                            <span class="rcpt-label">Entry</span>
                            <span class="rcpt-value"><%= entryStr %></span>
                        </div>
                        <div class="rcpt-row">
                            <span class="rcpt-label">Exit</span>
                            <span class="rcpt-value"><%= exitStr %></span>
                        </div>
                        <div class="rcpt-row">
                            <span class="rcpt-label">Duration</span>
                            <span class="rcpt-value"><%= durationStr %></span>
                        </div>

                        <% if (!bill.isLostTicket()) { %>
                        <hr class="rcpt-divider">
                        <div class="rcpt-row">
                            <span class="rcpt-label">Grace Applied (15 min)</span>
                            <span class="rcpt-value">
                                <% if (bill.isGraceApplied()) { %>
                                    <span class="sp-badge sp-badge-green">Yes</span>
                                <% } else { %>
                                    <span class="sp-badge sp-badge-gray">No</span>
                                <% } %>
                            </span>
                        </div>
                        <div class="rcpt-row">
                            <span class="rcpt-label">Billable Hours</span>
                            <span class="rcpt-value"><%= bill.getBillableHours() %> hr</span>
                        </div>
                        <div class="rcpt-row">
                            <span class="rcpt-label">Hourly Rate</span>
                            <span class="rcpt-value">&#8377;<%= String.format("%.2f", bill.getHourlyRate()) %></span>
                        </div>
                        <div class="rcpt-row">
                            <span class="rcpt-label">Parking Fee</span>
                            <span class="rcpt-value">&#8377;<%= String.format("%.2f", bill.getParkingFee()) %></span>
                        </div>
                        <div class="rcpt-row">
                            <span class="rcpt-label">Daily Cap (&#8377;300)</span>
                            <span class="rcpt-value">
                                <% if (bill.isDailyCapApplied()) { %>
                                    <span class="sp-badge sp-badge-green">Applied</span>
                                <% } else { %>
                                    <span class="sp-badge sp-badge-gray">Not Applied</span>
                                <% } %>
                            </span>
                        </div>
                        <% } %>

                        <div class="rcpt-row">
                            <span class="rcpt-label">Lost Ticket</span>
                            <span class="rcpt-value">
                                <% if (bill.isLostTicket()) { %>
                                    <span class="sp-badge sp-badge-red">&#8377;500 Penalty</span>
                                <% } else { %>
                                    <span class="sp-badge sp-badge-gray">No</span>
                                <% } %>
                            </span>
                        </div>

                        <hr class="rcpt-divider">

                        <div class="rcpt-total">
                            <span class="rcpt-label">TOTAL AMOUNT</span>
                            <span class="rcpt-value">&#8377;<%= String.format("%.2f", bill.getTotalAmount()) %></span>
                        </div>
                    </div>

                    <!-- Thank You -->
                    <div class="rcpt-thanks">
                        <span class="check-icon"><i class="bi bi-check-circle-fill"></i></span>
                        <p>Thank You for Parking!</p>
                        <small>This bill is generated automatically based on the configured parking policy.</small>
                    </div>

                    <!-- Actions -->
                    <div class="rcpt-actions d-print-none">
                        <button onclick="window.print()" class="btn-calculate">
                            <i class="bi bi-printer-fill"></i> Print Receipt
                        </button>
                        <a href="index.jsp" class="btn-outline-action">
                            <i class="bi bi-arrow-left-circle"></i> New Calculation
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- ===== Footer ===== -->
    <footer class="sp-footer d-print-none">
        <div class="container d-flex justify-content-between align-items-center">
            <p>&copy; 2026 Smart City Parking Management System</p>
            <p>Need help? <a href="#">Contact Support</a></p>
        </div>
    </footer>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
