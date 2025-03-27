<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../WEB-INF/jspf/conexion.jspf"%>
<%@page import="java.sql.*" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
// Obtener el ID del proyecto de la URL
String proyectoId = request.getParameter("id");

// Obtener el nombre del estudiante de la sesión
String nombreEstudiante = (String) session.getAttribute("usuario");

// Actualizar el proyecto con el estudiante asignado y el estado a Aprobado
try {
    Connection conn = null;
    PreparedStatement pstmt = null;

    // Establecer la conexión a la base de datos
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Parcialc2", "root", "");

    // Obtener el ID del estudiante desde la base de datos usando su nombre
    String idEstudiante = null;
    String queryIdEstudiante = "SELECT id_usuario FROM usuarios WHERE nombre = ?";
    try (PreparedStatement pstmtIdEstudiante = conn.prepareStatement(queryIdEstudiante)) {
        pstmtIdEstudiante.setString(1, nombreEstudiante);
        try (ResultSet rsIdEstudiante = pstmtIdEstudiante.executeQuery()) {
            if (rsIdEstudiante.next()) {
                idEstudiante = rsIdEstudiante.getString("id_usuario");
            }
        }
    }

    // Actualizar la tabla proyectos con el ID del estudiante y el estado a Aprobado
    String query = "UPDATE proyectos SET id_estudiante = ?, estado = ? WHERE id_proyecto = ?";
    pstmt = conn.prepareStatement(query);
    pstmt.setString(1, idEstudiante); // Aquí asignamos el ID del estudiante en lugar de su nombre
    pstmt.setString(2, "Aprobado");
    pstmt.setString(3, proyectoId);

    // Ejecutar la actualización
    int rowsUpdated = pstmt.executeUpdate();
    
    if (rowsUpdated > 0) {
        out.println("<h2>Estudiante asignado correctamente al proyecto.</h2>");
    } else {
        out.println("<h2>Error al asignar estudiante al proyecto.</h2>");
    }

    // Cerrar la conexión y los recursos
    pstmt.close();
    conn.close();
} catch (SQLException e) {
    out.println("<h2>Error de base de datos: " + e.getMessage() + "</h2>");
    e.printStackTrace();
}
%>

<a href="./seleccionarIdeaProyecto.jsp" class="btn btn-outline-secondary rounded-pill fs-5 mb-5 mx-2">Regresar</a>
