package cn.kgc.mapper;

import java.util.List;
import cn.kgc.entity.Goods;

public interface GoodsMapper {
	
	/**
	 * 获取商品集合，根据最后更新时间降序分页显示
	 * @return
	 * @throws Exception
	 */
	public List<Goods> getGoosList(Goods goods) throws Exception;
	
	/**
	 * 获取商品集合，不分页
	 * @param goods
	 * @return
	 * @throws Exception
	 */
	public List<Goods> getGoosListNoFenYe(Goods goods) throws Exception;
	
	/**
	 * 根据id获取商品
	 * @param goods
	 * @return
	 * @throws Exception
	 */
	public Goods getGoodsById(Goods goods) throws Exception;
	
	/**
	 * 获取商品数量
	 * @param goods
	 * @return
	 * @throws Exception
	 */
	public int count(Goods goods) throws Exception;
	
	/**
	 * 修改商品信息
	 * @param goods
	 * @return
	 * @throws Exception
	 */
	public int updateGoods(Goods goods) throws Exception;
	
	/**
	 * 增加商品信息
	 * @param goods
	 * @return
	 * @throws Exception
	 */
	public int addGoods(Goods goods) throws Exception;
	
	/**
	 * 删除商品信息
	 * @param goods
	 * @return
	 * @throws Exception
	 */
	public int deleteGoods(Goods goods) throws Exception;
	
	/**
	 * 根据id查看当前商品是否在套餐内
	 * @param goods
	 * @return
	 * @throws Exception
	 */
	public int isgoodspack(Goods goods) throws Exception;
}
