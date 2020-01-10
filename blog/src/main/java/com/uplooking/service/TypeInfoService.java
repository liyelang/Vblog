package com.uplooking.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.uplooking.dao.ArticleInfoMapper;
import com.uplooking.dao.TypeInfoMapper;
import com.uplooking.exception.DablogException;
import com.uplooking.pojo.TypeInfo;

@Service("typeInfoService")
public class TypeInfoService {

	@Autowired
	private TypeInfoMapper typeInfoMapper;

	
	@Autowired
	private ArticleInfoMapper articleInfoMapper;
	/*
	 * 查询文章分类
	 */
	public List<TypeInfo> getList() {

		return typeInfoMapper.findList();
	}

	/*
	 * 批量更新/插入
	 */
	@Transactional
	public void save(String[] idArr, String[] sortArr, String[] nameArr,String[] numArr) {
		for (int i = 0; i < idArr.length; i++) {
			if (StringUtils.isEmpty(idArr[i])) {
				// 为空就添加
				typeInfoMapper.insert(sortArr[i], nameArr[i],numArr[i]);
			} else {
				// 存在就更新
				typeInfoMapper.update(idArr[i], sortArr[i], nameArr[i],numArr[i]);
			}
		}

	}

	/*
	 * 批量删除
	 */
	@Transactional
	public void delete(String[] idArr) throws DablogException {

		/*
		 * 判断文章类型id是否在使用   
		 */
		//System.out.println("当前值888888888888888888");
		int tcount=articleInfoMapper.countBytypeId(idArr,"1");
		//System.out.println("当前值"+tcount);
			if (tcount>0) {
				throw new DablogException("改文章类型已被占用,无法删除");
			}
		//删除先删除该分类下所有的文章(包括回收站)
			articleInfoMapper.batchDelatetypeId(idArr);
		typeInfoMapper.delete(idArr);

	}

	/*
	 * 通过类型主键查询文章类型
	 */
	public TypeInfo findById(int typeId) {
		// TODO Auto-generated method stub
		return typeInfoMapper.findOne(typeId);
	}
}
