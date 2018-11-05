package cn.kgc.util;

import org.springframework.data.redis.serializer.JdkSerializationRedisSerializer;

public class SerializerUtil {

	private static final JdkSerializationRedisSerializer jdkSerializationRedisSerializer = new JdkSerializationRedisSerializer();

    /**
     * ���л�����
     * @param obj
     * @return
     */
    public static <T> byte[] serialize(T obj){
        try {
            return jdkSerializationRedisSerializer.serialize(obj);
        } catch (Exception e) {
            throw new RuntimeException("���л�ʧ��!", e);
        }
    }

    /**
     * �����л�����
     * @param bytes �ֽ�����
     * @param cls cls
     * @return
     */
    @SuppressWarnings("unchecked")
    public static <T> T deserialize(byte[] bytes){
        try {
            return (T) jdkSerializationRedisSerializer.deserialize(bytes);
        } catch (Exception e) {
            throw new RuntimeException("�����л�ʧ��!", e);
        }
    }
}
