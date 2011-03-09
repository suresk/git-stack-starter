<%@include file="/WEB-INF/views/includes/init.jsp" %>

<div class="ixf-header">
	<div class="ixf-appname">
		<a href="${pageContext['request'].contextPath}/" class="ixf-appname-link"><spring:message code="header.home" text="Home" /></a>
	</div>
	<!-- END ixf-appname -->
	
	<div class="ixf-tools">
		<sec:authorize access="isAuthenticated()">
        	Welcome <sec:authentication property="principal"/>
        </sec:authorize>
	
	</div>
	
	<!-- END ixf-tools -->
	
	<ul class="ixf-nav">
	</ul>
	<!-- END ixf-nav -->
</div>
	
<div class="ixf-subheader">
	<ul class="ixf-subnav">
		<li id="empty"><a href="${pageContext['request'].contextPath}/"><span></span></a></li>
	 </ul> 
	 <!--END ixf-subnav -->
</div>
	
