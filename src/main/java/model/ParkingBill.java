package model;

import java.time.LocalDateTime;

/**
 * Model object representing a parking bill.
 */
public class ParkingBill {
    
    private String ownerName;
    private String contactNumber;
    private String vehicleNumber;
    private String vehicleType;
    
    private LocalDateTime entryTime;
    private LocalDateTime exitTime;
    
    private long totalDurationMinutes;
    private long billableHours;
    private boolean graceApplied;
    
    private double hourlyRate;
    private double parkingFee;
    
    private boolean lostTicket;
    private boolean dailyCapApplied;
    private double totalAmount;
    
    public ParkingBill() {
    }

    public String getOwnerName() {
        return ownerName;
    }

    public void setOwnerName(String ownerName) {
        this.ownerName = ownerName;
    }

    public String getContactNumber() {
        return contactNumber;
    }

    public void setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
    }

    public String getVehicleNumber() {
        return vehicleNumber;
    }

    public void setVehicleNumber(String vehicleNumber) {
        this.vehicleNumber = vehicleNumber;
    }

    public String getVehicleType() {
        return vehicleType;
    }

    public void setVehicleType(String vehicleType) {
        this.vehicleType = vehicleType;
    }

    public LocalDateTime getEntryTime() {
        return entryTime;
    }

    public void setEntryTime(LocalDateTime entryTime) {
        this.entryTime = entryTime;
    }

    public LocalDateTime getExitTime() {
        return exitTime;
    }

    public void setExitTime(LocalDateTime exitTime) {
        this.exitTime = exitTime;
    }

    public long getTotalDurationMinutes() {
        return totalDurationMinutes;
    }

    public void setTotalDurationMinutes(long totalDurationMinutes) {
        this.totalDurationMinutes = totalDurationMinutes;
    }

    public long getBillableHours() {
        return billableHours;
    }

    public void setBillableHours(long billableHours) {
        this.billableHours = billableHours;
    }

    public boolean isGraceApplied() {
        return graceApplied;
    }

    public void setGraceApplied(boolean graceApplied) {
        this.graceApplied = graceApplied;
    }

    public double getHourlyRate() {
        return hourlyRate;
    }

    public void setHourlyRate(double hourlyRate) {
        this.hourlyRate = hourlyRate;
    }

    public double getParkingFee() {
        return parkingFee;
    }

    public void setParkingFee(double parkingFee) {
        this.parkingFee = parkingFee;
    }

    public boolean isLostTicket() {
        return lostTicket;
    }

    public void setLostTicket(boolean lostTicket) {
        this.lostTicket = lostTicket;
    }

    public boolean isDailyCapApplied() {
        return dailyCapApplied;
    }

    public void setDailyCapApplied(boolean dailyCapApplied) {
        this.dailyCapApplied = dailyCapApplied;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }
}
