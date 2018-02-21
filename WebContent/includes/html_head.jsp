<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="language" value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}" scope="session" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="org.brics_baies.bricsbaies.i18n.text" />

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="x-ua-compatible" content="IE=9">

<link rel="stylesheet" href="../js/jqwidgets-4.1.2/styles/jqx.base.css" type="text/css" />

<link rel="stylesheet" href="../js/jqwidgets-4.1.2/styles/jqx.light.css" type="text/css" />
<link rel="stylesheet" href="../js/jqwidgets-4.1.2/styles/jqx.dark.css" type="text/css" />
<link rel="stylesheet" href="../js/jqwidgets-4.1.2/styles/jqx.arctic.css" type="text/css" />
<link rel="stylesheet" href="../js/jqwidgets-4.1.2/styles/jqx.web.css" type="text/css" />
<link rel="stylesheet" href="../js/jqwidgets-4.1.2/styles/jqx.bootstrap.css" type="text/css" />
<link rel="stylesheet" href="../js/jqwidgets-4.1.2/styles/jqx.metro.css" type="text/css" />
<link rel="stylesheet" href="../js/jqwidgets-4.1.2/styles/jqx.metrodark.css" type="text/css" />
<link rel="stylesheet" href="../js/jqwidgets-4.1.2/styles/jqx.office.css" type="text/css" />
<link rel="stylesheet" href="../js/jqwidgets-4.1.2/styles/jqx.orange.css" type="text/css" />
<link rel="stylesheet" href="../js/jqwidgets-4.1.2/styles/jqx.fresh.css" type="text/css" />
<link rel="stylesheet" href="../js/jqwidgets-4.1.2/styles/jqx.energyblue.css" type="text/css" />
<link rel="stylesheet" href="../js/jqwidgets-4.1.2/styles/jqx.darkblue.css" type="text/css" />
<link rel="stylesheet" href="../js/jqwidgets-4.1.2/styles/jqx.black.css" type="text/css" />
<link rel="stylesheet" href="../js/jqwidgets-4.1.2/styles/jqx.shinyblack.css" type="text/css" />
<link rel="stylesheet" href="../js/jqwidgets-4.1.2/styles/jqx.classic.css" type="text/css" />
<link rel="stylesheet" href="../js/jqwidgets-4.1.2/styles/jqx.summer.css" type="text/css" />
<link rel="stylesheet" href="../js/jqwidgets-4.1.2/styles/jqx.highcontrast.css" type="text/css" />
<link rel="stylesheet" href="../js/jqwidgets-4.1.2/styles/jqx.ui-lightness.css" type="text/css" />
<link rel="stylesheet" href="../js/jqwidgets-4.1.2/styles/jqx.ui-darkness.css" type="text/css" />
<link rel="stylesheet" href="../js/jqwidgets-4.1.2/styles/jqx.ui-smoothness.css" type="text/css" />
<link rel="stylesheet" href="../js/jqwidgets-4.1.2/styles/jqx.ui-start.css" type="text/css" />
<link rel="stylesheet" href="../js/jqwidgets-4.1.2/styles/jqx.ui-redmond.css" type="text/css" />
<link rel="stylesheet" href="../js/jqwidgets-4.1.2/styles/jqx.ui-sunny.css" type="text/css" />
<link rel="stylesheet" href="../js/jqwidgets-4.1.2/styles/jqx.ui-overcast.css" type="text/css" />
<link rel="stylesheet" href="../js/jqwidgets-4.1.2/styles/jqx.ui-le-frog.css" type="text/css" />

<link href="../css/css.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="../js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="../js/jqwidgets-4.1.2/jqxcore.js"></script>
<script type="text/javascript" src="../js/jqwidgets-4.1.2/jqx-all.js"></script>

<script type="text/javascript" src="../js/common.js"></script>
<script type="text/javascript" src="../js/public_tool.js"></script>