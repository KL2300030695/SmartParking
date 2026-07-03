<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.ParkingSlot" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vehicles & Slots - SmartParking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <%
        List<ParkingSlot> allSlots = (List<ParkingSlot>) request.getAttribute("allSlots");
        int[] carCounts = (int[]) request.getAttribute("carCounts");
        int[] bikeCounts = (int[]) request.getAttribute("bikeCounts");
        int[] suvCounts = (int[]) request.getAttribute("suvCounts");

        if (allSlots == null || carCounts == null) {
            response.sendRedirect("vehicles");
            return;
        }

        int totalSlots = carCounts[0] + bikeCounts[0] + suvCounts[0];
        int totalOccupied = carCounts[1] + bikeCounts[1] + suvCounts[1];
        int totalAvailable = totalSlots - totalOccupied;
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
                <a class="nav-link active" href="vehicles"><i class="bi bi-truck-front me-1"></i>Vehicles</a>
                <a class="nav-link" href="reports"><i class="bi bi-bar-chart-line me-1"></i>Reports</a>
            </div>
            <span class="badge-online d-none d-sm-flex"><span class="dot"></span> System Online</span>
        </div>
    </nav>

    <!-- Hero -->
    <section class="sp-hero" style="padding: 32px 0 40px;">
        <div class="container">
            <h1 style="font-size:1.8rem;">PARKING SLOT DASHBOARD</h1>
            <p class="hero-subtitle">Live Slot Availability Across All Floors</p>
        </div>
    </section>

    <!-- Content -->
    <div class="container">
        <div class="sp-form-card">

            <!-- Summary Cards -->
            <div class="row mb-4">
                <div class="col-md-3 mb-3">
                    <div class="p-3 rounded-3 text-center" style="background:#eff6ff; border:1px solid #bfdbfe;">
                        <div style="font-size:2rem; font-weight:800; color:#1e40af;"><%= totalSlots %></div>
                        <div style="font-size:0.8rem; font-weight:600; color:#64748b;">TOTAL SLOTS</div>
                    </div>
                </div>
                <div class="col-md-3 mb-3">
                    <div class="p-3 rounded-3 text-center" style="background:#f0fdf4; border:1px solid #bbf7d0;">
                        <div style="font-size:2rem; font-weight:800; color:#16a34a;"><%= totalAvailable %></div>
                        <div style="font-size:0.8rem; font-weight:600; color:#64748b;">AVAILABLE</div>
                    </div>
                </div>
                <div class="col-md-3 mb-3">
                    <div class="p-3 rounded-3 text-center" style="background:#fef2f2; border:1px solid #fecaca;">
                        <div style="font-size:2rem; font-weight:800; color:#dc2626;"><%= totalOccupied %></div>
                        <div style="font-size:0.8rem; font-weight:600; color:#64748b;">OCCUPIED</div>
                    </div>
                </div>
                <div class="col-md-3 mb-3">
                    <div class="p-3 rounded-3 text-center" style="background:#fefce8; border:1px solid #fde68a;">
                        <div style="font-size:2rem; font-weight:800; color:#d97706;">3</div>
                        <div style="font-size:0.8rem; font-weight:600; color:#64748b;">FLOORS</div>
                    </div>
                </div>
            </div>

            <!-- Vehicle Type Breakdown -->
            <div class="row mb-4">
                <div class="col-md-4 mb-3">
                    <div class="p-3 rounded-3" style="background:#f8fafc; border:1px solid #e2e8f0;">
                        <h6 style="font-weight:700;"><i class="bi bi-car-front-fill text-primary me-2"></i>Car Slots</h6>
                        <div class="d-flex justify-content-between mt-2" style="font-size:0.85rem;">
                            <span>Total: <strong><%= carCounts[0] %></strong></span>
                            <span style="color:#16a34a;">Available: <strong><%= carCounts[2] %></strong></span>
                            <span style="color:#dc2626;">Occupied: <strong><%= carCounts[1] %></strong></span>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="p-3 rounded-3" style="background:#f8fafc; border:1px solid #e2e8f0;">
                        <h6 style="font-weight:700;"><i class="bi bi-bicycle text-primary me-2"></i>Bike Slots</h6>
                        <div class="d-flex justify-content-between mt-2" style="font-size:0.85rem;">
                            <span>Total: <strong><%= bikeCounts[0] %></strong></span>
                            <span style="color:#16a34a;">Available: <strong><%= bikeCounts[2] %></strong></span>
                            <span style="color:#dc2626;">Occupied: <strong><%= bikeCounts[1] %></strong></span>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="p-3 rounded-3" style="background:#f8fafc; border:1px solid #e2e8f0;">
                        <h6 style="font-weight:700;"><i class="bi bi-truck text-primary me-2"></i>SUV Slots</h6>
                        <div class="d-flex justify-content-between mt-2" style="font-size:0.85rem;">
                            <span>Total: <strong><%= suvCounts[0] %></strong></span>
                            <span style="color:#16a34a;">Available: <strong><%= suvCounts[2] %></strong></span>
                            <span style="color:#dc2626;">Occupied: <strong><%= suvCounts[1] %></strong></span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Slot Table -->
            <div class="form-section-header">
                <span class="section-icon"><i class="bi bi-grid-3x3-gap"></i></span>
                All Parking Slots
            </div>

            <div class="table-responsive">
                <table class="table table-bordered table-hover" style="font-size:0.85rem;">
                    <thead style="background:#0f1d44; color:#fff;">
                        <tr>
                            <th>Slot</th>
                            <th>Floor</th>
                            <th>Type</th>
                            <th>Status</th>
                            <th>Vehicle</th>
                            <th>Owner</th>
                            <th>Since</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (ParkingSlot slot : allSlots) { %>
                        <tr>
                            <td><strong><%= slot.getSlotNumber() %></strong></td>
                            <td><%= slot.getFloorLevel() %></td>
                            <td><%= slot.getVehicleType() %></td>
                            <td>
                                <% if (slot.isOccupied()) { %>
                                    <span class="sp-badge sp-badge-red">Occupied</span>
                                <% } else { %>
                                    <span class="sp-badge sp-badge-green">Available</span>
                                <% } %>
                            </td>
                            <td><%= slot.getVehicleNumber() != null ? slot.getVehicleNumber() : "-" %></td>
                            <td><%= slot.getOwnerName() != null ? slot.getOwnerName() : "-" %></td>
                            <td><%= slot.getOccupiedSince() != null ? slot.getOccupiedSince() : "-" %></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
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
