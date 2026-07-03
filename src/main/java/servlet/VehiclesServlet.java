package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ParkingSlotDAO;
import model.ParkingSlot;

@WebServlet("/vehicles")
public class VehiclesServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ParkingSlotDAO slotDao = new ParkingSlotDAO();
        List<ParkingSlot> allSlots = slotDao.getAllSlots();

        int[] carCounts = slotDao.getSlotCounts("Car");
        int[] bikeCounts = slotDao.getSlotCounts("Bike");
        int[] suvCounts = slotDao.getSlotCounts("SUV");

        request.setAttribute("allSlots", allSlots);
        request.setAttribute("carCounts", carCounts);
        request.setAttribute("bikeCounts", bikeCounts);
        request.setAttribute("suvCounts", suvCounts);

        request.getRequestDispatcher("vehicles.jsp").forward(request, response);
    }
}
