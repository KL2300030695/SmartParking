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

            <%
                ParkingBill bill = (ParkingBill) request.getAttribute("bill");
                if (bill == null) {
                    response.sendRedirect("index.jsp");
                    return;
                }

                DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd MMM yyyy");
                DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("hh:mm a");

                String entryDateDisplay = bill.isLostTicket() ? "N/A" : bill.getEntryTime().format(dateFormatter);
                String entryTimeDisplay = bill.isLostTicket() ? "--" : bill.getEntryTime().format(timeFormatter);
                String exitDateDisplay  = bill.isLostTicket() ? "N/A" : bill.getExitTime().format(dateFormatter);
                String exitTimeDisplay  = bill.isLostTicket() ? "--" : bill.getExitTime().format(timeFormatter);

                long totalMins = bill.getTotalDurationMinutes();
                String durationDisplay;
                if (bill.isLostTicket()) {
                    durationDisplay = "N/A";
                } else if (totalMins < 60) {
                    durationDisplay = totalMins + " min";
                } else {
                    long hrs = totalMins / 60;
                    long mins = totalMins % 60;
                    durationDisplay = hrs + " hr " + mins + " min";
                }
            %>

            <!-- Page Header -->
            <div class="page-header">
                <div class="icon-wrapper">
                    <i class="bi bi-receipt-cutoff"></i>
                </div>
                <h1>PARKING RECEIPT</h1>
                <p class="subtitle">Transaction Complete</p>
            </div>

            <div class="row justify-content-center">
                <div class="col-md-8 col-lg-5">
                    <div class="receipt-card">

                        <!-- Receipt Header -->
                        <div class="receipt-top">
                            <h3><i class="bi bi-p-circle-fill me-2"></i>SmartParking</h3>
                            <p>Smart City Parking Management</p>
                        </div>

                        <!-- Receipt Body -->
                        <div class="receipt-body">

                            <div class="receipt-row">
                                <span class="label">Vehicle Number</span>
                                <span class="value"><%= bill.getVehicleNumber().toUpperCase() %></span>
                            </div>
                            <div class="receipt-row">
                                <span class="label">Vehicle Type</span>
                                <span class="value"><%= bill.getVehicleType() %></span>
                            </div>
                            <div class="receipt-row">
                                <span class="label">Entry</span>
                                <span class="value"><%= entryDateDisplay %> <%= entryTimeDisplay %></span>
                            </div>
                            <div class="receipt-row">
                                <span class="label">Exit</span>
                                <span class="value"><%= exitDateDisplay %> <%= exitTimeDisplay %></span>
                            </div>
                            <div class="receipt-row">
                                <span class="label">Duration</span>
                                <span class="value"><%= durationDisplay %></span>
                            </div>

                            <% if (!bill.isLostTicket()) { %>
                            <hr class="receipt-divider">
                            <div class="receipt-row">
                                <span class="label">Grace Applied (15 min)</span>
                                <span class="value">
                                    <% if (bill.isGraceApplied()) { %>
                                        <span class="badge-status badge-yes">Yes</span>
                                    <% } else { %>
                                        <span class="badge-status badge-no">No</span>
                                    <% } %>
                                </span>
                            </div>
                            <div class="receipt-row">
                                <span class="label">Billable Hours</span>
                                <span class="value"><%= bill.getBillableHours() %> hr</span>
                            </div>
                            <div class="receipt-row">
                                <span class="label">Hourly Rate</span>
                                <span class="value">&#8377;<%= String.format("%.2f", bill.getHourlyRate()) %></span>
                            </div>
                            <div class="receipt-row">
                                <span class="label">Parking Fee</span>
                                <span class="value">&#8377;<%= String.format("%.2f", bill.getParkingFee()) %></span>
                            </div>
                            <div class="receipt-row">
                                <span class="label">Daily Cap (&#8377;300)</span>
                                <span class="value">
                                    <% if (bill.isDailyCapApplied()) { %>
                                        <span class="badge-status badge-yes">Applied</span>
                                    <% } else { %>
                                        <span class="badge-status badge-no">Not Applied</span>
                                    <% } %>
                                </span>
                            </div>
                            <% } %>

                            <div class="receipt-row">
                                <span class="label">Lost Ticket</span>
                                <span class="value">
                                    <% if (bill.isLostTicket()) { %>
                                        <span class="badge-status badge-penalty">&#8377;500 Penalty</span>
                                    <% } else { %>
                                        <span class="badge-status badge-no">No</span>
                                    <% } %>
                                </span>
                            </div>

                            <hr class="receipt-divider">

                            <div class="receipt-total">
                                <span class="label">TOTAL AMOUNT</span>
                                <span class="value">&#8377;<%= String.format("%.2f", bill.getTotalAmount()) %></span>
                            </div>
                        </div>

                        <!-- Thank You -->
                        <div class="receipt-thankyou">
                            <i class="bi bi-check-circle-fill"></i>
                            <p>Thank You for Parking!</p>
                            <small>This bill is generated automatically based on the configured parking policy.</small>
                        </div>

                        <!-- Actions -->
                        <div class="receipt-actions d-print-none">
                            <button onclick="window.print()" class="btn-primary-glow">
                                <i class="bi bi-printer-fill"></i> Print Receipt
                            </button>
                            <a href="index.jsp" class="btn-secondary-outline">
                                <i class="bi bi-arrow-left-circle"></i> New Calculation
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="smart-footer d-print-none">
        <div class="container">
            <p class="disclaimer">This bill is generated automatically based on the configured parking policy.</p>
            <p>&copy; 2026 Smart City Parking Management System</p>
        </div>
    </footer>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
