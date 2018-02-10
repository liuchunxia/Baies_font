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
	
	var cat_tree_src = econ_data_cat_tree_src_<fmt:message key="common.language" />;
	
	$('#cat_expander').jqxExpander({
		width: '250px', height: '400px', showArrow: false, toggleMode: 'none', theme: '<%=jqx_theme %>'
	});
	
	$('#cat_tree').jqxTree({
		source: cat_tree_src, width: '100%', height: '100%', theme: '<%=jqx_theme %>'
	});
	
	$('#location_expander').jqxExpander({
		width: '280px', height: '180px', showArrow: false, toggleMode: 'none', theme: '<%=jqx_theme %>'
	});
	
	$('#location_list').jqxListBox({
		source: ['<fmt:message key="common.country.brazil" />', '<fmt:message key="common.country.russia" />', '<fmt:message key="common.country.india" />', '<fmt:message key="common.country.china" />', '<fmt:message key="common.country.south_africa" />', '<fmt:message key="common.country.brics" />', '<fmt:message key="common.country.world" />'], checkboxes: true,
		multiple: true, width: '100%', height: '100%', theme: '<%=jqx_theme %>'
	});
	
	$('#variable_expander').jqxExpander({
		width: '280px', height: '180px', showArrow: false, toggleMode: 'none', theme: '<%=jqx_theme %>'
	});
	
	$('#variable_list').jqxListBox({
		source: ['<fmt:message key="common.indicator.population" />', '<fmt:message key="common.indicator.male" />', '<fmt:message key="common.indicator.female" />', '<fmt:message key="common.indicator.uban_population" />', '<fmt:message key="common.indicator.rural_population" />'], checkboxes: true,
		multiple: true, width: '100%', height: '100%', theme: '<%=jqx_theme %>'
	});
	
	$('#time_expander').jqxExpander({
		width: '280px', height: '100px', showArrow: false, toggleMode: 'none', theme: '<%=jqx_theme %>'
	});
	
	$('#time_slider').jqxSlider({
		width: '95%', values: [2005, 2010], min: 2000, max: 2016, mode: 'fixed',
		rangeSlider: true, theme: '<%=jqx_theme %>', ticksFrequency: 1
	});
	
	$('#time_slider').on('change', function(event) {
		$('#time1').html(event.args.value.rangeStart);
		$('#time2').html(event.args.value.rangeEnd);
	});
	
	$('#query_button').jqxButton({
		width: '150px', height: '40px', template: 'primary', theme: '<%=jqx_theme %>'
	});
	
	$('#query_button').on('click', function() {
		window.location.href='country_econ_data_management_table.jsp';
	});
	
});

</script>
</head>
<body>

<jsp:include page="../includes/html_body_header.jsp" />

<div id="cat_expander" class="left margin_15">
	<div><fmt:message key="text.category" /></div>
	<div style="overflow: hidden;">
		<div id="cat_tree" style="border: none;"></div>
	</div>
</div>

<div class="left margin_15" style="width: 650px;">
	<div style="width: 650px;">
		<div id="location_expander" class="left">
			<div><fmt:message key="common.dimension.country" /></div>
			<div style="overflow: hidden;">
				<div id="location_list" style="border: none;"></div>
			</div>
		</div>
		<div class="left margin_20"></div>
		<div id="variable_expander" class="left">
			<div><fmt:message key="common.dimension.indicator" /></div>
			<div style="overflow: hidden;">
				<div id="variable_list" style="border: none;"></div>
			</div>
		</div>
		<div class="clear"></div>
	</div>
	<div class="margin_30"></div>
	<div style="width: 650px;">
		<div class="left">
			<div id="time_expander">
				<div><fmt:message key="common.dimension.time" /></div>
				<div style="overflow: hidden;">
					<div style="width: 90%;" class="center margin_10">
						<div id="time1" class="left">2005</div>
						<div id="time2" class="right">2010</div>
					</div>
					<div id="time_slider" class="center"></div>
				</div>
			</div>
		</div>
		<div class="left margin_20"></div>
		<div class="left" style="width: 280px;">
			<div class="margin_30"></div>
			<input type="button" id="query_button" value="<fmt:message key="text.query" />" style="margin-left: 65px;">
		</div>
		<div class="clear"></div>
	</div>
</div>

<div class="clear"></div>


<jsp:include page="../includes/html_body_footer.jsp" />

</body>
</html>
