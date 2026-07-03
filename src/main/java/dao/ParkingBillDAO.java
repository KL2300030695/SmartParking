package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;

import model.ParkingBill;
import util.DBConnection;

public class ParkingBillDAO {

    public void saveBill(ParkingBill bill) {
        String sql = "INSERT INTO parking_bills " +
                     "(vehicle_number, vehicle_type, entry_time, exit_time, total_duration_minutes, " +
                     "billable_hours, grace_applied, hourly_rate, parking_fee, lost_ticket, daily_cap_applied, total_amount) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection()) {
             
            if (conn == null) {
                System.err.println("Failed to get database connection. Bill was NOT saved to the database.");
                return;
            }
            
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, bill.getVehicleNumber());
                stmt.setString(2, bill.getVehicleType());
            
            // Handle null times in case of lost ticket
            if (bill.getEntryTime() != null) {
                stmt.setTimestamp(3, Timestamp.valueOf(bill.getEntryTime()));
            } else {
                stmt.setNull(3, java.sql.Types.TIMESTAMP);
            }
            
            if (bill.getExitTime() != null) {
                stmt.setTimestamp(4, Timestamp.valueOf(bill.getExitTime()));
            } else {
                stmt.setNull(4, java.sql.Types.TIMESTAMP);
            }
            
            stmt.setLong(5, bill.getTotalDurationMinutes());
            stmt.setLong(6, bill.getBillableHours());
            stmt.setBoolean(7, bill.isGraceApplied());
            stmt.setDouble(8, bill.getHourlyRate());
            stmt.setDouble(9, bill.getParkingFee());
            stmt.setBoolean(10, bill.isLostTicket());
            stmt.setBoolean(11, bill.isDailyCapApplied());
            stmt.setDouble(12, bill.getTotalAmount());
            
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Bill saved to database successfully.");
            }
            } // close inner try block
        } catch (SQLException e) {
            System.err.println("Error saving bill to database.");
            e.printStackTrace();
        }
    }
}
