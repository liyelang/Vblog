package com.uplooking.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.uplooking.dao.UserInfoMapper;
import com.uplooking.pojo.UserInfo;

@Service("userInfoService")
public class UserInfoService {

	@Autowired
	private UserInfoMapper userInfoMapper;

	public UserInfo getOne(String loginName, String password) {
		return userInfoMapper.findOne(loginName, password);
	}
}
