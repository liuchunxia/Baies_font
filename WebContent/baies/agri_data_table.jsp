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

page_id = 3;

$(document).ready(function() {
	
	var cat_tree_src = agri_data_cat_tree_src_<fmt:message key="common.language" />;
	
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
	
	$('#product_expander').jqxExpander({
		width: '170px', showArrow: false, toggleMode: 'none', theme: '<%=jqx_theme %>'
	});
	
	$('#product_list').jqxDropDownList({
		source: ['<fmt:message key="common.product.rice" />', '<fmt:message key="common.product.wheat" />', '<fmt:message key="common.product.maize" />'], checkboxes: true,
		width: '100%', theme: '<%=jqx_theme %>'
	});
	
	$("#product_list").jqxDropDownList('checkIndex', 0);
	
	$('#variable_expander').jqxExpander({
		width: '170px', showArrow: false, toggleMode: 'none', theme: '<%=jqx_theme %>'
	});
	
	$('#variable_list').jqxDropDownList({
		source: ['<fmt:message key="common.indicator.harvest_area" />', '<fmt:message key="common.indicator.total_production" />', '<fmt:message key="common.indicator.yield" />'], checkboxes: true,
		width: '100%', theme: '<%=jqx_theme %>'
	});
	
	$("#variable_list").jqxDropDownList('checkIndex', 1);
	
	$('#time_slider').jqxSlider({
		width: '220px', values: [2005, 2010], min: 2000, max: 2016, mode: 'fixed',
		rangeSlider: true, theme: '<%=jqx_theme %>', ticksFrequency: 1
	});
	
	$('#time_slider').on('change', function(event) {
		$('#time1').html(event.args.value.rangeStart);
		$('#time2').html(event.args.value.rangeEnd);
	});
	
	$('#query_button').jqxButton({
		width: '100px', height: '47px', template: 'primary', theme: '<%=jqx_theme %>'
	});
	
	$('#query_button').on('click', function() {
		//window.location.href='agri_data_table.jsp';
	});
	
	$('#chart_button').jqxButton({
		width: '100px', height: '47px', theme: '<%=jqx_theme %>'
	});
	
	$('#chart_button').on('click', function() {
		window.location.href='agri_data_chart.jsp';
	});
	
	$('#export_button').jqxButton({
		width: '100px', height: '47px', theme: '<%=jqx_theme %>'
	});
	
	var local_data = [
	                   ['<fmt:message key="common.country.brazil" />', '<fmt:message key="common.product.rice" />', '<fmt:message key="common.indicator.total_production" /> (<fmt:message key="common.unit.ten_thousand_tons" />)', 392, 297, 289, 285, 287, 272],
	                   ['<fmt:message key="common.country.russia" />', '<fmt:message key="common.product.rice" />', '<fmt:message key="common.indicator.total_production" /> (<fmt:message key="common.unit.ten_thousand_tons" />)', 14, 16, 16, 16, 18, 20],
	                   ['<fmt:message key="common.country.india" />', '<fmt:message key="common.product.rice" />', '<fmt:message key="common.indicator.total_production" /> (<fmt:message key="common.unit.ten_thousand_tons" />)', 4366, 4381, 4391, 4554, 4192, 4286],
	                   ['<fmt:message key="common.country.china" />', '<fmt:message key="common.product.rice" />', '<fmt:message key="common.indicator.total_production" /> (<fmt:message key="common.unit.ten_thousand_tons" />)', 2912, 2956, 2918, 2949, 2988, 3012],
	                   ['<fmt:message key="common.country.south_africa" />', '<fmt:message key="common.product.rice" />', '<fmt:message key="common.indicator.total_production" /> (<fmt:message key="common.unit.ten_thousand_tons" />)', 0, 0, 0, 0, 0, 0]
	                   ];
	var data_fields = [
	                   {name: 'location', type: 'string', map: '0'},
	                   {name: 'product', type: 'string', map: '1'},
	                   {name: 'variable', type: 'string', map: '2'},
	                   {name: 'y2005', type: 'number', map: '3'},
	                   {name: 'y2006', type: 'number', map: '4'},
	                   {name: 'y2007', type: 'number', map: '5'},
	                   {name: 'y2008', type: 'number', map: '6'},
	                   {name: 'y2009', type: 'number', map: '7'},
	                   {name: 'y2010', type: 'number', map: '8'}
	                   ];
	var data_columns = [
	                   {text: '<fmt:message key="common.dimension.country" />', datafield: 'location', width: 70},
	                   {text: '<fmt:message key="common.dimension.product" />', datafield: 'product', width: 70},
	                   {text: '<fmt:message key="common.dimension.indicator" />', datafield: 'variable', width: 100},
	                   {text: '2005', datafield: 'y2005', width: 70, cellsalign: 'right'},
	                   {text: '2006', datafield: 'y2006', width: 70, cellsalign: 'right'},
	                   {text: '2007', datafield: 'y2007', width: 70, cellsalign: 'right'},
	                   {text: '2008', datafield: 'y2008', width: 70, cellsalign: 'right'},
	                   {text: '2009', datafield: 'y2009', width: 70, cellsalign: 'right'},
	                   {text: '2010', datafield: 'y2010', width: 70, cellsalign: 'right'}
	               ];
	var data_source = {
			localdata: local_data,
			datafields: data_fields,
			datatype: 'array'
	};
	var data_adapter = new $.jqx.dataAdapter(data_source);
	$('#data_grid').jqxGrid({
		width: '650px', height: '270px', source: data_adapter, columnsresize: true,
		columns: data_columns, theme: '<%=jqx_theme %>'
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
		<div class="left" style="margin: 1px 35px 1px 35px;"></div>
		<div id="product_expander" class="left">
			<div><fmt:message key="common.dimension.product" /></div>
			<div style="overflow: hidden;">
				<div id="product_list" style="border: none;"></div>
			</div>
		</div>
		<div class="left" style="margin: 1px 35px 1px 35px;"></div>
		<div id="variable_expander" class="left">
			<div><fmt:message key="common.dimension.indicator" /></div>
			<div style="overflow: hidden;">
				<div id="variable_list" style="border: none;"></div>
			</div>
		</div>
		<div class="clear"></div>
		<div class="margin_20"></div>
		<div class="left">
			<div style="width: 100%;" class="center">
				<div id="time1" class="left">2005</div>
				<div id="time2" class="right">2010</div>
			</div>
			<div id="time_slider" class="center"></div>
		</div>
		<div class="left margin_20"></div>
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
		<div id="data_grid"></div>
	</div>
</div>

<div class="clear"></div>


<jsp:include page="../includes/html_body_footer.jsp" />

</body>
</html>
