package com.mycompany.gestordeturnosgubernamental.persistencia;

import com.mycompany.gestordeturnosgubernamental.logica.Ciudadano;
import com.mycompany.gestordeturnosgubernamental.logica.Tramite;
import com.mycompany.gestordeturnosgubernamental.logica.Turno;
import java.util.List;

public class ControladoraPersistencia {

    TurnoJpaController turnoJPA = new TurnoJpaController();
    TramiteJpaController tramiteJPA = new TramiteJpaController();
    CiudadanoJpaController ciudadanoJPA = new CiudadanoJpaController();

    public void crearTurno(Turno turno) {
        if (turno.getCiudadano() != null) {
            turnoJPA.create(turno);
        } else {
            System.err.println("xxxxx_Error_xxxxxxx");

        }
    }

    public List<Turno> traerTurnos() {
        return turnoJPA.findTurnoEntities();
    }

    public Turno buscarTurnosPorId(Long id) {
        return turnoJPA.findTurno(id);
    }

    public void crearTramite(Tramite tramite) {
        tramiteJPA.create(tramite);
    }

    public List<Tramite> traerTramites() {
        return tramiteJPA.findTramiteEntities();

    }

    public void actualizarTurno(Turno turno) {
        try {
            turnoJPA.edit(turno);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public void crearCiudadano(Ciudadano ciudadano) {
        ciudadanoJPA.create(ciudadano);
    }

}
