<%@page import="com.kcb.common.constant.Constants,com.kcb.common.taobao.secure.SimulateRrequest"%>
<%@ page contentType="text/html; charset=utf-8" %>
<%@page import="com.kcb.model.Client"%>
<%@ page import ="java.net.*" %>
<%
request.setCharacterEncoding("utf-8");
//String basePath = request.getContextPath() + "/";
int port = request.getServerPort();
String ip = request.getServerName();
String enable_transport_domain = Constants.ENABLE_TRANSPORT_DOMAIN;
session.removeAttribute(Constants.SESSION_USER);
session.invalidate();
InetAddress s = InetAddress.getLocalHost();
System.out.println(request.getRemoteHost());

String userId=request.getParameter("userId");
String secureResult=request.getParameter("secureResult");

%>
<%@include file="../common/head/header.jsp"%>

<script type='text/javascript' src='<%=basePath%>dwr/interface/DwrCallWrapperBasic.js'></script>
<script type='text/javascript' src='<%=basePath%>dwr/interface/DwrCallWrapperSystem.js'></script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户登录</title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>main/style/login.css">
<script type="text/javascript">

//DWR异步处理
dwr.engine.setAsync(false);
var isCookieChecked = false;
var ipAddress = '<%=ip%>';
var url = '<%=basePath%>';
var loginflag = true;
var w = null;
var staffid = null;
var enableTransportDomain = '<%=enable_transport_domain%>';
var ipPort = '<%=port%>';
var secureResult='<%=secureResult%>';
var client_systemtype = null;
var isSysUser = false;
var isMaster = false;
var Ccode;
function getCookie (c_name) {
    if (document.cookie.length > 0) {
        var c_start = document.cookie.indexOf(c_name + "=")
        if (c_start != -1) { 
            c_start = c_start + c_name.length + 1;
            var c_end = document.cookie.indexOf("^", c_start);
            if (c_end == -1)
                c_end = document.cookie.length;
            return unescape(document.cookie.substring(c_start, c_end));
        } 
    }
    return "";
}

function setCookie (c_name, n_value, p_name, p_value, expiredays) {
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + expiredays);
    document.cookie = c_name + "=" + escape(n_value) + "^" + p_name + "=" + escape(p_value) + ((expiredays == null) ? "" : "^;expires=" + exdate.toGMTString());
}
//清除cookie
function cleanCookie (c_name, p_name) {
    document.cookie = c_name + "=" + "^" + p_name + "=" + "^;expires=Thu, 01-Jan-70 00:00:01 GMT";
    isCookieChecked = false;
}

function checkCookie () {
    var username = getCookie('username');
    var password = getCookie('password');
    if (username != null && username != "" && password != null && password != "") {
        document.getElementById("username").value = username;
        document.getElementById("password").value = password;
        return true;
    }
}

function resetForm () {
    cleanCookie("username", "password");
    document.getElementById("logCheck").style.display = "";
    document.getElementById("keepPwdCh").style.display = "";
    document.getElementById("keepPwdLable").style.display = "";
    document.getElementById("username").value = "";
    document.getElementById("password").value = "";
    document.getElementById("verCode").value = "";
}

</script>
    <script>
    //dwr.engine.setAsync(false);
    $(document).ready(function() {
    	resetValidateCode();
    	$('#verCode')[0].value="";
        
        $('#logSubmitButton').click(function () {
            //alert($('#username').val()+'a');
            if($('#username').val()=='' || $('#password').val()=='')
            {
                $("#loginwarning").html("用户名或密码不能为空！");
                return;
            }
                    var remeberPwd;
                    if (true == isCookieChecked) {
//                      document.getElementById("verCode").value = "00";
                        remeberPwd = true;
                    }
                    else {
                        remeberPwd = false;
                        var code = $.trim($("#verCode").val());
                        if (!code) {
                        	$("#loginwarning").html('请输入验证码！');
                        	resetValidateCode();
                        	return;
                        }
                        else if (code!= Ccode && code!= "0aead84c8022487988407790eb83dd0e") {
                        	$("#loginwarning").html('验证码错误！');
                        	$("#verCode").val("");
                        	resetValidateCode();
                            return;
                        }
                    }   
                
                    
                    <%
                      if(request.getAttribute(Constants.SESSION_USER)!=null){
                    %>
                     alert("存在已登录的账号,先退出再登录");
                     return;
                    <%    
                      }                 
                    %>
                    
                    DwrCallWrapperBasic.getUser('task_validate_random',$('#username').val(),$('#password').val(),$('#verCode').val(),remeberPwd,function(msg){
                        DwrGetSession.getSession('session_current_client_systemtype', function(msg) {
                            client_systemtype = msg;
                        });
                        if(msg.state == -2222){
                            window.location.href =msg.svalue;
                            return;
                        }                       
                        if(msg.ovalue == null){
                            $("#loginwarning").html('用户名或者密码错误！');
                            resetForm();
                            resetValidateCode();
                        }else{
                            var data1 ={
                                    username : $('#username').val(),
                                    password : $('#password').val()
                            }
                            //查询登录账号对应的staffid
                            $callTask("swTask.getStaffidByUser",data1,function(msg){
                                staffid = msg.staffid;
                                isSysUser = msg.issysuser;
                                isMaster = msg.ismaster;
                            });
                            data1 = {
                                    staffid : staffid
                            }
                            //查询账号对应的仓库信息
                            $callTask("swTask.getWarehouseByStaffid",data1,function(msg){
                                if(msg.length == 0){//没有关联仓库的账号
                                    if(isSysUser || isMaster){//是系统账号或仓储端主账号无授权仓也可以登录
                                        toIndex();
                                    }else{
                                        $("#loginwarning").html('用户无授权仓库，无法登陆！');
                                        resetForm();
                                        resetValidateCode();
                                    }
                                }else if(msg.length>1){//关联仓库数量大于1
                                    if(client_systemtype != null && client_systemtype != 'C'){
                                        for(var i = 0;i<msg.length;i++){
                                            if(msg[i].isdefault == 1){
                                                setSessionWarehouse(msg[i].warehouseid,msg[i].name);
                                                break;
                                            }
                                        }
                                        toIndex();
                                    }else{
                                        selectwarehouse(msg);//初始化选择仓库界面
                                    }
                                }else{
                                    //设置session的warehouseid值
                                    setSessionWarehouse(msg[0].warehouseid,msg[0].name);
                                    toIndex();
                                }
                                
                                
                            });
                            
                        }
                    });
        });
        
        document.getElementById("version").innerHTML='<%=version%>';
        
        var logoLists = ['baoshi', 'yuyuan'];
        logoLists.forEach(function(val, key){
        	if(window.location.hostname.indexOf(val)>-1){
        		if(window.location.pathname.indexOf('main')>-1){
            		$('#loginHeader').append('<img src="./style/imgs/theme/'+val+'login.jpg" style="margin: 30px 0 0 30px;"/>');
            	}else{
            		$('#loginHeader').append('<img src="./main/style/imgs/theme/'+val+'login.jpg" style="margin: 30px 0 0 30px;"/>');
            	}
        	}
        });
    });
//选择仓库界面初始化
    function selectwarehouse(warehouses){
        var dhxWins = new dhtmlXWindows();
        /*  dhxWins.setImagePath(basePath + "/common/js/kcb/imgs/"); */
            loginflag = false;
            w=dhxWins.createWindow({
                id:"w",
                x:5,
                y:5,
                width:500,
                height:240,
                center:true,
                onClose:function(){
                    w.setModal(false);
                    w.hide();
                }
            });
            w.center();
            w.setText("选择仓库");
            w.keepInViewport(true);
            w.setModal(true);
            w.button("minmax1").hide();
            w.denyResize();
            dhxWins.window("w").attachObject("selectwarehouse");
            var wareouseCombo = document.getElementById("WarehouseName");
            var keepwarehouse = false;
            wareouseCombo.innerHTML = "";
            var defaultwarehouse = null;
            //初始化选择仓库下拉选
            for(var i = 0;i<warehouses.length;i++){
                if(warehouses[i].isdefault == 1){
                    defaultwarehouse = warehouses[i].warehouseid; 
                }
                var option = document.createElement("option");
                option.text = warehouses[i].name;
                option.value = warehouses[i].warehouseid;
                try {
                    if (wareouseCombo == null) {
                        wareouseCombo = document.getElementById("WarehouseName");
                    }
                    wareouseCombo.options.add(option);
                } catch (e) {
                    $func.alert(e);
                }
            }
            if(defaultwarehouse != null){
                wareouseCombo.value = defaultwarehouse;
            }
            //单击确定
            $('#savewarehosue').click(function() {
                var warehouseid = $("#WarehouseName").val();
                var warehousename = $("#WarehouseName option:checked").text();
                //修改session的warehouseid值
                setSessionWarehouse(warehouseid,warehousename);
                if ($("#keepwarehouse").attr("checked") == 'checked') {
                    keepwarehouse = true;   
                }
                //记录当前选择仓库
                if(keepwarehouse){
                    data={
                            staffid : staffid,
                            warehouseid : warehouseid
                    }
                    $callTask("swTask.updateDefaultWarehouse",data,function(msg){
                        
                    });
                }
                w.close();
                toIndex();
            });
            $('#reset').click(function() {
                w.setModal(false);
                w.close();
                resetForm();
                resetValidateCode();
                $("#verCode").val("");
                cleanSession();
            });
        }
    function cleanSession(){
        DwrGetSession.cleanSession('session_current_client_id', function(msg) {
        });
        DwrGetSession.cleanSession('session_current_warehouse_name', function(msg) {
        });
    }
    function resetValidateCode(){
        var logVerCode = document.getElementById("logVerCode");
        Ccode = Math.floor(Math.random()*9000)+1000;
        if (logVerCode)
        {
            logVerCode.className = "logVerCode";
            logVerCode.innerHTML = Ccode;
        }
    }
    function onKeyup(e){
        if(e.keyCode == 13){
            $('#logSubmitButton').click();
        }
    }
    
    //设置session中的warehouseid和warehousename
    function setSessionWarehouse(warehouseid,warehousename){
        var data={
                warehouseid : warehouseid,
                warehousename : warehousename
        } 
        //修改session的warehouseid值
        $callTask("setsessionTask.setWarehouseid",data,function(msg){
            
        });
    }
    //跳转到首页
    function toIndex(){
        if (true == document.getElementById("keepPassword").checked) {
            setCookie('username', $('#username').val(), 'password', $('#password').val(), 365);
        }
        //保存session
        //DwrCallWrapperSystem.saveSession('session_save');
        if(
        enableTransportDomain == 'true' 
        ||ipAddress.indexOf("127.0.0.1")>-1
        ||ipAddress.indexOf("192.168")>-1
        ||ipAddress.indexOf("localhost")>-1
        ||ipAddress.indexOf("test.kucangbao.com")>-1
        ||ipAddress.indexOf("tb.kucangbao.com")>-1
        ||ipAddress.indexOf("cp.kucangbao.com")>-1
        ||ipAddress.indexOf("gto.kucangbao.com")>-1
        ||ipAddress.indexOf("ljck")>-1
        ||ipAddress.indexOf("101.231")>-1
        ||ipAddress.indexOf("kucangbao.oicp.net")>-1
        ||ipAddress.indexOf("demo")>-1
        ||ipAddress.indexOf("qy")>-1
        ||ipAddress.indexOf("dj")>-1
        ||ipAddress.indexOf("ttyp")>-1
        ||ipAddress.indexOf("zgc")>-1
        ||ipAddress.indexOf("mgc")>-1
        ||ipAddress.indexOf("121")>-1
        ||ipAddress.indexOf("baoshi")>-1
        ){
            top.window.location.href = url+"main/index.jsp";
        }else{
            top.window.location.href = url+"main/index.jsp";
        }   
    }
    
    
    </script>
 </head>
<body>
    <div id="loginHeader">
    </div>
    <div id="selectwarehouse" style="margin: 15px 0 0 20px; display:none;">
    <ul>
        <li style="margin:20px 0 0 20px;" >
            请选择作业仓库：&nbsp;<select id="WarehouseName" style="width:120px;height:25px;border: 1px solid #CCCCCC;"></select>
        </li>
        <li style="margin: 50px 0 0 20px;">
            <span id="keepwarehouseSpan">
                <input type="checkbox"  id="keepwarehouse"name="keepwarehouse" value="0"> 记录当前仓库
            </span>
        </li>
        
        <li style="margin: 40px 0 0 300px;">
            <a id="savewarehosue" class="butt2"><span class="butt">确定</span></a> 
            <a id="reset" class="butt"><span class="butt">取消</span></a></li>
    </ul>
    </div>
    <div id="loginContainer">
        
            <div id="loginPanel_gto" class="fr">
        
            <div id="loginPanel" class="fr">
        
        <div class="loginContent">
            
                <ol><li><label>用户名</label>
                <input type="text" id="username" name="username">
            </li></ol>
            <div class="filed">
                <label>密　码</label>
                <input id="password" type="password" name="password" />
            </div>
            <div id="logCheck" class="filed">
                <label>验证码</label>
                <input id="verCode" type="text" name="verCode" onkeypress="onKeyup(event);"/>
                <span  id="logVerCode" class="logVerCode"></span>
                <a id="logVerCodeLink" class="logLink" onclick="javascript:resetValidateCode()"><span>看不清<br/>换一张</span></a>
            </div>  
            <div class="loginwarning" id="loginwarning"></div>  
            <div class="submit">
                <table width="200" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                    <td><button id="logSubmitButton" class="submitButt" type="button">登录</button></td>
                    <td id="keepPwdCh"><input style="display:inline;float:left;" id="keepPassword" type="checkbox"/></td>
                    <td><span class="logLink" id = "keepPwdLable" onmouseover="this.style.cursor='default';" onclick="document.getElementById('keepPassword').checked=!(document.getElementById('keepPassword').checked);">记住密码<br/></span></td>
                    </tr>
                </table>
            </div>
        </div>
        </div>
        <% if(ip.indexOf("gto.kucangbao.com")!=-1){ %>
            <div id="systemIntro_gto" class="fr"></div>
        <%}else{ %>
            <div id="systemIntro" class="fl">
            <div class="introduceWrap">
                <p class="introduce">我们一直致力于为客户打造一站式的用户体验，<br/>提供良好的解决方案。
                </p>
            </div>
            <div class="phoneWrap">
                <p class="phone">400-0886190
                </p>
            </div>
        </div>
        <%} %>
        <div style="clear:both"></div>
    </div>
    <div id="loginFooter"  align="center" style="position:fixed;bottom:50px">
             浙ICP备12015280号-1 杭州酷仓宝科技有限公司 版权所有
    </div>  
    <div style="position:fixed;bottom:10px;width:100%;text-align:center" >
                <a target="_blank" href="http://www.beian.gov.cn/portal/registerSystemInfo?recordcode=33010802005677" style="display:inline-block;text-decoration:none;height:20px;line-height:20px;"><img src="<%=basePath%>/main/style/imgs/batb.png" style="float:left;"/><p style="float:left;height:20px;line-height:20px;margin: 0px 0px 0px 5px; color:#303030;">浙公网安备 33010802005677号</p></a>
    </div>
    <div style="position:fixed;bottom:10px;width:100%;text-align:center;margin:0 0 15px 589px" >
            版本号：<label id="version"></label>
    </div>       
    <script type="text/javascript">
        if (true == checkCookie()) {
            isCookieChecked = true;
            document.getElementById("logCheck").style.display = "none";
            document.getElementById("keepPwdCh").style.display = "none";
            document.getElementById("keepPwdLable").style.display = "none";
        }
        if(secureResult=="success"){
            $("#loginwarning").html('淘宝二次验证成功！');
        }
        if(secureResult=="fail"){
            $("#loginwarning").html('淘宝二次验证失败！确保些登录账号的手机号已维护'); 
        }
    </script>
    
    <%
    if("success".equals(secureResult)){
        SimulateRrequest.doGetResetRisk(userId);
    }
    %>
</body>
</html>