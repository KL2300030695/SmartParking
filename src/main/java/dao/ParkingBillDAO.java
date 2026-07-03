package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import model.ParkingBill;
import util.DBConnection;

public class ParkingBillDAO {

    public void saveBill(ParkingBill bill) {
        String sql = "INSERT INTO parking_bills " +
                     "(owner_name, contact_number, vehicle_number, vehicle_type, slot_number, entry_time, exit_time, total_duration_minutes, " +
                     "billable_hours, grace_applied, hourly_rate, parking_fee, lost_ticket, daily_cap_applied, total_amount) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                System.err.println("Failed to get database connection. Bill was NOT saved to the database.");
                return;
            }

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, bill.getOwnerName());
                stmt.setString(2, bill.getContactNumber());
                stmt.setString(3, bill.getVehicleNumber());
                stmt.setString(4, bill.getVehicleType());
                stmt.setString(5, bill.getSlotNumber());

                if (bill.getEntryTime() != null) {
                    stmt.setTimestamp(6, Timestamp.valueOf(bill.getEntryTime()));
                } else {
                    stmt.setNull(6, java.sql.Types.TIMESTAMP);
                }

                if (bill.getExitTime() != null) {
                    stmt.setTimestamp(7, Timestamp.valueOf(bill.getExitTime()));
                } else {
                    stmt.setNull(7, java.sql.Types.TIMESTAMP);
                }

                stmt.setLong(8, bill.getTotalDurationMinutes());
                stmt.setLong(9, bill.getBillableHours());
                stmt.setBoolean(10, bill.isGraceApplied());
                stmt.setDouble(11, bill.getHourlyRate());
                stmt.setDouble(12, bill.getParkingFee());
                stmt.setBoolean(13, bill.isLostTicket());
                stmt.setBoolean(14, bill.isDailyCapApplied());
                stmt.setDouble(15, bill.getTotalAmount());

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    System.out.println("Bill saved to database successfully.");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error saving bill to database.");
            e.printStackTrace();
        }
    }

    /**
     * Get all billing records for the reports page.
     */
    public List<ParkingBill> getAllBills() {
        List<ParkingBill> bills = new ArrayList<>();
        String sql = "SELECT * FROM parking_bills ORDER BY created_at DESC";

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) return bills;
            try (PreparedStatement stmt = conn.prepareStatement(sql);
                 ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ParkingBill bill = new ParkingBill();
                    bill.setOwnerName(rs.getString("owner_name"));
                    bill.setContactNumber(rs.getString("contact_number"));
                    bill.setVehicleNumber(rs.getString("vehicle_number"));
                    bill.setVehicleType(rs.getString("vehicle_type"));
                    bill.setSlotNumber(rs.getString("slot_number"));
                    if (rs.getTimestamp("entry_time") != null) {
                        bill.setEntryTime(rs.getTimestamp("entry_time").toLocalDateTime());
                    }
                    if (rs.getTimestamp("exit_time") != null) {
                        bill.setExitTime(rs.getTimestamp("exit_time").toLocalDateTime());
                    }
                    bill.setTotalDurationMinutes(rs.getLong("total_duration_minutes"));
                    bill.setBillableHours(rs.getLong("billable_hours"));
                    bill.setGraceApplied(rs.getBoolean("grace_applied"));
                    bill.setHourlyRate(rs.getDouble("hourly_rate"));
                    bill.setParkingFee(rs.getDouble("parking_fee"));
                    bill.setLostTicket(rs.getBoolean("lost_ticket"));
                    bill.setDailyCapApplied(rs.getBoolean("daily_cap_applied"));
                    bill.setTotalAmount(rs.getDouble("total_amount"));
                    bills.add(bill);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching bills.");
            e.printStackTrace();
        }
        return bills;
    }
}
