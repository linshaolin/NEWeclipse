
/**验证码*/
function change(){
	var code = $("#code");
	//验证码组成库
	var arrays = new Array('1','2','3','4','5','6','7','8','9','0','a',
	'b','c','d','e','f','g','h','i','g','k','l','m','n','o','p','q','r','s',
	't','u','v','w','x','y','z','A','B','C','D','E','F','G','H','I','G','K','L',
	'M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z');
	codes = '';//重新初始化验证码
	for(var i=0; i<4; i++){
			//随机获取一个数组的下标
			var r = parseInt(Math.random()*arrays.length);
			codes += arrays[r];
		}
	//验证码添加到input里
	code.val(codes);
}
change();
$("#code").click(change);

$("#loginBtn").click(function(){
		
	//以对象模式获取输入的值
	var user = new Object();
	user.loginCode = $.trim($("#loginCode").val());
    user.password = $.trim($("#password").val());
    user.isStart = 1;
    //验证码验证
	//取得验证码并转化为大写
	var inputCode = $("#yanzhengma").val().toUpperCase();
	
    if(user.loginCode == "" || user.loginCode == null){
    	//鼠标焦点放到#loginCode
    	$("#loginCode").focus();
    	//更改样式
    	$("#formtip").css("color","red");
    	//显示提示信息
    	$("#formtip").html("对不起，登录账号不能为空!");
    }else if(user.password == "" || user.password == null){
    	$("#password").focus();
    	$("#formtip").css("color","red");
    	$("#formtip").html("对不起，登录密码不能为空!");
    }else if(inputCode.length == 0){
		//若输入长度为0，则让重新输入验证码
    	$("#yanzhengma").focus();
    	$("#formtip").css("color","red");
    	$("#formtip").html("请输入验证码！");
    	change();
	}else if(inputCode != codes.toUpperCase()){
		//若输入有误，则让重新输入，并刷新生成码，然后清除输入框
		$("#yanzhengma").focus();
    	$("#formtip").css("color","red");
    	$("#formtip").html("验证码输入有误,请重新输入!");
		change();
		$("#yanzhengma").val("");
	}else{
    	//显示空白信息
    	$("#formtip").html("");
    	$.ajax({
    		type:"POST",
    		url:"/user/checkLogin",
    		data:{user:JSON.stringify(user)},
    		dataType:'text',
    		timeout:1000,
    		error:function(){
    			$("#formtip").css("color","red");
    	    	$("#formtip").html("登录失败！请重试。");
    		},
    		success:function(result){
    			if(result != "" && result == "success"){
    				//若登录成功，跳转到"/user/chengGong"
    				window.location.href='/user/success';
    			}else if(result == "error"){
    				//验证失败，提示信息，并置空文本框
    				$("#formtip").css("color","red");
        	    	$("#formtip").html("登录失败！请重试。");
        	    	$("#loginCode").val('');
        	    	$("#password").val('');
    			}else if(result == "nofind"){
    				$("#formtip").css("color","red");
        	    	$("#formtip").html("登录账号不存在！请重试。");
    			}else if(result == "pwderror"){
    				$("#formtip").css("color","red");
        	    	$("#formtip").html("登录密码错误！请重试。");
    			}else if(result == "nodata"){
    				$("#formtip").css("color","red");
        	    	$("#formtip").html("对不起，没有任何数据需要处理！请重试。");
    			}
    		}
    		
    	});
    	
    }
	
});