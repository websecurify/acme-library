<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

	<c:if test="${userId == null}">
		<p><a href="./">Welcome</a> | <a href="./login">Login</a> | <a href="./createaccount">Create Account</a></p>
	</c:if>

	<c:if test="${userId != null}">
		<p><a href="./">Welcome</a>, ${userName} | <a href="./logout">Logout</a></p>
	</c:if>