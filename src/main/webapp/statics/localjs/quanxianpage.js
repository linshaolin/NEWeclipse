//获取功能列表（回显加载checkbox）
$('.roleNameAuthority').click(function(){
	var authority = $(this);
	var roleId = authority.attr("roleid");
	$("#selectrole").html("当前配置角色为：" + authority.attr("rolename"));
	$("#roleidhide").val(roleId);
	//把当前角色的id传入后台，获取对应的菜单列表
	$.ajax({
		url: '/quanxian/getFunctions',
		type: 'POST',
		data:{fid:roleId},
		dataType: 'html',
		timeout: 1000,
		error: function(){
			alert("对不起，功能列表获取失败，请重试!");
		},
		success: function(result){
			if(result == "nodata"){
				alert("对不起，功能列表获取失败，请重试!");
			}else{
				var json = eval("("+result+")");
				listr = "";
				//通过拼接标签，显示当前角色对应的权限菜单
				for(var i=0;i<json.length;i++){
					listr += "<li>";
					listr += "<ul id=\"subfuncul"+json[i].mainFunction.id+"\" class=\"subfuncul\">";
					listr += "<li  class=\"functiontitle\" ><input id='functiontitle"+json[i].mainFunction.id+"' onchange='mainFunctionSelectChange(this,"+json[i].mainFunction.id+");' funcid=\""+json[i].mainFunction.id+"\" type='checkbox' />"+json[i].mainFunction.functionName+"</li>";
					for(j=0;j<json[i].subFunctions.length;j++){
						
						listr += "<li><input onchange='subFunctionSelectChange(this,"+json[i].mainFunction.id+");' funcid=\""+json[i].subFunctions[j].id+"\" type='checkbox' /> "+json[i].subFunctions[j].functionName+"</li>";
					}
					listr += "</ul></li>";
				}
				
				$("#functionList").html(listr);
				
				//回显当前角色对应的功能
				$("#functionList :checkbox").each(function () {  
					var checkbox = $(this);
					$.ajax({
						url: '/quanxian/getQuanXianDefault',
						type: 'POST',
						data:{rid:$("#roleidhide").val(),fid:$(this).attr("funcid")},
						dataType: 'text',
						timeout: 1000,
						error: function(){
						},
						success: function(result){
							if(result == "success"){
								checkbox.attr("checked", true); 
							}else{
								checkbox.attr("checked", false);
							}
						}
						});
				});
			}
		}
		});
});
//点击子菜单，主菜单选中
function subFunctionSelectChange(obj,id){
	if(obj.checked){
		$("#functiontitle"+id).attr("checked", true);  
	}
}
//点击主菜单，所有子菜单全部选中，反之全部取消
function mainFunctionSelectChange(obj,id){
	if(obj.checked){
		$("#subfuncul"+id+" :checkbox").attr("checked", true);  
	}else{
		$("#subfuncul"+id+" :checkbox").attr("checked", false);  
	}
	
}
//全选按钮
$("#selectAll").click(function () {  
    $("#functionList :checkbox").attr("checked", true);  
});  
//全不选按钮
$("#unSelect").click(function () {  
    $("#functionList :checkbox").attr("checked", false);  
});  
//反选按钮
$("#reverse").click(function () {  
    $("#functionList :checkbox").each(function () {  
        $(this).attr("checked", !$(this).attr("checked"));  
    });  
});  


//提交修改
$("#confirmsave").click(function(){
	
	if(confirm("您确定要修改当前角色的权限吗？")){
	
		ids = $("#roleidhide").val()+"-";
		//循环拼接当前角色所拥有的所有功能id
		$("#functionList :checkbox").each(function () {
			if($(this).attr("checked") == 'checked'){
				ids += $(this).attr("funcid") + "-" ;
			}
	    }); 
		//传入后台，进行修改（先删除，后添加）
		$.ajax({
			url: '/quanxian/updateQuanXian',
			type: 'POST',
			data:{ids:ids},
			dataType: 'html',
			timeout: 1000,
			error: function(){
			},
			success: function(result){
				if(result == "nodata"){
					alert("对不起，功能列表获取失败，请重试。");
				}else{
					alert("恭喜您，权限修改成功。");
				}
			}
		});
	}
});