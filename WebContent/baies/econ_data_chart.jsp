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

page_id = 2;

$(document).ready(function() {
	
	var cat_tree_src = econ_data_cat_tree_src_<fmt:message key="common.language" />;
	
	$('#cat_expander').jqxExpander({
		width: '250px', height: '400px', showArrow: false, toggleMode: 'none', theme: '<%=jqx_theme %>'
	});
	
	$('#cat_tree').jqxTree({
		source: cat_tree_src, width: '100%', height: '100%', theme: '<%=jqx_theme %>'
	});
	
	$('#location_expander').jqxExpander({
		width: '170px', showArrow: false, toggleMode: 'none', theme: '<%=jqx_theme %>'
	});
	
	$('#location_list').jqxDropDownList({
		source: ['<fmt:message key="common.country.brazil" />', '<fmt:message key="common.country.russia" />', '<fmt:message key="common.country.india" />', '<fmt:message key="common.country.china" />', '<fmt:message key="common.country.south_africa" />', '<fmt:message key="common.country.brics" />', '<fmt:message key="common.country.world" />'], checkboxes: true,
		width: '100%', theme: '<%=jqx_theme %>'
	});
	
	$("#location_list").jqxDropDownList('checkIndex', 0);
	$("#location_list").jqxDropDownList('checkIndex', 1);
	$("#location_list").jqxDropDownList('checkIndex', 2);
	$("#location_list").jqxDropDownList('checkIndex', 3);
	$("#location_list").jqxDropDownList('checkIndex', 4);
	
	$('#variable_expander').jqxExpander({
		width: '170px', showArrow: false, toggleMode: 'none', theme: '<%=jqx_theme %>'
	});
	
	$('#variable_list').jqxDropDownList({
		source: ['<fmt:message key="common.indicator.population" />', '<fmt:message key="common.indicator.male" />', '<fmt:message key="common.indicator.female" />', '<fmt:message key="common.indicator.uban_population" />', '<fmt:message key="common.indicator.rural_population" />'], checkboxes: true,
		width: '100%', theme: '<%=jqx_theme %>'
	});
	
	$("#variable_list").jqxDropDownList('checkIndex', 0);
	
	$('#time_slider').jqxSlider({
		width: '220px', values: [2005, 2010], min: 2000, max: 2016, mode: 'fixed',
		rangeSlider: true, theme: '<%=jqx_theme %>', ticksFrequency: 1
	});
	
	$('#time_slider').on('change', function(event) {
		$('#time1').html(event.args.value.rangeStart);
		$('#time2').html(event.args.value.rangeEnd);
	});
	
	$('#query_button').jqxButton({
		width: '100px', height: '47px', theme: '<%=jqx_theme %>'
	});
	
	$('#query_button').on('click', function() {
		window.location.href='econ_data_table.jsp';
	});
	
	$('#chart_button').jqxButton({
		width: '100px', height: '47px', template: 'primary', theme: '<%=jqx_theme %>'
	});
	
	$('#chart_button').on('click', function() {
		//window.location.href='econ_data_chart.jsp';
	});
	
	$('#export_button').jqxButton({
		width: '100px', height: '47px', theme: '<%=jqx_theme %>'
	});
	
	var data_source= [
		{<fmt:message key="common.dimension.time" />:2005, <fmt:message key="common.country.brazil" />:18848, <fmt:message key="common.country.russia" />:14362, <fmt:message key="common.country.india" />:114433, <fmt:message key="common.country.china" />:133562, '<fmt:message key="common.country.south_africa" />':4835 },
		{<fmt:message key="common.dimension.time" />:2006, <fmt:message key="common.country.brazil" />:19070, <fmt:message key="common.country.russia" />:14334, <fmt:message key="common.country.india" />:116209, <fmt:message key="common.country.china" />:134277, '<fmt:message key="common.country.south_africa" />':4903 },
		{<fmt:message key="common.dimension.time" />:2007, <fmt:message key="common.country.brazil" />:19278, <fmt:message key="common.country.russia" />:14318, <fmt:message key="common.country.india" />:117969, <fmt:message key="common.country.china" />:134994, '<fmt:message key="common.country.south_africa" />':4969 },
		{<fmt:message key="common.dimension.time" />:2008, <fmt:message key="common.country.brazil" />:19477, <fmt:message key="common.country.russia" />:14312, <fmt:message key="common.country.india" />:119707, <fmt:message key="common.country.china" />:135715, '<fmt:message key="common.country.south_africa" />':5035 },
		{<fmt:message key="common.dimension.time" />:2009, <fmt:message key="common.country.brazil" />:19670, <fmt:message key="common.country.russia" />:14313, <fmt:message key="common.country.india" />:121418, <fmt:message key="common.country.china" />:136441, '<fmt:message key="common.country.south_africa" />':5099 },
		{<fmt:message key="common.dimension.time" />:2010, <fmt:message key="common.country.brazil" />:19861, <fmt:message key="common.country.russia" />:14316, <fmt:message key="common.country.india" />:123098, <fmt:message key="common.country.china" />:137170, '<fmt:message key="common.country.south_africa" />':5162 }
	                   ];
	var settings = {
			title: '<fmt:message key="common.indicator.population" /> <fmt:message key="text.trend_chart" /> (2005 - 2010)',
			description: '',
			source: data_source,
			enableAnimations: true,
			xAxis: {
				dataField: '<fmt:message key="common.dimension.time" />',
				valuesOnTicks: false,
				minValue: 2005,
				maxValue: 2010,
				gridLines: {visible: false},
			},
			valueAxis: {
				visible: true,
				title: {text: '<fmt:message key="common.indicator.population" /> (<fmt:message key="common.unit.ten_thousand_people" />)'}
			},
			colorScheme: 'scheme04',
			seriesGroups: [
			               {
			            	   type: 'line',
			            	   toolTipFormatFunction: function(value, itemIndex, serie, group, categoryValue, categoryAxis) {
			            		   return value;
			            	   },
			            	   series: [
			            	            {dataField: '<fmt:message key="common.country.brazil" />', displayText: '<fmt:message key="common.country.brazil" />', symbolType: 'circle'},
			            	            {dataField: '<fmt:message key="common.country.russia" />', displayText: '<fmt:message key="common.country.russia" />', symbolType: 'square'},
			            	            {dataField: '<fmt:message key="common.country.india" />', displayText: '<fmt:message key="common.country.india" />', symbolType: 'diamond'},
			            	            {dataField: '<fmt:message key="common.country.china" />', displayText: '<fmt:message key="common.country.china" />', symbolType: 'triangle_up'},
			            	            {dataField: '<fmt:message key="common.country.south_africa" />', displayText: '<fmt:message key="common.country.south_africa" />', symbolType: 'triangle_down'}
			            	            ]
			               }
			               ]
	};
	$('#data_chart').jqxChart(settings);
	
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
		<div class="left" style="margin: 1px 15px 1px 15px;"></div>
		<div id="variable_expander" class="left">
			<div><fmt:message key="common.dimension.indicator" /></div>
			<div style="overflow: hidden;">
				<div id="variable_list" style="border: none;"></div>
			</div>
		</div>
		<div class="left" style="margin: 1px 15px 1px 15px;"></div>
		<div class="left">
			<div style="width: 100%;" class="center">
				<div id="time1" class="left">2005</div>
				<div id="time2" class="right">2010</div>
			</div>
			<div id="time_slider" class="center"></div>
		</div>
		<div class="clear"></div>
		<div class="margin_20"></div>
		<div class="left margin_h_150"></div>
		<div class="left">
			<input type="button" id="query_button" value="<fmt:message key="text.query" />" class="right">
		</div>
		<div class="left margin_10"></div>
		<div class="left">
			<input type="button" id="chart_button" value="<fmt:message key="text.chart" />" class="right">
		</div>
		<div class="left margin_10"></div>
		<div class="left">
			<input type="button" id="export_button" value="<fmt:message key="text.export" />" class="right">
		</div>
		<div class="clear"></div>
	</div>
	<div class="margin_15"></div>
	<div style="width: 650px;">
		<div id="data_chart" style="width: 650px; height: 270px;"></div>
	</div>
</div>

<div class="clear"></div>


<jsp:include page="../includes/html_body_footer.jsp" />

</body>
</html>
