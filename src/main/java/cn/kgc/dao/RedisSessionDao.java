package cn.kgc.dao;

import java.io.Serializable;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

import org.apache.shiro.session.Session;
import org.apache.shiro.session.UnknownSessionException;
import org.apache.shiro.session.mgt.eis.AbstractSessionDAO;

import cn.kgc.util.RedisManager;
import cn.kgc.util.SerializerUtil;

public class RedisSessionDao extends AbstractSessionDAO{

	private RedisManager redisManager;

    /** 
     * The Redis key prefix for the sessions  
     */  
    private static final String KEY_PREFIX = "shiro_redis_session:"; 

    @Override
    public void update(Session session) throws UnknownSessionException {
        this.saveSession(session);
    }

    @Override
    public void delete(Session session) {
        if (session == null || session.getId() == null) {
            return;
        }
        redisManager.del(KEY_PREFIX + session.getId());
    }

    @Override
    public Collection<Session> getActiveSessions() {
        Set<Session> sessions = new HashSet<Session>();  
        Set<byte[]> keys = redisManager.keys(KEY_PREFIX + "*");  
        if(keys != null && keys.size()>0){  
            for(byte[] key : keys){  
                Session s = (Session)SerializerUtil.deserialize(redisManager.get(SerializerUtil.deserialize(key)));  
                sessions.add(s);  
            } 
        }
        return sessions;  
    }

    @Override
    protected Serializable doCreate(Session session) {
        Serializable sessionId = this.generateSessionId(session);
        this.assignSessionId(session, sessionId);
        this.saveSession(session);
        return sessionId;
    }

    @Override
    protected Session doReadSession(Serializable sessionId) {
         if(sessionId == null){  
                return null;  
            }  

            Session s = (Session)redisManager.get(KEY_PREFIX + sessionId);  
            return s;  
    }

    private void saveSession(Session session) throws UnknownSessionException{
        if (session == null || session.getId() == null) {
            return;
        }
        //设置过期时间
        long expireTime = 1800000l;
        session.setTimeout(expireTime);
        redisManager.setEx(KEY_PREFIX + session.getId(), session, expireTime);
    }

    public void setRedisManager(RedisManager redisManager) {
        this.redisManager = redisManager;
    }

    public RedisManager getRedisManager() {
        return redisManager;
    }

}
