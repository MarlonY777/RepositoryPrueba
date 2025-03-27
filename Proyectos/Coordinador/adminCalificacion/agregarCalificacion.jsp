<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@include file="../../../WEB-INF/jspf/conexion.jspf"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Sistema Universitario</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="../../../style.css">
</head>
<body>
<header class="container-fluid pt-1 pb-1 bg-warning d-flex justify-content-center">
    <p class="text-light mb-0 p-2 fs-5">Ejercicio JAVA JSTL - Marlon Yesid Sánchez Moncada</p>
</header>
<nav class="navbar navbar-expand-lg navbar-dark p-3" id="menu">
    <div class="container">
        <a class="navbar-brand" href="#">
            <img src="../../../img/java_logo_blanco.png" alt="#">
            <span class="ml-2 fs-5 text-white fw-bold">Ejercicios JSTL</span>
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="agregarProyecto.jsp">Agregar Proyecto</a>
                </li>
            </ul>
            <form class="form-inline my-2 my-lg-0 ml-3">
                <button type="button" class="btn btn-warning btn-primary-outline-warning"
                        onclick="window.location.href='indexProyecto.jsp'"> MENÚ PRINCIPAL </button>
            </form>
        </div>
    </div>
</nav>
<div class="container my-4">
    <h1 class="text-center">Nueva Calificación</h1>

    <c:if test="${param.calificacion == null}">
        <form action="agregarCalificacion.jsp" method="post">
            <div class="form-group">
                <label for="id_proyecto">Proyecto:</label>
                <select class="form-control" id="id_proyecto" name="id_proyecto" required>
                    <sql:query var="proyectos" dataSource="${universidad}">
                        SELECT id_proyecto, titulo FROM proyectos
                    </sql:query>
                    <c:forEach var="proyecto" items="${proyectos.rows}">
                        <option value="<c:out value="${proyecto.id_proyecto}"/>"><c:out value="${proyecto.titulo}"/></option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label for="id_usuario_calificador">Director:</label>
                <select class="form-control" id="id_proyecto" name="id_proyecto" required>
                    <sql:query var="proyectos" dataSource="${universidad}">
                        SELECT id_proyecto, titulo FROM proyectos
                    </sql:query>
                    <c:forEach var="proyecto" items="${proyectos.rows}">
                        <option value="<c:out value="${proyecto.id_proyecto}"/>"><c:out value="${proyecto.titulo}"/></option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label for="calificacion">Calificación:</label>
                <select class="form-control" id="calificacion" name="calificacion" required>
                    <option value="PENDIENTE">PENDIENTE</option>
                    <option value="APROBADO">APROBADO</option>
                    <option value="DESAPROBADO">DESAPROBADO</option>
                </select>
            </div>
            <button type="submit" class="btn btn-success rounded-pill fs-5">Guardar</button>
            <a href="indexProyecto.jsp" class="btn btn-danger rounded-pill fs-5">Cancelar</a>
        </form>
    </c:if>

    <c:if test="${param.calificacion != null}">
        <sql:update var="result" dataSource="${universidad}">
            INSERT INTO calificaciones (id_proyecto, id_usuario_calificador, calificacion)
            VALUES (
                '${param.id_proyecto}',
                '${param.id_usuario_calificador}',
                '${param.calificacion}'
            )
        </sql:update>
        <div class="text-center my-5">
            <c:if test="${result == 1}">
                <p>¡Calificación registrada satisfactoriamente!</p>
                <a href="indexProyecto.jsp" class="btn btn-warning rounded-pill fs-5">Regresar</a>
            </c:if>
        </div>
    </c:if>
</div>
<footer class="bg-dark text-white mt-5 py-3">
    <div class="container d-flex justify-content-center justify-content-lg-between align-items-center flex-wrap">
        <p class="text-center text-lg-start flex-grow-1 mb-0">&copy; Marlon Yesid Sánchez Moncada - Derechos Reservados.</p>
        <div class="social-links d-flex justify-content-center justify-content-lg-end align-items-center">
            <a href="#"><img src="../../../img/facebook.png" alt="#" width="40px" height="40px"></a>
            <a href="#"><img src="../../../img/instagram.png" alt="#" width="40px" height="40px"></a>
            <a href="#"><img src="../../../img/twitter.png" alt="#" width="40px" height="40px"></a>
            <a href="#"><img src="../../../img/youtube.png" alt="#" width="40px" height="40px"></a>
        </div>
    </div>
</footer>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
