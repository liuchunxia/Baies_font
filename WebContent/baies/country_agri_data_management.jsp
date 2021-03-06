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

removeByValue = function(ary,val) {
    var index = ary.indexOf(val);
    if (index > -1) {
        ary.splice(index, 1);
    }
};

var parseParam=function(param){
    var paramStr="";
    for (var key in param) {
        paramStr = paramStr+ "&"+ key + '=' + JSON.stringify(param[key])
    }
    return paramStr.substr(1);
};

var table_index_data= {};
var table_data = [];
var country_data = [];
var index_data = [];
var kind_data = [];
var query_args = { country_ids:[], table_id:0, index_ids:[], start_time:'', end_time:'', kind_ids:[]};

$.ajax({
    type:'GET',
    url:host+'/quantify/agriculture_table',
    data: {},
    withCredentials: true,
    async: false ,
    success: function (resp) {
        for (var table in resp.data) {
            console.log('table', resp.data[table])
            table_data.push({label: resp.data[table].<fmt:message key="data.field" />, value: resp.data[table].id, id:resp.data[table].id})
            table_index_data[resp.data[table].id] = resp.data[table].indexes
        }
        console.log('table', table_data, 'index', table_index_data)
        // $('#cat_tree').jqxTree('render')
        // $('#variable_list').jqxListBox('render')
    }.bind(this)
})


$.ajax({
    type:'GET',
    url:host+'/quantify/country',
    data: {},
    withCredentials: true,
    success: function (resp) {
        for (var index in resp.data) {
            country_data.push(resp.data[index])
        }
        $('#location_list').jqxListBox('refresh')

        console.log(country_data,'r2')}.bind(this)
});

$.ajax({
    type:'GET',
    url:host+'/quantify/agriculture_kinds',
    data: {},
    withCredentials: true,
    success: function (resp) {
        for (var index in resp.data) {
            kind_data.push(resp.data[index])
        }
        $('#product_list').jqxListBox('refresh')

        console.log(kind_data,'kind')}.bind(this)
});


$(document).ready(function() {

    var cat_tree_src = agri_data_cat_tree_src_<fmt:message key="common.language" />;

    $('#cat_expander').jqxExpander({
        width: '250px', height: '400px', showArrow: false, toggleMode: 'none', theme: '<%=jqx_theme %>'
    });

    $('#cat_tree').jqxTree({
        source: table_data, width: '100%', height: '100%', theme: '<%=jqx_theme %>'
    });

    $('#location_expander').jqxExpander({
        width: '280px', height: '180px', showArrow: false, toggleMode: 'none', theme: '<%=jqx_theme %>'
    });

    $('#location_list').jqxListBox({
        source: country_data, checkboxes: true,
        multiple: true, width: '100%', height: '100%', theme: '<%=jqx_theme %>',
        displayMember:'<fmt:message key="data.field" />',valueMember:'id'
    });

    $('#product_expander').jqxExpander({
        width: '280px', height: '180px', showArrow: false, toggleMode: 'none', theme: '<%=jqx_theme %>'
    });

    $('#product_list').jqxListBox({
        source: kind_data, checkboxes: true,
        multiple: true, width: '100%', height: '100%', theme: '<%=jqx_theme %>',
        displayMember:'<fmt:message key="data.field" />',valueMember:'id'
    });

    $('#variable_expander').jqxExpander({
        width: '280px', height: '180px', showArrow: false, toggleMode: 'none', theme: '<%=jqx_theme %>'
    });

    $('#variable_list').jqxListBox({
        source: index_data, checkboxes: true,
        multiple: true, width: '100%', height: '100%', theme: '<%=jqx_theme %>',
        displayMember:'<fmt:message key="data.field" />',valueMember:'id'
    });

    $('#time_expander').jqxExpander({
        width: '280px', height: '100px', showArrow: false, toggleMode: 'none', theme: '<%=jqx_theme %>'
    });

    $('#time_slider').jqxSlider({
        width: '95%', values: [2015,2016 ], min: start_year, max: end_year, mode: 'fixed',
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
        window.location.href='country_agri_data_management_table.jsp'+'?'+ parseParam(query_args);
    });

    // 处理事件
    $('#cat_tree').on('select',function (event)
    {
        var args = event.args;
        var item = $('#cat_tree').jqxTree('getItem', args.element);

        query_args.table_id=item.value
        index_data.splice(0,index_data.length);
        query_args.index_ids=[]
        for (var i in table_index_data[item.id]) {
            index_data.push({label:table_index_data[item.id][i].<fmt:message key="data.field" />, value:table_index_data[item.id][i].id, id:table_index_data[item.id][i].id})
        }
        $('#variable_list').jqxListBox('refresh')
        console.log('qu', query_args)
        console.log("change", index_data)
    });

    $('#variable_list').on('select', function (event) {
        var args = event.args;
        console.log(args)
        var item = $('#variable_list').jqxListBox('getItem', args.index);
        if (item.checked === true) {
            query_args.index_ids.push(item.value)
        }
        else {
            removeByValue(query_args.index_ids,item.value)
        }
        console.log('qu', query_args)
    })

    $('#location_list').on('select', function (event) {
        var args = event.args;
        var item = $('#location_list').jqxListBox('getItem', args.index);
        if (item.checked === true) {
            query_args.country_ids.push(item.value)
        }
        else {
            removeByValue(query_args.country_ids,item.value)
        }
        console.log('qu', query_args)
    })

    $('#product_list').on('select', function (event) {
        var args = event.args;
        var item = $('#product_list').jqxListBox('getItem', args.index);
        if (item.checked === true) {
            query_args.kind_ids.push(item.value)
        }
        else {
            removeByValue(query_args.kind_ids,item.value)
        }
        console.log('qu', query_args)
    })

    var values = $('#time_slider').jqxSlider('values');
    query_args.start_time = values[0];
    query_args.end_time = values[1];

    $('#time_slider').on('change', function (event) {
        var values = $('#time_slider').jqxSlider('values');
        query_args.start_time = values[0]
        query_args.end_time = values[1]
        console.log('qu', query_args)
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
		<div id="product_expander" class="left">
			<div><fmt:message key="common.dimension.product" /></div>
			<div style="overflow: hidden;">
				<div id="product_list" style="border: none;"></div>
			</div>
		</div>
		<div class="clear"></div>
	</div>
	<div class="margin_30"></div>
	<div style="width: 650px;">
		<div id="variable_expander" class="left">
			<div><fmt:message key="common.dimension.indicator" /></div>
			<div style="overflow: hidden;">
				<div id="variable_list" style="border: none;"></div>
			</div>
		</div>
		<div class="left margin_20"></div>
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
			<div class="margin_40"></div>
			<input type="button" id="query_button" value="<fmt:message key="text.query" />" class="right">
		</div>
		<div class="clear"></div>
	</div>
</div>

<div class="clear"></div>


<jsp:include page="../includes/html_body_footer.jsp" />

</body>
</html>
