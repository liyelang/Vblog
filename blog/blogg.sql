/*
 Navicat Premium Data Transfer

 Source Server         : loca
 Source Server Type    : MySQL
 Source Server Version : 50728
 Source Host           : localhost:3306
 Source Schema         : blogg

 Target Server Type    : MySQL
 Target Server Version : 50728
 File Encoding         : 65001

 Date: 10/01/2020 19:31:13
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for article_info
-- ----------------------------
DROP TABLE IF EXISTS `article_info`;
CREATE TABLE `article_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `content_text` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `conver` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `view_count` int(11) NOT NULL,
  `update_time` datetime(0) NOT NULL,
  `status` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `placement` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '界面显示置顶\r\n3/轮播图 , 2/左侧上方 , 1/左侧阅读排行 , 0/全部',
  `typenum` int(11) NULL DEFAULT NULL COMMENT 'type大类/学无止境, 慢生活',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article_info
-- ----------------------------
INSERT INTO `article_info` VALUES (1, 'spring Boot 邮件服务', '<div><h2 style=\"margin-top: 8px; margin-bottom: 16px; font-size: 24px; font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; color: rgb(79, 79, 79); line-height: 32px; overflow-wrap: break-word; font-variant-ligatures: common-ligatures;\">1. 依赖文件 pom.xml</h2></div><div><pre><code>&lt;dependencies&gt;<br>    &lt;dependency&gt;<br>        &lt;groupId&gt;org.springframework.boot&lt;/groupId&gt;<br>        &lt;artifactId&gt;spring-boot-starter-mail&lt;/artifactId&gt;<br>    &lt;/dependency&gt;<br>    &lt;dependency&gt;<br>        &lt;groupId&gt;org.springframework.boot&lt;/groupId&gt;<br>        &lt;artifactId&gt;spring-boot-starter-thymeleaf&lt;/artifactId&gt;<br>    &lt;/dependency&gt;<br><br>    &lt;dependency&gt;<br>        &lt;groupId&gt;org.springframework.boot&lt;/groupId&gt;<br>        &lt;artifactId&gt;spring-boot-starter-test&lt;/artifactId&gt;<br>        &lt;scope&gt;test&lt;/scope&gt;<br>    &lt;/dependency&gt;<br>&lt;/dependencies&gt;</code></pre><h2 style=\"margin-top: 8px; margin-bottom: 16px; font-size: 24px; font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; color: rgb(79, 79, 79); line-height: 32px; overflow-wrap: break-word; font-variant-ligatures: common-ligatures;\">2. 配置文件 application.yml</h2></div><div><pre><code>server:<br>  port: 8080<br>spring:<br>  application:<br>    name: spring-boot-mail<br>  mail:<br>    host: smtp.qq.com<br>    username: 136736247<br>    password: xxxxxx<br>    default-encoding: UTF-8<br>    fromAddr: 136736247@qq.com<br>    nickName: inwsy</code></pre><p><span style=\"color: rgb(77, 77, 77); font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; font-variant-ligatures: common-ligatures;\">这里我使用 QQ 邮箱作为邮件的发送方，password</span><span style=\"color: rgb(77, 77, 77); font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; font-variant-ligatures: common-ligatures;\">这个密码需要我们在 QQ 邮箱的设置里面自己申请的授权码。</span></p><h2 style=\"margin-top: 8px; margin-bottom: 16px; font-size: 24px; font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; color: rgb(79, 79, 79); line-height: 32px; overflow-wrap: break-word; font-variant-ligatures: common-ligatures;\">3. 简易邮件发送</h2></div><div><h3 style=\"margin-top: 8px; margin-bottom: 16px; font-size: 22px; font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; color: rgb(79, 79, 79); line-height: 30px; overflow-wrap: break-word; font-variant-ligatures: common-ligatures;\">3.1 实现类</h3><p style=\"margin-bottom: 16px; font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; color: rgb(77, 77, 77); line-height: 26px; overflow-wrap: break-word; font-variant-ligatures: common-ligatures;\">MailServiceImpl.java</p><pre><code>@Service<br>public class MailServiceImpl implements MailService {<br><br>    private final Logger logger = LoggerFactory.getLogger(this.getClass());<br><br>    @Autowired<br>    private JavaMailSender javaMailSender;<br><br>    @Value(\"${spring.mail.fromAddr}\")<br>    private String from;<br><br>    @Value(\"${spring.mail.nickName}\")<br>    private String nickName;<br><br>    @Override<br>    public void sendSimpleEmail(String to, String subject, String content) {<br>        SimpleMailMessage simpleMailMessage = new SimpleMailMessage();<br>        simpleMailMessage.setFrom(nickName   \"&lt;\"   from   \"&gt;\");<br>        simpleMailMessage.setTo(to);<br>        simpleMailMessage.setSubject(subject);<br>        simpleMailMessage.setText(content);<br>        <br>        try{<br>            javaMailSender.send(simpleMailMessage);<br>            logger.info(\"简易邮件发送成功\");<br>        } catch(Exception e) {<br>            logger.error(\"简易邮件发送异常\", e);<br>        }<br><br>    }<br>}</code></pre><h3 style=\"margin-top: 8px; margin-bottom: 16px; font-size: 22px; font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; color: rgb(79, 79, 79); line-height: 30px; overflow-wrap: break-word; font-variant-ligatures: common-ligatures;\">3.2 测试类</h3><p style=\"margin-bottom: 16px; font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; color: rgb(77, 77, 77); line-height: 26px; overflow-wrap: break-word; font-variant-ligatures: common-ligatures;\">SpringBootMailApplicationTests.java</p><pre><code>@Autowired<br>MailService mailService;<br><br>@Test<br>public void sendSimpleEmail() {<br>    mailService.sendSimpleEmail(\"inwsy@hotmail.com\", \"测试邮件题目\", \"测试邮件内容\");<br>}</code></pre><h2 style=\"margin-top: 8px; margin-bottom: 16px; font-size: 24px; font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; color: rgb(79, 79, 79); line-height: 32px; overflow-wrap: break-word; font-variant-ligatures: common-ligatures;\">4. 发送 HTML 格式的邮件</h2><h3 style=\"margin-top: 8px; margin-bottom: 16px; font-size: 22px; font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; color: rgb(79, 79, 79); line-height: 30px; overflow-wrap: break-word; font-variant-ligatures: common-ligatures;\"><a name=\"t6\" style=\"outline: 0px; margin: 0px; padding: 0px; color: rgb(78, 161, 219); text-decoration-line: none; cursor: pointer; background-color: transparent; overflow-wrap: break-word;\"></a><a id=\"41__112\" style=\"outline: 0px; margin: 0px; padding: 0px; color: rgb(78, 161, 219); text-decoration-line: none; cursor: pointer; background-color: transparent; overflow-wrap: break-word;\"></a>4.1 实现类</h3></div><div><span style=\"color: rgb(77, 77, 77); font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; font-variant-ligatures: common-ligatures;\">MailServiceImpl.java</span></div><div><pre><code>@Override<br>public void sendHTMLEmail(String to, String subject, String content) {<br>    MimeMessage message = javaMailSender.createMimeMessage();<br><br>    try {<br>        MimeMessageHelper messageHelper = new MimeMessageHelper(message, true);<br><br>        messageHelper.setFrom(new InternetAddress(from, nickName, \"UTF-8\"));<br>        messageHelper.setTo(to);<br>        messageHelper.setSubject(subject);<br>        messageHelper.setText(content, true);<br><br>        javaMailSender.send(message);<br>        <br>        logger.info(\"HTML 模版邮件发送成功\");<br>    } catch (MessagingException e) {<br>        logger.error(\"HTML 模版邮件发送失败\", e);<br>    } catch (UnsupportedEncodingException e) {<br>        logger.error(\"收件地址编码异常\", e);<br>    }<br><br>}</code></pre><h3 style=\"margin-top: 8px; margin-bottom: 16px; font-size: 22px; font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; color: rgb(79, 79, 79); line-height: 30px; overflow-wrap: break-word; font-variant-ligatures: common-ligatures;\">4.2 页面模版</h3><p style=\"margin-bottom: 16px; font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; color: rgb(77, 77, 77); line-height: 26px; overflow-wrap: break-word; font-variant-ligatures: common-ligatures;\">email.html</p><pre><code>&lt;!DOCTYPE html&gt;<br>&lt;html lang=\"zh\" xmlns:th=\"http://www.thymeleaf.org\"&gt;<br>    &lt;head&gt;<br>        &lt;meta charset=\"UTF-8\"/&gt;<br>        &lt;title&gt;邮件模版&lt;/title&gt;<br>    &lt;/head&gt;<br>    &lt;body&gt;<br>        这是邮件模版生成的邮件，可以点击链接查看详情。<br>        &lt;a href=\"#\" th:href=\"@{ http://www.geekdigging.com/ }\"&gt;查看详情。&lt;/a&gt;<br>        当前的Code为：&lt;span th:text=\"${code}\"&gt;&lt;/span&gt;<br>    &lt;/body&gt;<br>&lt;/html&gt;</code></pre><h3 style=\"margin-top: 8px; margin-bottom: 16px; font-size: 22px; font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; color: rgb(79, 79, 79); line-height: 30px; overflow-wrap: break-word; font-variant-ligatures: common-ligatures;\">4.3 测试类</h3><p style=\"margin-bottom: 16px; font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; color: rgb(77, 77, 77); line-height: 26px; overflow-wrap: break-word; font-variant-ligatures: common-ligatures;\">SpringBootMailApplicationTests.java</p><pre><code>@Test<br>public void sendHTMLTemplateMail() {<br>    Context context = new Context();<br>    context.setVariable(\"code\", \"123456\");<br>    String emailHTMLContent = templateEngine.process(\"email\", context);<br><br>    mailService.sendHTMLEmail(\"inwsy@hotmail.com\", \"测试 HTML 模版邮件\", emailHTMLContent);<br>}</code></pre><h2 style=\"margin-top: 8px; margin-bottom: 16px; font-size: 24px; font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; color: rgb(79, 79, 79); line-height: 32px; overflow-wrap: break-word; font-variant-ligatures: common-ligatures;\">5. 发送带附件的邮件</h2><h3 style=\"margin-top: 8px; margin-bottom: 16px; font-size: 22px; font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; color: rgb(79, 79, 79); line-height: 30px; overflow-wrap: break-word; font-variant-ligatures: common-ligatures;\"><a name=\"t10\" style=\"outline: 0px; margin: 0px; padding: 0px; color: rgb(78, 161, 219); text-decoration-line: none; cursor: pointer; background-color: transparent; overflow-wrap: break-word;\"></a><a id=\"51__179\" style=\"outline: 0px; margin: 0px; padding: 0px; color: rgb(78, 161, 219); text-decoration-line: none; cursor: pointer; background-color: transparent; overflow-wrap: break-word;\"></a>5.1 实现类</h3><p style=\"margin-bottom: 16px; font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; color: rgb(77, 77, 77); line-height: 26px; overflow-wrap: break-word; font-variant-ligatures: common-ligatures;\">MailServiceImpl.java</p><pre><code>@Override<br>public void sendAttachmentsMail(String to, String subject, String content, String fileName, String filePath) {<br><br>    MimeMessage message = javaMailSender.createMimeMessage();<br><br>    try {<br>        MimeMessageHelper messageHelper = new MimeMessageHelper(message, true);<br><br>        messageHelper.setFrom(new InternetAddress(from, nickName, \"UTF-8\"));<br>        messageHelper.setTo(to);<br>        messageHelper.setSubject(subject);<br>        messageHelper.setText(content, true);<br><br>        FileSystemResource file = new FileSystemResource(new File(filePath));<br>        messageHelper.addAttachment(fileName, file);<br><br>        javaMailSender.send(message);<br>        <br>        logger.info(\"带附件邮件发送成功\");<br>    } catch (MessagingException e) {<br>        logger.error(\"带附件邮件发送失败\", e);<br>    } catch (UnsupportedEncodingException e) {<br>        logger.error(\"收件地址编码异常\", e);<br>    }<br>}</code></pre><p><span style=\"outline: 0px; margin: 0px; padding: 0px; font-weight: 700; overflow-wrap: break-word; color: rgb(77, 77, 77); font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; font-variant-ligatures: common-ligatures;\">注意：</span><font color=\"#4d4d4d\" face=\"Microsoft YaHei, SF Pro Display, Roboto, Noto, Arial, PingFang SC, sans-serif\"><span style=\"font-variant-ligatures: common-ligatures;\">&nbsp;如果需要发送多个附件，写多个</span></font>&nbsp;<span style=\"outline-color: initial; outline-style: initial; padding: 2px 4px; line-height: 22px; border-radius: 2px;\">messageHelper.addAttachment(fileName, file)</span><span style=\"outline-color: initial; outline-style: initial; padding: 2px 4px; line-height: 22px; border-radius: 2px;\">;</span><span style=\"color: rgb(77, 77, 77); font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; font-variant-ligatures: common-ligatures;\">&nbsp;</span></p><h3 style=\"margin-top: 8px; margin-bottom: 16px; font-size: 22px; font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; color: rgb(79, 79, 79); line-height: 30px; overflow-wrap: break-word; font-variant-ligatures: common-ligatures;\">5.2 测试类</h3><p style=\"margin-bottom: 16px; font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif; color: rgb(77, 77, 77); line-height: 26px; overflow-wrap: break-word; font-variant-ligatures: common-ligatures;\">SpringBootMailApplicationTests.java</p><pre><code>@Test<br>public void sendAttachmentsMail() {<br><br>    String fileName = \"图片.jpg\";<br>    String filePath = \"C:\\\\Users\\\\inwsy\\\\Downloads\\\\0370279582fe3e2a8012060c896a5dd.jpg\";<br><br>    mailService.sendAttachmentsMail(\"inwsy@hotmail.com\", \"测试带附件的邮件\", \"详细请查阅附件\", fileName, filePath);<br>}</code></pre></div>						<br>						<br/>						', '集成邮件发送功能', '/upload/2019/10/15/3a2e6e21-d588-499d-a46a-8138c1d463ce.jpg', 55, '2019-10-16 00:39:25', 1, 1, '3', 1);

-- ----------------------------
-- Table structure for comment_info
-- ----------------------------
DROP TABLE IF EXISTS `comment_info`;
CREATE TABLE `comment_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `visitor` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '游客用户',
  `ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'ip地址',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内容',
  `article_id` int(11) NOT NULL COMMENT '文章id',
  `new_datatime` datetime(0) NOT NULL COMMENT '时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment_info
-- ----------------------------
INSERT INTO `comment_info` VALUES (1, '123', '124.160.213.99', '--  where  1=1  ', 13, '2019-10-21 12:12:38');

-- ----------------------------
-- Table structure for num_info
-- ----------------------------
DROP TABLE IF EXISTS `num_info`;
CREATE TABLE `num_info`  (
  `num_id` int(11) NOT NULL AUTO_INCREMENT,
  `num_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '大类',
  PRIMARY KEY (`num_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of num_info
-- ----------------------------
INSERT INTO `num_info` VALUES (1, '学无止境');
INSERT INTO `num_info` VALUES (2, '慢生活');

-- ----------------------------
-- Table structure for portal_userinfo
-- ----------------------------
DROP TABLE IF EXISTS `portal_userinfo`;
CREATE TABLE `portal_userinfo`  (
  `portal_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `portal_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `portal_pwd` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户密码',
  `portal_addr` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户注册地址',
  `portal_sex` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '性别',
  `portal_time` datetime(0) NOT NULL COMMENT '注册时间',
  `portal_introduce` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '个人简介',
  PRIMARY KEY (`portal_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for type_info
-- ----------------------------
DROP TABLE IF EXISTS `type_info`;
CREATE TABLE `type_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sort` int(11) NOT NULL,
  `num` int(11) NOT NULL COMMENT '区别 1:学无止境/2:慢生活 ',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of type_info
-- ----------------------------
INSERT INTO `type_info` VALUES (1, 'Java', 1, 1);
INSERT INTO `type_info` VALUES (2, '前端', 2, 1);
INSERT INTO `type_info` VALUES (3, '配置', 3, 1);
INSERT INTO `type_info` VALUES (4, '杂谈', 4, 2);
INSERT INTO `type_info` VALUES (5, '记录', 5, 2);

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pass_word` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_info
-- ----------------------------
INSERT INTO `user_info` VALUES (1, 'q', 'q');

SET FOREIGN_KEY_CHECKS = 1;
