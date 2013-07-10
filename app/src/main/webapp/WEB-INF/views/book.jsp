<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
	<head>
		<title>Books! Main Page</title>
	</head>

	<body>

		<% if (pageContext.getAttribute("userId") == null) { %>
			<p>Welcome | <a href="./login">Login</a> | <a href="./createaccount">Create Account</a></p>
		<% } else { %>
			<p>Welcome ${sessionId} | <a href="./logout">Logout</a></p>
		<% } %>

		<h1>
			Hello world!  
		</h1>

		<P>The time on the server is ${sessionId}. </P>

	</body>
</html>
