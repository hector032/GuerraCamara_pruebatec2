package com.mycompany.gestordeturnosgubernamental.servlets;

import com.google.protobuf.TextFormat.ParseException;
import com.mycompany.gestordeturnosgubernamental.logica.Ciudadano;
import com.mycompany.gestordeturnosgubernamental.logica.Controladora;
import com.mycompany.gestordeturnosgubernamental.logica.Tramite;
import com.mycompany.gestordeturnosgubernamental.logica.Turno;
import com.mycompany.gestordeturnosgubernamental.logica.Validaciones;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "TurnoSv", urlPatterns = {"/TurnoSv"})
public class TurnosSv extends HttpServlet {

    //Instanciamos la clase Controladora
    Controladora control = new Controladora();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet TurnosSv</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet TurnosSv at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //Obtenemos los parametros de la solicitud
        String fechaStr = request.getParameter("fecha");
        String filtros = request.getParameter("filtros");
        List<Turno> listaTurnos;

        //Verificamos que la fecha sea valida
        if (fechaStr != null && !fechaStr.isBlank()) {
            //Se establece la fecha como atributo de la solicitud 
            request.setAttribute("fecha", fechaStr);
            LocalDate fecha = LocalDate.parse(fechaStr);

            //Verificamos que se aplique filtro de estado
            if (filtros != null && !filtros.isBlank()) {
                Boolean estado = Boolean.parseBoolean(filtros);
                //Aplicamos filtro de estado y fecha
                listaTurnos = control.filtrarPorEstadoYFecha(estado, fecha);

            } else {
                //Solo filtramos por fecha
                listaTurnos = control.filtrarPorFecha(fecha);
            }

        } else {
            //filtramos todos los turnos
            listaTurnos = control.traerTurnos();

        }
        request.setAttribute("turnos", listaTurnos);
        request.getRequestDispatcher("mostrarTurnos.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //Obtenemos el parametro para verificar que accion realizamos
        String action = request.getParameter("action");

        //Accion => cambiar estado
        if (action != null && action.equals("cambiarEstado")) {
            //Cambiamos el estado de un turno
            long idTurno = Long.parseLong(request.getParameter("idTurno"));
            boolean nuevoEstado = Boolean.parseBoolean(request.getParameter("nuevoEstado"));
            control.cambiarEstado(idTurno, nuevoEstado);

            //Accion => crear turno    
        } else {
            String nombreCiudadano = request.getParameter("nombreCiudadano");
            String dniCiudadano = request.getParameter("dniCiudadano");
            long idTramite = Long.parseLong(request.getParameter("idTramite"));

            try {

                //Validamos formato del DNI
                if (!Validaciones.validarDNI(dniCiudadano)) {
                    List<Tramite> listaTramites = control.traerTramites();
                    request.setAttribute("listaTramites", listaTramites);
                    request.setAttribute("errorDNI", "El formato del DNI no es valido. Debe tener el formato de España: 12345678A.");
                    request.getRequestDispatcher("turnos.jsp").forward(request, response);
                    return;
                }

                //Validamos si un ciudadano tiene un turno activo
                if (control.ciudadanoActivo(dniCiudadano, idTramite)) {
                    List<Tramite> listaTramites = control.traerTramites();
                    request.setAttribute("listaTramites", listaTramites);
                    request.setAttribute("errorTramite", "El ciudadano ya tiene un turno activo para este tramite.");
                    request.getRequestDispatcher("turnos.jsp").forward(request, response);
                    return;
                }

                //Buscar ciudadano por DNI en la base de datos
                Ciudadano ciudadanoExistente = control.obtenerCiudadanoPorDNI(dniCiudadano);
                //Si el ciudadano no existe, creamos uno nuevo
                if (ciudadanoExistente == null) {
                    System.out.println("se ha creado desde aqui");
                    ciudadanoExistente = new Ciudadano(nombreCiudadano, dniCiudadano.toUpperCase());
                    control.crearCiudadano(ciudadanoExistente);

                }

                //Verificar si el ciudadano tiene un turno activo para un tramite
                if (control.ciudadanoActivo(dniCiudadano, idTramite)) {
                    List<Tramite> listaTramites = control.traerTramites();
                    request.setAttribute("listaTramites", listaTramites);
                    request.setAttribute("errorTramite", "El ciudadano ya tiene un turno activo para este tramite.");
                    request.getRequestDispatcher("turnos.jsp").forward(request, response);
                    return;
                }

                //Creamos un nuevo turno con todos los datos recogidos
                Tramite tramite = new Tramite();
                tramite.setId(idTramite);

                Turno turno = new Turno();
                turno.setFecha(LocalDate.now());
                turno.setEstado(true);
                turno.setCiudadano(ciudadanoExistente);
                turno.setTramite(tramite);

                control.crearTurno(turno);

                //Obtenemos lista de tramites
                List<Tramite> listaTramites = control.traerTramites();
                request.setAttribute("listaTramites", listaTramites);

                //Mensaje de creacion correcta
                request.setAttribute("successMessage", "El turno se ha agregado correctamente.");
                request.getRequestDispatcher("turnos.jsp").forward(request, response);

            } catch (ParseException ex) {
                Logger.getLogger(TurnosSv.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        //Redirigimos al servlet principal
        response.sendRedirect(request.getContextPath() + "/TurnoSv");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
