package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ParkingBillDAO;
import model.ParkingBill;

@WebServlet("/reports")
public class ReportsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ParkingBillDAO billDao = new ParkingBillDAO();
        List<ParkingBill> allBills = billDao.getAllBills();

        request.setAttribute("allBills", allBills);
        request.getRequestDispatcher("reports.jsp").forward(request, response);
    }
}
