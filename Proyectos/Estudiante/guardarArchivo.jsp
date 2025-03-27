<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../WEB-INF/jspf/conexion.jspf" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.DataSource" %>

<%
    // Obtener el ID del proyecto y el enlace del archivo del formulario
    String idProyecto = request.getParameter("id_proyecto");
    String enlaceArchivo = request.getParameter("enlace");

    // Verificar si el ID del proyecto y el enlace del archivo no están vacíos
    if (idProyecto != null && enlaceArchivo != null) {
        try {
            // Establecer la conexión a la base de datos
            Connection conn = null;
            PreparedStatement pstmt = null;
            try {
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Parcialc2", "root", "");

                // Consulta SQL para actualizar el enlace del archivo del proyecto
                String sql = "UPDATE proyectos SET archivo_proyecto = ? WHERE id_proyecto = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, enlaceArchivo);
                pstmt.setString(2, idProyecto);

                // Ejecutar la consulta
                int rowsAffected = pstmt.executeUpdate();
            } finally {
                // Cerrar la conexión y el PreparedStatement
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            }
            
            // Redirigir a la página informeProyectoEstudiante.jsp después de guardar el enlace del archivo
            response.sendRedirect("informeProyectoEstudiante.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            // Manejar cualquier excepción SQL
            out.println("Error al guardar el enlace del archivo: " + e.getMessage());
        }
    } else {
        // Manejar si el ID del proyecto o el enlace del archivo están vacíos
        out.println("ID del proyecto o enlace del archivo vacíos.");
    }
%>