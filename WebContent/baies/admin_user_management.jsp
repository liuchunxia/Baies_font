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
	
	var rows = $("#user_ul");
	var data = [];
	for (var i = 0; i < 100; i++) {
		var row = rows[0];
		var datarow = {};
		datarow['id'] = i + 1;
		datarow['name'] = 'user' + (Math.floor(Math.random()*1000)+1);
		datarow['real_name'] = $(row).find('li:nth-child(3)').find('span:nth-child('+(Math.floor(Math.random()*4)+1)+')').html();
		datarow['country'] = $(row).find('li:nth-child(4)').find('span:nth-child('+(Math.floor(Math.random()*5)+1)+')').html();
		datarow['create_time'] = $(row).find('li:nth-child(5)').html();
		datarow['last_login_time'] = $(row).find('li:nth-child(6)').html();
		datarow['role'] = $(row).find('li:nth-child(7)').find('span:nth-child('+(Math.floor(Math.random()*3)+1)+')').html();
		datarow['operation'] = $(row).find('li:nth-child(8)').html();
		data[data.length] = datarow;
	}
	var source = {
			localdata: data,
			datatype: 'array',
			datafields: [{name: 'id', type: 'number'},
			             {name: 'name', type: 'string'},
			             {name: 'real_name', type: 'string'},
			             {name: 'country', type: 'string'},
			             {name: 'create_time', type: 'string'},
			             {name: 'last_login_time', type: 'string'},
			             {name: 'role', type: 'string'},
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
			columns: [{text: '编号', dataField: 'id', width: 100, align: 'center', cellsalign: 'center'},
			          {text: '登录名', dataField: 'name', width: 150, align: 'center', cellsalign: 'center'},
			          {text: '姓名', dataField: 'real_name', width: 100, align: 'center', cellsalign: 'center'},
			          {text: '<fmt:message key="common.dimension.country" />', dataField: 'country', width: 100, align: 'center', cellsalign: 'center'},
			          {text: '创建时间', dataField: 'create_time', width: 100, align: 'center', cellsalign: 'center'},
			          {text: '最后登录时间', dataField: 'last_login_time', width: 100, align: 'center', cellsalign: 'center'},
			          {text: '角色', dataField: 'role', width: 100, align: 'center', cellsalign: 'center'},
			          {text: '操作', dataField: 'operation', width: 100, align: 'center', cellsalign: 'center'}
			          ],
			showtoolbar: true,
			rendertoolbar: function(toolbar) {
				var container = $('<div style="margin: 5px 10px 5px 5px; text-align: right;"></div>');
				toolbar.append(container);
				container.append('<input id="addrowbutton" type="button" value="添加用户" />');
				$("#addrowbutton").jqxButton();
				$("#addrowbutton").on('click', function () {
					$('#edit_title_input').val('');
					$('#edit_content_editor').val('');
					$('#edit_window').jqxWindow('open');
				});
			}
	};
	$('#user_grid').jqxGrid(settings);
	
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
	
	$('.edit_buttons').on('click', function() {
		$('#edit_title_input').val('<fmt:message key="temp.policy_title" />');
		$('#edit_content_editor').val($('<div />').html($('#editor_content').html()).text());
		$('#edit_window').jqxWindow('open');
	});
	
	$('.delete_buttons').on('click', function() {
		$('#dialog_window_content').html('是否删除用户？');
		$('#dialog_window').one('close', function(event) {
			if(event.args.dialogResult.OK) {
				$('#message_notification_content').html('用户已删除。');
				$('#message_notification').jqxNotification('open');
			}
		});
		$('#dialog_window').jqxWindow('open');
	});
	
	$('#edit_window').jqxWindow({
		width: 350, height: 'auto', resizable: false,  isModal: true, autoOpen: false,
		okButton: $("#edit_window_ok_button"), cancelButton: $("#edit_window_cancel_button"),
		modalOpacity: 0.3, theme: '<%=jqx_theme %>'
	});
	
	$("#edit_window_ok_button").jqxButton({
		theme: '<%=jqx_theme %>'
	});
	
	$("#edit_window_ok_button").on('click', function(event) {
		$('#message_notification_content').html('用户已保存。');
		$('#message_notification').jqxNotification('open');
	});
	
	$("#edit_window_cancel_button").jqxButton({
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


<div style="padding: 25px;">
	<h1>用户管理</h1>
	<br><br>
	<div id="user_grid"></div>
</div>

<ul id="user_ul" style="display: none;">
	<li>（用户编号）</li>
	<li>（登录名）</li>
	<li><span><fmt:message key="temp.policy_author" /></span><span>李四</span><span>王五</span><span>赵六</span></li>
	<li><span><fmt:message key="common.country.brazil" /></span><span><fmt:message key="common.country.russia" /></span><span><fmt:message key="common.country.india" /></span><span><fmt:message key="common.country.china" /></span><span><fmt:message key="common.country.south_africa" /></span></li>
	<li>2016-07-01 08:00</li>
	<li>2016-07-04 10:39</li>
	<li><span>查询用户</span><span><fmt:message key="common.dimension.country" />管理员</span><span>系统管理员</span></li>
	<li>
		<button>
			<img class="edit_buttons" src="../js/jqwidgets-4.1.2/styles/images/icon-edit.png"
				title="编辑" style="width: 16px; height: 16px; vertical-align: middle;">
		</button>
		<button>
			<img class="delete_buttons" src="../js/jqwidgets-4.1.2/styles/images/icon-delete.png"
				title="删除" style="width: 16px; height: 16px; vertical-align: middle;">
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

<div id="edit_window">
	<div>录入信息</div>
	<div style="overflow: hidden; padding: 20px;">
		<table>
			<tr>
				<td>登录名:</td>
				<td><input type="text" id="name_input" style="width: 200px;"></td>
			</tr>
			<tr>
				<td>姓名:</td>
				<td><input type="text" id="real_name_input" style="width: 200px;"></td>
			</tr>
			<tr>
				<td><fmt:message key="common.dimension.country" />:</td>
				<td>
					<select style="width: 200px;">
						<option>--请选择--</option>
						<option><fmt:message key="common.country.brazil" /></option>
						<option><fmt:message key="common.country.russia" /></option>
						<option><fmt:message key="common.country.india" /></option>
						<option><fmt:message key="common.country.china" /></option>
						<option><fmt:message key="common.country.south_africa" /></option>
					</select>
				</td>
			</tr>
			<tr>
				<td>角色:</td>
				<td>
					<select style="width: 200px;">
						<option>--请选择--</option>
						<option>查询用户</option>
						<option><fmt:message key="common.dimension.country" />管理员</option>
						<option>系统管理员</option>
					</select>
				</td>
			</tr>
		</table>
		<div class="right margin_10">
			<input type="button" id="edit_window_ok_button" value="保存">
			<input type="button" id="edit_window_cancel_button" value="取消">
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
