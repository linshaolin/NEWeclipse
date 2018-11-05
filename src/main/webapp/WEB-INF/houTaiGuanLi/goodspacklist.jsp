<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/pages/utilPages/head.jsp"%>
<div>
	<ul class="breadcrumb">
		<li><a href="#">后台管理</a> <span class="divider">/</span></li>
		<li><a href="/goodspack/logingoodspackpage">商品套餐管理</a></li>
	</ul>
</div>
			<div class="row-fluid sortable">		
				<div class="box span12">
					<div class="box-header well" data-original-title>
						<h2><i class="icon-user"></i> 商品套餐列表</h2>
						<div class="box-icon">
							<span class="icon32 icon-color icon-add custom-setting addGoodsPack"/>
						</div>
					</div>
					
					<div class="box-content">
						<form action="/goodspack/logingoodspackpage" method="post">
							<div class="searcharea">
							商品套餐名称:
							<input type="text" name="s_goodsPackName" value="${s_goodsPackName}" />
							套餐类型：
							 <select name="s_typeId" style="width:100px;">
					 			<option value="" selected="selected">--请选择--</option>
					 			<c:if test="${ziDianList != null}">
					 				<c:forEach items="${ziDianList}" var="packType">
					 					<option <c:if test="${s_typeId == packType.valueId}">selected = "selected"</c:if>
					 					value="${packType.valueId}">${packType.valueName}</option>
					 				</c:forEach>
					 			</c:if>
					 		</select>
							状态：
							 <select name="s_state" style="width:100px;">
								<option value="" selected="selected">--请选择--</option>
								　　 <c:if test="${s_state == 1}">  
									　　<option value="1" selected="selected">上架</option>
										<option value="2">下架</option>
								　　 </c:if>  
								　　 <c:if test="${s_state == 2}">  
									　    <option value="2" selected="selected">下架</option>
										<option value="1">上架</option>
								 	 </c:if>
								　　  <c:if test="${s_state == null || s_state == ''}">  
									　    <option value="2">下架</option>
										<option value="1">上架</option>
								 	</c:if>
						 	</select>
							<button type="submit" class="btn btn-primary"><i class="icon-search icon-white"></i> 查询 </button>
						</div>
						</form>
					
						<table class="table table-striped table-bordered bootstrap-datatable datatable">
						  <thead>
							  <tr>
								  <th>套餐编号</th>
								  <th>套餐名称</th>
								  <th>套餐总价(元)</th>
								  <th>库存量</th>
								  <th>状态(上架/下架)</th>
								  <th>套餐类型</th>
								  <th>最后更新时间</th>
								  <th>操作</th>
							  </tr>
						  </thead>   
						  <tbody>
						  <c:if test="${page.items != null}">
						  <c:forEach items="${page.items}" var="goodsPack">
							<tr>
								<td class="center">${goodsPack.goodsPackCode}</td>
								<td class="center">${goodsPack.goodsPackName}</td>
								<td class="center">${goodsPack.totalPrice}</td>
								<td class="center">${goodsPack.num}</td>
								<td class="center">
								<input type="checkbox" title="直接勾选修改状态，立即生效" data-rel="tooltip" class="modifystate" state="${goodsPack.state}" goodspackid="${goodsPack.id}" <c:if test="${goodsPack.state == 1}"> checked="true"</c:if>/>
								</td>
								<td class="center">${goodsPack.typeName}</td>
								<td class="center">
								<fmt:formatDate value="${goodsPack.lastUpdateTime}" pattern="yyyy-MM-dd"/>
								</td>
								<td class="center">
									<a class="btn btn-success viewgoodspack" href="#" id="${goodsPack.id}">
										<i class="icon-zoom-in icon-white"></i>  
										查看                                           
									</a>
									<a class="btn btn-info modifygoodspack" href="#" id="${goodsPack.id}">
										<i class="icon-edit icon-white"></i>  
										修改                                            
									</a>
									<a class="btn btn-danger delgoodspack" href="#" id="${goodsPack.id}" goodsPackName="${goodsPack.goodsPackName}">
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
					  <div id="tianye-zuo" style="float: left; padding-top: 8px; padding-left: 130px; font-size: 15px; color: blue;">共${page.zongShu }个套餐  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  ${page.page }/${page.zongYeShu }页</div>
					  <ul>
					  <c:choose>
					  	<c:when test="${page.page == 1}">
					  	<li class="active"><a href="javascript:void();" title="首页">首页</a></li>
					  	</c:when>
					  	<c:otherwise>
					  	<li><a href="/goodspack/logingoodspackpage?currentpage=1&s_goodsPackName=${s_goodsPackName}&s_state=${s_state}&s_typeId=${s_typeId}" title="首页">首页</a></li>
					  	</c:otherwise>
					  </c:choose>
						<c:if test="${page.prevPages!=null}">
							<c:forEach items="${page.prevPages}" var="num">
								<li><a href="/goodspack/logingoodspackpage?currentpage=${num}&s_goodsPackName=${s_goodsPackName}&s_state=${s_state}&s_typeId=${s_typeId}"
									class="number" title="${num}">${num}</a></li>
							</c:forEach>
						</c:if>
						<li class="active">
						  <a href="#" title="${page.page}">${page.page}</a>
						</li>
						<c:if test="${page.nextPages!=null}">
							<c:forEach items="${page.nextPages}" var="num">
								<li><a href="/goodspack/logingoodspackpage?currentpage=${num}&s_goodsPackName=${s_goodsPackName}&s_state=${s_state}&s_typeId=${s_typeId}" title="${num}">
								${num} </a></li>
							</c:forEach>
						</c:if>
						<c:if test="${page.zongYeShu !=null}">
							<c:choose>
						  	<c:when test="${page.page == page.zongYeShu}">
						  	<li class="active"><a href="javascript:void();" title="尾页">尾页</a></li>
						  	</c:when>
						  	<c:otherwise>
						  	<li><a href="/goodspack/logingoodspackpage?currentpage=${page.zongYeShu}&s_goodsPackName=${s_goodsPackName}&s_state=${s_state}&s_typeId=${s_typeId}" title="尾页">尾页</a></li>
						  	</c:otherwise>
						    </c:choose>
					    </c:if>
						<c:if test="${page.zongYeShu == null}">
						<li class="active"><a href="javascript:void();" title="尾页">尾页</a></li>
					  	</c:if>
					  </ul>
					  <div id="tianye-you" style="float: right; padding-top: 3px; padding-left: 100px; margin-right:266px; font-size: 15px; color: blue;">
					  	<form action="/goodspack/logingoodspackpage" method="post">
					  	跳转至&nbsp;<input type="text" name="tiaoZhuanYe" value="请输入需跳转的页数" style="width: 150px;" onblur="if(this.value==''){this.value='请输入需跳转的页数'}" onfocus="if(this.value=='请输入需跳转的页数'){this.value=''}"/>&nbsp;页 &nbsp;&nbsp;
					  		<input type="hidden" value="${s_goodsPackName}" name="s_goodsPackName"/>
					  		<input type="hidden" value="${s_typeId }" name="s_typeId"/>
					  		<input type="hidden" value="${s_state }" name="s_state"/>
					  		<button type="submit" class="btn btn-primary"> GO </button>
					  	</form>
					  </div>
				  </div>
				</div>
			</div><!--/span-->
		</div><!--/row-->
	
<%@include file="/WEB-INF/pages/utilPages/foot.jsp"%>
<script type="text/javascript" src="/statics/localjs/goodspacklist.js"></script> 
