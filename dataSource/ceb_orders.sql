/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50714
Source Host           : localhost:3306
Source Database       : ceb_orders

Target Server Type    : MYSQL
Target Server Version : 50714
File Encoding         : 65001

Date: 2017-11-22 08:47:53
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
INSERT INTO `ceb_admin` VALUES ('1', 'admin', '21232f297a57a5a743894a0e4a801fc3', '0.0.0.0', '9', '2017-11-21 16:50:56');
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
INSERT INTO `ceb_auth_group_access` VALUES ('1', '27,7');
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
) ENGINE=MyISAM AUTO_INCREMENT=54 DEFAULT CHARSET=utf8 COMMENT='规则表';

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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ceb_order_batch
-- ----------------------------
INSERT INTO `ceb_order_batch` VALUES ('21', '201711201728309031', 'fff');

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
  `gjcode` varchar(60) DEFAULT NULL COMMENT '国检商品编号',
  `gtype` varchar(100) NOT NULL COMMENT '商品规格型号',
  `price` decimal(19,2) NOT NULL COMMENT '商品单价。赠品单价填写为“0”。',
  `total_price` decimal(19,2) NOT NULL COMMENT '商品总价，等于单价乘以数量。',
  `currency` char(3) NOT NULL COMMENT '限定为人民币，填写“142”。',
  `goods_note` varchar(1000) DEFAULT NULL COMMENT '促销活动，商品单价偏离市场价格的，可以在此说明。',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=215 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ceb_order_goods
-- ----------------------------
INSERT INTO `ceb_order_goods` VALUES ('201', 'F8152620205', '1', null, 'A2婴儿奶粉2段900g', null, null, '3.00', '2.70', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '93.00', '279.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('202', 'F8152565181', '1', null, '爱他美婴儿奶粉1段900g', null, null, '6.00', '5.40', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '93.00', '558.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('203', 'F8152629341', '1', '', 'bellamy婴儿奶粉1段900g', '', '', '2.00', '1.80', '0.00', '122', '035', '', '601', '1901101000', '2015617298', '900克/罐', '93.00', '186.00', '142', '');
INSERT INTO `ceb_order_goods` VALUES ('204', 'F8152629341', '2', null, 'Bellamy婴儿奶粉2段900g', null, null, '4.00', '3.60', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '93.00', '372.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('205', 'F8152492677', '1', null, '爱他美婴儿奶粉3段900g', null, null, '6.00', '5.40', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '91.00', '546.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('206', 'F8152514637', '1', null, '爱他美婴儿奶粉4段900g', null, null, '6.00', '5.40', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '91.00', '546.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('207', 'F8152455738', '1', null, '爱他美婴儿奶粉3段900g', null, null, '6.00', '5.40', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '91.00', '546.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('208', 'F8152575724', '1', null, 'Bellamy婴儿奶粉3段900g', null, null, '6.00', '5.40', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '91.00', '546.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('209', 'F8152565251', '1', '', 'A2婴儿奶粉3段900g', '', '', '6.00', '5.40', '0.00', '122', '035', '', '601', '1901101000', '2015617298', '900克/罐', '91.00', '546.00', '142', '');
INSERT INTO `ceb_order_goods` VALUES ('210', 'F8152565180', '1', '', 'A2婴儿奶粉1段900g', '', '', '6.00', '5.40', '0.00', '122', '035', '', '601', '1901101000', '2015617298', '900克/罐', '93.00', '558.00', '142', '');
INSERT INTO `ceb_order_goods` VALUES ('211', 'V8152455659', '1', '', 'bellamy婴儿奶粉1段900g', '', '', '2.00', '1.80', '0.00', '122', '035', '', '601', '1901101000', '2015617298', '900克/罐', '93.00', '186.00', '142', '');
INSERT INTO `ceb_order_goods` VALUES ('212', 'V8152455659', '2', null, 'Bellamy婴儿奶粉2段900g', null, null, '4.00', '3.60', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '93.00', '372.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('213', 'F8152638254', '1', null, '爱他美婴儿奶粉4段900g', null, null, '6.00', '5.40', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '91.00', '546.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('214', 'F8152575777', '1', null, 'A2婴儿奶粉2段900g', null, null, '6.00', '5.40', null, '122', '035', null, '601', '1901101000', '2015617298', '900克/罐', '93.00', '558.00', '142', null);

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
  `buyer_regno` varchar(60) DEFAULT NULL COMMENT '订购人注册号',
  `buyer_name` varchar(60) NOT NULL COMMENT '订购人的真实姓名。',
  `buyer_telephone` varchar(50) NOT NULL COMMENT '收货人联系电话，必须与电子运单的收货人电话一致。',
  `buyer_id_type` char(1) NOT NULL COMMENT '1-身份证,2-其它。限定为身份证，填写“1”。',
  `buyer_id_number` varchar(60) NOT NULL COMMENT '订购人的身份证件号码。',
  `pay_code` varchar(18) DEFAULT NULL COMMENT '支付企业的海关注册登记编号。',
  `pay_name` varchar(100) DEFAULT NULL COMMENT '支付企业在海关注册登记的企业名称。',
  `pay_transaction_id` varchar(60) DEFAULT NULL COMMENT '支付企业唯一的支付流水号。',
  `consignee` varchar(100) NOT NULL COMMENT '收货人姓名，必须与电子运单的收货人姓名一致。',
  `consignee_telephone` varchar(50) NOT NULL COMMENT '收货人联系电话，必须与电子运单的收货人电话一致。',
  `consignee_address` varchar(200) NOT NULL COMMENT '收货地址，必须与电子运单的收货地址一致。',
  `logistics_no` varchar(60) NOT NULL COMMENT '物流企业的运单包裹面单号。同一物流企业的运单编号在6个月内不重复。运单编号长度不能超过60位。',
  `trade_mode` char(4) NOT NULL COMMENT '直购进口填写“9610”，保税进口填写“1210”。',
  `books_no` varchar(60) DEFAULT NULL COMMENT '保税模式必填，填写区内仓储企业在海关备案的账册编号，用于保税进口业务在特殊区域辅助系统记账（二线出区核减）。',
  `license_no` varchar(60) DEFAULT NULL COMMENT '商务主管部门及其授权发证机关签发的进出口货物许可证件的编号',
  `a_country` char(3) NOT NULL COMMENT '直购进口填写起始发出国家（地区）代码，参照《JGS-20 海关业务代码集》的国家（地区）代码表；保税进口填写代码“142”。',
  `freight2` decimal(19,2) NOT NULL COMMENT '物流企业实际收取的运输费用。',
  `insured_fee` decimal(19,2) NOT NULL COMMENT '物流企业实际收取的商品保价费用。',
  `wrap_type` char(1) NOT NULL COMMENT '海关对进出口货物实际采用的外部包装方式的标识代码，采用1 位数字表示，如：木箱、纸箱、桶装、散装、托盘、包、油罐车等',
  `gross_weight` decimal(19,2) NOT NULL COMMENT '毛重',
  `net_weight` decimal(19,2) NOT NULL COMMENT '净重',
  `bill_no` varchar(60) NOT NULL COMMENT '提单号',
  `voyage_no` varchar(60) NOT NULL COMMENT '航班航次号',
  `pack_no` decimal(19,0) NOT NULL COMMENT '件数',
  `oh_note` varchar(1000) DEFAULT NULL COMMENT '备注',
  `declare_status` char(1) DEFAULT '0' COMMENT '报关状态',
  `pay_status` char(1) DEFAULT '0' COMMENT '支付状态',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `batch_time` varchar(60) NOT NULL COMMENT '导入的批次号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_no` (`order_no`)
) ENGINE=InnoDB AUTO_INCREMENT=182 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ceb_order_head
-- ----------------------------
INSERT INTO `ceb_order_head` VALUES ('170', 'F8152620205', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '279.00', '0.00', '0.00', '33.20', '312.20', '142', null, '伍晓媛', '18298291801', '1', '340881198907272845', null, null, null, '伍晓媛', '18298291801', '安徽省安庆市开发区站南路南侧梦园小区3号楼综合楼一层安庆农商银行', '', '', null, null, '', '0.00', '0.00', '', '0.00', '0.00', '', '', '0', null, '0', '0', '2017-11-20 17:28:30', '201711201728309031');
INSERT INTO `ceb_order_head` VALUES ('171', 'F8152565181', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '558.00', '0.00', '0.00', '66.40', '624.40', '142', null, '王梦蝶', '13865527197', '1', '340302198706221029', null, null, null, '王梦蝶', '13865527197', '安徽省蚌埠市龙子湖区东城师范府邸18栋一单元802', '', '', null, null, '', '0.00', '0.00', '', '0.00', '0.00', '', '', '0', null, '0', '0', '2017-11-20 17:28:30', '201711201728309031');
INSERT INTO `ceb_order_head` VALUES ('172', 'F8152629341', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '558.00', '0.00', '0.00', '66.40', '624.40', '142', null, '王丹丹', '13813502033', '1', '23233019910115144X', null, null, null, '王丹丹', '13813502033', '安徽省亳州市蒙城县范集工业园区', '', '', null, null, '', '0.00', '0.00', '', '0.00', '0.00', '', '', '0', null, '1', '1', '2017-11-20 17:28:30', '201711201728309031');
INSERT INTO `ceb_order_head` VALUES ('173', 'F8152492677', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '546.00', '0.00', '0.00', '64.97', '610.97', '142', null, '周雨晴', '18856722969', '1', '210882198806153342', null, null, null, '周雨晴', '18856722969', '安徽省亳州市蒙城县玖隆国际C区3栋403', '', '', null, null, '', '0.00', '0.00', '', '0.00', '0.00', '', '', '0', null, '0', '0', '2017-11-20 17:28:30', '201711201728309031');
INSERT INTO `ceb_order_head` VALUES ('174', 'F8152514637', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '546.00', '0.00', '0.00', '64.97', '610.97', '142', null, '王艳', '18055073501', '1', '120107198312114546', null, null, null, '王艳', '18055073501', '安徽省滁州市琅琊区城南天逸华府桂园16号楼2单元702室', '', '', null, null, '', '0.00', '0.00', '', '0.00', '0.00', '', '', '0', null, '0', '0', '2017-11-20 17:28:30', '201711201728309031');
INSERT INTO `ceb_order_head` VALUES ('175', 'F8152455738', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '546.00', '0.00', '0.00', '64.97', '610.97', '142', null, '耿放', '13965710890', '1', '342123198002050017', null, null, null, '耿放', '13965710890', '安徽省阜阳市太和县长征北路晶宫世纪城楼下欧利雅家居', '', '', null, null, '', '0.00', '0.00', '', '0.00', '0.00', '', '', '0', null, '0', '0', '2017-11-20 17:28:30', '201711201728309031');
INSERT INTO `ceb_order_head` VALUES ('176', 'F8152575724', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '546.00', '0.00', '0.00', '64.97', '610.97', '142', null, '张梦茹', '13855186528', '1', '340102198704033541', null, null, null, '张梦茹', '13855186528', '安徽省合肥市包河区望湖西路民航家园6栋1004', '', '', null, null, '', '0.00', '0.00', '', '0.00', '0.00', '', '', '0', null, '0', '0', '2017-11-20 17:28:30', '201711201728309031');
INSERT INTO `ceb_order_head` VALUES ('177', 'F8152565251', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '546.00', '0.00', '0.00', '64.97', '610.97', '142', null, '张婷', '15715517617', '1', '110102198203150042', null, null, null, '张婷', '15715517617', '安徽省合肥市高新区科学大道108号狮城微宴楼', '', '', null, null, '', '0.00', '0.00', '', '0.00', '0.00', '', '', '0', null, '0', '1', '2017-11-20 17:28:30', '201711201728309031');
INSERT INTO `ceb_order_head` VALUES ('178', 'F8152565180', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '558.00', '0.00', '0.00', '66.40', '624.40', '142', null, '马楠', '18656000806', '1', '210881198801300503', null, null, null, '马楠', '18656000806', '安徽省合肥市高新区香樟大道和红枫路交口香枫创意园B楼501室', '', '', null, null, '', '0.00', '0.00', '', '0.00', '0.00', '', '', '0', null, '1', '1', '2017-11-20 17:28:30', '201711201728309031');
INSERT INTO `ceb_order_head` VALUES ('179', 'V8152455659', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '558.00', '0.00', '0.00', '66.40', '624.40', '142', null, '吴玮', '15956941535', '1', '231005198507190045', null, null, null, '吴玮', '15956941535', '安徽省合肥市庐阳区荷塘路与蒙城北路交口碧水兰亭小区3栋', '', '', null, null, '', '0.00', '0.00', '', '0.00', '0.00', '', '', '0', null, '0', '1', '2017-11-20 17:28:30', '201711201728309031');
INSERT INTO `ceb_order_head` VALUES ('180', 'F8152638254', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '546.00', '0.00', '0.00', '64.97', '610.97', '142', null, '沈盼霖', '18709850320', '1', '362202198801124454', null, null, null, '沈盼霖', '18709850320', '安徽省合肥市庐阳区上城国际御景苑1栋303室', '', '', null, null, '', '0.00', '0.00', '', '0.00', '0.00', '', '', '0', null, '0', '0', '2017-11-20 17:28:30', '201711201728309031');
INSERT INTO `ceb_order_head` VALUES ('181', 'F8152575777', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '558.00', '0.00', '0.00', '66.40', '624.40', '142', null, '丁一', '15856960801', '1', '142333198909251817', null, null, null, '丁一', '15856960801', '安徽省合肥市潜山路国际花都天香苑8号一栋303', '', '', null, null, '', '0.00', '0.00', '', '0.00', '0.00', '', '', '0', null, '0', '0', '2017-11-20 17:28:30', '201711201728309031');

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
  `buyer_regno` varchar(60) DEFAULT NULL COMMENT '订购人注册号',
  `buyer_name` varchar(60) NOT NULL COMMENT '订购人的真实姓名。',
  `buyer_telephone` varchar(50) NOT NULL COMMENT '收货人联系电话，必须与电子运单的收货人电话一致。',
  `buyer_id_type` char(1) NOT NULL COMMENT '1-身份证,2-其它。限定为身份证，填写“1”。',
  `buyer_id_number` varchar(60) NOT NULL COMMENT '订购人的身份证件号码。',
  `pay_code` varchar(18) DEFAULT NULL COMMENT '支付企业的海关注册登记编号。',
  `pay_name` varchar(100) DEFAULT NULL COMMENT '支付企业在海关注册登记的企业名称。',
  `pay_transaction_id` varchar(60) DEFAULT NULL COMMENT '支付企业唯一的支付流水号。',
  `consignee` varchar(100) NOT NULL COMMENT '收货人姓名，必须与电子运单的收货人姓名一致。',
  `consignee_telephone` varchar(50) NOT NULL COMMENT '收货人联系电话，必须与电子运单的收货人电话一致。',
  `consignee_address` varchar(200) NOT NULL COMMENT '收货地址，必须与电子运单的收货地址一致。',
  `logistics_no` varchar(60) NOT NULL COMMENT '物流企业的运单包裹面单号。同一物流企业的运单编号在6个月内不重复。运单编号长度不能超过60位。',
  `trade_mode` char(4) NOT NULL COMMENT '直购进口填写“9610”，保税进口填写“1210”。',
  `books_no` varchar(60) DEFAULT NULL COMMENT '保税模式必填，填写区内仓储企业在海关备案的账册编号，用于保税进口业务在特殊区域辅助系统记账（二线出区核减）。',
  `license_no` varchar(60) DEFAULT NULL COMMENT '商务主管部门及其授权发证机关签发的进出口货物许可证件的编号',
  `a_country` char(3) NOT NULL COMMENT '直购进口填写起始发出国家（地区）代码，参照《JGS-20 海关业务代码集》的国家（地区）代码表；保税进口填写代码“142”。',
  `freight2` decimal(19,2) NOT NULL COMMENT '物流企业实际收取的运输费用。',
  `insured_fee` decimal(19,2) NOT NULL COMMENT '物流企业实际收取的商品保价费用。',
  `wrap_type` char(1) NOT NULL COMMENT '海关对进出口货物实际采用的外部包装方式的标识代码，采用1 位数字表示，如：木箱、纸箱、桶装、散装、托盘、包、油罐车等',
  `gross_weight` decimal(19,2) NOT NULL COMMENT '毛重',
  `net_weight` decimal(19,2) NOT NULL COMMENT '净重',
  `bill_no` varchar(60) NOT NULL COMMENT '提单号',
  `voyage_no` varchar(60) NOT NULL COMMENT '航班航次号',
  `pack_no` decimal(19,0) NOT NULL COMMENT '件数',
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
  `gjcode` varchar(60) DEFAULT NULL COMMENT '国检商品编号',
  `gtype` varchar(100) NOT NULL COMMENT '商品规格型号',
  `price` decimal(19,2) NOT NULL COMMENT '商品单价。赠品单价填写为“0”。',
  `total_price` decimal(19,2) NOT NULL COMMENT '商品总价，等于单价乘以数量。',
  `item_currency` char(3) NOT NULL COMMENT '限定为人民币，填写“142”。',
  `goods_note` varchar(1000) DEFAULT NULL COMMENT '促销活动，商品单价偏离市场价格的，可以在此说明。',
  `batch_no` varchar(60) NOT NULL COMMENT '批次号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ceb_order_preview
-- ----------------------------
