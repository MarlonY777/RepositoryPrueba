<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../../WEB-INF/jspf/conexion.jspf" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Administrar Proyectos</title>
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
            <form class="form-inline my-2 my-lg-0 ml-3">
                <button type="button" class="btn btn-warning btn-primary-outline-warning"
                        onclick="window.location.href='#'"> MENÚ PRINCIPAL </button>
            </form>
            <form action="../../logout.jsp" method="post"  class="form-inline my-2 my-lg-0 ml-3">
                <button type="submit" class="btn btn-danger">Cerrar Sesión</button>
            </form>
        </div>
    </div>
</nav>
<div class="container mt-5">
    <h1 class="text-center mb-4">Informe de Proyecto de <%= session.getAttribute("usuario") %></h1>
    
    <%-- <form action="informeProyectoEstudiante.jsp" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label for="archivo">Subir archivo del proyecto:</label>
            <input type="file" class="form-control-file" id="archivo" name="archivo">
        </div>
        <button type="submit" class="btn btn-primary">Subir Archivo</button>
    </form> --%>

    <hr>

    <%-- Verificar si hay un usuario logueado y obtener su nombre de usuario --%>
    <c:if test="${not empty sessionScope.usuario}">
        <%-- Obtener el proyecto asignado al estudiante con la sesión actual --%>
        <sql:query var="proyecto" dataSource="${universidad}">
            SELECT 
                p.id_proyecto, 
                p.titulo, 
                p.descripcion, 
                p.estado,
                p.archivo_proyecto,
                (SELECT nombre FROM usuarios WHERE id_usuario = p.id_estudiante) as estudiante,
                (SELECT nombre FROM usuarios WHERE id_usuario = p.id_director) as director,
                (SELECT nombre FROM usuarios WHERE id_usuario = p.id_evaluador) as evaluador
            FROM
                proyectos p
            WHERE
                p.id_estudiante = (SELECT id_usuario FROM usuarios WHERE nombre = '${sessionScope.usuario}')
        </sql:query>
        
        <c:choose>
            <c:when test="${proyecto.rows != null}">
                <table class="table table-hover table-striped text-center">
                    <thead class="thead-dark">
                        <tr>
                            <th>ID</th>
                            <th>Título</th>
                            <th>Descripción</th>
                            <th>Estado</th>
                            <th>Estudiante</th>
                            <th>Director</th>
                            <th>Evaluador</th>
                            <th>Archivo</th>
                            <th>Ver Archivo</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="proyecto" items="${proyecto.rows}">
                            <tr>
                                <td>${proyecto.id_proyecto}</td>
                                <td>${proyecto.titulo}</td>
                                <td>${proyecto.descripcion}</td>
                                <td>${proyecto.estado}</td>
                                <td>${proyecto.estudiante}</td>
                                <td>${proyecto.director}</td>
                                <td>${proyecto.evaluador}</td>
                                <td><a href="./subirArchivo.jsp?id=${proyecto.id_proyecto}" class="btn btn-outline-primary rounded-pill fs-5">Subir Archivo</a></td>
                                <td>
                                    <c:if test="${not empty proyecto.archivo_proyecto}">
                                        <a href="${proyecto.archivo_proyecto}" target="_blank">Ver Archivo</a>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <p>No se encontraron proyectos para el usuario especificado.</p>
            </c:otherwise>
        </c:choose>
    </c:if>

    <br>
    <a href="./seleccionarIdeaProyecto.jsp" class="btn btn-outline-secondary rounded-pill fs-5 mb-5 mx-2">Regresar</a>

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
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
