package cn.kgc.entity;

import java.util.List;

/**
 * 菜单类
 * @author ty
 *
 */
public class Menu {
	
	//主菜单
	private Function zhuMenu;
	//子菜单
	private List<Function> ziMenus;
	
	public Function getZhuMenu() {
		return zhuMenu;
	}
	public void setZhuMenu(Function zhuMenu) {
		this.zhuMenu = zhuMenu;
	}
	public List<Function> getZiMenus() {
		return ziMenus;
	}
	public void setZiMenus(List<Function> ziMenus) {
		this.ziMenus = ziMenus;
	}

	
}
