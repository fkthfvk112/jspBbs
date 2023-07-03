package dto;

import java.io.Serializable;

public class UserDto implements Serializable{
	public UserDto(String id, String pwd, String name, String email, int auth) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.email = email;
		this.auth = auth;
	}

	private String id;
	private String pwd;
	private String name;
	private String email;
	private int auth;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmaile() {
		return email;
	}
	public void setEmaile(String email) {
		this.email = email;
	}
	public int getAuth() {
		return auth;
	}
	public void setAuth(int auth) {
		this.auth = auth;
	}
	
	public void printAll() {
		System.out.printf("id : %s \npwd: %s \nname : %s \nemail: %s\nauth: %d \n", id, pwd, name, email, auth);
	}
	
}
