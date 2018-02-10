<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="language" value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}" scope="session" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="org.brics_baies.bricsbaies.i18n.text" />
<%
request.setCharacterEncoding("UTF-8");

String theme = (String) request.getParameter("theme");
String url = (String) request.getParameter("url");
request.getSession().setAttribute("jqx_nav_theme", theme);
response.sendRedirect(url);
%>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
</body>
</html>
