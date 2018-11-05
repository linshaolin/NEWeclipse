
/**点击“+”号按钮显示添加角色模式窗口*/
$('.addrole').click(function(e){
		e.preventDefault();
		$('#addRoleDiv').modal('show');
});

/**跳回角色列表页面*/
function loadingRoleList(){
	window.location.href = "/role/rolelist";
}

/**点击×和关闭按钮，跳回角色列表页面*/
$("#addRoleCancel").click(loadingRoleList);
$("#addRoleClose").click(loadingRoleList);

/**添加角色界面，点击添加按钮执行操作*/
$("#addRoleBtn").click(function(){
	var role = new Object();
	//拿到角色编号和角色名称数据
	role.roleCode = $.trim($("#roleCode").val());
	role.roleName = $.trim($("#roleName").val());
	//判断角色编号和角色名称
	if(role.roleCode == "" || role.roleCode == null){
		 $("#roleCode").focus();
		 $("#formtip").css("color","red");
		 $("#formtip").html("对不起，角色代码不能为空。");
	}else if(role.roleName == "" || role.roleName == null){
		$("#roleName").focus();
		$("#formtip").css("color","red");
		$("#formtip").html("对不起，角色名称不能为空。");
	}else{
		$("#formtip").html("");
		//使用Ajax提交到后台，数据为角色编号和角色名称，启用状态后天默认设置为启用
		$.ajax({
			url: '/role/addRole',
			type: 'POST',
			data:{role:JSON.stringify(role)},
			dataType: 'html',
			timeout: 1000,
			error: function(){
				$("#formtip").css("color","red");
				$("#formtip").html("角色添加失败！请重试。");
			},
			success: function(result){
				if(result != "" && "success" == result){
					$("#formtip").css("color","green");
					$("#formtip").html("角色添加成功 , 继续添加请填写!");
					$("#roleCode").val('');
					$("#roleName").val('');
				}else if("error" == result){
					$("#formtip").css("color","red");
					$("#formtip").html("角色添加失败！请重试。");
				}
				else if("chongfu" == result){
					$("#formtip").css("color","red");
					$("#formtip").html("角色添加失败！角色代码或角色名称已存在，请重新添加！");
				}else if("nodata" == result){
					alert("对不起，没有任何数据需要处理！请重试。");
				}
			}
		});
	}
});

/**点击修改按钮执行操作*/
$(".modifyrole").click(function(){
	//获取当前点击对象
	var modify = $(this);
	//获取当前对象的id
	var id= modify.attr("roleid");
	//获取当前对象的编号
	var oldCode= modify.attr("rolecode");
	//获取当前对象的名称
	var oldName= modify.attr("rolename");
	//获取当前对象用户输入的编号
	var roleCode = $.trim($("#roleCode"+id).val());
	//获取当前对象用户输入的名称
	var roleName = $.trim($("#roleName"+id).val());
	if(roleCode == "" || roleCode == null){
		 alert("对不起，角色代码不能为空。");
	}else if(roleName == "" || roleName == null){
		alert("对不起，角色名称不能为空。");
	}else{
		var tip = "您确定要将原来的\n角色编号："+oldCode + "\t角色名称："+oldName + "\n,修改为\n角色编号：" + roleCode + "\t角色名称：" + roleName + "\t吗？";
		//弹出确认窗口，返回true或false
		if(confirm(tip)){
			var role = new Object();
			role.id = id;
			role.roleCode = roleCode;
			role.roleName = roleName;
			$.ajax({
				url: '/role/updateRole',
				type: 'POST',
				data:{role:JSON.stringify(role)},
				dataType: 'html',
				timeout: 1000,
				error: function(){
					alert("角色修改失败！请重试。");
				},
				success: function(result){
					if(result != "" && "success" == result){
						alert("角色修改成功 !");
					}else if("error" == result){
						alert("角色修改失败！请重试。");
					}else if("nodata" == result){
						alert("对不起，没有任何数据需要处理！请重试。");
					}
				}
			});
		}
	}
});

/**点击启用状态的按钮，传输后台修改*/
$(".modifyIsStart").click(function(){
	modify = $(this);
	id= modify.attr("roleid");
	isstart= modify.attr("isstart");
	roleIstart = new Object();
	roleIstart.id = id;
	roleIstart.roleName = null;
	if(isstart == "1"){
		roleIstart.isStart = 2;
	}else{
		roleIstart.isStart = 1;
	}
	
	$.ajax({
		url: '/role/updateRole',
		type: 'POST',
		data:{role:JSON.stringify(roleIstart)},
		dataType: 'html',
		timeout: 1000,
		error: function(){
			alert("开启或关闭角色操作时失败！请重试。");
		},
		success: function(result){
			if(result != "" && "success" == result){
				if(isstart == "1"){
					//如果是1，设置成2
					modify.attr("isstart",2);
				}else{
					modify.attr("isstart",1);
				}
			}else if("error" == result){
				alert("开启或关闭角色操作时失败！请重试。");
			}else if("nodata" == result){
				alert("对不起，没有任何数据需要处理！请重试。");
			}
		}
	});
});

/**删除角色*/
$(".delrole").click(function(){
	var modify = $(this);
	var id= modify.attr("roleid");
	var roleName= modify.attr("rolename");
	var tip = "您确定要删除角色：<"+roleName+">吗？";
	if(confirm(tip)){
		var role = new Object();
		role.id = id;
		$.ajax({
			url: '/role/deleteRole',
			type: 'POST',
			data:{role:JSON.stringify(role)},
			dataType: 'html',
			timeout: 1000,
			error: function(){
				alert("删除角色失败！请重试。");
			},
			success: function(result){
				if(result != "" && "success" == result){
					alert("删除角色成功 !");
					loadingRoleList();
				}else if("error" == result){
					alert("删除角色失败！请重试。");
				}else if("nodata" == result){
					alert("对不起，没有任何数据需要处理！请重试。");
				}else{
					//拿到的是属于当前角色的所有用户信息
					if(result != null && result != ""){
						//截取返回的字符串（用户名称），length-1是去掉最后一个逗号
						result = result.substring(0,result.length-1);
						alert("系统中有用户被授权该角色，不能被删除！用户账号：<"+result+">");
					}
				}
			}
		});
	}
});