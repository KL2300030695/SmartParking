<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.ParkingBill" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reports - SmartParking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <%
        List<ParkingBill> allBills = (List<ParkingBill>) request.getAttribute("allBills");
        if (allBills == null) {
            response.sendRedirect("reports");
            return;
        }

        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a");

        double totalRevenue = 0;
        for (ParkingBill b : allBills) {
            totalRevenue += b.getTotalAmount();
        }
    %>

    <!-- Navbar -->
    <nav class="sp-navbar navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">
                <span class="brand-icon-box"><i class="bi bi-car-front-fill"></i></span>
                <span class="brand-text"><strong>Smart</strong>Parking<small>System Online</small></span>
            </a>
            <div class="d-none d-md-flex align-items-center gap-1">
                <a class="nav-link" href="index.jsp"><i class="bi bi-house-door me-1"></i>Home</a>
                <a class="nav-link" href="index.jsp"><i class="bi bi-receipt me-1"></i>Billing</a>
                <a class="nav-link" href="vehicles"><i class="bi bi-truck-front me-1"></i>Vehicles</a>
                <a class="nav-link active" href="reports"><i class="bi bi-bar-chart-line me-1"></i>Reports</a>
            </div>
            <span class="badge-online d-none d-sm-flex"><span class="dot"></span> System Online</span>
        </div>
    </nav>

    <!-- Hero -->
    <section class="sp-hero" style="padding: 32px 0 40px;">
        <div class="container">
            <h1 style="font-size:1.8rem;">BILLING REPORTS</h1>
            <p class="hero-subtitle">Complete Billing History & Revenue Summary</p>
        </div>
    </section>

    <!-- Content -->
    <div class="container">
        <div class="sp-form-card">

            <!-- Summary -->
            <div class="row mb-4">
                <div class="col-md-4 mb-3">
                    <div class="p-3 rounded-3 text-center" style="background:#eff6ff; border:1px solid #bfdbfe;">
                        <div style="font-size:2rem; font-weight:800; color:#1e40af;"><%= allBills.size() %></div>
                        <div style="font-size:0.8rem; font-weight:600; color:#64748b;">TOTAL TRANSACTIONS</div>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="p-3 rounded-3 text-center" style="background:#f0fdf4; border:1px solid #bbf7d0;">
                        <div style="font-size:2rem; font-weight:800; color:#16a34a;">&#8377;<%= String.format("%.2f", totalRevenue) %></div>
                        <div style="font-size:0.8rem; font-weight:600; color:#64748b;">TOTAL REVENUE</div>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="p-3 rounded-3 text-center" style="background:#fefce8; border:1px solid #fde68a;">
                        <div style="font-size:2rem; font-weight:800; color:#d97706;">&#8377;<%= allBills.size() > 0 ? String.format("%.2f", totalRevenue / allBills.size()) : "0.00" %></div>
                        <div style="font-size:0.8rem; font-weight:600; color:#64748b;">AVG PER BILL</div>
                    </div>
                </div>
            </div>

            <!-- Table -->
            <div class="form-section-header">
                <span class="section-icon"><i class="bi bi-table"></i></span>
                All Billing Records
            </div>

            <% if (allBills.isEmpty()) { %>
                <div class="text-center py-5" style="color:#94a3b8;">
                    <i class="bi bi-inbox" style="font-size:3rem;"></i>
                    <p class="mt-2">No billing records found. Generate your first bill from the <a href="index.jsp">Home</a> page.</p>
                </div>
            <% } else { %>
            <div class="table-responsive">
                <table class="table table-bordered table-hover" style="font-size:0.82rem;">
                    <thead style="background:#0f1d44; color:#fff;">
                        <tr>
                            <th>#</th>
                            <th>Owner</th>
                            <th>Contact</th>
                            <th>Vehicle</th>
                            <th>Type</th>
                            <th>Slot</th>
                            <th>Entry</th>
                            <th>Exit</th>
                            <th>Hours</th>
                            <th>Amount</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% int count = 1; for (ParkingBill b : allBills) { %>
                        <tr>
                            <td><%= count++ %></td>
                            <td><%= b.getOwnerName() != null ? b.getOwnerName() : "-" %></td>
                            <td><%= b.getContactNumber() != null ? b.getContactNumber() : "-" %></td>
                            <td><strong><%= b.getVehicleNumber() != null ? b.getVehicleNumber().toUpperCase() : "-" %></strong></td>
                            <td><%= b.getVehicleType() %></td>
                            <td><%= b.getSlotNumber() != null ? b.getSlotNumber() : "-" %></td>
                            <td><%= b.getEntryTime() != null ? b.getEntryTime().format(dtf) : "N/A" %></td>
                            <td><%= b.getExitTime() != null ? b.getExitTime().format(dtf) : "N/A" %></td>
                            <td><%= b.getBillableHours() %></td>
                            <td style="font-weight:700; color:#1e40af;">&#8377;<%= String.format("%.2f", b.getTotalAmount()) %></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            <% } %>
        </div>
    </div>

    <!-- Footer -->
    <footer class="sp-footer">
        <div class="container d-flex justify-content-between align-items-center">
            <p>&copy; 2026 Smart City Parking Management System</p>
            <p>Need help? <a href="#">Contact Support</a></p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
