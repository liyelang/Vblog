package com.uplooking.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.uplooking.exception.DablogException;
import com.uplooking.pojo.TypeInfo;
import com.uplooking.service.TypeInfoService;
import com.uplooking.view.Result;

@Controller
@RequestMapping("type_info")
public class TypeInfoController {

	@Autowired
	private TypeInfoService typeInfoService;

	@RequestMapping("list.action")
	public String list(ModelMap map) {
		List<TypeInfo> lists = typeInfoService.getList();
		map.put("lists", lists);
		return "admin/type_info/list";
	}
/*
 * 批量更新/添加
 */
	@RequestMapping("save.json")
	@ResponseBody
	public Result save(@RequestParam(value = "idArr") String[] idArr, @RequestParam(value = "sortArr") String[] sortArr,
			@RequestParam(value = "nameArr") String[] nameArr,@RequestParam(value = "numArr") String[] numArr) {
		typeInfoService.save(idArr, sortArr, nameArr,numArr);

		return Result.success();
	}

	
	@RequestMapping("delete.json")
	@ResponseBody
	public Result delete(@RequestParam(value = "idArr") String[] idArr) throws DablogException {
		
		typeInfoService.delete(idArr);
		return Result.success();
	}
}
