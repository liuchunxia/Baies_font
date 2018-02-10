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
<style>
.grid_edited_cell {
	background-color: #FF9;
}
</style>
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
	$("#location_list").jqxDropDownList('checkIndex', 5);
	$("#location_list").jqxDropDownList('checkIndex', 6);
	
	$('#variable_expander').jqxExpander({
		width: '170px', showArrow: false, toggleMode: 'none', theme: '<%=jqx_theme %>'
	});
	
	$('#variable_list').jqxDropDownList({
		source: ['<fmt:message key="common.indicator.population" />', '<fmt:message key="common.indicator.male" />', '<fmt:message key="common.indicator.female" />', '<fmt:message key="common.indicator.uban_population" />', '<fmt:message key="common.indicator.rural_population" />'], checkboxes: true,
		width: '100%', theme: '<%=jqx_theme %>'
	});
	
	$("#variable_list").jqxDropDownList('checkIndex', 0);
	$("#variable_list").jqxDropDownList('checkIndex', 1);
	$("#variable_list").jqxDropDownList('checkIndex', 2);
	$("#variable_list").jqxDropDownList('checkIndex', 3);
	$("#variable_list").jqxDropDownList('checkIndex', 4);
	
	$('#time_slider').jqxSlider({
		width: '220px', values: [2005, 2010], min: 2000, max: 2016, mode: 'fixed',
		rangeSlider: true, theme: '<%=jqx_theme %>', ticksFrequency: 1
	});
	
	$('#time_slider').on('change', function(event) {
		$('#time1').html(event.args.value.rangeStart);
		$('#time2').html(event.args.value.rangeEnd);
	});
	
	$('#query_button').jqxButton({
		width: '75px', height: '35px', theme: '<%=jqx_theme %>'
	});
	
	$('#query_button').on('click', function() {
		//window.location.href='econ_data_table.jsp';
	});
	
	$('#save_button').jqxButton({
		width: '75px', height: '35px', theme: '<%=jqx_theme %>', disabled: true
	});
	
	$('#save_button').on('click', function() {
		$('#dialog_window_content').html('请输入版本说明: <input type="text">');
		$('#dialog_window').one('close', function(event) {
			if(event.args.dialogResult.OK) {
				grid_edited_cells.length = 0;
				$('#data_grid').jqxGrid('render');
				$('#save_button').jqxButton({ disabled: true });
				$('#message_notification_content').html('修订版本已保存。');
				$('#message_notification').jqxNotification('open');
			}
		});
		$('#dialog_window').jqxWindow('open');
	});
	
	$('#import_button').jqxButton({
		width: '75px', height: '35px', theme: '<%=jqx_theme %>'
	});
	
	$('#import_button').on('click', function() {
		$('#dialog_window_content').html('<table><tr><td>请选择文件:</td><td><input type="file"></td></tr>'
				+ '<tr><td>请输入版本说明:</td><td><input type="text"></td></tr></table>');
		$('#dialog_window').one('close', function(event) {
			if(event.args.dialogResult.OK) {
				$('#message_notification_content').html('文件已导入。');
				$('#message_notification').jqxNotification('open');
			}
		});
		$('#dialog_window').jqxWindow('open');
	});
	
	$('#export_button').jqxButton({
		width: '75px', height: '35px', theme: '<%=jqx_theme %>'
	});
	
	var local_data = [
		['<fmt:message key="common.country.brazil" />', '<fmt:message key="common.indicator.population" /> (<fmt:message key="common.unit.ten_thousand_people" />)', 18848 , 19070 , 19278 , 19477 , 19670 , 19861 ],
		['<fmt:message key="common.country.russia" />', '<fmt:message key="common.indicator.population" /> (<fmt:message key="common.unit.ten_thousand_people" />)', 14362 , 14334 , 14318 , 14312 , 14313 , 14316 ],
		['<fmt:message key="common.country.india" />', '<fmt:message key="common.indicator.population" /> (<fmt:message key="common.unit.ten_thousand_people" />)', 114433 , 116209 , 117969 , 119707 , 121418 , 123098 ],
		['<fmt:message key="common.country.china" />', '<fmt:message key="common.indicator.population" /> (<fmt:message key="common.unit.ten_thousand_people" />)', 133562 , 134277 , 134994 , 135715 , 136441 , 137170 ],
		['<fmt:message key="common.country.south_africa" />', '<fmt:message key="common.indicator.population" /> (<fmt:message key="common.unit.ten_thousand_people" />)', 4835 , 4903 , 4969 , 5035 , 5099 , 5162 ],
		['<fmt:message key="common.country.brics" />', '<fmt:message key="common.indicator.population" /> (<fmt:message key="common.unit.ten_thousand_people" />)', 286040 , 288792 , 291528 , 294246 , 296941 , 299608 ],
		['<fmt:message key="common.country.world" />', '<fmt:message key="common.indicator.population" /> (<fmt:message key="common.unit.ten_thousand_people" />)', 651964 , 660022 , 668161 , 676373 , 684648 , 692973 ],
		['<fmt:message key="common.country.brazil" />', '<fmt:message key="common.indicator.male" /> (<fmt:message key="common.unit.ten_thousand_people" />)', 9300 , 9406 , 9506 , 9601 , 9692 , 9783 ],
		['<fmt:message key="common.country.russia" />', '<fmt:message key="common.indicator.male" /> (<fmt:message key="common.unit.ten_thousand_people" />)', 6684 , 6664 , 6650 , 6643 , 6639 , 6639 ],
		['<fmt:message key="common.country.india" />', '<fmt:message key="common.indicator.male" /> (<fmt:message key="common.unit.ten_thousand_people" />)', 59310 , 60239 , 61160 , 62069 , 62962 , 63835 ],
		['<fmt:message key="common.country.china" />', '<fmt:message key="common.indicator.male" /> (<fmt:message key="common.unit.ten_thousand_people" />)', 68644 , 69022 , 69400 , 69779 , 70161 , 70546 ],
		['<fmt:message key="common.country.south_africa" />', '<fmt:message key="common.indicator.male" /> (<fmt:message key="common.unit.ten_thousand_people" />)', 2374 , 2407 , 2438 , 2470 , 2501 , 2532 ],
		['<fmt:message key="common.country.brics" />', '<fmt:message key="common.indicator.male" /> (<fmt:message key="common.unit.ten_thousand_people" />)', 146313 , 147738 , 149155 , 150561 , 151955 , 153336 ],
		['<fmt:message key="common.country.world" />', '<fmt:message key="common.indicator.male" /> (<fmt:message key="common.unit.ten_thousand_people" />)', 328508 , 332618 , 336766 , 340947 , 345159 , 349396 ],
		['<fmt:message key="common.country.brazil" />', '<fmt:message key="common.indicator.female" /> (<fmt:message key="common.unit.ten_thousand_people" />)', 9548 , 9663 , 9772 , 9876 , 9978 , 10078 ],
		['<fmt:message key="common.country.russia" />', '<fmt:message key="common.indicator.female" /> (<fmt:message key="common.unit.ten_thousand_people" />)', 7679 , 7670 , 7668 , 7670 , 7673 , 7677 ],
		['<fmt:message key="common.country.india" />', '<fmt:message key="common.indicator.female" /> (<fmt:message key="common.unit.ten_thousand_people" />)', 55122 , 55969 , 56808 , 57638 , 58456 , 59263 ],
		['<fmt:message key="common.country.china" />', '<fmt:message key="common.indicator.female" /> (<fmt:message key="common.unit.ten_thousand_people" />)', 64917 , 65254 , 65594 , 65936 , 66280 , 66624 ],
		['<fmt:message key="common.country.south_africa" />', '<fmt:message key="common.indicator.female" /> (<fmt:message key="common.unit.ten_thousand_people" />)', 2461 , 2496 , 2531 , 2565 , 2598 , 2630 ],
		['<fmt:message key="common.country.brics" />', '<fmt:message key="common.indicator.female" /> (<fmt:message key="common.unit.ten_thousand_people" />)', 139727 , 141054 , 142374 , 143685 , 144985 , 146272 ],
		['<fmt:message key="common.country.world" />', '<fmt:message key="common.indicator.female" /> (<fmt:message key="common.unit.ten_thousand_people" />)', 323455 , 327404 , 331395 , 335426 , 339489 , 343577 ],
		['<fmt:message key="common.country.brazil" />', '<fmt:message key="common.indicator.uban_population" /> (<fmt:message key="common.unit.ten_thousand_people" />)', 15419 , 15642 , 15855 , 16060 , 16262 , 16463 ],
		['<fmt:message key="common.country.russia" />', '<fmt:message key="common.indicator.uban_population" /> (<fmt:message key="common.unit.ten_thousand_people" />)', 10574 , 10564 , 10566 , 10574 , 10582 , 10583 ],
		['<fmt:message key="common.country.india" />', '<fmt:message key="common.indicator.uban_population" /> (<fmt:message key="common.unit.ten_thousand_people" />)', 32952 , 33806 , 34664 , 35529 , 36402 , 37290 ],
		['<fmt:message key="common.country.china" />', '<fmt:message key="common.indicator.uban_population" /> (<fmt:message key="common.unit.ten_thousand_people" />)', 58431 , 60577 , 62734 , 64934 , 67163 , 69426 ],
		['<fmt:message key="common.country.south_africa" />', '<fmt:message key="common.indicator.uban_population" /> (<fmt:message key="common.unit.ten_thousand_people" />)', 2872 , 2939 , 3007 , 3074 , 3139 , 3201 ],
		['<fmt:message key="common.country.brics" />', '<fmt:message key="common.indicator.uban_population" /> (<fmt:message key="common.unit.ten_thousand_people" />)', 120247 , 123528 , 126826 , 130171 , 133549 , 136963 ],
		['<fmt:message key="common.country.world" />', '<fmt:message key="common.indicator.uban_population" /> (<fmt:message key="common.unit.ten_thousand_people" />)', 319901 , 327140 , 334475 , 341942 , 349494 , 357127 ],
		['<fmt:message key="common.country.brazil" />', '<fmt:message key="common.indicator.rural_population" /> (<fmt:message key="common.unit.ten_thousand_people" />)', 3195 , 3171 , 3145 , 3117 , 3087 , 3058 ],
		['<fmt:message key="common.country.russia" />', '<fmt:message key="common.indicator.rural_population" /> (<fmt:message key="common.unit.ten_thousand_people" />)', 3820 , 3807 , 3799 , 3793 , 3787 , 3779 ],
		['<fmt:message key="common.country.india" />', '<fmt:message key="common.indicator.rural_population" /> (<fmt:message key="common.unit.ten_thousand_people" />)', 79763 , 80523 , 81245 , 81938 , 82611 , 83272 ],
		['<fmt:message key="common.country.china" />', '<fmt:message key="common.indicator.rural_population" /> (<fmt:message key="common.unit.ten_thousand_people" />)', 76396 , 75061 , 73737 , 72388 , 71022 , 69629 ],
		['<fmt:message key="common.country.south_africa" />', '<fmt:message key="common.indicator.rural_population" /> (<fmt:message key="common.unit.ten_thousand_people" />)', 1952 , 1953 , 1954 , 1953 , 1950 , 1944 ],
		['<fmt:message key="common.country.brics" />', '<fmt:message key="common.indicator.rural_population" /> (<fmt:message key="common.unit.ten_thousand_people" />)', 165125 , 164515 , 163879 , 163188 , 162458 , 161683 ],
		['<fmt:message key="common.country.world" />', '<fmt:message key="common.indicator.rural_population" /> (<fmt:message key="common.unit.ten_thousand_people" />)', 331508 , 332183 , 332835 , 333423 , 333978 , 334491 ],
	                   ];
	var data_fields = [
	                   {name: 'location', type: 'string', map: '0'},
	                   {name: 'variable', type: 'string', map: '1'},
	                   {name: 'y2005', type: 'number', map: '2'},
	                   {name: 'y2006', type: 'number', map: '3'},
	                   {name: 'y2007', type: 'number', map: '4'},
	                   {name: 'y2008', type: 'number', map: '5'},
	                   {name: 'y2009', type: 'number', map: '6'},
	                   {name: 'y2010', type: 'number', map: '7'}
	                   ];
	var grid_edited_cells = new Array();
	var grid_cell_class = function (row, datafield, value, rowdata) {
		for (var i = 0; i < grid_edited_cells.length; i++) {
			if(grid_edited_cells[i].row == row && grid_edited_cells[i].datafield == datafield) {
				return 'grid_edited_cell';
			}
		}
	};
	var data_columns = [
	                   {text: '<fmt:message key="common.dimension.country" />', datafield: 'location', width: 70, editable: false},
	                   {text: '<fmt:message key="common.dimension.indicator" />', datafield: 'variable', width: 100, editable: false},
	                   {text: '2005', datafield: 'y2005', width: 70, cellsalign: 'right', cellclassname: grid_cell_class},
	                   {text: '2006', datafield: 'y2006', width: 70, cellsalign: 'right', cellclassname: grid_cell_class},
	                   {text: '2007', datafield: 'y2007', width: 70, cellsalign: 'right', cellclassname: grid_cell_class},
	                   {text: '2008', datafield: 'y2008', width: 70, cellsalign: 'right', cellclassname: grid_cell_class},
	                   {text: '2009', datafield: 'y2009', width: 70, cellsalign: 'right', cellclassname: grid_cell_class},
	                   {text: '2010', datafield: 'y2010', width: 70, cellsalign: 'right', cellclassname: grid_cell_class}
	               ];
	var data_source = {
			localdata: local_data,
			datafields: data_fields,
			datatype: 'array'
	};
	var data_adapter = new $.jqx.dataAdapter(data_source);
	$('#data_grid').jqxGrid({
		width: '650px', height: '270px', source: data_adapter, columnsresize: true,
		columns: data_columns, theme: '<%=jqx_theme %>', selectionmode: 'singlecell',
		editable: true
	});
	
	$('#data_grid').on('cellendedit', function(event) {
		var args = event.args;
		var rowindex = args.rowindex;
		var datafield = args.datafield;
		var value = args.value;
		var oldvalue = args.oldvalue;
		if(value == oldvalue) {
			return;
		}
		$('#save_button').jqxButton({ disabled: false });
		grid_edited_cells.push({row: rowindex, datafield: datafield});
	});
	
	$('#dialog_window').jqxWindow({
		width: 400, height: 'auto', resizable: false,  isModal: true, autoOpen: false,
		okButton: $("#dialog_window_ok_button"), cancelButton: $("#dialog_window_cancel_button"),
		modalOpacity: 0.3, theme: '<%=jqx_theme %>'
	});
	$("#dialog_window_ok_button").jqxButton({
		theme: '<%=jqx_theme %>'
	});
	$("#dialog_window_cancel_button").jqxButton({
		theme: '<%=jqx_theme %>'
	});
	
	$('#message_notification').jqxNotification({
		width: 'auto', position: "bottom-right", opacity: 0.9, template: 'success', theme: '<%=jqx_theme %>'
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
			<input type="button" id="save_button" value="保存" class="right">
		</div>
		<div class="left margin_10"></div>
		<div class="left">
			<input type="button" id="import_button" value="导入" class="right">
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

<div id="dialog_window">
	<div>请选择</div>
	<div style="overflow: hidden;">
		<div id="dialog_window_content" style="margin: 20px; height: 50px;">&nbsp;</div>
		<div class="right margin_10">
			<input type="button" id="dialog_window_ok_button" value="确定">
			<input type="button" id="dialog_window_cancel_button" value="取消">
		</div>
		<div class="clear"></div>
	</div>
</div>

<div id="message_notification">
	<div id="message_notification_content"></div>
</div>


<jsp:include page="../includes/html_body_footer.jsp" />

</body>
</html>
