package cn.kgc.entity;

import java.util.Date;
import java.util.List;

/**
 * 实体类--商品套餐类
 * @author ty
 *
 */
public class GoodsPack extends Base {
	
	private String goodsPackCode;
	private String goodsPackName;
	private Integer typeId;//套餐类型id
	private String typeName;
	private Double totalPrice;//套餐总价（系统生成，保存时根据相关商品的优惠价*数量计算生成）
	private Integer state;//状态 1：上架 2：下架
	private String note;//备注说明
	private Integer num;
	private String createdBy;
	private Date createTime;
	private Date lastUpdateTime;
	
	private List<Goods> listGoods;
	
	public List<Goods> getListGoods() {
		return listGoods;
	}
	public void setListGoods(List<Goods> listGoods) {
		this.listGoods = listGoods;
	}
	public String getGoodsPackCode() {
		return goodsPackCode;
	}
	public void setGoodsPackCode(String goodsPackCode) {
		this.goodsPackCode = goodsPackCode;
	}
	public String getGoodsPackName() {
		return goodsPackName;
	}
	public void setGoodsPackName(String goodsPackName) {
		this.goodsPackName = goodsPackName;
	}
	public Integer getTypeId() {
		return typeId;
	}
	public void setTypeId(Integer typeId) {
		this.typeId = typeId;
	}
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	public Double getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(Double totalPrice) {
		this.totalPrice = totalPrice;
	}
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
	}
	public String getCreatedBy() {
		return createdBy;
	}
	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Date getLastUpdateTime() {
		return lastUpdateTime;
	}
	public void setLastUpdateTime(Date lastUpdateTime) {
		this.lastUpdateTime = lastUpdateTime;
	}
}
