<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@include file="/WEB-INF/views/includes/init.jsp" %>
<jsp:directive.attribute name="head" required="false" fragment="true"/>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title><spring:message code="index.mainpage" arguments="${siteName}" text="Main page - {0}"/></title>
		<jsp:include page="/WEB-INF/views/includes/brains.jsp"/>
		<jsp:invoke fragment="head"/>
	</head>
	<body>
		<jsp:include page="/WEB-INF/views/includes/header.jsp"/>
		<div class="ixf-panels">
			<jsp:doBody />
		</div>
	</body>
</html>