package com.uplooking.service.portal;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.uplooking.dao.portal.PortalUserInfoMapper;
import com.uplooking.pojo.PortalUserInfo;
import com.uplooking.view.Result;

@Service("portalUserInfoService")
public class PortalUserInfoService {

	@Autowired
	private PortalUserInfoMapper portalUserInfoMapper;

	/*
	 * 注册
	 */
	public Result save(PortalUserInfo userInfo) {
		Date now = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		userInfo.setPortalTime(format.format(now));

		int eff = portalUserInfoMapper.findByName(userInfo.getPortalName());
		if (eff == 0) {
			portalUserInfoMapper.add(userInfo);
			return Result.success();
		} else {
			return Result.error("账户已存在");
		}
	}

	/*
	 * 登陆
	 */
	public void findByNameAndByPwd(String portalName, String portalPwd) {
		portalUserInfoMapper.finOne(portalName, portalPwd);

	}
}
