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

page_id = 0;

$(document).ready(function() {
	
	$('#nav2_tabs').jqxTabs({width: '998px', position: 'top', theme: '<%=jqx_theme %>'});
	$('#nav2_tabs').jqxTabs({ selectedItem: 2 });
	$('#nav2_tabs').on('selected', function (event) {
		var idx = event.args.item;
		window.location.href=nav2_items_approval[idx];
	});
	
	var rows = $("#data_ul");
	var data = [];
	for (var i = 0; i < 100; i++) {
		var row = rows[0];
		var datarow = {};
		datarow['version_id'] = 162 - i;
		var objs = agri_data_cat_tree_src_<fmt:message key="common.language" />[0].items[0].items;
		datarow['category'] = objs[Math.floor(Math.random()*objs.length)].label;
		datarow['country'] = $(row).find('li:nth-child(3)').html();
		datarow['author'] = $(row).find('li:nth-child(4)').html();
		datarow['time'] = $(row).find('li:nth-child(5)').html();
		datarow['description'] = $(row).find('li:nth-child(6)').find('span:nth-child('+(Math.floor(Math.random()*2)+1)+')').html();
		datarow['operation'] = $(row).find('li:nth-child(7)').html();
		data[data.length] = datarow;
	}
	var source = {
			localdata: data,
			datatype: 'array',
			datafields: [{name: 'version_id', type: 'number'},
			             {name: 'category', type: 'string'},
			             {name: 'country', type: 'string'},
			             {name: 'author', type: 'string'},
			             {name: 'time', type: 'string'},
			             {name: 'description', type: 'string'},
			             {name: 'operation', type: 'string'}],
	};
	var dataAdapter = new $.jqx.dataAdapter(source);
	var settings = {
			width: '850px',
			source: dataAdapter,
			autoheight: true,
			autorowheight: true,
			showheader: true,
			pageable: true,
			pagesize: 10,
			theme: '<%=jqx_theme %>',
			columns: [{text: '<fmt:message key="text.edition" />', dataField: 'version_id', width: 65, align: 'center', cellsalign: 'center'},
			          {text: '<fmt:message key="text.category" />', dataField: 'category', width: 160, align: 'center', cellsalign: 'center'},
			          {text: '<fmt:message key="common.dimension.country" />', dataField: 'country', width: 80, align: 'center', cellsalign: 'center'},
			          {text: '<fmt:message key="text.author" />', dataField: 'author', width: 80, align: 'center', cellsalign: 'center'},
			          {text: '<fmt:message key="common.dimension.time" />', dataField: 'time', width: 100, align: 'center', cellsalign: 'center'},
			          {text: '版本说明', dataField: 'description', width: 285, align: 'center'},
			          {text: '操作', dataField: 'operation', width: 80, align: 'center', cellsalign: 'center'}
			          ]
	};
	$('#data_grid').jqxGrid(settings);
	
	$('#dialog_window').jqxWindow({
		width: 350, height: 'auto', resizable: false,  isModal: true, autoOpen: false,
		okButton: $("#dialog_window_ok_button"), cancelButton: $("#dialog_window_cancel_button"),
		modalOpacity: 0.3, theme: '<%=jqx_theme %>'
	});
	$("#dialog_window_ok_button").jqxButton({
		theme: '<%=jqx_theme %>'
	});
	$("#dialog_window_cancel_button").jqxButton({
		theme: '<%=jqx_theme %>'
	});
	
	$('.detail_buttons').on('click', function() {
		$('#diff_category').html('<fmt:message key="temp.agri_data_approval.category" />');
		$('#diff_window').jqxWindow('open');
	});
	
	$('.approve_buttons').on('click', function() {
		$('#dialog_window_content').html('是否通过本信息？');
		$('#dialog_window').one('close', function(event) {
			if(event.args.dialogResult.OK) {
				$('#message_notification_content').html('信息已通过。');
				$('#message_notification').jqxNotification('open');
			}
		});
		$('#dialog_window').jqxWindow('open');
	});
	
	$('.reject_buttons').on('click', function() {
		$('#dialog_window_content').html('是否拒绝本信息？');
		$('#dialog_window').one('close', function(event) {
			if(event.args.dialogResult.OK) {
				$('#message_notification_content').html('信息已拒绝。');
				$('#message_notification').jqxNotification('open');
			}
		});
		$('#dialog_window').jqxWindow('open');
	});
	
	$('#diff_window').jqxWindow({
		width: 700, height: 550, resizable: false,  isModal: true, autoOpen: false,
		okButton: $("#diff_window_ok_button"), cancelButton: $("#diff_window_cancel_button"),
		modalOpacity: 0.3, theme: '<%=jqx_theme %>'
	});
	
	$("#diff_window_ok_button").jqxButton({
		theme: '<%=jqx_theme %>'
	});
	
	$("#diff_window_ok_button").on('click', function(event) {
		$('#message_notification_content').html('信息已通过。');
		$('#message_notification').jqxNotification('open');
	});
	
	$("#diff_window_cancel_button").jqxButton({
		theme: '<%=jqx_theme %>'
	});
	
	$("#diff_window_cancel_button").on('click', function(event) {
		$('#message_notification_content').html('信息已拒绝。');
		$('#message_notification').jqxNotification('open');
	});

	$('#message_notification').jqxNotification({
		width: 'auto', position: "bottom-right", opacity: 0.9, template: 'success', theme: '<%=jqx_theme %>'
	});
	
	$('#diff_content_splitter').jqxSplitter({
		width: 660, height: 400, theme: '<%=jqx_theme %>',
		panels: [
		         {size: 330, min: 100, collapsible: true, collapsed: false},
		         {size: 330, min: 100, collapsible: true, collapsed: false}
		         ]
	});

	var init_diff_grid_widgets = function () {
		
		var local_data_1 = [
		                   ['<fmt:message key="common.country.brazil" />', '<fmt:message key="common.product.rice" />', '<fmt:message key="common.indicator.total_production" /> (<fmt:message key="common.unit.ten_thousand_tons" />)', 392, 297, 289, 285, 287, 272],
		                   ['<fmt:message key="common.country.russia" />', '<fmt:message key="common.product.rice" />', '<fmt:message key="common.indicator.total_production" /> (<fmt:message key="common.unit.ten_thousand_tons" />)', 14, 16, 16, 16, 18, 20],
		                   ['<fmt:message key="common.country.india" />', '<fmt:message key="common.product.rice" />', '<fmt:message key="common.indicator.total_production" /> (<fmt:message key="common.unit.ten_thousand_tons" />)', 4366, 4381, 4391, 4554, 4192, 4286],
		                   ['<fmt:message key="common.country.china" />', '<fmt:message key="common.product.rice" />', '<fmt:message key="common.indicator.total_production" /> (<fmt:message key="common.unit.ten_thousand_tons" />)', 2912, 2956, 2918, 2949, 2988, 3012],
		                   ['<fmt:message key="common.country.south_africa" />', '<fmt:message key="common.product.rice" />', '<fmt:message key="common.indicator.total_production" /> (<fmt:message key="common.unit.ten_thousand_tons" />)', 0, 0, 0, 0, 0, 0]
		                   ];
		var local_data_2 = [
			               ['<fmt:message key="common.country.brazil" />', '<fmt:message key="common.product.rice" />', '<fmt:message key="common.indicator.total_production" /> (<fmt:message key="common.unit.ten_thousand_tons" />)', 392, 298, 289, 285, 287, 272],
			               ['<fmt:message key="common.country.russia" />', '<fmt:message key="common.product.rice" />', '<fmt:message key="common.indicator.total_production" /> (<fmt:message key="common.unit.ten_thousand_tons" />)', 15, 16, 16, 16, 18, 20],
			               ['<fmt:message key="common.country.india" />', '<fmt:message key="common.product.rice" />', '<fmt:message key="common.indicator.total_production" /> (<fmt:message key="common.unit.ten_thousand_tons" />)', 4366, 4381, 4391, 4554, 4192, 4286],
			               ['<fmt:message key="common.country.china" />', '<fmt:message key="common.product.rice" />', '<fmt:message key="common.indicator.total_production" /> (<fmt:message key="common.unit.ten_thousand_tons" />)', 2912, 2956, 2918, 2949, 2988, 3012],
			               ['<fmt:message key="common.country.south_africa" />', '<fmt:message key="common.product.rice" />', '<fmt:message key="common.indicator.total_production" /> (<fmt:message key="common.unit.ten_thousand_tons" />)', 0, 0, 100, 0, 0, 0]
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
		var grid_edited_cells = [
		                         {row: 0, datafield: 'y2006'},
		                         {row: 1, datafield: 'y2005'},
		                         {row: 4, datafield: 'y2007'},
		                         ];
		var grid_cell_class = function (row, datafield, value, rowdata) {
			for (var i = 0; i < grid_edited_cells.length; i++) {
				if(grid_edited_cells[i].row == row && grid_edited_cells[i].datafield == datafield) {
					return 'grid_edited_cell';
				}
			}
		};
		var data_columns = [
		                   {text: '<fmt:message key="common.dimension.country" />', datafield: 'location', width: 50},
		                   {text: '<fmt:message key="common.dimension.product" />', datafield: 'product', width: 40},
		                   {text: '<fmt:message key="common.dimension.indicator" />', datafield: 'variable', width: 70},
		                   {text: '2005', datafield: 'y2005', width: 40, cellsalign: 'right', cellclassname: grid_cell_class},
		                   {text: '2006', datafield: 'y2006', width: 40, cellsalign: 'right', cellclassname: grid_cell_class},
		                   {text: '2007', datafield: 'y2007', width: 40, cellsalign: 'right', cellclassname: grid_cell_class},
		                   {text: '2008', datafield: 'y2008', width: 40, cellsalign: 'right', cellclassname: grid_cell_class},
		                   {text: '2009', datafield: 'y2009', width: 40, cellsalign: 'right', cellclassname: grid_cell_class},
		                   {text: '2010', datafield: 'y2010', width: 40, cellsalign: 'right', cellclassname: grid_cell_class}
		               ];
		var data_source_1 = {
				localdata: local_data_1,
				datafields: data_fields,
				datatype: 'array'
		};
		var data_source_2 = {
				localdata: local_data_2,
				datafields: data_fields,
				datatype: 'array'
		};
		var data_adapter_1 = new $.jqx.dataAdapter(data_source_1);
		var data_adapter_2 = new $.jqx.dataAdapter(data_source_2);
		$('#diff_grid_1').jqxGrid({
			width: '330px', height: '400px', source: data_adapter_1, columnsresize: true, columns: data_columns, theme: '<%=jqx_theme %>'
		});
		$('#diff_grid_2').jqxGrid({
			width: '330px', height: '400px', source: data_adapter_2, columnsresize: true, columns: data_columns, theme: '<%=jqx_theme %>'
		});
		
	};
	init_diff_grid_widgets();
	
});

</script>
</head>
<body>

<jsp:include page="../includes/html_body_header.jsp" />


<div id="nav2_tabs" style="border: none;">
	<ul>
		<li style="margin-left: 30px;">
			<div style="height: 20px; margin-top: 5px;">
				<div style="margin-left: 4px; vertical-align: middle; text-align: center;">
					<fmt:message key="nav.system_admin.approval.policy" />
				</div>
			</div>
		</li>
		<li>
			<div style="height: 20px; margin-top: 5px;">
				<div style="margin-left: 4px; vertical-align: middle; text-align: center;">
					<fmt:message key="nav.system_admin.approval.econ" />
				</div>
			</div>
		</li>
		<li>
			<div style="height: 20px; margin-top: 5px;">
				<div style="margin-left: 4px; vertical-align: middle; text-align: center;">
					<fmt:message key="nav.system_admin.approval.agri" />
				</div>
			</div>
		</li>
	</ul>
	<div></div>
	<div></div>
	<div></div>
</div>

<div style="padding: 25px;">
	<h1><fmt:message key="nav.system_admin.approval.agri" /></h1>
	<br><br>
	<div id="data_grid"></div>
</div>

<ul id="data_ul" style="display: none;">
	<li>（<fmt:message key="text.edition" />）</li>
	<li>（<fmt:message key="text.category" />）</li>
	<li><fmt:message key="common.country.china" /></li>
	<li><fmt:message key="temp.policy_author" /></li>
	<li>2016-07-04 10:39</li>
	<li><span><fmt:message key="temp.agri_data_approval.desc_1" /></span><span><fmt:message key="temp.agri_data_approval.desc_2" /></span></li>
	<li>
		<button>
			<img class="detail_buttons" src="../js/jqwidgets-4.1.2/styles/images/search.png"
				title="查看" style="width: 16px; height: 16px; vertical-align: middle;">
		</button>
		<button>
			<img class="approve_buttons" src="../js/jqwidgets-4.1.2/styles/images/check_black.png"
				title="通过" style="width: 16px; height: 16px; vertical-align: middle;">
		</button>
		<button>
			<img class="reject_buttons" src="../js/jqwidgets-4.1.2/styles/images/close_black.png"
				title="拒绝" style="width: 16px; height: 16px; vertical-align: middle;">
		</button>
	</li>
</ul>

<div id="dialog_window">
	<div>请选择</div>
	<div style="overflow: hidden;">
		<div id="dialog_window_content" style="margin: 20px;">&nbsp;</div>
		<div class="right margin_10">
			<input type="button" id="dialog_window_ok_button" value="确定">
			<input type="button" id="dialog_window_cancel_button" value="取消">
		</div>
		<div class="clear"></div>
	</div>
</div>

<div id="diff_window">
	<div><fmt:message key="agri_data_approval.edition_comparison" /></div>
	<div style="overflow: hidden; padding: 20px;">
		<div class="left" style="width: 70px;"><fmt:message key="text.category" />:</div>
		<div class="left" id="diff_category" style="font-weight: bold;"></div>
		<div class="clear"></div>
		<div class="margin_10"></div>
		<div style="width: 100%; height: 20px;">
			<div class="left" style="margin-left: 50px;"><fmt:message key="text.original_edition" /></div>
			<div class="right" style="margin-right: 50px;"><fmt:message key="text.revised_edition" /></div>
			<div class="clear"></div>
		</div>
		<div id="diff_content_splitter">
			<div class="splitter-panel">
				<div id="diff_grid_1"></div>
			</div>
			<div class="splitter-panel">
				<div id="diff_grid_2"></div>
			</div>
		</div>
		<div class="right margin_10">
			<input type="button" id="diff_window_ok_button" value="<fmt:message key="text.approve" />">
			<input type="button" id="diff_window_cancel_button" value="<fmt:message key="text.reject" />">
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
