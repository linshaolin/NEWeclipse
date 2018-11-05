package cn.kgc.entity;

/**
 * 实体类的父类，提供一些公用的属性
 * @author ty
 *
 */
public class Base {
	
	private Integer id;
	private Integer starNum;//分页的开始行
	private Integer pageSize;//每页显示多少行

	public Integer getStarNum() {
		return starNum;
	}
	public void setStarNum(Integer starNum) {
		this.starNum = starNum;
	}
	public Integer getPageSize() {
		return pageSize;
	}
	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
}
