$('#a_note').cleditor({ width:730,height:300});

$("#a_typeId").change(function(){
	$("#a_typeName").val($("#a_typeId").find("option:selected").text()) ;
});

/**返回按钮*/
$('.backbtn').click(function(e){
	window.location.href="/goodspack/logingoodspackpage";
});

function addGoods(id,goodsname,rprice){
//	alert(id+"_"+ goodsname +"_"+ rprice+" _");
	var ok = true;
	$(".goodsname").each(function () {  
		title = $(this).html();
        if(goodsname == title){
        	ok = false;
        	return false;
        }
    });  
	if(ok){
		str = "<div id=\"selectdiv\"><label class=\"goodsname\">"+goodsname+"</label>"+
				"<label class=\"goodscount\"><input class=\"finalresult\" goodsid=\""+id+"\" rprice=\""+rprice+"\" type=\"text\" value=\"1\"/></label>"+
						"<label class=\"del\" rprice=\""+rprice+"\"><img src=\"/statics/img/cancel-on.png\"/></label>"+
						"<label class=\"clear\"></label></div>";
		$("#selectgoodslist").append(str);
		var gcount = $(".finalresult").val();
		$(".del").val(gcount);
		var tprice = rprice*gcount;
		var tempprice = $("#a_totalPrice").val();
		$("#a_totalPrice").val(tprice);
		if(tempprice == "" || tempprice == null) tempprice =0;
		tprice = parseInt(tprice) + parseInt(tempprice);
		console.log("tprice------ "+tprice);
		$("#a_totalPrice").val(tprice);
		$('.del').click(function(e){
			$(this).parents("#selectdiv").remove();
			$("#selectgoodslist").change();
		});
	}
}

/**计算套餐总价*/
$("#selectgoodslist").change(function(){
	var totleprice = 0;
	$(".finalresult").each(function () {  
		id = $(this).attr("goodsid");
		rprice = $(this).attr("rprice");
		gcount = $(this).val();
		totleprice = parseInt(totleprice) + parseInt(rprice*gcount);
    });  
	$("#a_totalPrice").val(totleprice);
});

/**验证套餐编号是否重复*/
$("#a_goodsPackCode").blur(function(){
	var agpc = $.trim($("#a_goodsPackCode").val());
	if(agpc != ""){
		$.post("/goodspack/goodspackcodeisexit",{'goodsPackCode':agpc,'id':'-1'},function(result){
			if(result == "repeat"){
				$("#add_formtip").css("color","red");
				$("#add_formtip").html("<li>对不起，该套餐编码已存在。</li>");
				$("#add_formtip").attr("key","1");;
				result = false;
			}else if(result == "failed"){
				alert("操作超时!");
			}else if(result == "only"){
				$("#add_formtip").css("color","green");
				$("#add_formtip").html("<li>该套餐编码可以正常使用。</li>");
				$("#add_formtip").attr("key","0");
			}
		},'html');
	}
});

/**添加套餐表单验证*/
function addGoodsPackFunc(){
	$("#add_formtip").html("");
	var result = true;
	//使用json数据传送商品集合信息
	json = "[";
	$(".finalresult").each(function () {  
		id = $(this).attr("goodsid");
		gcount = $(this).val();
		json = json+"{";
		json = json+"\"id\":\""+id+"\",\"goodsNum\":\""+gcount+"\"";
		json = json+"},";
    });  
	json = json + "]";
	$("#goodsJson").val(json);
	
	if($.trim($("#a_goodsPackName").val()) == "" || $("#a_goodsPackName").val() == null){
		$("#add_formtip").css("color","red");
		$("#add_formtip").append("<li>对不起，套餐名称不能为空。</li>");
		result = false;
	}
	if($.trim($("#a_goodsPackCode").val()) == "" || $("#a_goodsPackCode").val() == null){
		$("#add_formtip").css("color","red");
		$("#add_formtip").append("<li>对不起，套餐编码不能为空。</li>");
		result = false;
	}else{
		if($("#add_formtip").attr("key") == "1"){
			$("#add_formtip").append("<li>对不起，该套餐编码已存在。</li>");
			result = false;
		}
	}
	if($("#a_typeId").val() == ""){
		$("#add_formtip").css("color","red");
		$("#add_formtip").append("<li>对不起，套餐类型不能为空。</li>");
		result = false;
	}
	if($.trim($("#a_num").val()) == "" || $("#a_num").val() == null){
		$("#add_formtip").css("color","red");
		$("#add_formtip").append("<li>对不起，套餐库存量不能为空。</li>");
		result = false;
	}
	if($.trim($("#a_totalPrice").val()) == "" || $("#a_totalPrice").val() == null){
		$("#add_formtip").css("color","red");
		$("#add_formtip").append("<li>对不起，套餐总价不能为空。</li>");
		result = false;
	}
	
	return result;
}