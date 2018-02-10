<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="language" value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}" scope="session" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="org.brics_baies.bricsbaies.i18n.text" />

</div>
<!--main end-->

<!--footer start-->
<div id="footer">
	<p>Copyright &copy; 2016 &nbsp; <fmt:message key="common.copyright" /></p>
</div>
<!--footer end-->
</div>
<!--container end-->
</div>
<!--background end-->
