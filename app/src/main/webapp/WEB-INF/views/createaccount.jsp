<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<html>
	<head>
		<title>Books! Create Account</title>
	</head>

	<body>

		<jsp:include page="welcome.jsp" />

		<h1>Books! Create Account</h1>

		<p>${error}</p>

		<form action="./createaccount" method="GET">
			<table>
				<tr>
					<td>Username</td>
					<td><input name="username" /></td>
				</tr>
				<tr>
					<td>Password</td>
					<td><input name="password1" /></td>
				</tr>
				<tr>
					<td>Repeat Password</td>
					<td><input name="password2" /></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><input type="submit" value="Create" /></td>
				</tr>
			</table>
		</form>

	</body>
</html>
