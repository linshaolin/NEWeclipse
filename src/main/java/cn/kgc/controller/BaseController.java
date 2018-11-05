package cn.kgc.controller;

import java.beans.PropertyEditorSupport;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import cn.kgc.entity.User;
import cn.kgc.util.Statics;


/**
 * Controller父类
 * 用于提取所有Controller类公用的方法
 * @author ty
 *
 */
public class BaseController {
	
	private User successUser;

	public User getSuccessUser() {
		if(null == this.successUser){
			//通过RequestContextHolder获取HttpServletRequest，需要强制转类型（ServletRequestAttributes）
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
			//通过request获取session对象，参数默认true:如果没有会自动创建一个，false：如果没有返回null
			HttpSession session = request.getSession(false);
			if(null != session){
				successUser = (User) session.getAttribute(Statics.SESSION_USER);
			}else{
				successUser = null;
			}
		}
		return successUser;
	}
	public void setSuccessUser(User successUser) {
		this.successUser = successUser;
	}
	
	/**
	 * 日期国际化
	 * @param dataBinder
	 */
	@InitBinder
	public void initBinder(WebDataBinder dataBinder){
		dataBinder.registerCustomEditor(Date.class, new PropertyEditorSupport(){

			@Override
			public String getAsText() {
				// TODO Auto-generated method stub
				return new SimpleDateFormat("yyyy-MM-dd").format((Date)getValue());
			}

			@Override
			public void setAsText(String text) throws IllegalArgumentException {
				try {
					setValue(new SimpleDateFormat("yyyy-MM-dd").parse(text));
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					setValue(null);
				}
			}
		});
	}
}
