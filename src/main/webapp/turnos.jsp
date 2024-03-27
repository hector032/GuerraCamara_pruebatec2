<%@page import="java.util.List"%>
<%@page import="com.mycompany.gestordeturnosgubernamental.logica.Tramite"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Gestión de Turnos</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    </head>
    <body>

        <div class="container mt-4">

            <!-- Mandamos alert de error del formato del dni -->
            <% if (request.getAttribute("errorDNI") != null) {%>
            <div class="alert alert-danger" role="alert">
                <%= request.getAttribute("errorDNI")%>
            </div>
            <% } %>

            <!-- Mandamos alert de error de tramite activo en uso para un ciudadano -->
            <% if (request.getAttribute("errorTramite") != null) {%>
            <div class="alert alert-danger" role="alert">
                <%= request.getAttribute("errorTramite")%>
            </div>
            <% } %>

            <!-- Mandamos alert de turno creado correctamente -->
            <div class="container mt-4">
                <% if (request.getAttribute("successMessage") != null) {%>
                <div class="alert alert-success" role="alert">
                    <%= request.getAttribute("successMessage")%>
                </div>
                <% } %>
            </div>

            <div class="row">
                <div class="col">
                    <h1>Gestión de Turnos</h1>
                    <br>      
                    <h3>Agregar Nuevo Turno</h3>
                </div>
                <div class="col">
                    <div class="float-right">
                        <form action="TurnoSv" method="GET">
                            <button type=" submit" class="btn btn-secondary" type="submit">
                                Mostrar turnos
                            </button>
                        </form>
                    </div>
                </div>
            </div>

            <br>

            <form action="TurnoSv" method="post">
                <div class="form-group">
                    <label for="nombreCiudadano">Nombre del ciudadano:</label>
                    <input type="text" class="form-control" id="nombreCiudadano" name="nombreCiudadano" required>
                </div>
                <div class="form-group">
                    <label for="dniCiudadano">DNI del ciudadano:</label>
                    <input type="text" class="form-control" id="dniCiudadano" name="dniCiudadano" required>
                </div>
                <div class="form-group">
                    <label for="tramiteSelect">Trámite:</label>
                    <select class="form-control form-select form-select-lg mb-3" aria-label=".form-select-lg example" id="idTramite" name="idTramite" required>
                        <option value="" required>Seleccione un trámite</option>
                        <%
                            List<Tramite> listaTramites = (List<Tramite>) request.getAttribute("listaTramites");
                            if (listaTramites != null) {
                                for (Tramite tramite : listaTramites) {
                                    if (tramite.getId() != null && tramite.getDescripcion() != null) {
                        %>
                        <option value="<%= tramite.getId()%>"><%= tramite.getDescripcion()%></option>
                        <%
                                    }
                                }
                            }
                        %>

                    </select>

                </div>
                <button type="submit" class="btn btn-success">Agregar turno</button>

                <a type="button" href="index.jsp" " class="btn btn-danger my-2">Cancelar</a>
            </form>


        </div>  
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    </body>
</html>
