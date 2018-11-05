<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/pages/utilPages/head.jsp"%>

<div>
	<ul class="breadcrumb">
		<li><a href="#">会员管理</a> <span class="divider">/</span></li>
		<li><a href="/updateUser/modifypwd">修改本人密码</a></li>
	</ul>
</div>
<div>
	<div class="modal-header" >
		<button type="button" class="close" data-dismiss="modal">×</button>
		<h3 style="text-align: center;">修改密码</h3>
	</div>
	<div class="modal-body" style="text-align:center;">
		<p>
				<label>请输入原密码：</label>
				  <input id="oldpasswordtianye"  type="password" onkeydown="javascript:if(event.keyCode==13) document.getElementById('modifypwstianye').click();">
				  <span style="color:red;font-weight: bold;">*</span>
				<label>请输入新密码：</label>
				  <input id="newpasswordtianye"  type="password" style="margin-left: 110px" onkeydown="javascript:if(event.keyCode==13) document.getElementById('modifypwstianye').click();">
				  <span style="color:red;font-weight: bold;">*新密码必须6位以上</span>
				<label>再次输入新密码：</label>
				  <input id="aginpasswordtianye"  type="password" onkeydown="javascript:if(event.keyCode==13) document.getElementById('modifypwstianye').click();">
				  <span style="color:red;font-weight: bold;">*</span>
		</p>
		<p id="modifypwdtiptianye">
		</p>
	</div>
	<div class="modal-footer" style="text-align: center;">
		<a href="#" class="btn" data-dismiss="modal">取消</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="#" id="modifypwstianye" class="btn btn-primary">修改</a>
	</div>
</div>


<%@include file="/WEB-INF/pages/utilPages/foot.jsp" %>
