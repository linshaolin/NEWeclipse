package cn.kgc.entity;

import java.util.List;

/**
 *  功能菜单类
 * @author Administrator
 *
 */
public class RoleFunctions {
	private Function mainFunction;
	private List<Function> subFunctions;
	public Function getMainFunction() {
		return mainFunction;
	}
	public void setMainFunction(Function mainFunction) {
		this.mainFunction = mainFunction;
	}
	public List<Function> getSubFunctions() {
		return subFunctions;
	}
	public void setSubFunctions(List<Function> subFunctions) {
		this.subFunctions = subFunctions;
	}
}
