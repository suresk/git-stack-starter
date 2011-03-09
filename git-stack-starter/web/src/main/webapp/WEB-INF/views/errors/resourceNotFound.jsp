<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@include file="/WEB-INF/views/includes/init.jsp" %>

<tags:template>
	<jsp:body>
		<div class="ixf-panel ui-layout-center padding-md">
			<h2>${messages['resourceNotFound.notfounderror']}</h2>
			<p/>
				${messages['resourceNotFound.sorry']} 
			<p/>
		</div>
	</jsp:body>
</tags:template>