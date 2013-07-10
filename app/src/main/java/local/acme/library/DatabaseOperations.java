package local.acme.library;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DatabaseOperations
{
	private static final Logger logger = LoggerFactory.getLogger(DatabaseOperations.class);

	private static DatabaseConnection connection = new DatabaseConnection();

	/**
	 * Creates a new session that is not associated with any user in the database
	 * and saves it in the database.
	 * 
	 * @return The unique id of the new session.
	 */
	public static String createSession()
	{
		String id = String.valueOf(System.currentTimeMillis());
		connection.executeUpdate("INSERT INTO `session` VALUES ('" + id + "', NULL)");
		return id;
	}

	/**
	 * Returns a session from the database.
	 * 
	 * @param sessionId The unique id of the session to return.
	 * 
	 * return Session with the specified id.
	 */
	public static Session getSession(String id)
	{
		try
		{
			String sql = "SELECT * FROM `session` WHERE `id`='" + id + "'";
			logger.info(sql);
			ResultSet rs = connection.executeQuery(sql);
			rs.next();
			Session result = new Session();
			result.setId(rs.getString("id"));
			result.setUserId(rs.getInt("user_id"));
			return result;
		}

		catch (Exception e)
		{
			return null;
		}
	}

	/**
	 * Associates an existing session with a user.
	 * 
	 * @param sessionId The unique id of the session to update.
	 * @param userId The unique id of the user to associate with the session.
	 */
	public static void updateSession(String sessionId, int userId)
	{
		String sql = "UPDATE `session` SET `user_id`='" + userId + "' WHERE `id`='" + sessionId + "'";
		logger.info(sql);
		connection.executeUpdate(sql);
	}

	/**
	 * Removes an existing session.
	 * 
	 * @param sessionId The unique id of the session to remove.
	 */
	public static void removeSession(String sessionId)
	{
		String sql = "DELETE FROM `session` WHERE `id`='" + sessionId + "'";
		logger.info(sql);
		connection.executeUpdate(sql);
	}

	/**
	 * Creates a new user and saves it in the database.
	 * 
	 * @return The unique id of the new session.
	 */
	public static boolean createUser(User user)
	{
		String sql = "INSERT INTO `user` (`username`, `password`) VALUES ('" + user.getUserName() + "', '" + user.getPassword() + "')";
		logger.info(sql);
		return connection.executeUpdate(sql) == 1;
	}

	/**
	 * Returns an existing user from the database.
	 * 
	 * @param id The unique id of the user to return.
	 */
	public static User getUserById(int id)
	{
		try
		{
			ResultSet rs = connection.executeQuery("SELECT * FROM `user` WHERE `id`='" + id + "'");
			rs.next();
			User result = new User();
			result.setId(rs.getInt("id"));
			result.setUserName(rs.getString("username"));
			result.setPassword(rs.getString("password"));
			result.setAdmin(rs.getInt("is_admin") == 1);
			return result;
		}

		catch (Exception e)
		{
			return null;
		}
	}

	/**
	 * Returns an existing user from the database.
	 * 
	 * @param id The name of the user to return.
	 */
	public static User getUserByName(String userName)
	{
		try
		{
			String sql = "SELECT * FROM `user` WHERE `username`='" + userName + "'";
			logger.info(sql);
			ResultSet rs = connection.executeQuery(sql);
			rs.next();
			User result = new User();
			result.setId(rs.getInt("id"));
			result.setUserName(rs.getString("username"));
			result.setPassword(rs.getString("password"));
			result.setAdmin(rs.getInt("is_admin") == 1);
			return result;
		}

		catch (Exception e)
		{
			return null;
		}
	}

	/**
	 * Finds the books in the database that contain the specified filter.
	 * 
	 * @param filter Filter for the list of books.
	 * 
	 * @return List of matching books.
	 */
	public static List<Book> getBooks(String filter)
	{
		try
		{
			List<Book> result = new ArrayList<Book>();

			String sql = "SELECT * FROM `book`";
			if (!Common.isEmpty(filter)) sql = sql + " WHERE `title` LIKE '%" + filter + "%' OR `authors` LIKE '%" + filter + "%'";
			logger.info(sql);

			ResultSet rs = connection.executeQuery(sql);

			while (rs.next())
			{
				Book book = new Book();
				book.setId(rs.getInt("id"));
				book.setTitle(rs.getString("title"));
				book.setAuthors(rs.getString("authors"));
				book.setDescription(rs.getString("description"));
				book.setTotalCount(rs.getInt("total_count"));
				book.setReservedCount(rs.getInt("reserved_count"));
				book.setBlocked(rs.getInt("is_blocked") == 1);
				result.add(book);
			}

			return result;
		}

		catch (Exception e)
		{
			return null;
		}
	}

	/**
	 * Returns a specific book in the database.
	 * 
	 * @param id The unique id of the book.
	 */
	public static Book getBook(String id)
	{
		try
		{
			String sql = "SELECT * FROM `book` WHERE `id` = " + id;
			logger.info(sql);

			ResultSet rs = connection.executeQuery(sql);

			rs.next();

			Book book = new Book();

			book.setId(rs.getInt("id"));
			book.setTitle(rs.getString("title"));
			book.setAuthors(rs.getString("authors"));
			book.setDescription(rs.getString("description"));
			book.setTotalCount(rs.getInt("total_count"));
			book.setReservedCount(rs.getInt("reserved_count"));
			book.setBlocked(rs.getInt("is_blocked") == 1);

			return book;
		}

		catch (Exception e)
		{
			return null;
		}
	}

	/**
	 * Sets the blocked flag of a book.
	 */
	public static void blockBook(int bookId, boolean flag)
	{
		String sql = null;
		if (flag) sql = "UPDATE `book` SET `is_blocked`=1 WHERE `id`='" + bookId + "'";
		else sql = "UPDATE `book` SET `is_blocked`=0 WHERE `id`='" + bookId + "'";
		logger.info(sql);
		connection.executeUpdate(sql);
	}

	/**
	 * Reserves a book for a user.
	 */
	public static void reserveBook(String bookId, int userId)
	{
		String sql = null;

		if (userId != 0)
		{
			sql = "INSERT INTO `reservation` VALUES ('" + bookId + "', '" + userId + "')";
			logger.info(sql);
			if (connection.executeUpdate(sql) == -1) return;
		}

		sql = "UPDATE `book` SET `reserved_count`=`reserved_count`+1 WHERE `id`='" + bookId + "'";
		logger.info(sql);
		connection.executeUpdate(sql);
	}

	/**
	 * Unreserves a book for a user.
	 */
	public static void unreserveBook(String bookId, int userId)
	{
		String sql = null;

		if (userId != 0)
		{
			sql = "DELETE FROM `reservation` WHERE `book_id`='" + bookId + "' AND `user_id`='" + userId + "'";
			logger.info(sql);
			if (connection.executeUpdate(sql) == -1) return;
		}

		sql = "UPDATE `book` SET `reserved_count`=`reserved_count`-1 WHERE `id`='" + bookId + "'";
		logger.info(sql);
		connection.executeUpdate(sql);
	}
}
