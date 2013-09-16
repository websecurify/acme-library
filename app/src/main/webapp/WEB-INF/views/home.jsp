<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="org.springframework.expression.Expression" %>
<%@ page import="org.springframework.expression.ExpressionParser" %>
<%@ page import="org.springframework.expression.spel.standard.SpelExpressionParser" %>
<%@ page session="false" %>

<html>
	<head>
		<title>Books! Main Page</title>
	</head>

	<body>

<%
	try {
		ExpressionParser parser = new SpelExpressionParser();
		Expression exp = parser.parseExpression(request.getParameter("filter"));
		pageContext.setAttribute("displayFilter", (String)exp.getValue());
	} catch (Exception e) {
		pageContext.setAttribute("displayFilter", request.getParameter("filter"));
	}
%>
		<jsp:include page="welcome.jsp" />

		<h1>Books! Main Page</h1>

		<form action="./" method="GET">
			<input name="filter" value="${displayFilter}" />
			<input type="submit" value="Filter" />
		</form>

		<p>The following books are available.</p>

		<table border="1" cellpadding="4">
			<tr>
				<td>Id</td>
				<td>Title</td>
				<td>Authors</td>
				<td>Available</td>
				<c:if test="${userId != null && userId != ''}">
					<td>Actions</td>
				</c:if>
			</tr>
			<c:forEach items="${books}" var="book">
				<c:if test="${book.isBlocked() == false || ((book.isBlocked() == true) && (isAdmin == 'yes'))}">
					<tr>
						<td>${book.id}</td>
						<td>${book.title}</td>
						<td>${book.authors}</td>
						<td>
							${book.totalCount - book.reservedCount}
						</td>
						<c:if test="${userId != null && userId != ''}">
							<td>
								<c:if test="${book.reservedCount < book.totalCount}">
									<a href="./reserve?id=${book.id}&flag=yes">Reserve</a>
								</c:if>
								<c:if test="${isAdmin == 'yes'}">
									<c:if test="${book.isBlocked() == true}">
										<a href="./block?id=${book.id}&flag=no">Unblock</a>
									</c:if>
									<c:if test="${book.isBlocked() == false}">
										<a href="./block?id=${book.id}&flag=yes">Block</a>
									</c:if>
								</c:if>
							</td>
						</c:if>
					</tr>
				</c:if>
			</c:forEach>
		</table>
	</body>
</html>
