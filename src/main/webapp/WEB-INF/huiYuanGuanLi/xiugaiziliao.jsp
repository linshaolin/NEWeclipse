<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/pages/utilPages/head.jsp"%>

<div>
	<ul class="breadcrumb">
		<li><a href="#">会员管理</a> <span class="divider">/</span></li>
		<li><a href="/updateUser/xiugai">修改本人资料</a></li>
	</ul>
</div>
<!-- 修改用户界面 -->
<div>
<form action="/updateUser/updateUser" enctype="multipart/form-data" method="post" onsubmit="return modifyUserFunction();">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal">×</button>
		<h3>修改用户信息</h3>
	</div>
	<div class="modal-body">
		<ul id="modify_formtip"></ul>
		<input id="m_id" type="hidden" name="id"/>
		<ul class="topul">
			<li>
			  <label>角色：</label>
			  <input id="m_rolename" type="hidden" name="roleName" value=""/>
			  <select id="m_roleId" name="roleId" style="width:100px;">
			  	<option value="${user.roleId }" selected="selected">${user.roleName }</option>
			  </select>
			  <span style="color:red;font-weight: bold;">*</span>
			</li>
			<li>
			  <label>会员类型：</label>
			  <input id="m_selectusertypename" type="hidden" name="userTypeName" value=""/>
			  <select id="m_selectusertype" name="userType" style="width:100px;">
			  	<option value="${user.userType }" selected="selected">${user.userTypeName }</option>
	 		  </select>
			</li>
			<li>
			  <label>用户名：</label><input type="text" id="m_logincode" name="loginCode" value="${user.loginCode }" onkeyup="value=value.replace(/[^\w\.\/]/ig,'')"/>
			  <span style="color:red;font-weight: bold;">*</span>
			</li>
			<li>
			  <label>姓名：</label><input type="text" id="m_username" name="userName" value="${user.userName}"/>
			  <span style="color:red;font-weight: bold;">*</span>
			</li> 
			<li>
			  <label>性别：</label>
 			  <select id="m_sex" name="sex" style="width:100px;">
 			  	<option value="${user.sex }" selected="selected">${user.sex }</option>
			  </select>
			</li> 
			<li>
			  <label>证件类型：</label>
			  <input id="m_cardtypename" type="hidden" name="cardTypeName" value=""/>
			  <select id="m_cardtype" name="cardType" style="width:100px;">
			  	<option value="${user.cardType}" selected="selected">${user.cardTypeName }</option>
			  <c:if test="${user.cardType != null }">
			  	<c:forEach items="${ziDianList }" var="item">
			  		<option value="${item.valueId }">${item.valueName }</option>
			  	</c:forEach>
			  </c:if>
			  </select>
			  <span style="color:red;font-weight: bold;">*</span>
			</li>
			<li>
			  <label>证件号码：</label><input type="text" id="m_idcard" name="idCard" value="${user.idCard }" onkeyup="value=value.replace(/[^\w\.\/]/ig,'')"/>
			  <span style="color:red;font-weight: bold;">*</span>
			</li>
			<li>
			  <label>生日：</label>
			  <input class="Wdate" id="m_birthday" size="15" name="birthday" readonly="readonly"  type="hidden" value="${user.birthday }" onClick="WdatePicker();"/>
			  <input type="text" class="input-xlarge datepicker" value="<fmt:formatDate value="${user.birthday }" pattern="yyyy-MM-dd" />" id="m_birthday" name="birthday" readonly="readonly"/>
			  
			</li>
			<li>
			  <label>收货国家：</label><input type="text" id="m_country" name="country" value="${user.country }"/>
			</li>
			<li>
			  <label>联系电话：</label><input type="text" id="m_mobile" name="mobile" value="${user.mobile }" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
			  <span style="color:red;font-weight: bold;">*</span>
			</li>
			<li>
			  <label>Email：</label><input type="text" id="m_email" name="email" value="${user.email }"/>
			</li>
			<li>
			  <label>邮政编码：</label><input type="text" id="m_postcode" name="postCode" value="${user.postCode }" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
			</li>
			<li>
			  <label>开户行：</label><input type="text" id="m_bankname" name="bankName" value="${user.bankName }"/>
			  <span style="color:red;font-weight: bold;">*</span>
			</li>
			<li>
			  <label>开户卡号：</label><input type="text" id="m_bankaccount" name="bankAccount" value="${user.bankAccount }" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
			  <span style="color:red;font-weight: bold;">*</span>
			</li>
			<li>
			  <label>开户人：</label><input type="text" id="m_accountholder" name="accountHolder" value="${user.accountHolder }"/>
			  <span style="color:red;font-weight: bold;">*</span>
			</li>
			<li>
			  <label>推荐人：</label><input type="text" id="m_refercode" value="${user.referCode }" readonly="readonly"/>
			</li>
			<li>
			  <label>注册时间：</label>
			  <input type="hidden" id="m_createtime" name="createTime" value="${user.birthday }" readonly="readonly"/>
			  <input type="text" class="input-xlarge datepicker" value="<fmt:formatDate value="${user.createTime }" pattern="yyyy-MM-dd" />" id="m_createtime" name="createTime" readonly="readonly"/>
			  
			</li>
			<li>
			  <label>是否启用：</label>
			  <select id="m_isstart" name="isStart" style="width:100px;">
			  	<c:if test="${user.isStart == 1 }">
			  	<option value="1" selected="selected">启用</option>
			  	<option value="2">不启用</option>
			  	</c:if>
			  	<c:if test="${user.isStart == 2 }">
			  	<option value="1" >启用</option>
			  	<option value="2" selected="selected">不启用</option>
			  	</c:if>
			  </select>
			  <span style="color:red;font-weight: bold;">*</span>
			</li>
			<li class="lastli">
			  <label>收货地址：</label><textarea id="m_useraddress" name="userAddress">${user.userAddress }</textarea>
			</li>
			
		</ul>
		<div class="clear"></div>
		<ul class="downul">
			<li>
			<label>上传身份证图片：</label>
				<input type="hidden" id="m_fileInputIDPath" name="idCardPicPath" value=""/>
				<input id="m_fileInputID" name="m_fileInputID" type="file">
				<c:if test="${user.idCardPicPath == null }">
					<input type="button" id="m_uploadbtnID" value="上传" style="display:none;"/>
					<p><span style="color:red;font-weight: bold;">*注：1、正反面.2、大小不得超过50k.3、图片格式：jpg、png、jpeg、pneg</span></p>
					<div id="m_idPic"></div>
				</c:if>
				<c:if test="${user.idCardPicPath != null }">
					<input type="button" id="m_uploadbtnID" value="上传" />
					<p><span style="color:red;font-weight: bold;">*注：1、正反面.2、大小不得超过50k.3、图片格式：jpg、png、jpeg、pneg</span></p>
					<div id="m_idPic">
					</div>
				</c:if>
			 </li>
		</ul>
		<ul class="downul">
			<li>
			<label>上传银行卡图片：</label>
				<input type="hidden" id="m_fileInputBankPath" name="bankPicPath" value=""/>
				<input id="m_fileInputBank" name="m_fileInputBank" type="file">
				<input type="button" id="m_uploadbtnBank" value="上传"/>
				<p><span style="color:red;font-weight: bold;">*注：1、大小不得超过50k.2、图片格式：jpg、png、jpeg、pneg</span></p>
				<div id="m_bankPic"></div>
			 </li>
		</ul>
	</div>
	
	<div class="modal-footer">
		<a href="#" class="btn modifyusercancel" data-dismiss="modal">取消</a>
		<input type="submit"  class="btn btn-primary" value="保存" />
	</div>
</form>
</div>	

<%@include file="/WEB-INF/pages/utilPages/foot.jsp" %>

<script type="text/javascript">
	//${cardTypeList}
	var cardTypeListJson = [<c:forEach items="${ziDianList}" var="cardType">
							{"valueId":"${cardType.valueId}","valueName":"${cardType.valueName}"},
							</c:forEach>{"valueId":"over","valueName":"over"}];
	
	var roleListJson = 	[<c:forEach items="${roleList}" var="role">
						{"id":"${role.id}","roleName":"${role.roleName}"},
						</c:forEach>{"id":"over","roleName":"over"}];	

</script>

<script src="/statics/localjs/userlist.js"></script>