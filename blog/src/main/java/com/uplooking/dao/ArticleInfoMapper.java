package com.uplooking.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.uplooking.pojo.ArticleInfo;

public interface ArticleInfoMapper {

	/*
	 * 查询单个id文章
	 */
	ArticleInfo findOne(String id);

	/*
	 * 添加文章
	 */
	int add(ArticleInfo articleInfo);

	/*
	 * 更新文章
	 */
	int update(ArticleInfo articleInfo);

	/*
	 * 查询所有文章
	 */
	List<ArticleInfo> list(Map<String, Object> param);

	
	/*
	 * 批量移动到新分类
	 * idArr  主键数据id
	 * typeId 新的分类id
	 */
	void updateType(@Param("idArr") String[] idArr, @Param("typeId") String typeId);

	/*
	 * 文章放入回收站
	 */
	void upStatus(@Param("idArr")String[] idArr,@Param("status") String status);

	/*
	 * 从回收站中删除
	 */
	void delete(@Param("idArr") String[] idArr);

	/*
	 * 根据文章分类id 查询文章conunt
	 */
	int countBytypeId(@Param("idArr") String[] idArr,@Param("status") String status);

	/*
	 * 根据文章分类删除回收站文章
	 */
	void batchDelatetypeId(@Param("idArr") String[] idArr);

	/*
	 * 更新浏览量
	 */
	void updateCount(@Param("id") String id, @Param("newCount") int newCount); 

}
