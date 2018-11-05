package cn.kgc.controller;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mysql.jdbc.StringUtils;

import cn.kgc.entity.Goods;
import cn.kgc.entity.User;
import cn.kgc.service.intf.GoodsService;
import cn.kgc.util.JsonDateValueProcessor;
import cn.kgc.util.PageUtil;
import cn.kgc.util.SqlTools;
import cn.kgc.util.Statics;

/**
 * 商品控制器
 * @author ty
 *
 */
@Controller
@RequestMapping(value="/goods")
public class GoodsController extends BaseController {
	
	@Resource
	private GoodsService goodsService;
	
	/**
	 * 进入商品管理页面
	 * @param session
	 * @param model
	 * @param currentpage
	 * @param s_goodsName
	 * @param s_state
	 * @param tiaoZhuanYe
	 * @return
	 */
	@RequestMapping(value="/logingoodspage", produces = {"text/html;charset=UTF-8"})
	public ModelAndView logingoodspage(HttpSession session,Model model,
									@RequestParam(value="currentpage",required=false)Integer currentpage,
									@RequestParam(value="s_goodsName",required=false) String s_goodsName,
									@RequestParam(value="s_state",required=false) String s_state,
									@RequestParam(value="tiaoZhuanYe",required=false) String tiaoZhuanYe){
		Map<String,Object> baseModel = (Map<String, Object>) session.getAttribute(Statics.SESSION_BASE_MODEL);
		if(null == baseModel){
			return new ModelAndView("redirect:/");
		}else{
			List<Goods> goodsList = null;
			Goods goods = new Goods();
			if(null != s_goodsName && !"".equals(s_goodsName)){
				goods.setGoodsName("%"+SqlTools.sqlTools(s_goodsName)+"%");
			}
			if(!StringUtils.isNullOrEmpty(s_state)){
				goods.setState(Integer.valueOf(s_state));
			}else {
				goods.setState(null);
			}
			
			//分页设置
			PageUtil page = new PageUtil();
			//正整数的正则表达式
			String zhengZe = "^[0-9]*[1-9][0-9]*$";
			//编译正则表达式
			Pattern pattern = Pattern.compile(zhengZe);
			boolean tiaozhuan = false;
			if(null != tiaoZhuanYe){
				//传参是否与正则表达式相匹配
				Matcher matcher = pattern.matcher(tiaoZhuanYe);
				tiaozhuan = matcher.matches();
			}
			try {
				//获取用户的总数量，然后计算分页的总页数
				page.setZongShu(goodsService.count(goods));
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
				//如果异常，总页数赋值为0
				page.setZongYeShu(0);
			}
			//判断总页数是否大于0
			if(page.getZongYeShu() > 0){
				//判断跳转页
				if(tiaozhuan){
					//把String转换成Integer然后赋值到当前页面
					page.setPage(Integer.parseInt(tiaoZhuanYe));
				}
				//判断实现分页的时候，传过来的页数id 
				if(currentpage != null){
					page.setPage(currentpage);
				}
				//判断当前页是否小于0
				if(page.getPage() <= 0){
					page.setPage(1);
				}
				//判断当前页是否大于总页数
				if(page.getPage() > page.getZongYeShu()){
					page.setPage(page.getZongYeShu());
				}
				//把分页数据包装到user对象中
//				goods.setStarNum((page.getPage() - 1) * page.getPageSize());
//				goods.setPageSize(page.getPageSize());
				
				try {
					goodsList = goodsService.getGoosList(goods);
				}catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
					//如果异常，把集合置空
					goodsList = null;
				}
				//把查出来的分页用户列表放到page对象中，在页面中可以直接使用page对象获取
				page.setItems(goodsList);
			}else{
				page.setItems(null);
			}
			model.addAllAttributes(baseModel);
			model.addAttribute("page", page);
			model.addAttribute("s_goodsName", s_goodsName);
			model.addAttribute("s_state", s_state);
			return new ModelAndView("/houTaiGuanLi/goodsinfolist");
		}
	}
	
	/**
	 * 查找商品，用于判断是否编号重复
	 * @param loginCode
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/goosSNIsExit", produces = {"text/html;charset=UTF-8"})
	@ResponseBody
	public String goosSNIsExit(@RequestParam(value="goodsSN",required=false) String goodsSN,
								  @RequestParam(value="id",required=false) String id){
		String result = "failed";
		Goods goods = new Goods();
		goods.setGoodsSN(goodsSN);
		if(!id.equals("-1"))
			goods.setId(Integer.valueOf(id));
		try {
			if(goodsService.count(goods) == 0)
				result = "only";
			else 
				result = "repeat";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return result;
		}
		return result;
	}
	
	/**
	 * 添加商品
	 * @param session
	 * @param goods
	 * @return
	 */
	@RequestMapping(value="/addgoods",method=RequestMethod.POST)
	public ModelAndView addgoods(HttpSession session,@ModelAttribute("goods") Goods goods){
		if(null == session.getAttribute(Statics.SESSION_BASE_MODEL)){
			return new ModelAndView("redirect:/");
		}else{
			goods.setCreateTime(new Date());
			goods.setLastUpdateTime(new Date());
			goods.setCreatedBy(((User)session.getAttribute(Statics.SESSION_USER)).getLoginCode());
			try {
				goodsService.addGoods(goods);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return new ModelAndView("redirect:/goods/logingoodspage");
		}
	}
	
	/**
	 * 根据id查询商品信息
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/getgoodsbyid",produces={"text/html;charset=UTF-8"})
	@ResponseBody
	public Object getgoodsbyid(@RequestParam(value="id",required=false) Integer id){
		String st = "";
		if(null == id){
			st = "nodata";
		}else{
			Goods goods = new Goods();
			goods.setId(id);
			try {
				goods = goodsService.getGoodsById(goods);
				JsonConfig jsonConfig = new JsonConfig();
				jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor());
				JSONObject obj = JSONObject.fromObject(goods, jsonConfig);
				st = obj.toString();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				st = "failed";
			}
		}
		return st;
	}
	
	/**
	 * 修改商品状态
	 * @param session
	 * @param goods
	 * @return
	 */
	@RequestMapping(value="/updategoodsstate",method=RequestMethod.POST)
	public Object updategoodsstate(@RequestParam(value="state") String goods){
		String st = "";
		if(null == goods){
			st = "nodata";
		}else{
			JSONObject obj = JSONObject.fromObject(goods);
			Goods upGoods = (Goods) obj.toBean(obj,Goods.class);
			upGoods.setLastUpdateTime(new Date());
			try {
				goodsService.updateGoods(upGoods);
				st ="success";
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				st = "failed";
			}
		}
		return st;
	}
	
	/**
	 * 修改商品
	 * @param session
	 * @param goods
	 * @return
	 */
	@RequestMapping(value="/updategoods",method=RequestMethod.POST)
	public ModelAndView updategoods(HttpSession session,@ModelAttribute("goods") Goods goods){
		if(null == session.getAttribute(Statics.SESSION_BASE_MODEL)){
			return new ModelAndView("redirect:/");
		}else{
			goods.setLastUpdateTime(new Date());
			try {
				goodsService.updateGoods(goods);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return new ModelAndView("redirect:/goods/logingoodspage");
		}
	}
	
	/**
	 * 删除商品
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/deletegoods",produces={"text/html;charset=UTF-8"})
	@ResponseBody
	public Object deletegoods(@RequestParam(value="delId") Integer id){
		String st = "";
		if(null == id){
			st = "nodata";
		}else{
			Goods goods = new Goods();
			goods.setId(id);
			try {
				if((goodsService.getGoodsById(goods).getState()) == 1){
					st = "isstate";
				}else{
					if(goodsService.isgoodspack(goods)>0){
						st = "isused";
					}else{
						goodsService.deleteGoods(goods);
						st = "success";
					}
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return st; 
	}
}
