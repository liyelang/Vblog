package com.uplooking.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.uplooking.pojo.ArticleInfo;
import com.uplooking.service.ArticleInfoService;
import com.uplooking.service.TypeInfoService;
import com.uplooking.view.Result;

@Controller
@RequestMapping("article_info")
public class ArticleInfoController {

	@Autowired
	private ArticleInfoService articleInfoService;

	@Autowired
	private TypeInfoService typeInfoService;
	
	/*
	 * 查询所有文章(正常状态)
	 */
	@RequestMapping("list_namal.action")
	public String getList(ModelMap map,
			@RequestParam(required = false, value = "typeId") String typeId,
			@RequestParam(required = false, value = "startDate") String startDate,
			@RequestParam(required = false, value = "endDate") String endDate,
			@RequestParam(required = false, value = "keyword") String keyword,
			@RequestParam(value="pageNum",defaultValue="1") int pageNum,
			@RequestParam(value="pageSize",defaultValue="3") int pageSize) {

		Map<String, Object> param=new  HashMap<String, Object>();
		param.put("typeId", typeId);
		param.put("startDate", startDate);
		param.put("endDate", endDate);
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
		param.put("typeId", typeId);
		param.put("startDate", startDate);
		param.put("endDate", endDate);
		param.put("keyword", keyword);
		
		return "admin/article_info/list_namal";
	}

	/*
	 * 文章编辑
	 */
	@RequestMapping("edit.action")
	public String edit(ModelMap map, @RequestParam(required = false, value = "id") String id) {

		/*
		 * id为空就是新增, 否则是更新
		 */
		if (!StringUtils.isEmpty(id)) {
			ArticleInfo articleInfo = articleInfoService.findById(id);
			map.put("articleInfo", articleInfo);
		}
		map.put("typelist", typeInfoService.getList());

		return "admin/article_info/edit";
	}

	/*
	 * 上传文件到磁盘(物理路劲)
	 */
	@RequestMapping("upload.json")
	@ResponseBody
	public Result upload(MultipartFile file, HttpServletRequest request) throws Exception, IOException {
		// 文件原名称
		String fileName = file.getOriginalFilename();
		// 新的名称
		String fileNewName = "";
		// 根据年月日创建3级目录
		String datefile = "";

		// 上传文件
		if (file != null && fileName != null && fileName.length() > 0) {
			Date date = new Date();
			datefile = new SimpleDateFormat("yyyy/MM/dd").format(date);
			// 保存文件物理地址
			//String filepath = "F:\\upload\\" + datefile;
			String filepath = "/usr/upload/" + datefile;
			// 自动创建文件夹
			File f = new File(filepath);
			if (!f.exists()) {
				f.mkdirs();
			}
			// 新的文件名
			fileNewName = UUID.randomUUID() + fileName.substring(fileName.lastIndexOf("."));
			// 新文件（本机就是 \\反斜杠）
			File newfile = new File(filepath + "/" + fileNewName);
			// 写入磁盘
			file.transferTo(newfile);
			//System.out.println("当前地址"+datefile+"/"+fileNewName);
		}
		return Result.success().add("imgUrl", datefile+"/"+fileNewName);
	}
	/*
	 *  保存文本
	 */
	@RequestMapping("saveImg.json")
	@ResponseBody
	public Result save(ArticleInfo articleInfo) {
		//System.out.println("当前封面图片"+articleInfo.getConverimg());
		//System.out.println("更新当前文本内容"+articleInfo.getContent());
		articleInfoService.save(articleInfo);

		return Result.success();
	}
	/*
	 *  批量移动文章到分类
	 */
	@RequestMapping("move.json")
	@ResponseBody
	public Result move(
			@RequestParam(value = "idArr") String[] idArr,
			@RequestParam(value = "typeId") String typeId) {
	
		articleInfoService.move(idArr,typeId);
		
		return Result.success();
	}
	
	/*
	 * 将文章放到回收站
	 */
	/*
	 *  批量移动文章到分类
	 */
	@RequestMapping("updateStatus.json")
	@ResponseBody
	public Result updataStatus(
			@RequestParam(value = "idArr") String[] idArr,
			@RequestParam(value = "status") String status) {
	
		articleInfoService.updataStatus(idArr,status);
		
		return Result.success();
	}
	
	/*
	 * 非正常文章 回收站
	 */
	/*
	 * 查询所有文章(正常状态)
	 */
	@RequestMapping("recycle.action")
	public String getrecycle(ModelMap map,
			@RequestParam(required = false, value = "typeId") String typeId,
			@RequestParam(required = false, value = "startDate") String startDate,
			@RequestParam(required = false, value = "endDate") String endDate,
			@RequestParam(required = false, value = "keyword") String keyword,
			@RequestParam(value="pageNum",defaultValue="1") int pageNum,
			@RequestParam(value="pageSize",defaultValue="3") int pageSize) {

		Map<String, Object> param=new  HashMap<String, Object>();
		param.put("typeId", typeId);
		param.put("startDate", startDate);
		param.put("endDate", endDate);
		if (!StringUtils.isEmpty(keyword)) {
			param.put("keyword", keyword.trim());
		}
		param.put("status", '0');
	
		PageHelper.startPage(pageNum,pageSize);
		List<ArticleInfo> list = articleInfoService.list(param);

		PageInfo<ArticleInfo> pageInfo=new PageInfo<>(list);
		map.put("pageInfo", pageInfo);

		//查询所有文章的分类
		map.put("typelist", typeInfoService.getList());
		
		//回显
		param.put("typeId", typeId);
		param.put("startDate", startDate);
		param.put("endDate", endDate);
		param.put("keyword", keyword);
		
		return "admin/article_info/recycle";
	}

	
	@RequestMapping("dele.json")
	@ResponseBody
	public Result dele(@RequestParam(value="idArr") String [] idArr){
		
		articleInfoService.delete(idArr);
		
		return Result.success();
		
	}
}
