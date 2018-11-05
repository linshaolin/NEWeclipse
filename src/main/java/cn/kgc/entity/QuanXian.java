package cn.kgc.entity;

import java.util.Date;

/**
 * 权限类（功能与角色对应表）
 * @author ty
 *
 */
public class QuanXian extends Base{
	
	private int roleId;
	private int functionId; //功能id
	private int userTypeId; //用户id
	private Date creationTime; //创建时间
	private String createdBy;	//创建人
	
	public String getCreatedBy() {
		return createdBy;
	}
	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}
	public int getRoleId() {
		return roleId;
	}
	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}
	public int getFunctionId() {
		return functionId;
	}
	public void setFunctionId(int functionId) {
		this.functionId = functionId;
	}
	public int getUserTypeId() {
		return userTypeId;
	}
	public void setUserTypeId(int userTypeId) {
		this.userTypeId = userTypeId;
	}
	public Date getCreationTime() {
		return creationTime;
	}
	public void setCreationTime(Date creationTime) {
		this.creationTime = creationTime;
	}
	

}
