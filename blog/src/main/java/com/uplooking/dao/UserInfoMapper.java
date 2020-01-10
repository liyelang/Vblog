package com.uplooking.dao;

import org.apache.ibatis.annotations.Param;

import com.uplooking.pojo.UserInfo;

public interface UserInfoMapper {

	UserInfo findOne(@Param("username") String username, @Param("password") String password);
}
