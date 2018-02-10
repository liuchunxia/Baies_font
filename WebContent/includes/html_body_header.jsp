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
String jqx_nav_theme = (String)request.getSession().getAttribute("jqx_nav_theme");
%>

<!--background start-->
<div id="background">
<!--container start-->
<div id="container">
<!--header start-->
<div id="header" style="background-image: url(../images/banner_<fmt:message key="common.language" />.png);">
	<div class="right margin_10">
		<a href="./index.jsp?language=zh">中文</a>
		&nbsp;
		<a href="./index.jsp?language=en">English</a>
		&nbsp;&nbsp;|&nbsp;&nbsp;
		<fmt:message key="common.role.system_admin" />,
		<a href="./"><fmt:message key="text.logout" /></a>
		&nbsp;&nbsp;|&nbsp;&nbsp;
		<a href="country_policy_management.jsp"><fmt:message key="common.sub_system.country_manage" /></a>
		&nbsp;
		<a href="admin_policy_approval.jsp"><fmt:message key="common.sub_system.system_manage" /></a>
	</div>
	<div class="clear"></div>
	<div class="right margin_10" style="visibility: hidden;">
		<div id="theme_dropdownlist" class="right"></div>
		<div class="right margin_5"></div>
		<div id="nav_theme_dropdownlist" class="right"></div>
		<div class="clear"></div>
<script type="text/javascript">
$(document).ready(function() {
	var themes = [
		{ label: 'Light', group: 'Themes', value: 'light' },
		{ label: 'Dark', group: 'Themes', value: 'dark' },
		{ label: 'Arctic', group: 'Themes', value: 'arctic' },
		{ label: 'Web', group: 'Themes', value: 'web' },
		{ label: 'Bootstrap', group: 'Themes', value: 'bootstrap' },
		{ label: 'Metro', group: 'Themes', value: 'metro' },
		{ label: 'Metro Dark', group: 'Themes', value: 'metrodark' },
		{ label: 'Office', group: 'Themes', value: 'office' },
		{ label: 'Orange', group: 'Themes', value: 'orange' },
		{ label: 'Fresh', group: 'Themes', value: 'fresh' },
		{ label: 'Energy Blue', group: 'Themes', value: 'energyblue' },
		{ label: 'Dark Blue', group: 'Themes', value: 'darkblue' },
		{ label: 'Black', group: 'Themes', value: 'black' },
		{ label: 'Shiny Black', group: 'Themes', value: 'shinyblack' },
		{ label: 'Classic', group: 'Themes', value: 'classic' },
		{ label: 'Summer', group: 'Themes', value: 'summer' },
		{ label: 'High Contrast', group: 'Themes', value: 'highcontrast' },
		{ label: 'Lightness', group: 'UI Compatible', value: 'ui-lightness' },
		{ label: 'Darkness', group: 'UI Compatible', value: 'ui-darkness' },
		{ label: 'Smoothness', group: 'UI Compatible', value: 'ui-smoothness' },
		{ label: 'Start', group: 'UI Compatible', value: 'ui-start' },
		{ label: 'Redmond', group: 'UI Compatible', value: 'ui-redmond' },
		{ label: 'Sunny', group: 'UI Compatible', value: 'ui-sunny' },
		{ label: 'Overcast', group: 'UI Compatible', value: 'ui-overcast' },
		{ label: 'Le Frog', group: 'UI Compatible', value: 'ui-le-frog' }
	];
	
	$('#theme_dropdownlist').jqxDropDownList({
		width: 150, theme: '<%=jqx_theme %>', source: themes
	});
	$('#theme_dropdownlist').jqxDropDownList('selectItem',
			$('#theme_dropdownlist').jqxDropDownList('getItemByValue', '<%=jqx_theme %>'));
	$('#theme_dropdownlist').on('change', function(event) {
		var args = event.args;
		if(!args) {
			return;
		}
		var value = args.item.value;
		window.location.href='change_theme.jsp?theme='+value+'&url='+window.location.href;
	});
	
	$('#nav_theme_dropdownlist').jqxDropDownList({
		width: 150, theme: '<%=jqx_theme %>', source: themes
	});
	$('#nav_theme_dropdownlist').jqxDropDownList('selectItem',
			$('#nav_theme_dropdownlist').jqxDropDownList('getItemByValue', '<%=jqx_nav_theme %>'));
	$('#nav_theme_dropdownlist').on('change', function(event) {
		var args = event.args;
		if(!args) {
			return;
		}
		var value = args.item.value;
		window.location.href='change_nav_theme.jsp?theme='+value+'&url='+window.location.href;
	});
	
});
</script>
	</div>
</div>
<!--header end-->

<!--nav1 start-->
<% if(request.getRequestURI().contains("/admin_")) { %>
	<jsp:include page="../includes/nav1_admin.jsp" />
<% } else if(request.getRequestURI().contains("/country_")) { %>
	<jsp:include page="../includes/nav1_country.jsp" />
<% } else { %>
	<jsp:include page="../includes/nav1.jsp" />
<% } %>
<!--nav1 end-->

<!--nav2 start-->
<jsp:include page="../includes/nav2.jsp" />
<!--nav2 end-->

<!--main start-->
<div id="main">
