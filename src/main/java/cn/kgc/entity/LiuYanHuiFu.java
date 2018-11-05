package cn.kgc.entity;

import java.util.List;

/**
 * 留言与回复对应类
 * @author Administrator
 *
 */
public class LiuYanHuiFu{
	
	private LiuYan liuYan;
	private List<HuiFu> huiFuList;
	
	public LiuYan getLiuYan() {
		return liuYan;
	}
	public void setLiuYan(LiuYan liuYan) {
		this.liuYan = liuYan;
	}
	public List<HuiFu> getHuiFuList() {
		return huiFuList;
	}
	public void setHuiFuList(List<HuiFu> huiFuList) {
		this.huiFuList = huiFuList;
	}
}
