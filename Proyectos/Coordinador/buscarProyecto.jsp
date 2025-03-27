<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@include file="../../../WEB-INF/jspf/conexion.jspf"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Buscar Proyecto por Estudiante</title>
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
                <li class="nav-item">
                    <a class="nav-link" href="./adminProyectos/agregarProyecto.jsp">Agregar Proyecto</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="adminCoordinador.jsp">Administrar Proyectos</a>
                </li>
                <li class="nav-item">
                    <form class="form-inline my-2 my-lg-0 ml-3">
                        <button type="button" class="btn btn-warning btn-primary-outline-warning"
                                onclick="window.location.href='adminCoordinador.jsp'">MENÚ PRINCIPAL</button>
                    </form>
                </li>
            </ul>
        </div>
    </div>
</nav>
<div class="container my-4 ">
    <h1 class="text-center">Buscar Proyecto</h1>
    <div class="row justify-content-center">
        <div class="col-md-6">
            <form action="buscarProyecto.jsp" method="get">
                <div class="form-group">
                    <label for="tipoUsuario">Tipo de Usuario:</label>
                    <select class="form-control" id="tipoUsuario" name="tipoUsuario">
                        <option value="estudiante">Estudiante</option>
                        <option value="director">Director</option>
                        <option value="evaluador">Evaluador</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="nombreUsuario">Nombre del Usuario:</label>
                    <input type="text" class="form-control" id="nombreUsuario" name="nombreUsuario" required>
                </div>
                <button type="submit" class="btn btn-primary">Buscar Proyecto</button>
            </form>
        </div>
    </div>

    <c:if test="${param.nombreUsuario != null}">
        <sql:query var="proyectosUsuario" dataSource="${universidad}">
            SELECT p.id_proyecto, p.titulo, p.descripcion, p.estado, 
                (SELECT nombre FROM usuarios WHERE id_usuario = p.id_estudiante) as estudiante,
                (SELECT nombre FROM usuarios WHERE id_usuario = p.id_director) as director,
                (SELECT nombre FROM usuarios WHERE id_usuario = p.id_evaluador) as evaluador
            FROM proyectos p
            WHERE 
                CASE 
                    WHEN '${param.tipoUsuario}' = 'estudiante' THEN
                        (SELECT nombre FROM usuarios WHERE id_usuario = p.id_estudiante) 
                    WHEN '${param.tipoUsuario}' = 'director' THEN
                        (SELECT nombre FROM usuarios WHERE id_usuario = p.id_director) 
                    ELSE
                        (SELECT nombre FROM usuarios WHERE id_usuario = p.id_evaluador) 
                END LIKE '%${param.nombreUsuario}%';

        </sql:query>

        <div class="mt-4">
            <h2>Resultados de la Búsqueda</h2>
            <c:choose>
                <c:when test="${proyectosUsuario.rows != null}">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Título</th>
                                <th>Descripción</th>
                                <th>Estado</th>
                                <th>Estudiante</th>
                                <th>Director</th>
                                <th>Evaluador</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="proyecto" items="${proyectosUsuario.rows}">
                                <tr>
                                    <td>${proyecto.id_proyecto}</td>
                                    <td>${proyecto.titulo}</td>
                                    <td>${proyecto.descripcion}</td>
                                    <td>${proyecto.estado}</td>
                                    <td>${proyecto.estudiante}</td>
                                    <td>${proyecto.director}</td>
                                    <td>${proyecto.evaluador}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <p>No se encontraron proyectos para el usuario especificado.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </c:if>
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
