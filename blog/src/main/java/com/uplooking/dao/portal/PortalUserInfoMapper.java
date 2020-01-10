package com.uplooking.dao.portal;

import org.apache.ibatis.annotations.Param;

import com.uplooking.pojo.PortalUserInfo;

public interface PortalUserInfoMapper {

	/*
	 * 注册用户
	 */
	int add(PortalUserInfo userInfo);

	/*
	 * 登陆
	 */
	void finOne(@Param("portalName") String portalName, 
			@Param("portalPwd")String portalPwd);

	int findByName(@Param("portalName") String portalName);

}
