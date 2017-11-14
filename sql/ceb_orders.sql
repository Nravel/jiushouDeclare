/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50714
Source Host           : localhost:3306
Source Database       : ceb_orders

Target Server Type    : MYSQL
Target Server Version : 50714
File Encoding         : 65001

Date: 2017-11-14 10:24:14
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `ceb_admin`
-- ----------------------------
DROP TABLE IF EXISTS `ceb_admin`;
CREATE TABLE `ceb_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(64) NOT NULL,
  `password` varchar(64) NOT NULL,
  `ip` varchar(32) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `login_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ceb_admin
-- ----------------------------
INSERT INTO `ceb_admin` VALUES ('1', 'admin', '21232f297a57a5a743894a0e4a801fc3', '127.0.0.1', '9', '2017-11-14 10:06:14');
INSERT INTO `ceb_admin` VALUES ('40', 'tom', '21232f297a57a5a743894a0e4a801fc3', '0.0.0.0', '1', '2017-11-09 08:53:59');
INSERT INTO `ceb_admin` VALUES ('41', 'jack', '21232f297a57a5a743894a0e4a801fc3', '0.0.0.0', '0', '2017-11-08 15:40:40');
INSERT INTO `ceb_admin` VALUES ('43', 'neo', '21232f297a57a5a743894a0e4a801fc3', null, '1', null);
INSERT INTO `ceb_admin` VALUES ('45', 'root', '21232f297a57a5a743894a0e4a801fc3', '192.168.199.142', '0', '2017-11-10 17:04:33');

-- ----------------------------
-- Table structure for `ceb_auth_group`
-- ----------------------------
DROP TABLE IF EXISTS `ceb_auth_group`;
CREATE TABLE `ceb_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户组id,自增主键',
  `module` varchar(20) NOT NULL COMMENT '用户组所属模块',
  `type` tinyint(4) NOT NULL COMMENT '组类型',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '用户组中文名称',
  `description` varchar(80) NOT NULL DEFAULT '' COMMENT '描述信息',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户组状态：为1正常，为0禁用,-1为删除',
  `rules` varchar(500) NOT NULL DEFAULT '' COMMENT '用户组拥有的规则id，多个规则 , 隔开',
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`module`,`title`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ceb_auth_group
-- ----------------------------
INSERT INTO `ceb_auth_group` VALUES ('1', 'admin', '1', '默认用户组', 'admin', '1', '12,32,20,21,50,52,23,30,24,25,36,26,38,27,31');
INSERT INTO `ceb_auth_group` VALUES ('27', 'admin', '1', '超级管理员', '', '1', '12,32,20,21,49,50,51,52,23,30,24,25,35,36,37,26,38,39,40,41,42,27,31,33,34');
INSERT INTO `ceb_auth_group` VALUES ('19', 'admin', '1', 'root', '', '1', '12,32,20,21,49,50,52,23,30');
INSERT INTO `ceb_auth_group` VALUES ('7', 'admin', '1', 'admin', 'ffff', '1', '24,25,35,36,37,26,38,39,40,41,42,27,31,33,34');

-- ----------------------------
-- Table structure for `ceb_auth_group_access`
-- ----------------------------
DROP TABLE IF EXISTS `ceb_auth_group_access`;
CREATE TABLE `ceb_auth_group_access` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户id',
  `group_id` varchar(64) NOT NULL COMMENT '用户组id',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ceb_auth_group_access
-- ----------------------------
INSERT INTO `ceb_auth_group_access` VALUES ('1', '27');
INSERT INTO `ceb_auth_group_access` VALUES ('40', '1');
INSERT INTO `ceb_auth_group_access` VALUES ('41', '1');
INSERT INTO `ceb_auth_group_access` VALUES ('43', '7');
INSERT INTO `ceb_auth_group_access` VALUES ('45', '19');

-- ----------------------------
-- Table structure for `ceb_auth_rule`
-- ----------------------------
DROP TABLE IF EXISTS `ceb_auth_rule`;
CREATE TABLE `ceb_auth_rule` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '父级id',
  `module` varchar(20) NOT NULL COMMENT '规则所在module',
  `name` char(80) NOT NULL DEFAULT '' COMMENT '规则唯一标识',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '规则中文名称',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：为1正常，为0禁用',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `condition` char(100) NOT NULL DEFAULT '' COMMENT '规则表达式，为空表示存在就验证，不为空表示按照条件验证',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 COMMENT='规则表';

-- ----------------------------
-- Records of ceb_auth_rule
-- ----------------------------
INSERT INTO `ceb_auth_rule` VALUES ('50', '21', 'admin', 'Admin/Order/Edit', '修改', '1', '1', '');
INSERT INTO `ceb_auth_rule` VALUES ('12', '0', 'admin', 'Admin/Index/Index', '首页', '1', '1', '');
INSERT INTO `ceb_auth_rule` VALUES ('27', '24', 'admin', 'Admin/Admin/Permission', '权限管理', '1', '1', '');
INSERT INTO `ceb_auth_rule` VALUES ('20', '0', 'admin', 'Admin/Order', '订单管理', '1', '1', '');
INSERT INTO `ceb_auth_rule` VALUES ('21', '20', 'admin', 'Admin/Order/Index', '订单列表', '1', '1', '');
INSERT INTO `ceb_auth_rule` VALUES ('23', '20', 'admin', 'Admin/Order/Export', '订单导出', '1', '1', '');
INSERT INTO `ceb_auth_rule` VALUES ('24', '0', 'admin', 'Admin/Admin', '管理员管理', '1', '1', '');
INSERT INTO `ceb_auth_rule` VALUES ('25', '24', 'admin', 'Admin/Admin/Index', '管理员列表', '1', '1', '');
INSERT INTO `ceb_auth_rule` VALUES ('26', '24', 'admin', 'Admin/Admin/Groups', '用户组管理', '1', '1', '');
INSERT INTO `ceb_auth_rule` VALUES ('30', '23', 'admin', 'Admin/Order/ExportData', '导出', '1', '1', '');
INSERT INTO `ceb_auth_rule` VALUES ('31', '27', 'admin', 'Admin/Admin/Permissionadd', '添加权限', '1', '1', '');
INSERT INTO `ceb_auth_rule` VALUES ('32', '12', 'admin', 'Admin/Index/Welcome', '欢迎', '1', '1', '');
INSERT INTO `ceb_auth_rule` VALUES ('49', '21', 'admin', 'Admin/Order/Details', '详情', '1', '1', '');
INSERT INTO `ceb_auth_rule` VALUES ('33', '27', 'admin', 'Admin/Admin/Permissionedit', '修改', '1', '1', '');
INSERT INTO `ceb_auth_rule` VALUES ('34', '27', 'admin', 'Admin/Admin/Delpermission', '删除', '1', '1', '');
INSERT INTO `ceb_auth_rule` VALUES ('35', '25', 'admin', 'Admin/Admin/Add', '添加', '1', '1', '');
INSERT INTO `ceb_auth_rule` VALUES ('36', '25', 'admin', 'Admin/Admin/Edit', '修改', '1', '1', '');
INSERT INTO `ceb_auth_rule` VALUES ('37', '25', 'admin', 'Admin/Admin/Delusers', '删除', '1', '1', '');
INSERT INTO `ceb_auth_rule` VALUES ('38', '26', 'admin', 'Admin/Admin/Groupsadd', '添加', '1', '1', '');
INSERT INTO `ceb_auth_rule` VALUES ('39', '26', 'admin', 'Admin/Admin/Groupsedit', '修改', '1', '1', '');
INSERT INTO `ceb_auth_rule` VALUES ('40', '26', 'admin', 'Admin/Admin/Groupsauthorize', '授权', '1', '1', '');
INSERT INTO `ceb_auth_rule` VALUES ('41', '26', 'admin', 'Admin/Admin/Groupsmember', '组员管理', '1', '1', '');
INSERT INTO `ceb_auth_rule` VALUES ('42', '26', 'admin', 'Admin/Admin/Delgroups', '删除', '1', '1', '');
INSERT INTO `ceb_auth_rule` VALUES ('51', '21', 'admin', 'Admin/Order/DelOrder', '删除', '1', '1', '');
INSERT INTO `ceb_auth_rule` VALUES ('52', '21', 'admin', 'Admin/Order/ImportData', '导入', '1', '1', '');

-- ----------------------------
-- Table structure for `ceb_order_batch`
-- ----------------------------
DROP TABLE IF EXISTS `ceb_order_batch`;
CREATE TABLE `ceb_order_batch` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `batch_time` varchar(60) NOT NULL COMMENT '批次号',
  `batch_note` varchar(1000) DEFAULT NULL COMMENT '批次注释',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ceb_order_batch
-- ----------------------------
INSERT INTO `ceb_order_batch` VALUES ('14', '201711091542533880', 'v');
INSERT INTO `ceb_order_batch` VALUES ('15', '201711110853116872', 'v2');
INSERT INTO `ceb_order_batch` VALUES ('16', '201711111730308065', 'f');

-- ----------------------------
-- Table structure for `ceb_order_goods`
-- ----------------------------
DROP TABLE IF EXISTS `ceb_order_goods`;
CREATE TABLE `ceb_order_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_no` varchar(60) NOT NULL COMMENT '交易平台的订单编号，同一交易平台的订单编号。订单编号长度不能超过60位。',
  `gnum` decimal(4,0) NOT NULL COMMENT '从1开始的递增序号。',
  `item_no` varchar(30) DEFAULT NULL COMMENT '电商企业自定义的商品货号（SKU）。',
  `item_name` varchar(250) NOT NULL COMMENT '交易平台销售商品的中文名称。',
  `item_describe` varchar(1000) DEFAULT NULL COMMENT '交易平台销售商品的描述信息。',
  `bar_code` varchar(50) DEFAULT NULL COMMENT '国际通用的商品条形码，一般由前缀部分、制造厂商代码、商品代码和校验码组成。',
  `qty` decimal(19,2) NOT NULL COMMENT '按成交计量单位的实际数量',
  `qty1` decimal(19,2) NOT NULL COMMENT '按照商品编码规则对应的法定计量单位的实际数量填写。',
  `qty2` decimal(19,2) DEFAULT NULL COMMENT '第二数量',
  `unit` char(3) NOT NULL COMMENT '海关标准的参数代码  《JGS-20 海关业务代码集》- 计量单位代码(计量单位)',
  `unit1` char(3) NOT NULL COMMENT '海关标准的参数代码 《JGS-20 海关业务代码集》- 计量单位代码(法定计量单位)',
  `unit2` char(3) DEFAULT NULL COMMENT '海关标准的参数代码 《JGS-20 海关业务代码集》- 计量单位代码(第二计量单位)',
  `country` char(3) NOT NULL COMMENT '填写海关标准的参数代码，参照《JGS-20 海关业务代码集》-国家（地区）代码表。',
  `hscode` varchar(60) NOT NULL COMMENT '海关商品编码(Hscode)',
  `gjcode` varchar(60) NOT NULL COMMENT '国检商品编号',
  `gtype` varchar(100) NOT NULL COMMENT '商品规格型号',
  `price` decimal(19,2) NOT NULL COMMENT '商品单价。赠品单价填写为“0”。',
  `total_price` decimal(19,2) NOT NULL COMMENT '商品总价，等于单价乘以数量。',
  `currency` char(3) NOT NULL COMMENT '限定为人民币，填写“142”。',
  `goods_note` varchar(1000) DEFAULT NULL COMMENT '促销活动，商品单价偏离市场价格的，可以在此说明。',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=166 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ceb_order_goods
-- ----------------------------
INSERT INTO `ceb_order_goods` VALUES ('139', 'V8152565181', '1', null, '爱他美婴儿奶粉1段900g', null, null, '6.00', '5.40', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '93.00', '558.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('142', 'V8152455738', '1', null, '爱他美婴儿奶粉3段900g', null, null, '6.00', '5.40', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '91.00', '546.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('143', 'V8152565251', '1', null, 'A2婴儿奶粉3段900g', null, null, '6.00', '5.40', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '91.00', '546.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('148', 'V8152575777', '1', null, 'A2婴儿奶粉2段900g', null, null, '6.00', '5.40', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '93.00', '558.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('149', 'V8152629341', '1', null, 'bellamy婴儿奶粉1段900g', null, null, '2.00', '1.80', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '93.00', '186.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('150', 'V8152629341', '2', null, 'Bellamy婴儿奶粉2段900g', null, null, '4.00', '3.60', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '93.00', '372.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('151', 'V8152565180', '1', null, 'A2婴儿奶粉1段900g', null, null, '6.00', '5.40', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '93.00', '558.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('152', 'F8152620205', '1', null, 'A2婴儿奶粉2段900g', null, null, '3.00', '2.70', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '93.00', '279.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('153', 'F8152565181', '1', null, '爱他美婴儿奶粉1段900g', null, null, '6.00', '5.40', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '93.00', '558.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('156', 'F8152492677', '1', null, '爱他美婴儿奶粉3段900g', null, null, '6.00', '5.40', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '91.00', '546.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('157', 'F8152514637', '1', null, '爱他美婴儿奶粉4段900g', null, null, '6.00', '5.40', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '91.00', '546.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('160', 'F8152565251', '1', null, 'A2婴儿奶粉3段900g', null, null, '6.00', '5.40', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '91.00', '546.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('161', 'F8152565180', '1', null, 'A2婴儿奶粉1段900g', null, null, '6.00', '5.40', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '93.00', '558.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('162', 'V8152455659', '1', null, 'bellamy婴儿奶粉1段900g', null, null, '2.00', '1.80', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '93.00', '186.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('163', 'V8152455659', '2', null, 'Bellamy婴儿奶粉2段900g', null, null, '4.00', '3.60', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '93.00', '372.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('164', 'F8152638254', '1', null, '爱他美婴儿奶粉4段900g', null, null, '6.00', '5.40', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '91.00', '546.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('165', 'F8152575777', '1', null, 'A2婴儿奶粉2段900g', null, null, '6.00', '5.40', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '93.00', '558.00', '142', null);

-- ----------------------------
-- Table structure for `ceb_order_head`
-- ----------------------------
DROP TABLE IF EXISTS `ceb_order_head`;
CREATE TABLE `ceb_order_head` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_no` varchar(60) NOT NULL COMMENT '交易平台的订单编号，同一交易平台的订单编号应唯一。订单编号长度不能超过60位。',
  `ebp_code` varchar(18) NOT NULL COMMENT '电商平台的海关注册登记编号；电商平台未在海关注册登记，由电商企业发送订单的，以中国电子口岸发布的电商平台标识编号为准。',
  `ebp_name` varchar(100) NOT NULL COMMENT '电商平台的海关注册登记名称；电商平台未在海关注册登记，由电商企业发送订单的，以中国电子口岸发布的电商平台名称为准。',
  `ebc_code` varchar(18) NOT NULL DEFAULT '' COMMENT '电商企业的海关注册登记编号。',
  `ebc_name` varchar(100) NOT NULL COMMENT '电商企业的海关注册登记名称。',
  `goods_value` decimal(19,2) NOT NULL COMMENT '商品实际成交价，含非现金抵扣金额。',
  `freight` decimal(19,2) NOT NULL COMMENT '不包含在商品价格中的运杂费，无则填写"0"。',
  `discount` decimal(19,2) NOT NULL COMMENT '使用积分、虚拟货币、代金券等非现金支付金额，无则填写"0"。',
  `tax_total` decimal(19,2) NOT NULL COMMENT '企业预先代扣的税款金额，无则填写“0”',
  `actural_paid` decimal(19,2) NOT NULL COMMENT '商品价格+运杂费+代扣税款-非现金抵扣金额，与支付凭证的支付金额一致。',
  `currency` char(3) NOT NULL COMMENT '限定为人民币，填写“142”。',
  `buyer_name` varchar(60) NOT NULL COMMENT '订购人的真实姓名。',
  `buyer_telephone` varchar(50) NOT NULL COMMENT '收货人联系电话，必须与电子运单的收货人电话一致。',
  `buyer_id_type` char(1) NOT NULL COMMENT '1-身份证,2-其它。限定为身份证，填写“1”。',
  `buyer_id_number` varchar(60) NOT NULL COMMENT '订购人的身份证件号码。',
  `consignee` varchar(100) NOT NULL COMMENT '收货人姓名，必须与电子运单的收货人姓名一致。',
  `consignee_telephone` varchar(50) NOT NULL COMMENT '收货人联系电话，必须与电子运单的收货人电话一致。',
  `consignee_address` varchar(200) NOT NULL COMMENT '收货地址，必须与电子运单的收货地址一致。',
  `pay_code` varchar(18) DEFAULT NULL COMMENT '支付企业的海关注册登记编号。',
  `pay_name` varchar(100) DEFAULT NULL COMMENT '支付企业在海关注册登记的企业名称。',
  `pay_transaction_id` varchar(60) DEFAULT NULL COMMENT '支付企业唯一的支付流水号。',
  `oh_note` varchar(1000) DEFAULT NULL COMMENT '备注',
  `declare_status` char(1) DEFAULT '0' COMMENT '报关状态',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `batch_time` varchar(60) NOT NULL COMMENT '导入的批次号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_no` (`order_no`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ceb_order_head
-- ----------------------------
INSERT INTO `ceb_order_head` VALUES ('119', 'V8152565181', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '558.00', '0.00', '0.00', '66.40', '624.40', '142', '王梦蝶', '13865527197', '1', '340302198706221029', '王梦蝶', '13865527197', '安徽省蚌埠市龙子湖区东城师范府邸18栋一单元802', null, null, null, null, '1', '2017-11-09 15:42:53', '201711091542533880');
INSERT INTO `ceb_order_head` VALUES ('121', 'V8152455738', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '546.00', '0.00', '0.00', '64.97', '610.97', '142', '耿放', '13965710890', '1', '342123198002050017', '耿放', '13965710890', '安徽省阜阳市太和县长征北路晶宫世纪城楼下欧利雅家居', null, null, null, null, '0', '2017-11-09 15:42:53', '201711091542533880');
INSERT INTO `ceb_order_head` VALUES ('122', 'V8152565251', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '546.00', '0.00', '0.00', '64.97', '610.97', '142', '张婷', '15715517617', '1', '110102198203150042', '张婷', '15715517617', '安徽省合肥市高新区科学大道108号狮城微宴楼', null, null, null, null, '1', '2017-11-09 15:42:53', '201711091542533880');
INSERT INTO `ceb_order_head` VALUES ('126', 'V8152575777', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '558.00', '0.00', '0.00', '66.40', '624.40', '142', '丁一', '15856960801', '1', '142333198909251817', '丁一', '15856960801', '安徽省合肥市潜山路国际花都天香苑8号一栋303', null, null, null, null, '0', '2017-11-09 15:42:53', '201711091542533880');
INSERT INTO `ceb_order_head` VALUES ('127', 'V8152629341', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '558.00', '0.00', '0.00', '66.40', '624.40', '142', '王丹丹', '13813502033', '1', '23233019910115144X', '王丹丹', '13813502033', '安徽省亳州市蒙城县范集工业园区', null, null, null, null, '0', '2017-11-11 08:53:11', '201711110853116872');
INSERT INTO `ceb_order_head` VALUES ('128', 'V8152565180', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '558.00', '0.00', '0.00', '66.40', '624.40', '142', '马楠', '18656000806', '1', '210881198801300503', '马楠', '18656000806', '安徽省合肥市高新区香樟大道和红枫路交口香枫创意园B楼501室', null, null, null, null, '0', '2017-11-11 08:53:11', '201711110853116872');
INSERT INTO `ceb_order_head` VALUES ('129', 'F8152620205', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '279.00', '0.00', '0.00', '33.20', '312.20', '142', '伍晓媛', '18298291801', '1', '340881198907272845', '伍晓媛', '18298291801', '安徽省安庆市开发区站南路南侧梦园小区3号楼综合楼一层安庆农商银行', null, null, null, null, '0', '2017-11-11 17:30:30', '201711111730308065');
INSERT INTO `ceb_order_head` VALUES ('130', 'F8152565181', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '558.00', '0.00', '0.00', '66.40', '624.40', '142', '王梦蝶', '13865527197', '1', '340302198706221029', '王梦蝶', '13865527197', '安徽省蚌埠市龙子湖区东城师范府邸18栋一单元802', null, null, null, null, '0', '2017-11-11 17:30:30', '201711111730308065');
INSERT INTO `ceb_order_head` VALUES ('132', 'F8152492677', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '546.00', '0.00', '0.00', '64.97', '610.97', '142', '周雨晴', '18856722969', '1', '210882198806153342', '周雨晴', '18856722969', '安徽省亳州市蒙城县玖隆国际C区3栋403', null, null, null, null, '0', '2017-11-11 17:30:30', '201711111730308065');
INSERT INTO `ceb_order_head` VALUES ('133', 'F8152514637', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '546.00', '0.00', '0.00', '64.97', '610.97', '142', '王艳', '18055073501', '1', '120107198312114546', '王艳', '18055073501', '安徽省滁州市琅琊区城南天逸华府桂园16号楼2单元702室', null, null, null, null, '0', '2017-11-11 17:30:30', '201711111730308065');
INSERT INTO `ceb_order_head` VALUES ('136', 'F8152565251', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '546.00', '0.00', '0.00', '64.97', '610.97', '142', '张婷', '15715517617', '1', '110102198203150042', '张婷', '15715517617', '安徽省合肥市高新区科学大道108号狮城微宴楼', null, null, null, null, '0', '2017-11-11 17:30:30', '201711111730308065');
INSERT INTO `ceb_order_head` VALUES ('137', 'F8152565180', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '558.00', '0.00', '0.00', '66.40', '624.40', '142', '马楠', '18656000806', '1', '210881198801300503', '马楠', '18656000806', '安徽省合肥市高新区香樟大道和红枫路交口香枫创意园B楼501室', null, null, null, null, '0', '2017-11-11 17:30:30', '201711111730308065');
INSERT INTO `ceb_order_head` VALUES ('138', 'V8152455659', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '558.00', '0.00', '0.00', '66.40', '624.40', '142', '吴玮', '15956941535', '1', '231005198507190045', '吴玮', '15956941535', '安徽省合肥市庐阳区荷塘路与蒙城北路交口碧水兰亭小区3栋', null, null, null, null, '0', '2017-11-11 17:30:30', '201711111730308065');
INSERT INTO `ceb_order_head` VALUES ('139', 'F8152638254', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '546.00', '0.00', '0.00', '64.97', '610.97', '142', '沈盼霖', '18709850320', '1', '362202198801124454', '沈盼霖', '18709850320', '安徽省合肥市庐阳区上城国际御景苑1栋303室', null, null, null, null, '0', '2017-11-11 17:30:30', '201711111730308065');
INSERT INTO `ceb_order_head` VALUES ('140', 'F8152575777', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '558.00', '0.00', '0.00', '66.40', '624.40', '142', '丁一', '15856960801', '1', '142333198909251817', '丁一', '15856960801', '安徽省合肥市潜山路国际花都天香苑8号一栋303', null, null, null, null, '1', '2017-11-11 17:30:30', '201711111730308065');

-- ----------------------------
-- Table structure for `ceb_order_preview`
-- ----------------------------
DROP TABLE IF EXISTS `ceb_order_preview`;
CREATE TABLE `ceb_order_preview` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_no` varchar(60) NOT NULL COMMENT '交易平台的订单编号，同一交易平台的订单编号应唯一。订单编号长度不能超过60位。',
  `ebp_code` varchar(18) NOT NULL COMMENT '电商平台的海关注册登记编号；电商平台未在海关注册登记，由电商企业发送订单的，以中国电子口岸发布的电商平台标识编号为准。',
  `ebp_name` varchar(100) NOT NULL COMMENT '电商平台的海关注册登记名称；电商平台未在海关注册登记，由电商企业发送订单的，以中国电子口岸发布的电商平台名称为准。',
  `ebc_code` varchar(18) NOT NULL DEFAULT '' COMMENT '电商企业的海关注册登记编号。',
  `ebc_name` varchar(100) NOT NULL COMMENT '电商企业的海关注册登记名称。',
  `goods_value` decimal(19,2) NOT NULL COMMENT '商品实际成交价，含非现金抵扣金额。',
  `freight` decimal(19,2) NOT NULL COMMENT '不包含在商品价格中的运杂费，无则填写"0"。',
  `discount` decimal(19,2) NOT NULL COMMENT '使用积分、虚拟货币、代金券等非现金支付金额，无则填写"0"。',
  `tax_total` decimal(19,2) NOT NULL COMMENT '企业预先代扣的税款金额，无则填写“0”',
  `actural_paid` decimal(19,2) NOT NULL COMMENT '商品价格+运杂费+代扣税款-非现金抵扣金额，与支付凭证的支付金额一致。',
  `currency` char(3) NOT NULL COMMENT '限定为人民币，填写“142”。',
  `buyer_name` varchar(60) NOT NULL COMMENT '订购人的真实姓名。',
  `buyer_telephone` varchar(50) NOT NULL COMMENT '收货人联系电话，必须与电子运单的收货人电话一致。',
  `buyer_id_type` char(1) NOT NULL COMMENT '1-身份证,2-其它。限定为身份证，填写“1”。',
  `buyer_id_number` varchar(60) NOT NULL COMMENT '订购人的身份证件号码。',
  `consignee` varchar(100) NOT NULL COMMENT '收货人姓名，必须与电子运单的收货人姓名一致。',
  `consignee_telephone` varchar(50) NOT NULL COMMENT '收货人联系电话，必须与电子运单的收货人电话一致。',
  `consignee_address` varchar(200) NOT NULL COMMENT '收货地址，必须与电子运单的收货地址一致。',
  `pay_code` varchar(18) DEFAULT NULL COMMENT '支付企业的海关注册登记编号。',
  `pay_name` varchar(100) DEFAULT NULL COMMENT '支付企业在海关注册登记的企业名称。',
  `pay_transaction_id` varchar(60) DEFAULT NULL COMMENT '支付企业唯一的支付流水号。',
  `oh_note` varchar(1000) DEFAULT NULL COMMENT '备注',
  `gnum` decimal(4,0) NOT NULL COMMENT '从1开始的递增序号。',
  `item_no` varchar(30) DEFAULT NULL COMMENT '电商企业自定义的商品货号（SKU）。',
  `item_name` varchar(250) NOT NULL COMMENT '交易平台销售商品的中文名称。',
  `item_describe` varchar(1000) DEFAULT NULL COMMENT '交易平台销售商品的描述信息。',
  `bar_code` varchar(50) DEFAULT NULL COMMENT '国际通用的商品条形码，一般由前缀部分、制造厂商代码、商品代码和校验码组成。',
  `qty` decimal(19,2) NOT NULL COMMENT '按成交计量单位的实际数量',
  `qty1` decimal(19,2) NOT NULL COMMENT '按照商品编码规则对应的法定计量单位的实际数量填写。',
  `qty2` decimal(19,2) DEFAULT NULL COMMENT '第二数量',
  `unit` char(3) NOT NULL COMMENT '海关标准的参数代码  《JGS-20 海关业务代码集》- 计量单位代码(计量单位)',
  `unit1` char(3) NOT NULL COMMENT '海关标准的参数代码 《JGS-20 海关业务代码集》- 计量单位代码(法定计量单位)',
  `unit2` char(3) DEFAULT NULL COMMENT '海关标准的参数代码 《JGS-20 海关业务代码集》- 计量单位代码(第二计量单位)',
  `country` char(3) NOT NULL COMMENT '填写海关标准的参数代码，参照《JGS-20 海关业务代码集》-国家（地区）代码表。',
  `hscode` varchar(60) NOT NULL COMMENT '海关商品编码(Hscode)',
  `gjcode` varchar(60) NOT NULL COMMENT '国检商品编号',
  `gtype` varchar(100) NOT NULL COMMENT '商品规格型号',
  `price` decimal(19,2) NOT NULL COMMENT '商品单价。赠品单价填写为“0”。',
  `total_price` decimal(19,2) NOT NULL COMMENT '商品总价，等于单价乘以数量。',
  `item_currency` char(3) NOT NULL COMMENT '限定为人民币，填写“142”。',
  `goods_note` varchar(1000) DEFAULT NULL COMMENT '促销活动，商品单价偏离市场价格的，可以在此说明。',
  `batch_no` varchar(60) NOT NULL COMMENT '批次号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ceb_order_preview
-- ----------------------------
INSERT INTO `ceb_order_preview` VALUES ('8', 'F8152565181', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '558.00', '0.00', '0.00', '66.40', '624.40', '142', '王梦蝶', '13865527197', '1', '340302198706221029', '王梦蝶', '13865527197', '安徽省蚌埠市龙子湖区东城师范府邸18栋一单元802', null, null, null, null, '1', null, '爱他美婴儿奶粉1段900g', null, null, '6.00', '5.40', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '93.00', '558.00', '142', null, '201711090859446823');
INSERT INTO `ceb_order_preview` VALUES ('9', 'F8152629341', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '186.00', '0.00', '0.00', '22.13', '208.13', '142', '王丹丹', '13813502033', '1', '23233019910115144X', '王丹丹', '13813502033', '安徽省亳州市蒙城县范集工业园区', null, null, null, null, '1', null, 'bellamy婴儿奶粉1段900g', null, null, '2.00', '1.80', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '93.00', '186.00', '142', null, '201711090859446823');
INSERT INTO `ceb_order_preview` VALUES ('10', 'F8152629341', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '372.00', '0.00', '0.00', '44.27', '416.27', '142', '王丹丹', '13813502033', '1', '23233019910115144X', '王丹丹', '13813502033', '安徽省亳州市蒙城县范集工业园区', null, null, null, null, '2', null, 'Bellamy婴儿奶粉2段900g', null, null, '4.00', '3.60', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '93.00', '372.00', '142', null, '201711090859446823');
INSERT INTO `ceb_order_preview` VALUES ('11', 'F8152492677', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '546.00', '0.00', '0.00', '64.97', '610.97', '142', '周雨晴', '18856722969', '1', '210882198806153342', '周雨晴', '18856722969', '安徽省亳州市蒙城县玖隆国际C区3栋403', null, null, null, null, '1', null, '爱他美婴儿奶粉3段900g', null, null, '6.00', '5.40', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '91.00', '546.00', '142', null, '201711090859446823');
INSERT INTO `ceb_order_preview` VALUES ('12', 'F8152514637', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '546.00', '0.00', '0.00', '64.97', '610.97', '142', '王艳', '18055073501', '1', '120107198312114546', '王艳', '18055073501', '安徽省滁州市琅琊区城南天逸华府桂园16号楼2单元702室', null, null, null, null, '1', null, '爱他美婴儿奶粉4段900g', null, null, '6.00', '5.40', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '91.00', '546.00', '142', null, '201711090859446823');
INSERT INTO `ceb_order_preview` VALUES ('13', 'F8152455738', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '546.00', '0.00', '0.00', '64.97', '610.97', '142', '耿放', '13965710890', '1', '342123198002050017', '耿放', '13965710890', '安徽省阜阳市太和县长征北路晶宫世纪城楼下欧利雅家居', null, null, null, null, '1', null, '爱他美婴儿奶粉3段900g', null, null, '6.00', '5.40', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '91.00', '546.00', '142', null, '201711090859446823');
INSERT INTO `ceb_order_preview` VALUES ('14', 'F8152565251', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '546.00', '0.00', '0.00', '64.97', '610.97', '142', '张婷', '15715517617', '1', '110102198203150042', '张婷', '15715517617', '安徽省合肥市高新区科学大道108号狮城微宴楼', null, null, null, null, '1', null, 'A2婴儿奶粉3段900g', null, null, '6.00', '5.40', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '91.00', '546.00', '142', null, '201711090859446823');
INSERT INTO `ceb_order_preview` VALUES ('15', 'F8152565180', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '558.00', '0.00', '0.00', '66.40', '624.40', '142', '马楠', '18656000806', '1', '210881198801300503', '马楠', '18656000806', '安徽省合肥市高新区香樟大道和红枫路交口香枫创意园B楼501室', null, null, null, null, '1', null, 'A2婴儿奶粉1段900g', null, null, '6.00', '5.40', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '93.00', '558.00', '142', null, '201711090859446823');
INSERT INTO `ceb_order_preview` VALUES ('16', 'F8152638254', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '546.00', '0.00', '0.00', '64.97', '610.97', '142', '沈盼霖', '18709850320', '1', '362202198801124454', '沈盼霖', '18709850320', '安徽省合肥市庐阳区上城国际御景苑1栋303室', null, null, null, null, '1', null, '爱他美婴儿奶粉4段900g', null, null, '6.00', '5.40', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '91.00', '546.00', '142', null, '201711090859446823');
INSERT INTO `ceb_order_preview` VALUES ('17', 'V8152565181', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '558.00', '0.00', '0.00', '66.40', '624.40', '142', '王梦蝶', '13865527197', '1', '340302198706221029', '王梦蝶', '13865527197', '安徽省蚌埠市龙子湖区东城师范府邸18栋一单元802', null, null, null, null, '1', null, '爱他美婴儿奶粉1段900g', null, null, '6.00', '5.40', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '93.00', '558.00', '142', null, '201711090859552910');
INSERT INTO `ceb_order_preview` VALUES ('18', 'V8152629341', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '186.00', '0.00', '0.00', '22.13', '208.13', '142', '王丹丹', '13813502033', '1', '23233019910115144X', '王丹丹', '13813502033', '安徽省亳州市蒙城县范集工业园区', null, null, null, null, '1', null, 'bellamy婴儿奶粉1段900g', null, null, '2.00', '1.80', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '93.00', '186.00', '142', null, '201711090859552910');
INSERT INTO `ceb_order_preview` VALUES ('19', 'V8152629341', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '372.00', '0.00', '0.00', '44.27', '416.27', '142', '王丹丹', '13813502033', '1', '23233019910115144X', '王丹丹', '13813502033', '安徽省亳州市蒙城县范集工业园区', null, null, null, null, '2', null, 'Bellamy婴儿奶粉2段900g', null, null, '4.00', '3.60', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '93.00', '372.00', '142', null, '201711090859552910');
INSERT INTO `ceb_order_preview` VALUES ('20', 'V8152565180', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '558.00', '0.00', '0.00', '66.40', '624.40', '142', '马楠', '18656000806', '1', '210881198801300503', '马楠', '18656000806', '安徽省合肥市高新区香樟大道和红枫路交口香枫创意园B楼501室', null, null, null, null, '1', null, 'A2婴儿奶粉1段900g', null, null, '6.00', '5.40', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '93.00', '558.00', '142', null, '201711090859552910');
INSERT INTO `ceb_order_preview` VALUES ('21', 'V8152638254', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '546.00', '0.00', '0.00', '64.97', '610.97', '142', '沈盼霖', '18709850320', '1', '362202198801124454', '沈盼霖', '18709850320', '安徽省合肥市庐阳区上城国际御景苑1栋303室', null, null, null, null, '1', null, '爱他美婴儿奶粉4段900g', null, null, '6.00', '5.40', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '91.00', '546.00', '142', null, '201711090859552910');
INSERT INTO `ceb_order_preview` VALUES ('22', 'V8152565181', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '558.00', '0.00', '0.00', '66.40', '624.40', '142', '王梦蝶', '13865527197', '1', '340302198706221029', '王梦蝶', '13865527197', '安徽省蚌埠市龙子湖区东城师范府邸18栋一单元802', null, null, null, null, '1', null, '爱他美婴儿奶粉1段900g', null, null, '6.00', '5.40', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '93.00', '558.00', '142', null, '201711090908286612');
INSERT INTO `ceb_order_preview` VALUES ('23', 'V8152629341', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '186.00', '0.00', '0.00', '22.13', '208.13', '142', '王丹丹', '13813502033', '1', '23233019910115144X', '王丹丹', '13813502033', '安徽省亳州市蒙城县范集工业园区', null, null, null, null, '1', null, 'bellamy婴儿奶粉1段900g', null, null, '2.00', '1.80', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '93.00', '186.00', '142', null, '201711090908286612');
INSERT INTO `ceb_order_preview` VALUES ('24', 'V8152629341', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '372.00', '0.00', '0.00', '44.27', '416.27', '142', '王丹丹', '13813502033', '1', '23233019910115144X', '王丹丹', '13813502033', '安徽省亳州市蒙城县范集工业园区', null, null, null, null, '2', null, 'Bellamy婴儿奶粉2段900g', null, null, '4.00', '3.60', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '93.00', '372.00', '142', null, '201711090908286612');
INSERT INTO `ceb_order_preview` VALUES ('25', 'V8152455738', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '546.00', '0.00', '0.00', '64.97', '610.97', '142', '耿放', '13965710890', '1', '342123198002050017', '耿放', '13965710890', '安徽省阜阳市太和县长征北路晶宫世纪城楼下欧利雅家居', null, null, null, null, '1', null, '爱他美婴儿奶粉3段900g', null, null, '6.00', '5.40', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '91.00', '546.00', '142', null, '201711090908286612');
INSERT INTO `ceb_order_preview` VALUES ('26', 'V8152565251', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '546.00', '0.00', '0.00', '64.97', '610.97', '142', '张婷', '15715517617', '1', '110102198203150042', '张婷', '15715517617', '安徽省合肥市高新区科学大道108号狮城微宴楼', null, null, null, null, '1', null, 'A2婴儿奶粉3段900g', null, null, '6.00', '5.40', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '91.00', '546.00', '142', null, '201711090908286612');
INSERT INTO `ceb_order_preview` VALUES ('27', 'V8152565180', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '558.00', '0.00', '0.00', '66.40', '624.40', '142', '马楠', '18656000806', '1', '210881198801300503', '马楠', '18656000806', '安徽省合肥市高新区香樟大道和红枫路交口香枫创意园B楼501室', null, null, null, null, '1', null, 'A2婴儿奶粉1段900g', null, null, '6.00', '5.40', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '93.00', '558.00', '142', null, '201711090908286612');
INSERT INTO `ceb_order_preview` VALUES ('28', 'V8152455659', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '186.00', '0.00', '0.00', '22.13', '208.13', '142', '吴玮', '15956941535', '1', '231005198507190045', '吴玮', '15956941535', '安徽省合肥市庐阳区荷塘路与蒙城北路交口碧水兰亭小区3栋', null, null, null, null, '1', null, 'bellamy婴儿奶粉1段900g', null, null, '2.00', '1.80', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '93.00', '186.00', '142', null, '201711090908286612');
INSERT INTO `ceb_order_preview` VALUES ('29', 'V8152455659', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '372.00', '0.00', '0.00', '44.27', '416.27', '142', '吴玮', '15956941535', '1', '231005198507190045', '吴玮', '15956941535', '安徽省合肥市庐阳区荷塘路与蒙城北路交口碧水兰亭小区3栋', null, null, null, null, '2', null, 'Bellamy婴儿奶粉2段900g', null, null, '4.00', '3.60', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '93.00', '372.00', '142', null, '201711090908286612');
INSERT INTO `ceb_order_preview` VALUES ('30', 'V8152638254', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '546.00', '0.00', '0.00', '64.97', '610.97', '142', '沈盼霖', '18709850320', '1', '362202198801124454', '沈盼霖', '18709850320', '安徽省合肥市庐阳区上城国际御景苑1栋303室', null, null, null, null, '1', null, '爱他美婴儿奶粉4段900g', null, null, '6.00', '5.40', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '91.00', '546.00', '142', null, '201711090908286612');
INSERT INTO `ceb_order_preview` VALUES ('31', 'V8152575777', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '558.00', '0.00', '0.00', '66.40', '624.40', '142', '丁一', '15856960801', '1', '142333198909251817', '丁一', '15856960801', '安徽省合肥市潜山路国际花都天香苑8号一栋303', null, null, null, null, '1', null, 'A2婴儿奶粉2段900g', null, null, '6.00', '5.40', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '93.00', '558.00', '142', null, '201711090908286612');
INSERT INTO `ceb_order_preview` VALUES ('46', 'V8152629341', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '186.00', '0.00', '0.00', '22.13', '208.13', '142', '王丹丹', '13813502033', '1', '23233019910115144X', '王丹丹', '13813502033', '安徽省亳州市蒙城县范集工业园区', null, null, null, null, '1', null, 'bellamy婴儿奶粉1段900g', null, null, '2.00', '1.80', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '93.00', '186.00', '142', null, '201711101713303978');
INSERT INTO `ceb_order_preview` VALUES ('47', 'V8152629341', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '372.00', '0.00', '0.00', '44.27', '416.27', '142', '王丹丹', '13813502033', '1', '23233019910115144X', '王丹丹', '13813502033', '安徽省亳州市蒙城县范集工业园区', null, null, null, null, '2', null, 'Bellamy婴儿奶粉2段900g', null, null, '4.00', '3.60', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '93.00', '372.00', '142', null, '201711101713303978');
