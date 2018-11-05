<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/pages/utilPages/head.jsp"%>


			<div class="row-fluid sortable">		
				<div class="box span12">
					<div class="box-header well" data-original-title>
						<h2><i class="icon-th"></i> ${gongGao.title}</h2>
						<div class="box-icon">
							<a href="javascript:window.history.back(-1);"><span class="icon icon-color icon-undo" title="返回" /></i></a>
						</div>
					</div>
					<div class="box-content">
					 	<h1 style="text-align:center;">${gongGao.title}</h1>
					 	<div style="border-bottom:1px solid #ccc;padding:5px;">发布者： ${gongGao.publisher}  发布时间：<fmt:formatDate value="${gongGao.publishTime}" pattern="yyyy-MM-dd"/></div>
					 	<p style="padding:100px;">
					 		${gongGao.content}
					 	</p>
					 </div>
					</div><!--/span-->
				</div><!--/row-->
				
<%@include file="/WEB-INF/pages/utilPages/foot.jsp"%>
