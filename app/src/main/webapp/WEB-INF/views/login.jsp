<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
	<head>
		<title>Books! Login</title>
	</head>

	<body>

		<jsp:include page="welcome.jsp" />

		<h1>Books! Login</h1>

		<p>${error}</p>

		<form action="/books/login" method="GET">
			<table>
				<tr>
					<td>Username</td>
					<td><input name="username" /></td>
				</tr>
				<tr>
					<td>Password</td>
					<td><input name="password" /></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><input type="submit" value="Login" /></td>
				</tr>
			</table>
		</form>

	</body>
</html>
