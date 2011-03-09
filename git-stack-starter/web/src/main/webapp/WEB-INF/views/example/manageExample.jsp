<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>

<%@taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="sw" uri="http://code.lds.org/security/web" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@include file="/WEB-INF/views/includes/init.jsp" %>

<tags:template>
	<jsp:body>
		<div class="ixf-panel ui-layout-center padding-md">
		
			<spring:hasBindErrors name="example">
				<c:if test="${errors.errorCount > 0}">
					<div class="ixf-alert error">
						<p>${messages['manageExample.errorcheck']}</p>
						<ul>
							<c:forEach items="${errors.allErrors}" var="error">
								<li><spring:message message="${error}"/></li>
							</c:forEach>
						</ul>
					</div>
				</c:if>
			</spring:hasBindErrors>
			<c:if test="${msg == 'created'}">
				<div class="ixf-alert"><p>${messages['manageExample.success']}</p></div>
			</c:if>
			
			<h1>${messages['manageExample.manageexamples']}</h1>
			<div class="grid-33">
				<p>${messages['manageExample.examplemessage']}</p>
				<form:form commandName="example" cssClass="ixf-form table" acceptCharset="UTF-8" method="post">
					<spring:bind path="name">
						<dl class="${status.error ? 'error' : ''}">
							<dt><label for="name"><span title="${status.error ? 'error' : ''}" class="${status.error ? 'error' : ''}-indicator">${status.error ? '!' : ''}</span>${messages['manageExample.name']}</label></dt>
							<dd><form:input cssClass="text" path="name"/></dd>
						</dl>
					</spring:bind>
					<spring:bind path="data">
						<dl class="${status.error ? 'error' : ''}">
							<dt><label for="data"><span title="${status.error ? 'error' : ''}" class="${status.error ? 'error' : ''}-indicator">${status.error ? '!' : ''}</span>${messages['manageExample.data']}</label></dt>
							<dd><form:input cssClass="text" path="data"/></dd>
						</dl>
					</spring:bind>
					<dl>
						<dt>&nbsp;</dt>
						<dd><a href="#" id="createExample" onclick="$(this).parents('form').submit();" class="ixf-button"><span>${messages['manageExample.createexample']}</span></a></dd>
					</dl>
				</form:form>
			</div>
			
			<div class="grid-66 last">
				<c:choose>
					<c:when test="${fn:length(examples) == 0}">
						${messages['manageExample.nonefound']}
					</c:when>
					<c:otherwise>
			 			<table id="exampleModelsGrid" class="ixf-table ixf-fixed" border="1" cellspacing="0" cellpadding="0" >
							<thead>
								<tr>
									<th>${messages['manageExample.header.name']}</th>
									<th>${messages['manageExample.header.data']}</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${examples}" var="example" >
									<tr>
										<td>${sw:encodeHtml(example.name)}</td>
										<td>${sw:encodeHtml(example.data)}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</c:otherwise>
				</c:choose>
			</div>
			
		</div>
	</jsp:body>
</tags:template>