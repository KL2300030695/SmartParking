package util;

import model.ParkingBill;
import java.time.Duration;

/**
 * Utility class containing all the business logic for parking billing.
 */
public class BillingCalculator {

    private static final int GRACE_PERIOD_MINUTES = 15;
    private static final double RATE_CAR = 40.0;
    private static final double RATE_BIKE = 20.0;
    private static final double RATE_SUV = 60.0;
    private static final double DAILY_CAP = 300.0;
    private static final double LOST_TICKET_PENALTY = 500.0;

    /**
     * Computes the parking bill based on the input details.
     * 
     * @param bill The ParkingBill object with populated input data.
     * @return The updated ParkingBill object.
     */
    public static ParkingBill calculateBill(ParkingBill bill) {
        
        // Handle lost ticket scenario first
        if (bill.isLostTicket()) {
            bill.setTotalDurationMinutes(0);
            bill.setBillableHours(0);
            bill.setGraceApplied(false);
            bill.setHourlyRate(getHourlyRate(bill.getVehicleType()));
            bill.setParkingFee(0);
            bill.setDailyCapApplied(false);
            bill.setTotalAmount(LOST_TICKET_PENALTY);
            return bill;
        }

        // Calculate duration
        Duration duration = Duration.between(bill.getEntryTime(), bill.getExitTime());
        long totalMinutes = duration.toMinutes();
        bill.setTotalDurationMinutes(totalMinutes);
        
        double hourlyRate = getHourlyRate(bill.getVehicleType());
        bill.setHourlyRate(hourlyRate);

        if (totalMinutes <= GRACE_PERIOD_MINUTES) {
            bill.setGraceApplied(true);
            bill.setBillableHours(0);
            bill.setParkingFee(0);
            bill.setDailyCapApplied(false);
            bill.setTotalAmount(0);
            return bill;
        }

        // Apply grace period and convert to hours
        bill.setGraceApplied(true);
        long remainingMinutes = totalMinutes - GRACE_PERIOD_MINUTES;
        
        // Convert remaining minutes to hours, round UP
        long billableHours = (long) Math.ceil(remainingMinutes / 60.0);
        bill.setBillableHours(billableHours);

        // Multi-day stay logic
        long completedDays = billableHours / 24;
        long remainingHours = billableHours % 24;

        double remainingDurationFee = remainingHours * hourlyRate;
        
        // Apply daily cap to the remaining duration if it exceeds the daily cap
        boolean dailyCapApplied = false;
        if (remainingDurationFee > DAILY_CAP) {
            remainingDurationFee = DAILY_CAP;
            dailyCapApplied = true;
        }
        
        if (completedDays > 0) {
            dailyCapApplied = true;
        }
        
        double totalFee = (completedDays * DAILY_CAP) + remainingDurationFee;

        bill.setDailyCapApplied(dailyCapApplied);
        bill.setParkingFee(totalFee);
        bill.setTotalAmount(totalFee);

        return bill;
    }

    private static double getHourlyRate(String vehicleType) {
        if (vehicleType == null) return 0;
        switch (vehicleType.toUpperCase()) {
            case "CAR":
                return RATE_CAR;
            case "BIKE":
                return RATE_BIKE;
            case "SUV":
                return RATE_SUV;
            default:
                return 0;
        }
    }
}
