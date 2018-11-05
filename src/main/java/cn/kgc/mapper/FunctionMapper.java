package cn.kgc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.kgc.entity.Function;
import cn.kgc.entity.QuanXian;

public interface FunctionMapper {

	/**
	 * 获取主菜单
	 * @param quanXian
	 * @return
	 * @throws Exception
	 */
	public List<Function> getZhuCaiDan(QuanXian quanXian) throws Exception;
	
	/**
	 * 获取子菜单
	 * @param function
	 * @return
	 * @throws Exception
	 */
	public List<Function> getZiCaiDan(Function function) throws Exception;
	
	/**
	 * 获取主菜单
	 * @param function
	 * @return
	 * @throws Exception
	 */
	public List<Function> getZhuFuncList(Function function) throws Exception;
	
	/**
	 * 根据角色id获取功能集合
	 * @param function
	 * @return
	 * @throws Exception
	 */
	public List<Function> getFunctionListByRoId(QuanXian quanXian) throws Exception;
	
	/**
	 * 查询当前角色所拥有的所有功能列表
	 * @param sqlInString
	 * @return
	 * @throws Exception
	 */
	public List<Function> getFunctionListByIn(@Param(value="sqlInString") String sqlInString) throws Exception;
}
