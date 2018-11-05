package cn.kgc.util;

/**
 * 工具类--mybatis 防止sql注入
 * @author ty
 *
 */
public class SqlTools {
	
	/**
	 * mybatis 模糊查询时，防止sql注入（字符替换）
	 * @param key
	 * @return
	 */
	public static String sqlTools(String key){
		if(key.contains("%") || key.contains("_")){
			key = key.replace("\\\\", "\\\\\\\\").replace("\\%", "\\\\%").replace("\\_", "\\\\_");
		}
		return key;
	}
}
