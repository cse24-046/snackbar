package bac.ac.snackbar.controller;

import bac.ac.snackbar.dao.SnackDAO;
import bac.ac.snackbar.model.SnackItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/menu")
public class MenuServlet extends HttpServlet {

    private final SnackDAO snackDAO = new SnackDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<SnackItem> snacks = snackDAO.getAllAvailableSnacks();
        request.setAttribute("snackList", snacks);
        request.getRequestDispatcher("/WEB-INF/views/menu.jsp").forward(request, response);
    }
}