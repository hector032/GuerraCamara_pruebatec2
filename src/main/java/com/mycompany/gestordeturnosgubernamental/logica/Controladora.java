package com.mycompany.gestordeturnosgubernamental.logica;

import com.mycompany.gestordeturnosgubernamental.persistencia.ControladoraPersistencia;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

public class Controladora {

    ControladoraPersistencia controlPersis = new ControladoraPersistencia();

    public void crearTurno(Turno turno) {
        controlPersis.crearTurno(turno);
    }

    //Metodo para comprobar si existe un ciudadano en la bdd con un tramite activo
    public Boolean ciudadanoActivo(String dni, long idTramite) {
        List<Turno> turnosActivos = controlPersis.traerTurnos();
        for (Turno turno : turnosActivos) {
            if (turno.getCiudadano().getDni().equalsIgnoreCase(dni)
                    && turno.getTramite().getId() == idTramite && turno.isEstado()) {
                return true; //El ciudadano tiene un turno activo para el tramite seleccionado
            }
        }
        return false;
    }
    //Metodo para buscar un ciudadano por su dni
    public Ciudadano obtenerCiudadanoPorDNI(String dni) {
        List<Turno> turnos = controlPersis.traerTurnos();
        Optional<Turno> turno = turnos.stream()
                .filter(t -> t.getCiudadano().getDni().equalsIgnoreCase(dni))
                .findFirst();
        if (turno.isPresent()) {
            return turno.get().getCiudadano();
        } else {
            return null;
        }
    }

    public void crearCiudadano(Ciudadano ciudadano) {
        controlPersis.crearCiudadano(ciudadano);
    }
    
    public List<Turno> traerTurnos() {
        return controlPersis.traerTurnos();

    }

    public Turno buscarTurnoPorId(Long id) {
        return controlPersis.buscarTurnosPorId(id);
    }

    public void crearTramite(Tramite tramite) {
        controlPersis.crearTramite(tramite);
    }

    public List<Tramite> traerTramites() {
        return controlPersis.traerTramites();

    }

    //Filtro para buscar turnos por fecha especifica
    public List<Turno> filtrarPorFecha(LocalDate fecha) {
        List<Turno> turnos = controlPersis.traerTurnos();
        return turnos.stream()
                .filter(turno -> turno.getFecha().equals(fecha))
                .collect(Collectors.toList());
    }

    //Filtro para buscar un estado en una fecha especifica P.EJ:clientes atendidos el 24/04/2024
    public List<Turno> filtrarPorEstadoYFecha(boolean estado, LocalDate fecha) {
        List<Turno> turnos = controlPersis.traerTurnos();
        return turnos.stream()
                .filter(turno -> turno.getFecha().equals(fecha) && turno.isEstado() == estado)
                .collect(Collectors.toList());
    }

    //Metodo para cambiar el estado de los tramites (En espera <--> Atendido)
    public void cambiarEstado(long idTurno, boolean nuevoEstado) {
        Turno turno = controlPersis.buscarTurnosPorId(idTurno);
        if (turno != null) {
            turno.setEstado(nuevoEstado);
            controlPersis.actualizarTurno(turno);
        }
    }
}




