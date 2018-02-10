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
	
	$('#nav2_tabs').jqxTabs({width: '998px', position: 'top', theme: '<%=jqx_theme %>'});
	$('#nav2_tabs').jqxTabs({ selectedItem: 1 });
	$('#nav2_tabs').on('selected', function (event) {
		var idx = event.args.item;
		window.location.href=nav2_items_indicator[idx];
	});
	
	var cat_tree_src = agri_data_cat_tree_src_<fmt:message key="common.language" />;
	
	$('#cat_expander').jqxExpander({
		width: '250px', height: '300px', showArrow: false, toggleMode: 'none', theme: '<%=jqx_theme %>'
	});
	
	$('#cat_tree').jqxTree({
		source: cat_tree_src, width: '100%', height: '240px', theme: '<%=jqx_theme %>'
	});
	
	$('#cat_add_button').jqxButton({
		width: '82px', height: '30px', theme: '<%=jqx_theme %>'
	});
	
	$('#cat_delete_button').jqxButton({
		width: '82px', height: '30px', theme: '<%=jqx_theme %>'
	});
	
	$('#cat_edit_button').jqxButton({
		width: '82px', height: '30px', theme: '<%=jqx_theme %>'
	});
	
	$('#product_expander').jqxExpander({
		width: '280px', height: '300px', showArrow: false, toggleMode: 'none', theme: '<%=jqx_theme %>'
	});
	
	$('#product_list').jqxListBox({
		source: [
			'<fmt:message key="common.product.rice" />',
			'<fmt:message key="common.product.wheat" />',
			'<fmt:message key="common.product.maize" />',
			], checkboxes: false,
		multiple: false, width: '100%', height: '240px', theme: '<%=jqx_theme %>'
	});
	
	$('#product_add_button').jqxButton({
		width: '92px', height: '30px', theme: '<%=jqx_theme %>'
	});
	
	$('#product_delete_button').jqxButton({
		width: '92px', height: '30px', theme: '<%=jqx_theme %>'
	});
	
	$('#product_edit_button').jqxButton({
		width: '92px', height: '30px', theme: '<%=jqx_theme %>'
	});
	
	$('#variable_expander').jqxExpander({
		width: '280px', height: '300px', showArrow: false, toggleMode: 'none', theme: '<%=jqx_theme %>'
	});
	
	$('#variable_list').jqxListBox({
		source: ['<fmt:message key="common.indicator.harvest_area" /> (<fmt:message key="common.unit.ten_thousand_hectares" />)',
		         '<fmt:message key="common.indicator.total_production" /> (<fmt:message key="common.unit.ten_thousand_tons" />)',
		         '<fmt:message key="common.indicator.yield" /> (<fmt:message key="common.unit.ton_per_hectare" />)'],
		         checkboxes: false,
		multiple: false, width: '100%', height: '240px', theme: '<%=jqx_theme %>'
	});
	
	$('#variable_add_button').jqxButton({
		width: '92px', height: '30px', theme: '<%=jqx_theme %>'
	});
	
	$('#variable_delete_button').jqxButton({
		width: '92px', height: '30px', theme: '<%=jqx_theme %>'
	});
	
	$('#variable_edit_button').jqxButton({
		width: '92px', height: '30px', theme: '<%=jqx_theme %>'
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
	
	$('#cat_add_button, #product_add_button').on('click', function(event) {
		$('#dialog_window_content').html('请输入名称: <input type="text">');
		$('#dialog_window').one('close', function(event) {
			if(event.args.dialogResult.OK) {
				$('#message_notification_content').html('添加成功。');
				$('#message_notification').jqxNotification('open');
			}
		});
		$('#dialog_window').jqxWindow('open');
	});
	
	$('#variable_add_button').on('click', function(event) {
		$('#dialog_window_content').html('<table><tr><td>请输入名称:</td><td><input type="type"></td></tr>'
				+ '<tr><td>请输入单位:</td><td><input type="text"></td></tr></table>');
		$('#dialog_window').one('close', function(event) {
			if(event.args.dialogResult.OK) {
				$('#message_notification_content').html('添加成功。');
				$('#message_notification').jqxNotification('open');
			}
		});
		$('#dialog_window').jqxWindow('open');
	});
	
	$('#cat_edit_button, #product_edit_button').on('click', function(event) {
		$('#dialog_window_content').html('请输入名称: <input type="text">');
		$('#dialog_window').one('close', function(event) {
			if(event.args.dialogResult.OK) {
				$('#message_notification_content').html('编辑成功。');
				$('#message_notification').jqxNotification('open');
			}
		});
		$('#dialog_window').jqxWindow('open');
	});
	
	$('#variable_edit_button').on('click', function(event) {
		$('#dialog_window_content').html('<table><tr><td>请输入名称:</td><td><input type="text"></td></tr>'
				+ '<tr><td>请输入单位:</td><td><input type="text"></td></tr></table>');
		$('#dialog_window').one('close', function(event) {
			if(event.args.dialogResult.OK) {
				$('#message_notification_content').html('编辑成功。');
				$('#message_notification').jqxNotification('open');
			}
		});
		$('#dialog_window').jqxWindow('open');
	});
	
	$('#cat_delete_button, #product_delete_button, #variable_delete_button').on('click', function(event) {
		$('#dialog_window_content').html('是否删除？');
		$('#dialog_window').one('close', function(event) {
			if(event.args.dialogResult.OK) {
				$('#message_notification_content').html('删除成功。');
				$('#message_notification').jqxNotification('open');
			}
		});
		$('#dialog_window').jqxWindow('open');
	});
	
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
					<fmt:message key="nav.system_admin.indicator.econ" />
				</div>
			</div>
		</li>
		<li>
			<div style="height: 20px; margin-top: 5px;">
				<div style="margin-left: 4px; vertical-align: middle; text-align: center;">
					<fmt:message key="nav.system_admin.indicator.agri" />
				</div>
			</div>
		</li>
	</ul>
	<div></div>
	<div></div>
</div>

<div style="padding: 25px;">
	<h1><fmt:message key="nav.system_admin.indicator.agri" /></h1>
</div>

<div id="cat_expander" class="left margin_15">
	<div><fmt:message key="text.category" /></div>
	<div style="overflow: hidden;">
		<div id="cat_tree" style="border: none;"></div>
		<input type="button" id="cat_add_button" value="<fmt:message key="text.add" />" class="left">
		<input type="button" id="cat_delete_button" value="<fmt:message key="text.delete" />" class="left">
		<input type="button" id="cat_edit_button" value="<fmt:message key="text.edit" />" class="left">
		<div class="clear"></div>
	</div>
</div>

<div class="left margin_15" style="width: 650px;">
	<div style="width: 650px;">
		<div id="product_expander" class="left">
			<div><fmt:message key="common.dimension.product" /></div>
			<div style="overflow: hidden;">
				<div id="product_list" style="border: none;"></div>
				<input type="button" id="product_add_button" value="<fmt:message key="text.add" />" class="left">
				<input type="button" id="product_delete_button" value="<fmt:message key="text.delete" />" class="left">
				<input type="button" id="product_edit_button" value="<fmt:message key="text.edit" />" class="left">
				<div class="clear"></div>
			</div>
		</div>
		<div class="left margin_20"></div>
		<div id="variable_expander" class="left">
			<div><fmt:message key="common.dimension.indicator" /></div>
			<div style="overflow: hidden;">
				<div id="variable_list" style="border: none;"></div>
				<input type="button" id="variable_add_button" value="<fmt:message key="text.add" />" class="left">
				<input type="button" id="variable_delete_button" value="<fmt:message key="text.delete" />" class="left">
				<input type="button" id="variable_edit_button" value="<fmt:message key="text.edit" />" class="left">
				<div class="clear"></div>
			</div>
		</div>
		<div class="clear"></div>
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
