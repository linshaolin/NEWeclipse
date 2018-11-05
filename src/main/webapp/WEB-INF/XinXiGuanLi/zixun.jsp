<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/pages/utilPages/head.jsp"%>
<div>
	<ul class="breadcrumb">
		<li><a href="#">信息管理</a> <span class="divider">/</span></li>
		<li><a href="/zixun/loginZiXunPage">资讯管理</a></li>
	</ul>
</div>
			<div class="row-fluid sortable">		
				<div class="box span12">
					<div class="box-header well" data-original-title>
						<h2><i class="icon-user"></i> 资讯列表</h2>
						<div class="box-icon">
							<span class="icon32 icon-color icon-add custom-setting addInformation"/>
						</div>
					</div>
					
					<div class="box-content">
						<table class="table table-striped table-bordered bootstrap-datatable datatable">
						  <thead>
							  <tr>
								  <th>标题</th>
								  <th>文件大小</th>
								  <th>状态（发布/不发布）</th>
								  <th>发布者</th>
								  <th>最后修改时间</th>
								  <th>操作</th>
							  </tr>
						  </thead>   
						  <tbody>
						  
						  <c:if test="${page.items != null}">
						  <c:forEach items="${page.items}" var="zixun">
							<tr>
							
								<td class="center">${zixun.title}</td>
								<td class="center">${zixun.fileSize/1000}KB</td>
								<td class="center">
									<input type="checkbox" title="直接勾选修改状态，立即生效" data-rel="tooltip" class="modifyInformationState" inforstate="${zixun.state}" inforid="${zixun.id}" <c:if test="${zixun.state == 1}">checked="true"</c:if>/>
								</td>
								<td class="center">${zixun.publisher}</td>
								<td class="center"><fmt:formatDate value="${zixun.publishTime}" pattern="yyyy-MM-dd"/></td>
								<td class="center">
									<a class="btn btn-success viewinformation" href="#" id="${zixun.id}" title="${zixun.title}">
										<i class="icon-zoom-in icon-white"></i>  
										查看                                           
									</a>
									<a class="btn btn-info modifyinformation" href="#" id="${zixun.id}" title="${zixun.title}">
										<i class="icon-edit icon-white"></i>  
										修改                                            
									</a>
									<a class="btn btn-danger delinformation" href="#" id="${zixun.id}" title="${zixun.title}">
										<i class="icon-trash icon-white"></i> 
										删除
									</a>
								</td>
							</tr>
						  </c:forEach>
						 </c:if>
						  </tbody>
					  </table>   
					<div class="pagination pagination-centered">
					 <div id="tianye-zuo" style="float: left; padding-top: 8px; padding-left: 130px; font-size: 15px; color: blue;">共${page.zongShu }条资讯  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  ${page.page }/${page.zongYeShu }页</div>
					  <ul>
					  <c:choose>
					  	<c:when test="${page.page == 1}">
					  	<li class="active"><a href="javascript:void();" title="首页">首页</a></li>
					  	</c:when>
					  	<c:otherwise>
					  	<li><a href="/zixun/loginZiXunPage?currentpage=1" title="首页">首页</a></li>
					  	</c:otherwise>
					  </c:choose>
						
						<c:if test="${page.prevPages!=null}">
							<c:forEach items="${page.prevPages}" var="num">
								<li><a href="/zixun/loginZiXunPage?currentpage=${num}"
									class="number" title="${num}">${num}</a></li>
							</c:forEach>
						</c:if>
						<li class="active">
						  <a href="#" title="${page.page}">${page.page}</a>
						</li>
						<c:if test="${page.nextPages!=null}">
							<c:forEach items="${page.nextPages}" var="num">
								<li><a href="/zixun/loginZiXunPage?currentpage=${num}" title="${num}">
								${num} </a></li>
							</c:forEach>
						</c:if>
						<c:if test="${page.zongYeShu !=null}">
							<c:choose>
						  	<c:when test="${page.page == page.zongYeShu}">
						  	<li class="active"><a href="javascript:void();" title="尾页">尾页</a></li>
						  	</c:when>
						  	<c:otherwise>
						  	<li><a href="/zixun/loginZiXunPage?currentpage=${page.zongYeShu}" title="尾页">尾页</a></li>
						  	</c:otherwise>
						    </c:choose>
					    </c:if>
						<c:if test="${page.zongYeShu == null}">
						<li class="active"><a href="javascript:void();" title="尾页">尾页</a></li>
					  	</c:if>
					  </ul>
					  <div id="tianye-you" style="float: right; padding-top: 3px; margin-right: 250px; font-size: 15px; color: blue;">
					  	<form action="/zixun/loginZiXunPage" method="post">
					  	跳转至&nbsp;<input type="text" name="tiaoZhuanYe" value="请输入需跳转的页数" style="width: 150px;" onblur="if(this.value==''){this.value='请输入需跳转的页数'}" onfocus="if(this.value=='请输入需跳转的页数'){this.value=''}"/>&nbsp;页 &nbsp;&nbsp;
					  	<button type="submit" class="btn btn-primary"> GO </button>
					  	</form>
					  </div>
				  </div>
				</div>
			</div><!--/span-->
		</div><!--/row-->

	<div class="modal hide fade" id="addInformationDiv">
		<form action="/zixun/addZiXun" enctype="multipart/form-data" method="post" onsubmit="return addInfoFunction();">
			<div class="modal-header">
				<button type="button" class="close addusercancel" data-dismiss="modal">×</button>
				<h3>添加资讯信息</h3>
			</div>
			<div class="add_information_modal-body">
				<ul id="add_formtip"></ul>
				<ul class="topul">
					<li>
					  <label>标题：</label><input id="informationTitle" type="text" name="title" value=""/>
					</li>
					<li>
					  <label>资讯类型：</label>
					  <select id="docType" name="typeId" style="width:100px;">
					 			<option value="" selected="selected">--请选择--</option>
					 			<c:if test="${ziDianList != null}">
					 				<c:forEach items="${ziDianList}" var="ziDian">
					 					<option value="${ziDian.id}">${ziDian.valueName}</option>
					 				</c:forEach>
					 			</c:if>
					 		</select>
					</li>
				</ul>
				<div class="clear"></div>
				<ul class="downul">
					<li>
						<span>上传附件：</span><input id="uploadInformationFile" name="uploadInformationFile" type="file" /> <input type="button" id="informationuploadbtn" value="上传"/>
						<span style="color:red;font-weight: bold;">*注：上传大小不得超过 500M</span>
					 	<input type="hidden" id="uploadfilepathhide" name="filePath" />
					 	<input type="hidden" id="uploadfilenamehide" name="fileName" />
					 	<input type="hidden" id="typeNamehide" name="typeName" />
					 	<input type="hidden" id="fileSizehide" name="fileSize" />
					 </li>
					 <li id="filearea">
					 	
					 </li>
				</ul>
				<ul class="downul">
					<li>
					<span>资讯内容：</span> <br/><textarea class="cleditor" id="informationContent" name="content" rows="3"></textarea>
					 </li>
				</ul>
			</div>
			<div class="modal-footer">
				<a href="#" class="btn addinfocancel" data-dismiss="modal">取消</a>
				<input type="submit"  class="btn btn-primary" value="保存" />
			</div>
		</form>
	 </div>
	 
	 <div class="modal hide fade" id="modifyInfoDiv">
		<form action="/zixun/updateZiXun" enctype="multipart/form-data" method="post" onsubmit="return modifyInfoFunction();">
			<div class="modal-header">
				<button type="button" class="close addusercancel" data-dismiss="modal">×</button>
				<h3>修改资讯信息</h3>
			</div>
			<div class="add_information_modal-body">
				<ul id="modify_formtip"></ul>
				<ul class="topul">
					<li>
					  <label>标题：</label><input id="informationTitleModify" type="text" name="title" value=""/>
					</li>
					<li>
					  <label>资讯类型：</label>
					  <select id="docTypeModity" name="typeId" style="width:100px;"></select>
					</li>
				</ul>
				<div class="clear"></div>
				<ul class="downul">
					<li>
						<span>上传附件：</span><input id="uploadInformationFileM" name="uploadInformationFile" type="file" /> <input type="button" id="informationuploadMbtn" value="上传"/>
					 	<span style="color:red;font-weight: bold;">*注：上传大小不得超过 500M</span>
					 	<input type="hidden" id="infoIdModify" name="id"/>
					 	<input type="hidden" id="uploadfilepathhideM" name="filePath" />
					 	<input type="hidden" id="uploadfilenamehideM" name="fileName" />
					 	<input type="hidden" id="typeNamehideM" name="typeName" />
					 	<input type="hidden" id="fileSizehideM" name="fileSize" />
					 </li>
					 <li id="fileareaM">
					 	
					 </li>
				</ul>
				<ul class="downul">
					<li id="modifyinformationli">
					 </li>
				</ul>
			</div>
			<div class="modal-footer">
				<a href="#" class="btn modifyinfocancel" data-dismiss="modal">取消</a>
				<input type="submit"  class="btn btn-primary" value="保存" />
			</div>
		</form>
	 </div>
	 
	 <div class="modal hide fade" id="viewInfoDiv">
			<div class="modal-header">
				<button type="button" class="close addusercancel" data-dismiss="modal">×</button>
				<h3>查看资讯信息</h3>
			</div>
			
			
			<div class="view_information_modal-body">
				<ul class="viewinformationul" id="viewContent">
				</ul>
				<div class="clear"></div>
			</div>
			
			
			
			
			<div class="modal-footer">
				<a href="#" class="btn" data-dismiss="modal">关闭</a>
			</div>
	 </div>
	 
	 
	 
<%@include file="/WEB-INF/pages/utilPages/foot.jsp"%>
<script type="text/javascript">
	var dicJson =	[<c:forEach  items="${ziDianList}" var="ziDian"> 
							{"valueId":"${ziDian.id}","valueName":"${ziDian.valueName}"},
							</c:forEach>{"valueId":"over","valueName":"over"}];
</script>
<script type="text/javascript" src="/statics/localjs/zixun.js"></script> 
