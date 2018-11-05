<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/pages/utilPages/head.jsp"%>
<div>
	<ul class="breadcrumb">
		<li><a href="/user/success">首页</a> <span class="divider">/</span></li>
		<li><a href="/gonggao/shouYeGongGaoList">公告列表</a></li>
	</ul>
</div>
			<div class="row-fluid sortable">		
				<div class="box span12">
					<div class="box-header well" data-original-title>
						<h2><i class="icon-th"></i> 公告列表</h2>
					</div>
					
					<div class="box-content">
						<table class="table table-striped table-bordered bootstrap-datatable datatable">
						  <thead>
							  <tr>
								  <th width="40px;" class="center"></th>
								  <th class="center">标题</th>
								  <th class="center">发布时间</th>
							  </tr>
						  </thead>   
						  <tbody>
						  
						  <c:if test="${page.items != null}">
						  <c:forEach items="${page.items}" var="gonggao">
							<tr>
							
								<td class="center"><span class="icon32 icon-green icon-document"/></td>
								<td class="center"><a href="/gonggao/shouYeGongGao?id=${gonggao.id}">${gonggao.title}</a></td>
								<td class="center"><fmt:formatDate value="${gonggao.publishTime}" pattern="yyyy-MM-dd"/></td>
							</tr>
						  </c:forEach>
						 </c:if>
						  </tbody>
					  </table>   
					<div class="pagination pagination-centered">
					  <div id="tianye-zuo" style="float: left; padding-top: 8px; padding-left: 130px; font-size: 15px; color: blue;">共${page.zongShu }条公告  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  ${page.page }/${page.zongYeShu }页</div>
					  <ul>
						<c:choose>
					  	<c:when test="${page.page == 1}">
					  	<li class="active"><a href="javascript:void();" title="首页">首页</a></li>
					  	</c:when>
					  	<c:otherwise>
					  	<li><a href="/gonggao/shouYeGongGaoList?currentpage=1" title="首页">首页</a></li>
					  	</c:otherwise>
					   </c:choose>
						<c:if test="${page.prevPages!=null}">
							<c:forEach items="${page.prevPages}" var="num">
								<li><a href="/gonggao/shouYeGongGaoList?currentpage=${num}"
									class="number" title="${num}">${num}</a></li>
							</c:forEach>
						</c:if>
						<li class="active">
						  <a href="#" title="${page.page}">${page.page}</a>
						</li>
						<c:if test="${page.nextPages!=null}">
							<c:forEach items="${page.nextPages}" var="num">
								<li><a href="/gonggao/shouYeGongGaoList?currentpage=${num}" title="${num}">
								${num} </a></li>
							</c:forEach>
						</c:if>
						<c:if test="${page.zongYeShu !=null}">
							<c:choose>
						  	<c:when test="${page.page == page.zongYeShu}">
						  	<li class="active"><a href="javascript:void();" title="尾页">尾页</a></li>
						  	</c:when>
						  	<c:otherwise>
						  	<li><a href="/gonggao/shouYeGongGaoList?currentpage=${page.zongYeShu}" title="尾页">尾页</a></li>
						  	</c:otherwise>
						    </c:choose>
					    </c:if>
						<c:if test="${page.zongYeShu == null}">
						<li class="active"><a href="javascript:void();" title="尾页">尾页</a></li>
					  	</c:if>
					  </ul>
					  <div id="tianye-you" style="float: right; padding-top: 3px; margin-right: 250px; font-size: 15px; color: blue;">
					  	<form action="/gonggao/shouYeGongGaoList" method="post">
					  	跳转至&nbsp;<input type="text" name="tiaoZhuanYe" value="请输入需跳转的页数" style="width: 150px;" onblur="if(this.value==''){this.value='请输入需跳转的页数'}" onfocus="if(this.value=='请输入需跳转的页数'){this.value=''}"/>&nbsp;页 &nbsp;&nbsp;
					  	<button type="submit" class="btn btn-primary"> GO </button>
					  	</form>
					  </div>
				  </div>
				</div>
			</div><!--/span-->
		</div><!--/row-->

	 
<%@include file="/WEB-INF/pages/utilPages/foot.jsp"%>
