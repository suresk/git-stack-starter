<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page isErrorPage="true" import="java.io.*" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="web" uri="http://code.lds.org/web" %>
<%@ include file="/WEB-INF/views/includes/init.jsp" %>

<tags:template>
	<jsp:body>
		<div class="ixf-panel ui-layout-center padding-md">
			<h2>${messages['generalError.erroroccurred']}</h2>
			<p>
				${messages['generalError.apology']}
			</p>
			<c:if test="<%=Boolean.valueOf(System.getProperty(\"view.showExceptions\"))%>">
				<web:display-exception />
			</c:if>
		</div>
	</jsp:body>
</tags:template>