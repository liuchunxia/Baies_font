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
	$('#nav2_tabs').jqxTabs({ selectedItem: 1 });
	$('#nav2_tabs').on('selected', function (event) {
		var idx = event.args.item;
		window.location.href=nav2_items_approval[idx];
	});
	
	var rows = $("#data_ul");
	var data = [];
	<%--for (var i = 0; i < 100; i++) {--%>
		<%--var row = rows[0];--%>
		<%--var datarow = {};--%>
		<%--datarow['version_id'] = 162 - i;--%>
		<%--var objs = econ_data_cat_tree_src_<fmt:message key="common.language" />[0].items;--%>
		<%--datarow['category'] = objs[Math.floor(Math.random()*objs.length)].label;--%>
		<%--datarow['country'] = $(row).find('li:nth-child(3)').html();--%>
		<%--datarow['author'] = $(row).find('li:nth-child(4)').html();--%>
		<%--datarow['time'] = $(row).find('li:nth-child(5)').html();--%>
		<%--datarow['description'] = $(row).find('li:nth-child(6)').find('span:nth-child('+(Math.floor(Math.random()*2)+1)+')').html();--%>
		<%--datarow['operation'] = $(row).find('li:nth-child(7)').html();--%>
		<%--data[data.length] = datarow;--%>
	<%--}--%>

	var source = {
			localdata: data,
			datatype: 'array',
			datafields: [{name: 'id', type: 'number'},
			             {name: 'category', type: 'string'},
			             {name: 'country', type: 'string'},
			             {name: 'author', type: 'string'},
			             {name: 'time', type: 'string'},
			             {name: 'description', type: 'string'},
			             {name: 'operation', type: 'string'},
				         {name: 'pre', type:'object'},
                		 {name: 'past', type:'object'}],
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


    $.ajax({
        type:'GET',
        url:'http://127.0.0.1:5000/user/Log?',
        data: {kind:1},
        withCredentials: true,
        async: true,
        success: function (resp) {
            for (var index in resp.data) {
                var row = rows[0];
                var per_log = resp.data[index];
                var datarow = {}

                datarow["id"] = per_log.id
				datarow["pre"] = $.parseJSON(per_log.pre)
                datarow["past"] = $.parseJSON(per_log.past)

                datarow['category'] = $.parseJSON(per_log.target).name;
                datarow['country'] = per_log.user.country;
                datarow['author'] = per_log.user.username;
                datarow['time'] = per_log.timestamp;
                datarow['description'] = per_log.note;
                datarow['operation'] = $(row).find('li:nth-child(7)').html();
                data[data.length] = datarow;
            }
            dataAdapter.dataBind()
            $('#data_grid').jqxGrid('render');
            $('#data_grid').jqxGrid('refresh');
        }
    });

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
		$('#diff_category').html('人口概况');
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
		var local_data_2 = [
		          		['<fmt:message key="common.country.brazil" />', '<fmt:message key="common.indicator.population" /> (<fmt:message key="common.unit.ten_thousand_people" />)', 18848 , 19071 , 19278 , 19477 , 19670 , 19861 ],
		          		['<fmt:message key="common.country.russia" />', '<fmt:message key="common.indicator.population" /> (<fmt:message key="common.unit.ten_thousand_people" />)', 12345 , 14334 , 14318 , 14312 , 14313 , 14316 ],
		          		['<fmt:message key="common.country.india" />', '<fmt:message key="common.indicator.population" /> (<fmt:message key="common.unit.ten_thousand_people" />)', 114433 , 116209 , 117969 , 119707 , 121418 , 123098 ],
		          		['<fmt:message key="common.country.china" />', '<fmt:message key="common.indicator.population" /> (<fmt:message key="common.unit.ten_thousand_people" />)', 133562 , 134277 , 134994 , 135715 , 136441 , 137170 ],
		          		['<fmt:message key="common.country.south_africa" />', '<fmt:message key="common.indicator.population" /> (<fmt:message key="common.unit.ten_thousand_people" />)', 4836 , 4904 , 4970 , 5035 , 5099 , 5162 ],
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
		var grid_edited_cells = [
		                         {row: 0, datafield: 'y2006'},
		                         {row: 1, datafield: 'y2005'},
		                         {row: 4, datafield: 'y2005'},
		                         {row: 4, datafield: 'y2006'},
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
		                   {text: '<fmt:message key="common.dimension.indicator" />', datafield: 'variable', width: 70},
		                   {text: '2005', datafield: 'y2005', width: 70, cellsalign: 'right', cellclassname: grid_cell_class},
		                   {text: '2006', datafield: 'y2006', width: 70, cellsalign: 'right', cellclassname: grid_cell_class},
		                   {text: '2007', datafield: 'y2007', width: 70, cellsalign: 'right', cellclassname: grid_cell_class},
		                   {text: '2008', datafield: 'y2008', width: 70, cellsalign: 'right', cellclassname: grid_cell_class},
		                   {text: '2009', datafield: 'y2009', width: 70, cellsalign: 'right', cellclassname: grid_cell_class},
		                   {text: '2010', datafield: 'y2010', width: 70, cellsalign: 'right', cellclassname: grid_cell_class}
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
	<h1><fmt:message key="nav.system_admin.approval.econ" /></h1>
	<br><br>
	<div id="data_grid"></div>
</div>

<ul id="data_ul" style="display: none;">
	<li>（<fmt:message key="text.edition" />）</li>
	<li>（<fmt:message key="text.category" />）</li>
	<li><fmt:message key="common.country.china" /></li>
	<li><fmt:message key="temp.policy_author" /></li>
	<li>2016-07-04 10:39</li>
	<li><span>导入2016年最新社会经济数据。</span><span>根据最新统计结果对社会经济数据进行更新。</span></li>
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
	<div>查看信息</div>
	<div style="overflow: hidden; padding: 20px;">
		<div class="left" style="width: 70px;"><fmt:message key="text.category" />:</div>
		<div class="left" id="diff_category" style="font-weight: bold;"></div>
		<div class="clear"></div>
		<div class="margin_10"></div>
		<div style="width: 100%; height: 20px;">
			<div class="left" style="margin-left: 50px;">原始版</div>
			<div class="right" style="margin-right: 50px;">修订版</div>
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
			<input type="button" id="diff_window_ok_button" value="通过">
			<input type="button" id="diff_window_cancel_button" value="拒绝">
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
