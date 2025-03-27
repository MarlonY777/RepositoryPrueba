<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@include file="../WEB-INF/jspf/conexion.jspf"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
    <title>Sistema Universitano</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="../style.css">
</head>
<body>
<header class="container-fluid pt-1 pb-1 bg-warning d-flex justify-content-center">
<p class="text-light mb-0 p-2 fs-5">Ejercicio JAVA JSTL - Marlon Yesid Sánchez Moncada</p>
</header>
<nav class="navbar navbar-expand-lg navbar-dark p-3" id="menu">
   <div class="container">
      <a class="navbar-brand" href="#">
         <img src="../img/java_logo_blanco.png" alt="#">
         <span class="ml-2 fs-5 text-white fw-bold">Ejercicios JSTL</span>
      </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="../agregarUsuarios.jsp">Agregar usuarios</a>
                </li>
            </ul>
            <form class="form-inline my-2 my-lg-0 ml-3">
                <button type="button" class="btn btn-warning btn-primary-outline-warning"
                        onclick="window.location.href='../adminAdministrar.jsp'"> MENÚ PRINCIPAL </button>
            </form>
        </div>
   </div>
</nav>
    <div class="container mt-5">
        <h1 class="text-center">Sistema Universitario</h1>
        <h2 class="text-center">Actualizar usuarios</h2>

        <c:if test="${param.nombre == null}">
        <sql:query var="parcialc2" dataSource="${universidad}">
            SELECT * FROM usuarios WHERE id_usuario = ?
            <sql:param value="${param.id}">
            </sql:param>
        </sql:query>
        <form method="post">
            <table class="table">
                <c:forEach var="usuario" items="${parcialc2.rows}">
                    <tr>
                        <td><input type="hidden" name="id_usuario" value="${usuario.id}"/></td>
                    </tr>
                    <tr>
                        <td>Nombre</td>
                        <td><input type="text" name="nombre" value="${usuario.nombre}" class="form-control"/></td>
                    </tr>
                    <tr>
                        <td>Correo</td>
                        <td><input type="text" name="correo" value="${usuario.correo}" class="form-control"/></td>
                    </tr>
                    <tr>
                        <td>Password</td>
                        <td><input type="text" name="password" value="${usuario.password}" class="form-control"/></td>
                    </tr>
                </c:forEach>
            </table>
            <br>
            <input type="submit" value="Actualizar" class="btn btn-primary"/>
            <input type="hidden" name="modifica" value="SI"/>
        </form>
    </c:if>

        <c:if test="${param.modifica !=null}">
            <sql:update var="result" dataSource="${universidad}">
                UPDATE usuarios
                SET nombre='${param.nombre}',
                    correo='${param.correo}',
                    password='${param.password}'
                WHERE id_usuario = ${param.id}
            </sql:update>
            <c:if test="${result == 1}">
                <p class="mt-5 mb-5">Resgistro Actualizado Satisfactoriamente!</p>
                <a href="indexDirector.jsp" class="btn btn-primary mb-3">Regresar</a>
            </c:if>
        </c:if>
    </div>
<footer class="bg-dark text-white mt-5 py-3">
    <div class="container d-flex justify-content-center justify-content-lg-between align-items-center flex-wrap">
        <p class="text-center text-lg-start flex-grow-1 mb-0">&copy; Marlon Yesid Sánchez Moncada - Derechos Reservados.</p>
        <div class="social-links d-flex justify-content-center justify-content-lg-end align-items-center">
            <a href="#"><img src="../img/facebook.png" alt="#" width="40px" height="40px"></a>
            <a href="#"><img src="../img/instagram.png" alt="#" width="40px" height="40px"></a>
            <a href="#"><img src="../img/twitter.png" alt="#" width="40px" height="40px"></a>
            <a href="#"><img src="../img/youtube.png" alt="#" width="40px" height="40px"></a>
        </div>
    </div>
</footer>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"></script></body>
</html>
