<%@page import="com.mycompany.gestordeturnosgubernamental.logica.Turno"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mostrar Turnos</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/2.0.3/css/dataTables.dataTables.css">
        <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
        <script src="https://cdn.datatables.net/2.0.3/js/dataTables.js"></script>
    </head>

    <!-- Añadimos dataTable de JS para paginacion -->
    <script>
        $(document).ready(function () {
            new DataTable('#turnos', {
                pagingType: 'simple_numbers',
                "language": {
                    url: '//cdn.datatables.net/plug-ins/2.0.3/i18n/es-ES.json',
                    //search: 'Buscar:',
                }, columnDefs: [{
                        "defaultContent": "",
                        "targets": "_all"
                    }]
            });
        });
    </script>
    <body>
        <div class="container mt-4">
            <div class="col">
                <form action="TurnoSv" class="p-2 float-right" method="GET" style="display: inline">
                    <button type=" submit" class="btn btn-secondary" type="submit">Mostrar turnos</button>
                </form>

                <form action="TramiteSv" class="p-2 float-right" method="GET" style="display: inline">
                    <button type=" submit" class="btn btn-primary" type="submit">Crear turno</button>
                </form>
                <a type="button" href="index.jsp" " class="btn btn-secondary my-2">Home</a>
                <h1>Gestión de turnos</h1>

                <br>      
                <h3>Listado de turnos</h3>
                <br><br>    

            </div>
            <div class="row">
                <div class="col float-right">
                    <form action="TurnoSv" method="GET">
                        <label for ="fecha">Filtrar por fecha:</label>
                        <input type="date" id="fecha"  name="fecha" value="<%= (String) request.getAttribute("fecha")%>" required> 
                        <button type="submit" name="filtros" value="" class="btn btn-success">Filtrar por fecha</button>
                        <button type="submit" name="filtros" value="true" class="btn btn-primary">Clientes en espera</button>
                        <button type="submit" name="filtros" value="false" class="btn btn-primary">Clientes atentidos</button>
                    </form>
                </div>
            </div>  
            <div class="row">
                <div class="col pt-5">

                    <table class="table" id="turnos" >
                        <thead>
                            <tr>
                                <th>Número de Turno</th>
                                <th>Nombre Ciudadano</th>
                                <th>DNI</th>
                                <th>Trámite</th>
                                <th>Fecha</th>
                                <th>Estado</th>
                                <th>Acciones</th>

                            </tr>
                        </thead>
                        <tbody>                    
                            <% List<Turno> turnos = (List<Turno>) request.getAttribute("turnos");
                                if (turnos != null && !turnos.isEmpty()) {
                                    for (Turno turno : turnos) {
                            %>
                            <tr>
                                <td><%= turno.getId()%></td>
                                <td><%= turno.getCiudadano().getNombre()%></td>
                                <td><%= turno.getCiudadano().getDni()%></td>
                                <td><%= turno.getTramite().getDescripcion()%></td>
                                <td><%= turno.getFecha()%></td>
                                <td><%= turno.isEstado() ? "En espera" : "Ya atendido"%></td>
                                <td>
                                    <form action="TurnoSv" method="POST">
                                        <input type="hidden" name="action" value="cambiarEstado">
                                        <input type="hidden" name="idTurno" value="<%= turno.getId()%>">
                                        <input type="hidden" name="nuevoEstado" value="<%= !turno.isEstado()%>">
                                        <button type="submit" class="btn btn-warning btn-sm">Cambiar Estado</button>
                                    </form>
                                </td>
                            </tr>
                            <%  }
                            } else {
                            %>
                            <tr>
                                <td colspan="7">No hay turnos disponibles.</td>
                            </tr>
                            <% }%>
                        </tbody>
                    </table>
                </div>
            </div>     

            <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    </body>
</html>
