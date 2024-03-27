
# Sistema de Gestión de Turnos - Ayuntamiento de Madrid
Este proyecto es un sistema de gestión de turnos desarrollado para el Ayuntamiento de Madrid. Facilita la administración de los turnos para trámites gubernamentales, optimizando el proceso y mejorando la experiencia tanto para los empleados como para los ciudadanos.

# Funciones de la aplicación
* Creación de Turnos: Permite a los empleados del ayuntamiento crear nuevos turnos para los ciudadanos que necesiten realizar trámites gubernamentales.
* Filtrado por Fecha: Los empleados pueden filtrar los turnos por fecha.
* Filtrado por Estado: Posibilidad de filtrar los turnos por su estado, ya sea "En espera" o "Atendido".
* Cambio de Estado: Los empleados pueden cambiar el estado de un turno una vez que ha sido atendido.
* Validaciones: Se incluyen validaciones para garantizar la integridad de los datos ingresados, como el formato del DNI y la existencia de turnos activos para un mismo ciudadano.

# Supuestos
* Al iniciar el sistema, se cargan los tramites predefinidos en el sistema:
    1. Renovacion de DNI
    2. Renovacion de pasaporte
    3. Cambiar empadronamiento
    4. Solicitud de ayudas sociales
    5. Solicitud de cambio de titularidad del coche
* Se asume que los usuarios del sistema son exclusivamente empleados del Ayuntamiento de Madrid.
* Se asume que los DNI son de ciudadanos Españoles y cumplen con el formato establecido del mismo.
* Los ciudadanos no tienen acceso directo al sistema, sino que son atendidos por los empleados que gestionan los turnos.


# Tecnologías Utilizadas
* Java: El backend del sistema está desarrollado en Java, utilizando el framework Servlet para el manejo de solicitudes HTTP.
* JSP (JavaServer Pages): Se utiliza JSP para generar las vistas dinámicas del sistema.
* HTML/CSS: Para el diseño y presentación de las páginas web.
* Bootstrap: Se utiliza Bootstrap como framework de front-end para facilitar el diseño y la experiencia de usuario.
* JavaScript: Se emplea JavaScript para la funcionalidad de paginación utilizando DataTables.
* MySQL: La base de datos del sistema está gestionada por MySQL.

# Configuración del Proyecto

    1. Clonar este repositorio github.com/hector032/GuerraCamara_pruebatec2

    2. Ejecuta la aplicación para iniciarla 

    3. Utilizar las opciones disponibles del gestionador de turnos gubernamentales

# IMPORTANTE
La configuración de la unidad de persistencia está en el archivo persistence.xml.

El fichero sql se encuentra en la raiz del proyecto (turnos.sql)


## Authors

- [@hector032](https://www.github.com/hector032)