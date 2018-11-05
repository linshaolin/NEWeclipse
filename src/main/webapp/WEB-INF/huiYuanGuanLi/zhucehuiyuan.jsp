<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/pages/utilPages/head.jsp"%>

<div>
	<ul class="breadcrumb">
		<li><a href="#">会员管理</a> <span class="divider">/</span></li>
		<li><a href="/updateUser/zhuce">注册新会员</a></li>
	</ul>
</div>
<!-- 添加用户界面  -->
<div>
	<form action="/updateUser/addUser" method="post" enctype="multipart/form-data" onsubmit="return addUserFunction();">
			<div class="modal-header">
			<button type="button" class="close addusercancel" data-dismiss="modal">×</button>
			<h3>添加用户信息</h3>
			</div>
			<div class="modal-body">
			<ul id="add_formtip"></ul>
			<ul class="topul">
				<li>
				  <label>角色：</label>
				  <input id="selectrolename" type="hidden" name="roleName" value=""/>
				  <select id="selectrole" name="roleId" style="width:100px;">
		 			<option value="" selected="selected">--请选择--</option>
		 			<c:if test="${roleListTrue != null}">
		 				<c:forEach items="${roleListTrue}" var="role">
		 					<option value="${role.id}">${role.roleName}</option>
		 				</c:forEach>
		 			</c:if>
		 		 </select>
		 		 <span style="color:red;font-weight: bold;">*</span>
				</li>
				<li>
				  <label>会员类型：</label>
				  <input id="selectusertypename" type="hidden" name="userTypeName" value=""/>
				  <select id="selectusertype" name="userType" style="width:100px;">
		 			<option value="" selected="selected">--请选择--</option>
		 		 </select>
				</li>
				<li>
				  <label>用户名：</label><input type="text" id="a_logincode" name="loginCode" onkeyup="value=value.replace(/[^\w\.\/]/ig,'')"/>
				  <span style="color:red;font-weight: bold;">*</span>
				</li>
				<li>
				  <label>姓名：</label><input type="text" id="a_username" name="userName" />
				  <span style="color:red;font-weight: bold;">*</span>
				</li> 
				<li>
				  <label>性别：</label>
	 			  <select name="sex" style="width:100px;">
	 			    <option value="" selected="selected">--请选择--</option>
	 				<option value="男">男</option>
	 				<option value="女">女</option>
	 			  </select> 
				</li> 
				<li>
				  <label>证件类型：</label>
				  <input id="selectcardtypename" type="hidden" name="cardTypeName" value=""/>
				  <select id="selectcardtype" name="cardType" style="width:100px;">
		 			<option value="" selected="selected">--请选择--</option>
		 			<c:if test="${ziDianList != null}">
		 				<c:forEach items="${ziDianList}" var="ziDian">
		 					<option value="${ziDian.valueId}">${ziDian.valueName}</option>
		 				</c:forEach>
		 			</c:if>
		 		 </select>
		 		 <span style="color:red;font-weight: bold;">*</span>
				</li>
				<li>
				  <label>证件号码：</label>
				  <input type="text" id="a_idcard" name="idCard" onkeyup="value=value.replace(/[^\w\.\/]/ig,'')"/>
				  <span style="color:red;font-weight: bold;">*</span>
				</li>
				<li>
				  <label>生日：</label>
				  <input class="Wdate" id="a_birthday" size="15" name="birthday" readonly="readonly"  type="text" onClick="WdatePicker();"/>
				  <!--<input type="text" class="input-xlarge datepicker" id="a_birthday" name="birthday" value="" readonly="readonly"/> -->
				</li>
				<li>
				  <label>收货国家：</label><input type="text" name="country" value="中国"/>
				</li>
				<li>
				  <label>联系电话：</label><input type="text" id="a_mobile" name="mobile" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
				  <span style="color:red;font-weight: bold;">*</span>
				</li>
				<li>
				  <label>Email：</label><input type="text" id="a_email" name="email"/>
				</li>
				<li>
				  <label>邮政编码：</label><input type="text" id="a_postCode" name="postCode" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
				</li>
				<li>
				  <label>开户行：</label><input type="text" id="a_bankname" name="bankName"/>
				  <span style="color:red;font-weight: bold;">*</span>
				</li>
				<li>
				  <label>开户卡号：</label><input type="text" id="a_bankaccount" name="bankAccount" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
				  <span style="color:red;font-weight: bold;">*</span>
				</li>
				<li>
				  <label>开户人：</label><input type="text" id="a_accountholder" name="accountHolder"/>
				  <span style="color:red;font-weight: bold;">*</span>
				</li>
				<li>
				  <label>推荐人：</label><input type="text" name="referCode" value="${user.loginCode}" readonly="readonly"/>
				</li>
				<li>
				  <label>注册时间：</label>
				   <input type="text" id="a_cdate"  value="" readonly="readonly"/>
				   </li>
				<li>
				  <label>是否启用：</label>
	 			  <select name="isStart" style="width:100px;">
	 				<option value="1" selected="selected">启用</option>
	 				<option value="2">不启用</option>
	 			  </select> <span style="color:red;font-weight: bold;">*</span>
				</li>
				<li class="lastli">
				  <label>收货地址：</label><textarea id="a_useraddress" name="userAddress"></textarea>
				</li>
				
			</ul>
			<div class="clear"></div>
			<ul class="downul">
				<li>
				<label>上传身份证图片：</label>
					<input type="hidden" id="a_fileInputIDPath" name="idCardPicPath" value=""/>
					<input id="a_fileInputID" name="a_fileInputID" type="file"/>
					<input type="button" id="a_uploadbtnID" value="上传"/>
					<p><span style="color:red;font-weight: bold;">*注：1、正反面.2、大小不得超过50k.3、图片格式：jpg、png、jpeg、pneg</span></p>
					<div id="a_idPic"></div>
				 </li>
			</ul>
			<ul class="downul">
				<li>
				<label>上传银行卡图片：</label>
					<input type="hidden" id="a_fileInputBankPath" name="bankPicPath" value=""/>
					<input id="a_fileInputBank" name="a_fileInputBank" type="file"/>
					<input type="button" id="a_uploadbtnBank" value="上传"/>
					<p><span style="color:red;font-weight: bold;">*注：1、大小不得超过50k.2、图片格式：jpg、png、jpeg、pneg</span></p>
					<div id="a_bankPic"></div>
				 </li>
			</ul>
		</div>
		
		<div class="modal-footer">
			<a href="#" class="btn addusercancel" data-dismiss="modal">取消</a>
			<input type="submit"  class="btn btn-primary" value="提交" onclick="addUserFunction();"/>
		</div>
	</form>	
</div>


<%@include file="/WEB-INF/pages/utilPages/foot.jsp" %>

<script src="/statics/localjs/userlist.js"></script>
