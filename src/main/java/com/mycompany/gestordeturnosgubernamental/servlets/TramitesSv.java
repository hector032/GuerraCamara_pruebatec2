package com.mycompany.gestordeturnosgubernamental.servlets;

import com.mycompany.gestordeturnosgubernamental.logica.Controladora;
import com.mycompany.gestordeturnosgubernamental.logica.Tramite;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "TramiteSv", urlPatterns = {"/TramiteSv"})
public class TramitesSv extends HttpServlet {

    //Inicializamos la clase Controladora
    Controladora control = new Controladora();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet TramitesSv</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet TramitesSv at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            //Obtenemos la lista de los tramites            
            List<Tramite> listaTramites = control.traerTramites();
            if (listaTramites == null || listaTramites.isEmpty()) {
                control.crearTramite(new Tramite("Renovacion de DNI"));
                control.crearTramite(new Tramite("Renovacion de pasaporte"));
                control.crearTramite(new Tramite("Cambiar empadronamiento"));
                control.crearTramite(new Tramite("Solicitud de ayudas sociales"));
                control.crearTramite(new Tramite("Solicitud de cambio de titularidad del coche"));
                //Actualizamos la listra de tramites
                listaTramites = control.traerTramites();
            }

            //System.out.println("Tramites: " + listaTramites);
            request.setAttribute("listaTramites", listaTramites);

            request.getRequestDispatcher("turnos.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException("Error al inicializar datos: " + e.getMessage());
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
