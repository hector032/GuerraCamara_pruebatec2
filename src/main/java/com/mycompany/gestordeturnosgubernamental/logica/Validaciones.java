package com.mycompany.gestordeturnosgubernamental.logica;

public class Validaciones {

    public static boolean validarDNI(String dni) {

        String validador = "\\d{8}[A-HJ-NP-TV-Za-hj-np-tv-z]";
        return dni.matches(validador);
    }
}
