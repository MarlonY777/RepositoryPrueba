<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@include file="WEB-INF/jspf/conexion.jspf"%>

<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>

<%
    String correo = request.getParameter("correo");
    String password = request.getParameter("password"); 

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ParcialC2", "root", "");
        String query = "SELECT id_usuario, nombre, tipo_usuario FROM usuarios WHERE correo = ? AND password = ?";
        stmt = conn.prepareStatement(query);
        stmt.setString(1, correo);
        stmt.setString(2, password);
        rs = stmt.executeQuery();

        if (rs.next()) {
            // El usuario y la password son válidos
            String tipoUsuario = rs.getString("tipo_usuario");
            session.setAttribute("usuario", rs.getString("nombre"));
            session.setAttribute("tipoUsuario", tipoUsuario);
            if (tipoUsuario.equals("Administrador")) {
                response.sendRedirect("adminAdministrar.jsp");
            } else if (tipoUsuario.equals("Coordinador")) {
                response.sendRedirect("./Proyectos/Coordinador/adminCoordinador.jsp");
            } else if (tipoUsuario.equals("Director")) {
                response.sendRedirect("./Proyectos/Director/adminDirector.jsp");
            } else if (tipoUsuario.equals("Evaluador")) {
                response.sendRedirect("./Proyectos/Evaluador/adminEvaluador.jsp");
            } else if (tipoUsuario.equals("Estudiante")) {
                response.sendRedirect("./Proyectos/Estudiante/adminEstudiante.jsp");
            } else {
                // Tipo de usuario no reconocido
                response.sendRedirect("login.jsp");
            }
        } else {
            // Usuario o contraseña incorrectos
            response.sendRedirect("login.jsp");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
