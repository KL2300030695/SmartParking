package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ParkingSlotDAO;

@WebServlet("/releaseSlot")
public class ReleaseSlotServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String slotNumber = request.getParameter("slotNumber");
        
        if (slotNumber != null && !slotNumber.trim().isEmpty()) {
            ParkingSlotDAO slotDao = new ParkingSlotDAO();
            slotDao.releaseSlot(slotNumber);
        }
        
        // Redirect back to the vehicles dashboard
        response.sendRedirect("vehicles");
    }
}
