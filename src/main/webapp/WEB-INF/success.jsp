<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/pages/utilPages/head.jsp" %>
			<div class="row-fluid sortable">
				<div class="box span12">
					<div class="box-header well" data-orginal-title>
						<h2><i class="icon-th"></i> 公告栏</h2>
						<div class="box-icon">
							<a style="display:block;width:60px;padding-right:1px;font-size:14px;" href="/gonggao/shouYeGongGaoList">更多 >></a>
						</div>
					</div>
					<div class="box-content">
						 <table style="width:100%;">
						  <c:if test="${gongGaoList != null}">
						  <c:forEach items="${gongGaoList}" var="gonggao">
							<tr>
								<td style="width:20px;padding:3px;"><span class="icon icon-color icon-info"/></td>
								<td style=""><a href="/gonggao/shouYeGongGao?id=${gonggao.id}">${gonggao.title}</a></td>
								<td style="width:80px;"><fmt:formatDate value="${gonggao.publishTime}" pattern="yyyy-MM-dd"/></td>
							</tr>
						  </c:forEach>
						 </c:if> 
					  </table>  
					</div>
				</div><!--/span-->
			</div>		

		  <div class="row-fluid sortable">
				<div class="box span12">
					<div class="box-header well" data-orginal-title>
						<h2><i class="icon-file"></i> 资讯栏</h2>
						<div class="box-icon">
							<a style="display:block;width:60px;padding-right:1px;font-size:14px;" href="/zixun/shouYeZiXunList">更多 >></a>
						</div>
					</div>
					<div class="box-content">
						<table style="width:100%;">
						  <c:if test="${ziXunList != null}">
						  <c:forEach items="${ziXunList}" var="zixun">
							<tr>
								<td style="width:20px;padding:3px;"><span class="icon icon-color icon-info"/></td>
								<td style=""><a href="/zixun/shouYeZiXun?id=${zixun.id}">${zixun.title}</a></td>
								<td style="width:80px;"><fmt:formatDate value="${zixun.publishTime}" pattern="yyyy-MM-dd"/></td>
							</tr>
						  </c:forEach>
						 </c:if>
					  </table> 
					</div>
				</div><!--/span-->
			</div>	
       
			</div>	<!-- content ends -->
			</div><!--/#content.span10-->
				</div><!--/fluid-row-->
				
	

<%@include file="/WEB-INF/pages/utilPages/foot.jsp" %>
    