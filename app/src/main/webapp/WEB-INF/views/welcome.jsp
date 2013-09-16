<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<nav>
	<ul>
		<c:if test="${userId == null}">
			<li><a href="./">Welcome</a></li>
			<li><a href="./login">Login</a></li>
			<li><a href="./createaccount">Create Account</a></li>
		</c:if>
		
		<c:if test="${userId != null}">
			<li><a href="./">Welcome</a>, ${userName}</li>
			<li><a href="./logout">Logout</a></li>
		</c:if>
	</ul>
</nav>