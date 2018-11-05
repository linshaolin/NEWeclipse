package cn.kgc.entity;

import java.util.Date;

public class Goods {
	private int id;
	private String goodsSN;
	private String goodsName;
	private String goodsFormat;//商品规格
	private Double marketPrice;//市场价
	private Double realPrice;//优惠价
	private Integer state;//状态 1：上架 2：下架
	private String note;//商品说明
	private Integer goodsNum;//库存数量
	private String unit;//单位
	private Date createTime;//创建时间
	private Date lastUpdateTime;//最后更新时间
	private String createdBy;//创建人
	private Integer goodsPackId;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getGoodsName() {
		return goodsName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	public Double getMarketPrice() {
		return marketPrice;
	}
	public void setMarketPrice(Double marketPrice) {
		this.marketPrice = marketPrice;
	}
	public Double getRealPrice() {
		return realPrice;
	}
	public void setRealPrice(Double realPrice) {
		this.realPrice = realPrice;
	}
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	public Integer getGoodsNum() {
		return goodsNum;
	}
	public void setGoodsNum(Integer goodsNum) {
		this.goodsNum = goodsNum;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public String getCreatedBy() {
		return createdBy;
	}
	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}
	public Integer getGoodsPackId() {
		return goodsPackId;
	}
	public void setGoodsPackId(Integer goodsPackId) {
		this.goodsPackId = goodsPackId;
	}
	public String getGoodsSN() {
		return goodsSN;
	}
	public void setGoodsSN(String goodsSN) {
		this.goodsSN = goodsSN;
	}
	public String getGoodsFormat() {
		return goodsFormat;
	}
	public void setGoodsFormat(String goodsFormat) {
		this.goodsFormat = goodsFormat;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public Date getLastUpdateTime() {
		return lastUpdateTime;
	}
	public void setLastUpdateTime(Date lastUpdateTime) {
		this.lastUpdateTime = lastUpdateTime;
	}
	@Override
	public String toString() {
		return "GoodsInfo [goodsSN=" + goodsSN + ", goodsName=" + goodsName + ", goodsFormat=" + goodsFormat
				+ ", marketPrice=" + marketPrice + ", realPrice=" + realPrice + ", state=" + state + ", note=" + note
				+ ", goodsNum=" + goodsNum + ", unit=" + unit + ", createTime=" + createTime + ", lastUpdateTime="
				+ lastUpdateTime + ", createdBy=" + createdBy + ", goodsPackId=" + goodsPackId + "]";
	}
	
	
	

}
