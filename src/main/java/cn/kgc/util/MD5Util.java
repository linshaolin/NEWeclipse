package cn.kgc.util;

import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;

import cn.kgc.entity.User;

public class MD5Util {

	public static String getEncryption(User user){
		//声明加密方式
		String hashAlgorithmName = "MD5";
		//加入杂质salt，以用户名为杂质
		ByteSource salt = ByteSource.Util.bytes(user.getUserName());
		//加密 翻译成密文
		//第一个参数：加密方式
		//第二个参数：需加密的密码  明文
		//第三个参数：杂质
		//第四个参数：加密次数 
		SimpleHash pass = new SimpleHash(hashAlgorithmName, user.getPassword(), salt, 1024);
		String password = pass.toString();
		return password;
	}

}
