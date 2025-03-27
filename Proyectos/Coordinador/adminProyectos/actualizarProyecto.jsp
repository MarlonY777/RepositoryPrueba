<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@include file="../../../WEB-INF/jspf/conexion.jspf"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Actualizar Proyecto</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body style="background-color: #ebebebcc">
<div class="container my-4">
    <h1 class="text-center">Actualizar Proyecto</h1>
    <c:if test="${param.titulo == null}">
        <sql:query var="proyecto" dataSource="${universidad}">
            SELECT * FROM proyectos WHERE id_proyecto = ?
            <sql:param value="${param.id}">
            </sql:param>
        </sql:query>
        <form action="actualizarProyecto.jsp" method="post">
            <table class="table">
                <c:forEach var="item" items="${proyecto.rows}">
                    <tr>
                        <td><input type="hidden" name="id" value="${item.id_proyecto}"/></td>
                    </tr>
                    <tr>
                        <td>Título</td>
                        <td><input type="text" class="form-control" name="titulo" value="${item.titulo}"/></td>
                    </tr>
                    <tr>
                        <td>Descripción</td>
                        <td><textarea class="form-control" name="descripcion" rows="5">${item.descripcion}</textarea></td>
                    </tr>
                    <tr>
                        <td>Estado</td>
                        <td>
                            <select class="form-control" name="estado">
                                <option value="Pendiente" ${item.estado == 'Pendiente' ? 'selected' : ''}>Pendiente</option>
                                <option value="Aprobado" ${item.estado == 'Aprobado' ? 'selected' : ''}>Aprobado</option>
                                <option value="Rechazado" ${item.estado == 'Rechazado' ? 'selected' : ''}>Rechazado</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Estudiante</td>
                        <td>
                            <select class="form-control" name="estudiante">
                                <sql:query var="estudiantes" dataSource="${universidad}">
                                    SELECT id_usuario, nombre FROM usuarios WHERE tipo_usuario = 'Estudiante'
                                </sql:query>
                                <c:forEach var="estudiante" items="${estudiantes.rows}">
                                    <option value="${estudiante.id_usuario}" ${estudiante.id_usuario == item.id_estudiante ? 'selected' : ''}>${estudiante.nombre}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Director</td>
                        <td>
                            <select class="form-control" name="director">
                                <sql:query var="directores" dataSource="${universidad}">
                                    SELECT id_usuario, nombre FROM usuarios WHERE tipo_usuario = 'Director'
                                </sql:query>
                                <c:forEach var="director" items="${directores.rows}">
                                    <option value="${director.id_usuario}" ${director.id_usuario == item.id_director ? 'selected' : ''}>${director.nombre}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Evaluador</td>
                        <td>
                            <select class="form-control" name="evaluador">
                                <sql:query var="evaluadores" dataSource="${universidad}">
                                    SELECT id_usuario, nombre FROM usuarios WHERE tipo_usuario = 'Evaluador'
                                </sql:query>
                                <c:forEach var="evaluador" items="${evaluadores.rows}">
                                    <option value="${evaluador.id_usuario}" ${evaluador.id_usuario == item.id_evaluador ? 'selected' : ''}>${evaluador.nombre}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                </c:forEach>
            </table>
            <br>
            <input type="submit" class="btn btn-outline-success rounded-pill fs-5" value="Actualizar"/>
            <a href="administrarIdeasProyecto.jsp" class="btn btn-outline-secondary rounded-pill fs-5 mx-3">Regresar</a>
            <input type="hidden" name="modifica" value="SI"/>
        </form>
    </c:if>
    <c:if test="${param.modifica != null}">
        <sql:update var="result" dataSource="${universidad}">
            UPDATE proyectos
            SET titulo='${param.titulo}',
                descripcion='${param.descripcion}',
                estado='${param.estado}',
                id_estudiante=${param.estudiante},
                id_director=${param.director},
                id_evaluador=${param.evaluador}
            WHERE id_proyecto = ${param.id}
        </sql:update>
        <div class="text-center my-5">
            <c:if test="${result == 1}">
                <p>¡Proyecto actualizado satisfactoriamente!</p>
                <a href="administrarIdeasProyecto.jsp" class="btn btn-outline-secondary rounded-pill fs-5">Regresar</a>
            </c:if>
        </div>
    </c:if>
</div>

<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
