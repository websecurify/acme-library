package local.acme.library;

public class User
{
	private int id;
	private String userName;
	private String password;
	private boolean isAdmin;

	public int getId()
	{
		return id;
	}

	public void setId(int id)
	{
		this.id = id;
	}

	public String getUserName()
	{
		return userName;
	}

	public void setUserName(String username)
	{
		this.userName = username;
	}

	public String getPassword()
	{
		return password;
	}

	public void setPassword(String password)
	{
		this.password = password;
	}

	public boolean isAdmin()
	{
		return isAdmin;
	}

	public void setAdmin(boolean flag)
	{
		this.isAdmin = flag;
	}
}
