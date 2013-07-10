package local.acme.library;

public class Book
{
	private int id;
	private String title;
	private String authors;
	private String description;
	private int totalCount;
	private int reservedCount;
	private boolean isBlocked;

	public int getId()
	{
		return id;
	}

	public void setId(int id)
	{
		this.id = id;
	}

	public String getTitle()
	{
		return title;
	}

	public void setTitle(String title)
	{
		this.title = title;
	}

	public String getAuthors()
	{
		return authors;
	}

	public void setAuthors(String authors)
	{
		this.authors = authors;
	}

	public String getDescription()
	{
		return description;
	}

	public void setDescription(String description)
	{
		this.description = description;
	}

	public int getTotalCount()
	{
		return totalCount;
	}

	public void setTotalCount(int totalCount)
	{
		this.totalCount = totalCount;
	}

	public int getReservedCount()
	{
		return reservedCount;
	}

	public void setReservedCount(int reservedCount)
	{
		this.reservedCount = reservedCount;
	}

	public boolean isBlocked()
	{
		return isBlocked;
	}

	public void setBlocked(boolean flag)
	{
		this.isBlocked = flag;
	}
}
