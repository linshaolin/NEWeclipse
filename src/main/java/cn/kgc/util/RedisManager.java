package cn.kgc.util;

import java.io.Serializable;
import java.util.Set;

import org.apache.shiro.dao.DataAccessException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.connection.RedisConnection;
import org.springframework.data.redis.core.RedisCallback;
import org.springframework.data.redis.core.RedisTemplate;

import com.alibaba.druid.util.StringUtils;

public class RedisManager {

    private RedisTemplate<Serializable, Serializable> redisTemplate;
    
    

    public void setRedisTemplate(RedisTemplate<Serializable, Serializable> redisTemplate) {
		this.redisTemplate = redisTemplate;
	}

	/**
     * ��ӻ������ݣ�����key�Ѵ��ڣ����и��ǣ�
     * @param key
     * @param obj
     * @throws DataAccessException
     */
    public <T> void set(String key, T obj) throws DataAccessException{
        final byte[] bkey = key.getBytes();
        final byte[] bvalue = SerializerUtil.serialize(obj);
        redisTemplate.execute(new RedisCallback<Void>() {
            @Override
            public Void doInRedis(RedisConnection connection) throws DataAccessException {
                connection.set(bkey, bvalue);
                return null;
            }
        });
    }

    /**
     * ��ӻ������ݣ�����key�Ѵ��ڣ������и��ǣ�ֱ�ӷ���false��
     * @param key
     * @param obj
     * @return �����ɹ�����true�����򷵻�false
     * @throws DataAccessException
     */
    public <T> boolean setNX(String key, T obj) throws DataAccessException{
        final byte[] bkey = key.getBytes();
        final byte[] bvalue = SerializerUtil.serialize(obj);
        boolean result = redisTemplate.execute(new RedisCallback<Boolean>() {
            @Override
            public Boolean doInRedis(RedisConnection connection) throws DataAccessException {
                return connection.setNX(bkey, bvalue);
            }
        });

        return result;
    }

    /**
     * ��ӻ������ݣ��趨����ʧЧʱ��
     * @param key
     * @param obj
     * @param expireSeconds ����ʱ�䣬��λ ��
     * @throws DataAccessException
     */
    public <T> void setEx(String key, T obj, final long expireSeconds) throws DataAccessException{
        final byte[] bkey = key.getBytes();
        final byte[] bvalue = SerializerUtil.serialize(obj);
        redisTemplate.execute(new RedisCallback<Boolean>() {
            @Override
            public Boolean doInRedis(RedisConnection connection) throws DataAccessException {
                connection.setEx(bkey, expireSeconds, bvalue);
                return true;
            }
        });
    }

    /**
     * ��ȡkey��Ӧvalue
     * @param key
     * @return
     * @throws DataAccessException
     */
    public <T> T get(final String key) throws DataAccessException{
        byte[] result = redisTemplate.execute(new RedisCallback<byte[]>() {
            @Override
            public byte[] doInRedis(RedisConnection connection) throws DataAccessException {
                return connection.get(key.getBytes());
            }
        });
        if (result == null) {
            return null;
        }
        return SerializerUtil.deserialize(result);
    }

    /**
     * ɾ��ָ��key����
     * @param key
     * @return ���ز���Ӱ���¼��
     */
    public Long del(final String key){
        if (StringUtils.isEmpty(key)) {
            return 0l;
        }
        Long delNum = redisTemplate.execute(new RedisCallback<Long>() {
            @Override
            public Long doInRedis(RedisConnection connection) throws DataAccessException {
                byte[] keys = key.getBytes();
                return connection.del(keys);
            }
        });
        return delNum;
    }

    public Set<byte[]> keys(final String key){
        if (StringUtils.isEmpty(key)) {
            return null;
        }
        Set<byte[]> bytesSet = redisTemplate.execute(new RedisCallback<Set<byte[]>>() {
            @Override
            public Set<byte[]> doInRedis(RedisConnection connection) throws DataAccessException {
                byte[] keys = key.getBytes();
                return connection.keys(keys);
            }
        });

        return bytesSet;
    }

}
