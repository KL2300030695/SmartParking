package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.ParkingSlot;
import util.DBConnection;

public class ParkingSlotDAO {

    /**
     * Find and assign the first available slot for the given vehicle type.
     * Returns the slot number, or null if no slot is available.
     */
    public String assignSlot(String vehicleType, String vehicleNumber, String ownerName) {
        String findSql = "SELECT slot_number FROM parking_slots WHERE vehicle_type = ? AND is_occupied = FALSE ORDER BY slot_id ASC LIMIT 1";
        String updateSql = "UPDATE parking_slots SET is_occupied = TRUE, vehicle_number = ?, owner_name = ?, occupied_since = NOW() WHERE slot_number = ?";

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) return null;

            String slotNumber = null;

            try (PreparedStatement findStmt = conn.prepareStatement(findSql)) {
                findStmt.setString(1, vehicleType);
                try (ResultSet rs = findStmt.executeQuery()) {
                    if (rs.next()) {
                        slotNumber = rs.getString("slot_number");
                    }
                }
            }

            if (slotNumber != null) {
                try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                    updateStmt.setString(1, vehicleNumber);
                    updateStmt.setString(2, ownerName);
                    updateStmt.setString(3, slotNumber);
                    updateStmt.executeUpdate();
                }
            }

            return slotNumber;

        } catch (SQLException e) {
            System.err.println("Error assigning parking slot.");
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Release a slot by its slot number.
     */
    public void releaseSlot(String slotNumber) {
        String sql = "UPDATE parking_slots SET is_occupied = FALSE, vehicle_number = NULL, owner_name = NULL, occupied_since = NULL WHERE slot_number = ?";

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) return;
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, slotNumber);
                stmt.executeUpdate();
            }
        } catch (SQLException e) {
            System.err.println("Error releasing parking slot.");
            e.printStackTrace();
        }
    }

    /**
     * Get all parking slots.
     */
    public List<ParkingSlot> getAllSlots() {
        List<ParkingSlot> slots = new ArrayList<>();
        String sql = "SELECT * FROM parking_slots ORDER BY floor_level, slot_number";

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) return slots;
            try (PreparedStatement stmt = conn.prepareStatement(sql);
                 ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ParkingSlot slot = new ParkingSlot();
                    slot.setSlotId(rs.getInt("slot_id"));
                    slot.setSlotNumber(rs.getString("slot_number"));
                    slot.setFloorLevel(rs.getString("floor_level"));
                    slot.setVehicleType(rs.getString("vehicle_type"));
                    slot.setOccupied(rs.getBoolean("is_occupied"));
                    slot.setVehicleNumber(rs.getString("vehicle_number"));
                    slot.setOwnerName(rs.getString("owner_name"));
                    if (rs.getTimestamp("occupied_since") != null) {
                        slot.setOccupiedSince(rs.getTimestamp("occupied_since").toString());
                    }
                    slots.add(slot);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching parking slots.");
            e.printStackTrace();
        }
        return slots;
    }

    /**
     * Get slot counts: total, occupied, available for each vehicle type.
     */
    public int[] getSlotCounts(String vehicleType) {
        int total = 0, occupied = 0;
        String sql = "SELECT COUNT(*) as total, SUM(CASE WHEN is_occupied = TRUE THEN 1 ELSE 0 END) as occupied FROM parking_slots WHERE vehicle_type = ?";

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) return new int[]{0, 0, 0};
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, vehicleType);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        total = rs.getInt("total");
                        occupied = rs.getInt("occupied");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return new int[]{total, occupied, total - occupied};
    }
}
