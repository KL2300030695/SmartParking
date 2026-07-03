package servlet;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeParseException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.ParkingBill;
import util.BillingCalculator;
import dao.ParkingBillDAO;
import dao.ParkingSlotDAO;

@WebServlet("/calculateBill")
public class BillingServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String ownerName = request.getParameter("ownerName");
        String contactNumber = request.getParameter("contactNumber");
        String vehicleNumber = request.getParameter("vehicleNumber");
        String vehicleType = request.getParameter("vehicleType");
        
        String entryDateStr = request.getParameter("entryDate");
        String entryTimeStr = request.getParameter("entryTime");
        
        String exitDateStr = request.getParameter("exitDate");
        String exitTimeStr = request.getParameter("exitTime");
        
        String lostTicketStr = request.getParameter("lostTicket");
        boolean lostTicket = "Yes".equalsIgnoreCase(lostTicketStr);
        
        // Basic Validation
        if (vehicleNumber == null || vehicleNumber.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Vehicle Number is required.");
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }

        LocalDateTime entryDateTime = null;
        LocalDateTime exitDateTime = null;
        
        try {
            if (!lostTicket) {
                // If not a lost ticket, dates are required
                if (entryDateStr == null || entryDateStr.isEmpty() || entryTimeStr == null || entryTimeStr.isEmpty() ||
                    exitDateStr == null || exitDateStr.isEmpty() || exitTimeStr == null || exitTimeStr.isEmpty()) {
                    request.setAttribute("errorMessage", "Entry and Exit dates and times are required.");
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                    return;
                }
                
                entryDateTime = LocalDateTime.of(LocalDate.parse(entryDateStr), LocalTime.parse(entryTimeStr));
                exitDateTime = LocalDateTime.of(LocalDate.parse(exitDateStr), LocalTime.parse(exitTimeStr));
                
                if (exitDateTime.isBefore(entryDateTime)) {
                    request.setAttribute("errorMessage", "Exit time cannot be before entry time.");
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                    return;
                }
            }
        } catch (DateTimeParseException e) {
            request.setAttribute("errorMessage", "Invalid date or time format.");
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }

        // Build Model
        ParkingBill bill = new ParkingBill();
        bill.setOwnerName(ownerName);
        bill.setContactNumber(contactNumber);
        bill.setVehicleNumber(vehicleNumber);
        bill.setVehicleType(vehicleType);
        bill.setEntryTime(entryDateTime);
        bill.setExitTime(exitDateTime);
        bill.setLostTicket(lostTicket);
        
        // Calculate
        bill = BillingCalculator.calculateBill(bill);
        
        // Assign Parking Slot
        ParkingSlotDAO slotDao = new ParkingSlotDAO();
        String assignedSlot = slotDao.assignSlot(vehicleType, vehicleNumber, ownerName);
        if (assignedSlot != null) {
            bill.setSlotNumber(assignedSlot);
        } else {
            bill.setSlotNumber("N/A");
        }
        
        // Save to Database
        ParkingBillDAO dao = new ParkingBillDAO();
        dao.saveBill(bill);
        
        // Forward to Result
        request.setAttribute("bill", bill);
        request.getRequestDispatcher("result.jsp").forward(request, response);
    }
}
