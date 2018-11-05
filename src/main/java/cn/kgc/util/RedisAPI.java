package cn.kgc.util;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

/**
 * 工具类--redis数据库
 * @author ty
 *
 */
public class RedisAPI {
	
	//redis数据库对象
	private JedisPool jedisPool;

	public JedisPool getJedisPool() {
		return jedisPool;
	}
	public void setJedisPool(JedisPool jedisPool) {
		this.jedisPool = jedisPool;
	}
	
	/**
	 * 返还连接池方法
	 * @param pool
	 * @param jedis
	 */
	public static void retuen(JedisPool pool,Jedis jedis){
		if(null != jedis){
			pool.returnResource(jedis);
		}
	}
	
	/**
	 * redis数据库set方法
	 * @param key
	 * @param value
	 * @return
	 */
	public boolean set(String key,String value){
		Jedis jedis = null;
		//捕获异常
		try {
			jedis = jedisPool.getResource();
			jedis.set(key, value);
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			//打印异常信息
			e.printStackTrace();
		}finally{
			retuen(jedisPool,jedis);
		}
		return false;
	}
	
	/**
	 * 判断是否有key
	 * @param key
	 * @return
	 */
	public boolean exist(String key){
		boolean flag = false;
		Jedis jedis = null;
		//捕获异常
		try {
			jedis = jedisPool.getResource();
			flag = jedis.exists(key);
		} catch (Exception e) {
			// TODO: handle exception
			//打印异常信息
			e.printStackTrace();
		}finally{
			retuen(jedisPool,jedis);
		}
		return flag;
	}
	
	/**
	 * 获取key对应的value
	 * @param key
	 * @return
	 */
	public String get(String key){
		String st = null;
		Jedis jedis = null;
		//捕获异常
		try {
			jedis = jedisPool.getResource();
			st = jedis.get(key);
		} catch (Exception e) {
			// TODO: handle exception
			//打印异常信息
			e.printStackTrace();
		}finally{
			retuen(jedisPool,jedis);
		}
		return st;
	}
}
