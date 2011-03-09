<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@include file="/WEB-INF/views/includes/init.jsp" %>

<%@taglib prefix="tags" tagdir="/WEB-INF/tags" %>


<tags:template>
	<jsp:body>
		<div class="ixf-panel ui-layout-center padding-md">
			<p>${messages['index.welcome']}</p>
			<p><a href="example">${messages['index.managemodels']}</a></p>
		</div>
	</jsp:body>
</tags:template>