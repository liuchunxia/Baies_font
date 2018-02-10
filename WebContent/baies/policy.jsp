<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="language" value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}" scope="session" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="org.brics_baies.bricsbaies.i18n.text" />
<%
request.setCharacterEncoding("UTF-8");

String jqx_theme = (String)request.getSession().getAttribute("jqx_theme");
%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../includes/html_head.jsp" />
<title><fmt:message key="common.title" /></title>
<script>

page_id = 1;

$(document).ready(function() {
	
	$('#cat_tabs').jqxTabs({width: '998px', position: 'top', theme: '<%=jqx_theme %>'});
	
	var rows = $("#news_ul");
	var data = [];
	for (var i = 0; i < 100; i++) {
		var row = rows[0];
		var datarow = {};
		datarow['news'] = $(row).find('li').html();
		data[data.length] = datarow;
	}
	var source = {
			localdata: data,
			datatype: 'array',
			datafields: [{name: 'news', type: 'string'}],
	};
	var dataAdapter = new $.jqx.dataAdapter(source);
	var settings = {
			width: '90%',
			source: dataAdapter,
			autoheight: true,
			autorowheight: true,
			showheader: false,
			pageable: true,
			pagesize: 5,
			columns: [{text: 'news', dataField: 'news'}]
	};
	$('#news_grid_1').jqxGrid(settings);
	$('#news_grid_2').jqxGrid(settings);
	$('#news_grid_3').jqxGrid(settings);
	$('#news_grid_4').jqxGrid(settings);
	
});

</script>
<style>
.news_title a {
	font-size: large;
}
.jqx-grid {
	border-style: none !important;
}
.jqx-grid-cell {
	border-style: none !important;
}
.jqx-grid-content {
	border-style: none !important;
}
</style>
</head>
<body>

<jsp:include page="../includes/html_body_header.jsp" />


<div id="cat_tabs">
	<ul>
		<li style="margin-left: 10px;">
			<div style="height: 20px; margin-top: 5px;">
				<div style="margin-left: 4px; vertical-align: middle; text-align: center;">
					<fmt:message key="cat.dev" />
				</div>
			</div>
		</li>
		<li>
			<div style="height: 20px; margin-top: 5px;">
				<div style="margin-left: 4px; vertical-align: middle; text-align: center;">
					<fmt:message key="cat.trade" />
				</div>
			</div>
		</li>
		<li>
			<div style="height: 20px; margin-top: 5px;">
				<div style="margin-left: 4px; vertical-align: middle; text-align: center;">
					<fmt:message key="cat.tech" />
				</div>
			</div>
		</li>
		<li>
			<div style="height: 20px; margin-top: 5px;">
				<div style="margin-left: 4px; vertical-align: middle; text-align: center;">
					<fmt:message key="cat.fish" />
				</div>
			</div>
		</li>
	</ul>
	<div style="padding: 25px;">
		<h1><fmt:message key="cat.dev" /></h1>
		<br><br>
		<div id="news_grid_1"></div>
	</div>
	<div style="padding: 25px;">
		<h1><fmt:message key="cat.trade" /></h1>
		<br><br>
		<div id="news_grid_2"></div>
	</div>
	<div style="padding: 25px;">
		<h1><fmt:message key="cat.tech" /></h1>
		<br><br>
		<div id="news_grid_3"></div>
	</div>
	<div style="padding: 25px;">
		<h1><fmt:message key="cat.fish" /></h1>
		<br><br>
		<div id="news_grid_4"></div>
	</div>
</div>

<ul id="news_ul" style="display: none;">
	<li>
		<div class="margin_10">
			<div class="left"><img src="../images/policy.png"></div>
			<div class="left margin_10"></div>
			<div class="left">
				<div class="news_title"><a href="policy_detail.jsp"><fmt:message key="temp.policy_title" /></a></div>
				<p style="margin-top:5px;width: 600px;"><fmt:message key="temp.policy_abstract" /></p>
			</div>
			<div class="clear"></div>
		</div>
	</li>
</ul>


<jsp:include page="../includes/html_body_footer.jsp" />

</body>
</html>
