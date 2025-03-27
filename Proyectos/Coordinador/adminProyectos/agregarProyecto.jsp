<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@include file="../../../WEB-INF/jspf/conexion.jspf"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
    <title>Agregar Proyecto</title>
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
                    <a class="nav-link" href="#">Agregar Proyecto</a>
                </li>
            </ul>
            <form class="form-inline my-2 my-lg-0 ml-3">
                <button type="button" class="btn btn-warning btn-primary-outline-warning"
                        onclick="window.location.href='../adminCoordinador.jsp'"> MENÚ PRINCIPAL </button>
            </form>
        </div>
    </div>
</nav>
<div class="container my-4">
    <h1 class="text-center">Nuevo Proyecto</h1>

    <c:choose>
        <c:when test="${empty param.titulo}">
            <form action="agregarProyecto.jsp" method="post">
                <div class="form-group">
                    <label for="titulo">Título:</label>
                    <input type="text" class="form-control" id="titulo" name="titulo" required>
                </div>
                <div class="form-group">
                    <label for="descripcion">Descripción:</label>
                    <textarea class="form-control" id="descripcion" name="descripcion" rows="5" required></textarea>
                </div>
                <div class="form-group">
                    <label for="estado">Estado:</label>
                    <label for="estado1">Pendiente</label>
                    <input type="hidden" value="Pendiente" name="estado" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="director">Director:</label>
                    <select class="form-control" id="director" name="director" required>
                        <sql:query var="directores" dataSource="${universidad}">
                            SELECT id_usuario, nombre FROM usuarios WHERE tipo_usuario = 'Director'
                        </sql:query>
                        <c:forEach var="usuario" items="${directores.rows}">
                            <option value="<c:out value="${usuario.id_usuario}"/>"><c:out value="${usuario.nombre}"/></option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label for="evaluador">Evaluador:</label>
                    <select class="form-control" id="evaluador" name="evaluador" required>
                        <sql:query var="evaluadores" dataSource="${universidad}">
                            SELECT id_usuario, nombre FROM usuarios WHERE tipo_usuario = 'Evaluador'
                        </sql:query>
                        <c:forEach var="usuario" items="${evaluadores.rows}">
                            <option value="<c:out value="${usuario.id_usuario}"/>"><c:out value="${usuario.nombre}"/></option>
                        </c:forEach>
                    </select>
                </div>
                <button type="submit" class="btn btn-success rounded-pill fs-5">Guardar</button>
                <a href="indexProyecto.jsp" class="btn btn-danger rounded-pill fs-5">Cancelar</a>
            </form>
        </c:when>
        <c:otherwise>
            <sql:update var="result" dataSource="${universidad}">
                INSERT INTO proyectos (titulo, descripcion, estado, id_director, id_evaluador)
                VALUES (
                    '${param.titulo}',
                    '${param.descripcion}',
                    '${param.estado}',
                    ${param.director},
                    ${param.evaluador}
                )
            </sql:update>
            <div class="text-center my-5">
                <c:if test="${result == 1}">
                    <p>¡Proyecto insertado satisfactoriamente!</p>
                    <a href="indexProyecto.jsp" class="btn btn-warning rounded-pill fs-5">Regresar</a>
                </c:if>
            </div>
        </c:otherwise>
    </c:choose>
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
