<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="web-spring" uri="http://code.lds.org/web/spring" %>
<web-spring:message-source var="messages" scope="request"/>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<spring:message code="init.siteName" text="git-stack-starter" var="siteName" scope="request" />