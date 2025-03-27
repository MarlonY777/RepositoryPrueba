<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ include file="../../WEB-INF/jspf/conexion.jspf" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Evaluar Proyectos</title>
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
                        onclick="window.location.href='adminEvaluador.jsp'"> MENÚ PRINCIPAL </button>
            </form>
            <form action="../../logout.jsp" method="post"  class="form-inline my-2 my-lg-0 ml-3">
                <button type="submit" class="btn btn-danger">Cerrar Sesión</button>
            </form>
        </div>
    </div>
</nav>
<div class="container my-4">
    <h1 class="text-center">Evaluar Proyectos</h1>
    <div class="row justify-content-center">
        <div class="col-md-8">
            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>ID Proyecto</th>
                        <th>Título</th>
                        <th>Descripción</th>
                        <th>Estudiante</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <sql:query var="proyectosAprobados" dataSource="${universidad}">
                        SELECT id_proyecto, titulo, descripcion,
                            (SELECT nombre FROM usuarios WHERE id_usuario = p.id_estudiante) as nombre_estudiante
                        FROM proyectos p
                        WHERE estado = 'Aprobado' AND id_proyecto NOT IN (SELECT id_proyecto FROM calificaciones);
                    </sql:query>
                    <c:forEach var="proyecto" items="${proyectosAprobados.rows}">
                        <tr>
                            <td><c:out value="${proyecto.id_proyecto}"/></td>
                            <td><c:out value="${proyecto.titulo}"/></td>
                            <td><c:out value="${proyecto.descripcion}"/></td>
                            <td><c:out value="${proyecto.nombre_estudiante}"/></td>
                            <td>
                                <form action="guardarCalificacion.jsp" method="post">
                                    <input type="hidden" name="id_proyecto" value="<c:out value="${proyecto.id_proyecto}"/>">
                                    <div class="form-group">
                                        <label for="calificacion">Calificación:</label>
                                        <input type="number" class="form-control" id="calificacion" name="calificacion" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="calificador">Calificado por:</label>
                                        <select class="form-control" id="evaluador" name="evaluador" required>
                                            <sql:query var="evaluadores" dataSource="${universidad}">
                                                SELECT id_usuario, nombre FROM usuarios WHERE tipo_usuario = 'Evaluador'
                                            </sql:query>
                                            <c:forEach var="usuario" items="${evaluadores.rows}">
                                                <option value="<c:out value="${usuario.id_usuario}"/>"><c:out value="${usuario.nombre}"/></option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Guardar Calificación</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
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
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
