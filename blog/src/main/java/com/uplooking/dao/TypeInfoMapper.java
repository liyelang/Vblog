package com.uplooking.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.uplooking.pojo.TypeInfo;

public interface TypeInfoMapper {

	List<TypeInfo> findList();

	int insert(@Param("sort")String sort, @Param("name") String name,@Param("num") String num);

	int update(@Param("id") String id,@Param("sort") String sort, @Param("name") String name,@Param("num") String num);

	int delete(@Param("idArr") String[] idArr);

	/*
	 * 通过主键查询类型
	 */
	TypeInfo findOne(int typeId);
}
