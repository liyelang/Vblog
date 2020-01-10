package com.uplooking.controller.portal;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.uplooking.pojo.ArticleInfo;
import com.uplooking.pojo.TypeInfo;
import com.uplooking.service.ArticleInfoService;
import com.uplooking.service.TypeInfoService;
import com.uplooking.view.Result;


@Controller
@RequestMapping("portal")
public class PortalController {

	@Autowired
	private ArticleInfoService articleInfoService;

	@Autowired
	private TypeInfoService typeInfoService;
	
	/*
	 * 查询所有文章(正常状态)
	 */
	@RequestMapping("index.action")
	public String getList(ModelMap map,
			@RequestParam(value="pageNum",defaultValue="1") int pageNum,
			@RequestParam(value="pageSize",defaultValue="10") int pageSize) {

		Map<String, Object> param=new  HashMap<String, Object>();
		param.put("status", 1);
		PageHelper.startPage(pageNum,pageSize);
		List<ArticleInfo> list = articleInfoService.list(param);	
		PageInfo<ArticleInfo> pageInfo=new PageInfo<>(list);
		map.put("pageInfo", pageInfo);
		//查询所有文章的分类
		map.put("typelist", typeInfoService.getList());
		return "portal/index";
	}
	
	/*
	 *  主页显示文章类型
	 */
	@RequestMapping("get_type.json")
	@ResponseBody
	public Result getType(TypeInfo typeInfo){
		 List<TypeInfo> infos= typeInfoService.getList();
		 
		return Result.success().add("infos", infos);
	}
	
	/*
	 * 通过文章类型显示文章
	 */
	@RequestMapping("getArticle.action")
	public String getArticle(ModelMap map,
			@RequestParam(value="typeId") int typeId,
			@RequestParam(value="pageNum",defaultValue="1") int pageNum,
			@RequestParam(value="pageSize",defaultValue="10") int pageSize){

		Map<String, Object> param=new  HashMap<String, Object>();
		param.put("status", 1);
		param.put("typeId", typeId);
	
		PageHelper.startPage(pageNum,pageSize);
		List<ArticleInfo> list = articleInfoService.list(param);
		if (list.size()==0) {
		  return "portal/error/404";	
		}
		PageInfo<ArticleInfo> pageInfo=new PageInfo<>(list);
		map.put("pageInfo", pageInfo);
		//查询所有文章的分类
		map.put("typelist", typeInfoService.findById(typeId));
		
		return "portal/type";
	}
	
	/*
	 * 通过主键显示文章
	 */
	@RequestMapping("findOne.action")
	public String getArticle(ModelMap map,
			@RequestParam(value="id") String id){

		ArticleInfo articleInfo= articleInfoService.findById(id);	
		
		
		if (articleInfo==null) {
			return "portal/error/404";
		}
		map.put("articleInfo", articleInfo);
		//查询所有文章的分类
		/*map.put("typelist", typeInfoService.getList());	*/
		
		return "portal/finOne";
	}
	
	/*
	 * 关于我
	 */
	@RequestMapping("about.action")
	public String getArticle(){
		
		return "portal/about";
	}
	
	
	/*
	 * 搜索
	 */
	@RequestMapping("search.action")
	public String search(ModelMap map,
			@RequestParam(required = false, value = "keyWord") String keyword,
			@RequestParam(value="pageNum",defaultValue="1") int pageNum,
			@RequestParam(value="pageSize",defaultValue="3") int pageSize){
				
		Map<String, Object> param=new  HashMap<String, Object>();

		if (!StringUtils.isEmpty(keyword)) {
			param.put("keyword", keyword.trim());
		}

	
		param.put("status", 1);
	
		PageHelper.startPage(pageNum,pageSize);
		List<ArticleInfo> list = articleInfoService.list(param);
		
		PageInfo<ArticleInfo> pageInfo=new PageInfo<>(list);
		map.put("pageInfo", pageInfo);

		//查询所有文章的分类
		map.put("typelist", typeInfoService.getList());
		
		//回显
		map.put("keyword", keyword);
		
		return "portal/search";
		
	}
}
