<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

	<c:if test="${userId == null}">
		<p><a href="/books">Welcome</a> | <a href="/books/login">Login</a> | <a href="/books/createaccount">Create Account</a></p>
	</c:if>

	<c:if test="${userId != null}">
		<p><a href="/books">Welcome</a>, ${userName} | <a href="/books/logout">Logout</a></p>
	</c:if>