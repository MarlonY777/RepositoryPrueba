<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@include file="WEB-INF/jspf/conexion.jspf"%>

<%
    session.invalidate(); 
    response.sendRedirect("login.jsp"); 
%>
