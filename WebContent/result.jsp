<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.ParkingBill" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Smart Parking Receipt</title>
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

    <!-- Header -->
    <div class="sp-header">
        <div class="header-icon">
            <i class="bi bi-receipt-cutoff"></i>
        </div>
        <h1>PARKING RECEIPT</h1>
        <p>Transaction Complete</p>
    </div>

    <!-- Receipt -->
    <div class="container">
        <div style="max-width: 480px; margin: 0 auto;">
            <div class="receipt-wrapper">

                <div class="receipt-top-bar">
                    <h3><i class="bi bi-p-circle-fill"></i> SmartParking</h3>
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
                <div class="rcpt-actions">
                    <button onclick="window.print()" class="sp-submit">
                        <i class="bi bi-printer-fill"></i> Print Receipt
                    </button>
                    <a href="index.jsp" class="sp-btn-outline">
                        <i class="bi bi-arrow-left-circle"></i> New Calculation
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="sp-footer">
        <p class="disclaimer">This bill is generated automatically based on the configured parking policy.</p>
        <p>&copy; 2026 Smart City Parking Management System</p>
    </footer>

</body>
</html>
