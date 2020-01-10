package com.uplooking.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.uplooking.dao.ArticleInfoMapper;
import com.uplooking.dao.TypeInfoMapper;
import com.uplooking.pojo.ArticleInfo;
import com.uplooking.pojo.TypeInfo;

@Service("articleInfoService")
public class ArticleInfoService {

	@Autowired
	private ArticleInfoMapper articleInfoMapper;

	@Resource
	private TypeInfoMapper typeInfoMapper;

	/*
	 * 查询所有文章
	 */
	public List<ArticleInfo> list(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return articleInfoMapper.list(param);
	}

	/*
	 * 查询单个文章信息
	 */
	public ArticleInfo findById(String id) {
		// TODO Auto-generated method stub
		ArticleInfo articleInfo = articleInfoMapper.findOne(id);
		if (articleInfo != null) {
			int newCount = articleInfo.getViewCount();
			newCount++;
			articleInfoMapper.updateCount(id, newCount);
		}
		return articleInfo;
	}

	/*
	 * 保存文本
	 */
	@Transactional
	public void save(ArticleInfo articleInfo) {
		Date now = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		// 判断是新增还是更新
		if (StringUtils.isEmpty(articleInfo.getId())) {
			// 新增
			// System.out.println(articleInfo.getId());
			TypeInfo typeinfo = typeInfoMapper.findOne(Integer.parseInt(articleInfo.getTypeId()));
			articleInfo.setTypenum(Integer.parseInt(typeinfo.getNum()));
			articleInfo.setStatus(1);
			articleInfo.setUpdateTime(format.format(now));
			articleInfo.setViewCount(1);
			// System.out.println("******tiajai");
			articleInfoMapper.add(articleInfo);
		} else {
			// 更新
			if (articleInfo.getContent().equals("") || articleInfo.getContent().equals("null")) {
				articleInfo.setContent("友情提示:----当前为默认内容----");
			}
			articleInfo.setUpdateTime(format.format(now));
			articleInfoMapper.update(articleInfo);
		}

	}

	/*
	 * 批量移动到新分类 idArr 主键数据id typeId 新的分类id
	 */
	@Transactional
	public void move(String[] idArr, String typeId) {

		articleInfoMapper.updateType(idArr, typeId);

	}

	/*
	 * 文章放入回收站
	 */
	@Transactional
	public void updataStatus(String[] idArr, String status) {

		articleInfoMapper.upStatus(idArr, status);
	}

	/*
	 * 彻底删除
	 */
	@Transactional
	public void delete(String[] idArr) {
		articleInfoMapper.delete(idArr);

	}

}
