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

            <!-- Visual Slot Grid -->
            <div class="form-section-header mt-4">
                <span class="section-icon"><i class="bi bi-geo-alt-fill"></i></span>
                Live Parking Layout
            </div>

            <% 
               String currentFloor = "";
               for (int i = 0; i < allSlots.size(); i++) {
                   ParkingSlot slot = allSlots.get(i);
                   
                   // When floor changes, close the previous div (if not first) and start a new one
                   if (!slot.getFloorLevel().equals(currentFloor)) {
                       if (i > 0) {
                           out.print("</div></div>"); 
                       }
                       currentFloor = slot.getFloorLevel();
            %>
                       <div class="mb-5">
                           <h5 class="mb-3" style="color:#0f1d44; font-weight:700; border-bottom:2px solid #e2e8f0; padding-bottom:8px;">
                               <i class="bi bi-layers text-primary me-2"></i><%= currentFloor %>
                           </h5>
                           <div class="row g-3">
            <%
                   }
                   
                   String bgClass = slot.isOccupied() ? "bg-danger" : "bg-success";
                   String iconColor = slot.isOccupied() ? "#dc2626" : "#16a34a";
                   String icon = "bi-car-front-fill";
                   if (slot.getVehicleType().equals("Bike")) icon = "bi-bicycle";
                   else if (slot.getVehicleType().equals("SUV")) icon = "bi-truck";
            %>
                    <div class="col-6 col-sm-4 col-md-3 col-lg-2">
                        <div class="card h-100 text-center shadow-sm" style="border-radius:10px; overflow:hidden; border:1px solid <%= slot.isOccupied() ? "#fca5a5" : "#bbf7d0" %>;">
                            <div class="card-header py-1 text-white <%= bgClass %>" style="font-size:0.85rem; font-weight:700; border-bottom:none;">
                                <%= slot.getSlotNumber() %>
                            </div>
                            <div class="card-body p-2" style="background:<%= slot.isOccupied() ? "#fef2f2" : "#f0fdf4" %>;">
                                <i class="bi <%= icon %>" style="font-size:2.5rem; color:<%= iconColor %>;"></i>
                                <div class="mt-1" style="font-size:0.75rem; font-weight:600; color:#475569;">
                                    <%= slot.getVehicleType() %>
                                </div>
                                <% if (slot.isOccupied()) { %>
                                    <div class="mt-2" style="font-size:0.75rem; font-weight:700; color:#1e293b; background:#e2e8f0; border-radius:4px; padding:2px;">
                                        <%= slot.getVehicleNumber().toUpperCase() %>
                                    </div>
                                    <form action="releaseSlot" method="post" class="mt-2">
                                        <input type="hidden" name="slotNumber" value="<%= slot.getSlotNumber() %>">
                                        <button type="submit" class="btn btn-sm btn-outline-danger w-100" style="font-size:0.7rem; padding:2px 0;">Release</button>
                                    </form>
                                <% } else { %>
                                    <div class="mt-2" style="font-size:0.75rem; font-weight:600; color:#16a34a; padding:2px;">
                                        Available
                                    </div>
                                <% } %>
                            </div>
                        </div>
                    </div>
            <% 
               } 
               if (allSlots.size() > 0) {
                   out.print("</div></div>");
               }
            %>
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
