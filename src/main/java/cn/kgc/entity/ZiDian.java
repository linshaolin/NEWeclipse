package cn.kgc.entity;

/**
 * 实体类--字典数据
 * @author Administrator
 *
 */
public class ZiDian extends Base{
	private Integer id;
	private String typeCode;
	private String typeName;
	private Integer valueId;
	private String valueName;
	public ZiDian() {
		// TODO Auto-generated constructor stub
	}
	
	
	public ZiDian(String typeCode) {
		super();
		this.typeCode = typeCode;
	}


	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getTypeCode() {
		return typeCode;
	}
	public void setTypeCode(String typeCode) {
		this.typeCode = typeCode;
	}
	public void currentUser(String typeCode) {
		this.typeCode = typeCode;
	}
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	public Integer getValueId() {
		return valueId;
	}
	public void setValueId(Integer valueId) {
		this.valueId = valueId;
	}
	public String getValueName() {
		return valueName;
	}
	public void setValueName(String valueName) {
		this.valueName = valueName;
	}
	
	
}
