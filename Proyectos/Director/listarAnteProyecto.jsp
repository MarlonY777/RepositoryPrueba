<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@include file="../../WEB-INF/jspf/conexion.jspf"%>
<%@page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
    <title>Listar Anteproyectos</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="../../style.css">
</head>
<body>
<header class="container-fluid pt-1 pb-1 bg-warning d-flex justify-content-center">
    <p class="text-light mb-0 p-2 fs-5">Ejercicio JAVA JSTL - Marlon Yesid Sánchez Moncada</p>
</header>
<nav class="navbar navbar-expand-lg navbar-dark p-3" id="menu">
    <div class="container">
        <a class="navbar-brand" href="#">
            <img src="../../img/java_logo_blanco.png" alt="#">
            <span class="ml-2 fs-5 text-white fw-bold">Ejercicios JSTL</span>
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
            </ul>
            <form  class="form-inline my-2 my-lg-0 ml-3">
                <button type="button" class="btn btn-warning btn-primary-outline-warning"
                        onclick="window.location.href='adminDirector.jsp'"> MENÚ PRINCIPAL </button>
            </form>
        </div>
    </div>
</nav>
<div class="container my-4">
    <h1 class="text-center">Listar Anteproyectos</h1>

    <div class="table-responsive">
        <table class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th>ID Proyecto</th>
                    <th>Título</th>
                    <th>Descripción</th>
                    <th>Estado</th>
                    <th>Estudiante</th>
                    <th>Director</th>
                    <th>Evaluador</th>
                </tr>
            </thead>
            <tbody>
                <sql:query var="anteproyectos" dataSource="${universidad}">
                    SELECT p.id_proyecto, p.titulo, p.descripcion, p.estado,
                        (SELECT nombre FROM usuarios WHERE id_usuario = p.id_estudiante) as nombre_estudiante,
                        (SELECT nombre FROM usuarios WHERE id_usuario = p.id_director) as nombre_director,
                        (SELECT nombre FROM usuarios WHERE id_usuario = p.id_evaluador) as nombre_evaluador
                    FROM proyectos p;

                </sql:query>
                <c:forEach var="anteproyecto" items="${anteproyectos.rows}">
                    <tr>
                        <td><c:out value="${anteproyecto.id_proyecto}"/></td>
                        <td><c:out value="${anteproyecto.titulo}"/></td>
                        <td><c:out value="${anteproyecto.descripcion}"/></td>
                        <td><c:out value="${anteproyecto.estado}"/></td>
                        <td><c:out value="${anteproyecto.nombre_estudiante}"/></td>
                        <td><c:out value="${anteproyecto.nombre_director}"/></td>
                        <td><c:out value="${anteproyecto.nombre_evaluador}"/></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<footer class="bg-dark text-white mt-5 py-3">
    <div class="container d-flex justify-content-center justify-content-lg-between align-items-center flex-wrap">
        <p class="text-center text-lg-start flex-grow-1 mb-0">&copy; Marlon Yesid Sánchez Moncada - Derechos Reservados.</p>
        <div class="social-links d-flex justify-content-center justify-content-lg-end align-items-center">
            <a href="#"><img src="../../img/facebook.png" alt="#" width="40px" height="40px"></a>
            <a href="#"><img src="../../img/instagram.png" alt="#" width="40px" height="40px"></a>
            <a href="#"><img src="../../img/twitter.png" alt="#" width="40px" height="40px"></a>
            <a href="#"><img src="../../img/youtube.png" alt="#" width="40px" height="40px"></a>
        </div>
    </div>
</footer>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9
