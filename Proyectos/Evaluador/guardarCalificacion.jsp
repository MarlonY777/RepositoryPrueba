<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ include file="../../WEB-INF/jspf/conexion.jspf" %>
<sql:setDataSource var="universidad" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/parcialc2" user="root" password=""/>

<sql:update dataSource="${universidad}">
    INSERT INTO calificaciones (id_proyecto, id_usuario_calificador, calificacion)
    VALUES (?, ?, ?);
    <sql:param value="${param.id_proyecto}" />
    <sql:param value="${param.calificador}" />
    <sql:param value="${param.calificacion}" />
</sql:update>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Guardar Calificación</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="../../style.css">
</head>
<body>
<div class="container my-4">
    <h1 class="text-center">Calificación Guardada</h1>
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="alert alert-success" role="alert">
                La calificación ha sido guardada correctamente.
            </div>
            <a href="evaluarProyectos.jsp" class="btn btn-primary">Volver a Evaluar Proyectos</a>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
