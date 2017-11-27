/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50714
Source Host           : localhost:3306
Source Database       : ceb_orders

Target Server Type    : MYSQL
Target Server Version : 50714
File Encoding         : 65001

Date: 2017-11-27 16:26:10
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
INSERT INTO `ceb_admin` VALUES ('1', 'admin', '21232f297a57a5a743894a0e4a801fc3', '127.0.0.1', '9', '2017-11-22 10:39:00');
INSERT INTO `ceb_admin` VALUES ('40', 'tom', '21232f297a57a5a743894a0e4a801fc3', '0.0.0.0', '1', '2017-11-09 08:53:59');
INSERT INTO `ceb_admin` VALUES ('41', 'jack', '21232f297a57a5a743894a0e4a801fc3', '0.0.0.0', '0', '2017-11-08 15:40:40');

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
INSERT INTO `ceb_auth_group_access` VALUES ('1', '27,7,1');
INSERT INTO `ceb_auth_group_access` VALUES ('40', '1');
INSERT INTO `ceb_auth_group_access` VALUES ('41', '');

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ceb_order_batch
-- ----------------------------
INSERT INTO `ceb_order_batch` VALUES ('1', '201711241059416201', 'fff');
INSERT INTO `ceb_order_batch` VALUES ('2', '201711271043115167', 'ss');

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
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ceb_order_goods
-- ----------------------------
INSERT INTO `ceb_order_goods` VALUES ('1', '2017112401508718', '1', null, 'COW&GATE牛栏婴儿奶粉3段', null, null, '6.00', '5.40', null, '122', '035', null, '303', '1901101000', null, '900g/罐', '72.00', '432.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('2', '2017112401509561', '1', null, 'COW&GATE牛栏婴儿奶粉3段', null, null, '6.00', '5.40', null, '122', '035', null, '303', '1901101000', null, '900g/罐', '72.00', '432.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('6', '2017112401502489', '1', null, 'NESTLE雀巢成人奶粉', null, null, '6.00', '5.40', null, '122', '035', null, '303', '1901101000', null, '900g/罐', '50.00', '300.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('8', '2017112401504801', '1', null, 'COW&GATE牛栏婴儿奶粉3段', null, null, '6.00', '5.40', null, '122', '035', null, '303', '1901101000', null, '900g/罐', '72.00', '432.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('21', '2017112499982792', '1', '', 'NESTLE雀巢成人奶粉', '', '', '2.00', '1.80', '0.00', '122', '035', '', '303', '1901101000', '', '900g/罐', '50.00', '100.00', '142', '');
INSERT INTO `ceb_order_goods` VALUES ('22', '2017112499982792', '2', null, 'APTAMIL爱他美婴儿奶粉4段', null, null, '4.00', '3.20', null, '122', '035', null, '303', '1901101000', null, '800g/罐', '78.00', '312.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('24', '2017112499987228', '1', null, 'HIPP喜宝2段婴儿奶粉', null, null, '2.00', '1.60', null, '122', '035', null, '303', '1901101000', null, '800g/罐', '72.00', '144.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('25', '2017112499987228', '2', null, 'HIPP喜宝1段婴儿奶粉', null, null, '4.00', '3.20', null, '122', '035', null, '303', '1901101000', null, '800g/罐', '72.00', '288.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('36', '2017112498512863', '1', null, 'COW&GATE牛栏婴儿奶粉4段', null, null, '6.00', '4.80', null, '122', '035', null, '303', '1901101000', null, '800g/罐', '72.00', '432.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('43', '2017112498513516', '1', null, 'COW&GATE牛栏婴儿奶粉4段', null, null, '6.00', '4.80', null, '122', '035', null, '303', '1901101000', null, '800g/罐', '72.00', '432.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('48', '2017112498515941', '1', null, 'COW&GATE牛栏婴儿奶粉3段', null, null, '6.00', '5.40', null, '122', '035', null, '303', '1901101000', null, '900g/罐', '72.00', '432.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('55', '2017112457988240', '1', null, 'SMA惠氏婴儿奶粉3段', null, null, '6.00', '4.80', null, '122', '035', null, '303', '1901101000', null, '800g/罐', '75.00', '450.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('58', '2017112457981078', '1', '', 'SMA惠氏婴儿奶粉3段', '', '', '6.00', '4.80', '0.00', '122', '035', '', '303', '1901101000', '', '800g/罐', '75.00', '450.00', '142', '');
INSERT INTO `ceb_order_goods` VALUES ('64', '2017112755489328', '1', null, 'COW&GATE牛栏婴儿奶粉2段', null, null, '6.00', '5.40', null, '122', '035', null, '303', '1901101000', null, '900g/罐', '76.00', '456.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('66', '2017112755481961', '1', null, 'NESTLE雀巢成人奶粉', null, null, '6.00', '5.40', null, '122', '035', null, '303', '1901101000', null, '900g/罐', '50.00', '300.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('67', '2017112755489480', '1', null, 'NESTLE雀巢成人奶粉', null, null, '6.00', '5.40', null, '122', '035', null, '303', '1901101000', null, '900g/罐', '50.00', '300.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('71', '2017112755486604', '1', null, 'HIPP喜宝2段婴儿奶粉', null, null, '1.00', '0.80', null, '122', '035', null, '303', '1901101000', null, '800g/罐', '72.00', '72.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('72', '2017112755486604', '2', null, 'HIPP喜宝1段婴儿奶粉', null, null, '5.00', '4.00', null, '122', '035', null, '303', '1901101000', null, '800g/罐', '72.00', '360.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('75', '2017112755488721', '1', null, 'HIPP喜宝2段婴儿奶粉', null, null, '6.00', '4.80', null, '122', '035', null, '303', '1901101000', null, '800g/罐', '72.00', '432.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('80', '2017112753578781', '1', null, 'HIPP喜宝1段婴儿奶粉', null, null, '2.00', '1.60', null, '122', '035', null, '303', '1901101000', null, '800g/罐', '72.00', '144.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('81', '2017112753578781', '2', null, 'HIPP喜宝2段婴儿奶粉', null, null, '4.00', '3.20', null, '122', '035', null, '303', '1901101000', null, '800g/罐', '72.00', '288.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('83', '2017112753579579', '1', null, 'NESTLE雀巢成人奶粉', null, null, '6.00', '5.40', null, '122', '035', null, '303', '1901101000', null, '900g/罐', '50.00', '300.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('84', '2017112753577192', '1', null, 'NESTLE雀巢成人奶粉', null, null, '6.00', '5.40', null, '122', '035', null, '303', '1901101000', null, '900g/罐', '50.00', '300.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('87', '2017112753577995', '1', '', 'HIPP喜宝2段婴儿奶粉', '', '', '6.00', '4.80', '0.00', '122', '035', '', '303', '1901101000', '', '800g/罐', '72.00', '432.00', '142', '');
INSERT INTO `ceb_order_goods` VALUES ('88', '2017112753575312', '1', null, 'COW&GATE牛栏婴儿奶粉1段', null, null, '1.00', '0.90', null, '122', '035', null, '303', '1901101000', null, '900g/罐', '76.00', '76.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('89', '2017112753575312', '2', null, 'APTAMIL爱他美婴儿奶粉4段', null, null, '5.00', '4.00', null, '122', '035', null, '303', '1901101000', null, '800g/罐', '78.00', '390.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('90', '2017112753575182', '1', null, 'NESTLE雀巢成人奶粉', null, null, '6.00', '5.40', null, '122', '035', null, '303', '1901101000', null, '900g/罐', '50.00', '300.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('94', '2017112753574665', '1', null, 'COW&GATE牛栏婴儿奶粉3段', null, null, '6.00', '5.40', null, '122', '035', null, '303', '1901101000', null, '900g/罐', '72.00', '432.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('96', '2017112753579110', '1', null, 'HIPP喜宝1段婴儿奶粉', null, null, '6.00', '4.80', null, '122', '035', null, '303', '1901101000', null, '800g/罐', '72.00', '432.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('97', '2017112753574661', '1', null, 'NESTLE雀巢成人奶粉', null, null, '6.00', '5.40', null, '122', '035', null, '303', '1901101000', null, '900g/罐', '50.00', '300.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('98', '2017112753571714', '1', null, 'APTAMIL爱他美婴儿奶粉3段', null, null, '2.00', '1.80', null, '122', '035', null, '303', '1901101000', null, '900g/罐', '78.00', '156.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('99', '2017112753571714', '2', null, 'APTAMIL爱他美婴儿奶粉1段', null, null, '4.00', '3.60', null, '122', '035', null, '303', '1901101000', null, '900g/罐', '82.00', '328.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('100', '2017112753572460', '1', null, 'NESTLE雀巢成人奶粉', null, null, '6.00', '5.40', null, '122', '035', null, '303', '1901101000', null, '900g/罐', '50.00', '300.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('102', '2017112753573587', '1', null, 'HIPP喜宝1段婴儿奶粉', null, null, '6.00', '4.80', null, '122', '035', null, '303', '1901101000', null, '800g/罐', '72.00', '432.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('103', '2017112752496713', '1', null, 'NESTLE雀巢成人奶粉', null, null, '6.00', '5.40', null, '122', '035', null, '303', '1901101000', null, '900g/罐', '50.00', '300.00', '142', null);
INSERT INTO `ceb_order_goods` VALUES ('106', '2017112752494168', '1', null, 'HIPP喜宝1段婴儿奶粉', null, null, '6.00', '4.80', null, '122', '035', null, '303', '1901101000', null, '800g/罐', '72.00', '432.00', '142', null);

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
  UNIQUE KEY `order_no` (`order_no`),
  UNIQUE KEY `logistics_no` (`logistics_no`)
) ENGINE=InnoDB AUTO_INCREMENT=1517 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ceb_order_head
-- ----------------------------
INSERT INTO `ceb_order_head` VALUES ('1423', '2017112401508718', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '432.00', '0.00', '0.00', '0.00', '432.00', '142', '', '卓天明', '13500101311', '1', '350182197610255716', '', '', '', '卓天明', '15059419329', '福建省长乐市闽鹏村下厅125号', '9977926773356', '9610', '', '', '303', '0.00', '0.00', '5', '6.60', '5.40', '15732773053', 'QR028', '6', null, '0', '0', '2017-11-24 10:59:41', '201711241059416201');
INSERT INTO `ceb_order_head` VALUES ('1424', '2017112401509561', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '432.00', '0.00', '0.00', '0.00', '432.00', '142', '', '陈宝珠', '15059419329', '1', '35012619780907652X', '', '', '', '陈宝珠', '15059419329', '福建省长乐市闽鹏村下厅124号', '9977926773357', '9610', '', '', '303', '0.00', '0.00', '5', '6.60', '5.40', '15732773053', 'QR028', '6', null, '0', '0', '2017-11-24 10:59:41', '201711241059416201');
INSERT INTO `ceb_order_head` VALUES ('1428', '2017112401502489', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '300.00', '0.00', '0.00', '0.00', '300.00', '142', '', '唐喜枚', '13873239357', '1', '430321198201137842', '', '', '', '徐俊瑞', '18711310016', '湖南省湘潭市湘潭大学机械工程学院', '9977926773361', '9610', '', '', '303', '0.00', '0.00', '5', '6.60', '5.40', '15732773053', 'QR028', '6', null, '0', '0', '2017-11-24 10:59:41', '201711241059416201');
INSERT INTO `ceb_order_head` VALUES ('1430', '2017112401504801', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '432.00', '0.00', '0.00', '0.00', '432.00', '142', '', '刘建军', '15211080034', '1', '430922198104102014', '', '', '', '刘建军', '15211080034', '湖南省长沙市雨花区芙蓉中路三段569号第六都18B402', '9977926773363', '9610', '', '', '303', '0.00', '0.00', '5', '6.60', '5.40', '15732773053', 'QR028', '6', null, '0', '0', '2017-11-24 10:59:41', '201711241059416201');
INSERT INTO `ceb_order_head` VALUES ('1442', '2017112499982792', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '412.00', '0.00', '0.00', '0.00', '412.00', '142', '', '张丽', '13668065871', '1', '500382199111156420', '', '', '', '张丽', '13668065871', '重庆市合川区钱塘镇交通街137号', '9977926773375', '9610', '', '', '303', '0.00', '0.00', '5', '6.30', '5.00', '15732773053', 'QR028', '6', null, '1', '1', '2017-11-24 10:59:41', '201711241059416201');
INSERT INTO `ceb_order_head` VALUES ('1444', '2017112499987228', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '432.00', '0.00', '0.00', '0.00', '432.00', '142', '', '郑丽华', '15021995387', '1', '350425198502030740', '', '', '', '郑丽华', '15021995387', '上海市浦东新区昌里路340弄42号603', '9977926773377', '9610', '', '', '303', '0.00', '0.00', '5', '5.70', '4.80', '15732773053', 'QR028', '6', null, '0', '0', '2017-11-24 10:59:41', '201711241059416201');
INSERT INTO `ceb_order_head` VALUES ('1452', '2017112498512863', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '432.00', '0.00', '0.00', '0.00', '432.00', '142', '', '贺佳', '13638412552', '1', '430481198202060041', '', '', '', '贺佳', '13638412552', '湖南省永州市道县红星街科委家属院内', '9977926773405', '9610', '', '', '303', '0.00', '0.00', '5', '5.70', '4.80', '15732773053', 'QR028', '6', null, '0', '0', '2017-11-24 10:59:41', '201711241059416201');
INSERT INTO `ceb_order_head` VALUES ('1458', '2017112498513516', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '432.00', '0.00', '0.00', '0.00', '432.00', '142', '', '张谊', '18978192811', '1', '452133197311100317', '', '', '', '张谊', '18978192811', '广西壮族自治区崇左市龙州县疾病预防控制中心', '9977926773493', '9610', '', '', '303', '0.00', '0.00', '5', '5.70', '4.80', '15732773053', 'QR028', '6', null, '0', '0', '2017-11-24 10:59:41', '201711241059416201');
INSERT INTO `ceb_order_head` VALUES ('1463', '2017112498515941', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '432.00', '0.00', '0.00', '0.00', '432.00', '142', '', '李炳泉', '13906218010', '1', '32052419471228391X', '', '', '', '李炳泉', '13906218010', '江苏省苏州市相城区元和街道花南家园2幢501', '9977926773499', '9610', '', '', '303', '0.00', '0.00', '5', '6.60', '5.40', '15732773053', 'QR028', '6', null, '0', '0', '2017-11-24 10:59:41', '201711241059416201');
INSERT INTO `ceb_order_head` VALUES ('1469', '2017112457988240', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '450.00', '0.00', '0.00', '0.00', '450.00', '142', '', '王珊珊', '13726929366', '1', '420682199012133027', '', '', '', '周盐娟', '15980542699', '福建省长乐市文岭镇山边刘村新街8', '9977926773505', '9610', '', '', '303', '0.00', '0.00', '5', '6.00', '4.80', '15732773053', 'QR028', '6', null, '0', '0', '2017-11-24 10:59:41', '201711241059416201');
INSERT INTO `ceb_order_head` VALUES ('1472', '2017112457981078', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '450.00', '0.00', '0.00', '0.00', '450.00', '142', '', '王晓乐', '13804268430', '1', '210282198712061727', '', '', '', '周盐娟', '15980542699', '福建省长乐市文岭镇山边刘村新街9', '9977926773509', '9610', '', '', '303', '0.00', '0.00', '5', '6.00', '4.80', '15732773053', 'QR028', '6', null, '1', '1', '2017-11-24 10:59:41', '201711241059416201');
INSERT INTO `ceb_order_head` VALUES ('1478', '2017112755489328', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '456.00', '0.00', '0.00', '0.00', '456.00', '142', '', '徐俊瑞', '18711310016', '1', '150121192912205415', '', '', '', '徐俊瑞', '18711310016', '湖南省湘潭市湘潭大学机械工程学院', '9977926773362', '9610', '', '', '303', '0.00', '0.00', '5', '6.60', '5.40', '15732773053', 'QR028', '6', null, '0', '0', '2017-11-27 10:43:11', '201711271043115167');
INSERT INTO `ceb_order_head` VALUES ('1480', '2017112755481961', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '300.00', '0.00', '0.00', '0.00', '300.00', '142', '', '康元元', '13292850318', '1', '130184198501240028', '', '', '', '康元元', '13292850318', '河北省石家庄市谈固东街129号银通小区41号楼1单元303', '9977926773365', '9610', '', '', '303', '0.00', '0.00', '5', '6.60', '5.40', '15732773053', 'QR028', '6', null, '0', '0', '2017-11-27 10:43:11', '201711271043115167');
INSERT INTO `ceb_order_head` VALUES ('1481', '2017112755489480', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '300.00', '0.00', '0.00', '0.00', '300.00', '142', '', '王成', '13956638718', '1', '342601197708080036', '', '', '', '王成', '13956638718', '安徽省巢湖市北门转盘湖畔名俊2售楼部', '9977926773366', '9610', '', '', '303', '0.00', '0.00', '5', '6.60', '5.40', '15732773053', 'QR028', '6', null, '0', '0', '2017-11-27 10:43:11', '201711271043115167');
INSERT INTO `ceb_order_head` VALUES ('1485', '2017112755486604', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '432.00', '0.00', '0.00', '0.00', '432.00', '142', '', '马庆奇', '13512561519', '1', '320826197903030001', '', '', '', '马庆奇', '13512561519', '江苏省徐州市天能家园北1号楼2单元202', '9977926773372', '9610', '', '', '303', '0.00', '0.00', '5', '5.75', '4.80', '15732773053', 'QR028', '6', null, '0', '0', '2017-11-27 10:43:11', '201711271043115167');
INSERT INTO `ceb_order_head` VALUES ('1488', '2017112755488721', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '432.00', '0.00', '0.00', '0.00', '432.00', '142', '', '王晖', '15152115923', '1', '320322198412162811', '', '', '', '郑丽华', '15021995387', '上海市浦东新区昌里路340弄42号602', '9977926773376', '9610', '', '', '303', '0.00', '0.00', '5', '5.70', '4.80', '15732773053', 'QR028', '6', null, '0', '0', '2017-11-27 10:43:11', '201711271043115167');
INSERT INTO `ceb_order_head` VALUES ('1491', '2017112753578781', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '432.00', '0.00', '0.00', '0.00', '432.00', '142', '', '乌仁高娃', '18686032210', '1', '152526199112250000', '', '', '', '乌仁高娃', '18686032210', '内蒙古自治区呼和浩特市赛罕区丰州路巨海城9区五号楼-1', '9977926773395', '9610', '', '', '303', '0.00', '0.00', '5', '5.70', '4.80', '15732773053', 'QR028', '6', null, '0', '0', '2017-11-27 10:43:11', '201711271043115167');
INSERT INTO `ceb_order_head` VALUES ('1493', '2017112753579579', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '300.00', '0.00', '0.00', '0.00', '300.00', '142', '', '温静娴', '18273165452', '1', '430602198708136029', '', '', '', '温静娴', '18273165452', '湖南省株洲市石峰区田心街道田心立交桥亿都国际', '9977926773397', '9610', '', '', '303', '0.00', '0.00', '5', '6.60', '5.40', '15732773053', 'QR028', '6', null, '0', '0', '2017-11-27 10:43:11', '201711271043115167');
INSERT INTO `ceb_order_head` VALUES ('1494', '2017112753577192', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '300.00', '0.00', '0.00', '0.00', '300.00', '142', '', '王玲', '18770591778', '1', '36220419891116656X', '', '', '', '姜欢', '13638302223', '重庆市长寿区凤城街道黄桷逸景高层8_2', '9977926773398', '9610', '', '', '303', '0.00', '0.00', '5', '6.60', '5.40', '15732773053', 'QR028', '6', null, '0', '0', '2017-11-27 10:43:11', '201711271043115167');
INSERT INTO `ceb_order_head` VALUES ('1497', '2017112753577995', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '432.00', '0.00', '0.00', '0.00', '432.00', '142', '', '黄艳琴', '13824085996', '1', '440781199010242345', '', '', '', '黄艳琴', '13824085996', '广东省开平市光明路27号爱琴海', '9977926773489', '9610', '', '', '303', '0.00', '0.00', '5', '5.70', '4.80', '15732773053', 'QR028', '6', null, '0', '1', '2017-11-27 10:43:11', '201711271043115167');
INSERT INTO `ceb_order_head` VALUES ('1498', '2017112753575312', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '466.00', '0.00', '0.00', '0.00', '466.00', '142', '', '都艳', '15942882786', '1', '210212198912040542', '', '', '', '都艳', '15942882786', '辽宁省大连市旅顺口区向阳街道西二巷39-202', '9977926773490', '9610', '', '', '303', '0.00', '0.00', '5', '6.10', '4.90', '15732773053', 'QR028', '6', null, '0', '0', '2017-11-27 10:43:11', '201711271043115167');
INSERT INTO `ceb_order_head` VALUES ('1499', '2017112753575182', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '300.00', '0.00', '0.00', '0.00', '300.00', '142', '', '王若芬', '13489177760', '1', '350181197903186981', '', '', '', '张谊', '18978192811', '广西壮族自治区崇左市龙州县疾病预防控制中心隔壁', '9977926773492', '9610', '', '', '303', '0.00', '0.00', '5', '6.60', '5.40', '15732773053', 'QR028', '6', null, '0', '0', '2017-11-27 10:43:11', '201711271043115167');
INSERT INTO `ceb_order_head` VALUES ('1503', '2017112753574665', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '432.00', '0.00', '0.00', '0.00', '432.00', '142', '', '李介明', '13901540925', '1', '320524196808133915', '', '', '', '李介明', '13901540925', '江苏省苏州市相城区黄桥镇苏埭路2', '9977926773498', '9610', '', '', '303', '0.00', '0.00', '5', '6.60', '5.40', '15732773053', 'QR028', '6', null, '0', '0', '2017-11-27 10:43:11', '201711271043115167');
INSERT INTO `ceb_order_head` VALUES ('1505', '2017112753579110', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '432.00', '0.00', '0.00', '0.00', '432.00', '142', '', '陈春妹', '13502555585', '1', '44132319510628204X', '', '', '', '陈春妹', '13422903896', '广东省惠州市惠东县稔山镇大墩村1号', '9977926773501', '9610', '', '', '303', '0.00', '0.00', '5', '5.70', '4.80', '15732773053', 'QR028', '6', null, '0', '0', '2017-11-27 10:43:11', '201711271043115167');
INSERT INTO `ceb_order_head` VALUES ('1506', '2017112753574661', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '300.00', '0.00', '0.00', '0.00', '300.00', '142', '', '林朝英', '13422903896', '1', '441323197611132025', '', '', '', '林朝英', '13422903896', '广东省惠州市惠东县稔山镇大墩村', '9977926773502', '9610', '', '', '303', '0.00', '0.00', '5', '6.60', '5.40', '15732773053', 'QR028', '6', null, '0', '0', '2017-11-27 10:43:11', '201711271043115167');
INSERT INTO `ceb_order_head` VALUES ('1507', '2017112753571714', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '484.00', '0.00', '0.00', '0.00', '484.00', '142', '', '郭本瑞', '15960081380', '1', '350181198405021935', '', '', '', '郭本瑞', '15960081380', '福建省福清市阳下镇北林村208', '9977926773503', '9610', '', '', '303', '0.00', '0.00', '5', '2.20', '1.80', '15732773053', 'QR028', '6', null, '0', '0', '2017-11-27 10:43:11', '201711271043115167');
INSERT INTO `ceb_order_head` VALUES ('1508', '2017112753572460', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '300.00', '0.00', '0.00', '0.00', '300.00', '142', '', '孙曼华', '13567111053', '1', '330125195502280025', '', '', '', '孙曼华', '13567111053', '浙江省杭州市余杭顺平邱山大街607号名门天第1幢1102', '9977926773504', '9610', '', '', '303', '0.00', '0.00', '5', '6.90', '5.40', '15732773053', 'QR028', '6', null, '0', '0', '2017-11-27 10:43:11', '201711271043115167');
INSERT INTO `ceb_order_head` VALUES ('1510', '2017112753573587', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '432.00', '0.00', '0.00', '0.00', '432.00', '142', '', '杨艳', '13702058122', '1', '120113198309153226', '', '', '', '杨艳', '13702058122', '天津市武清区五一阳光锦园24号楼602', '9977926773508', '9610', '', '', '303', '0.00', '0.00', '5', '5.70', '4.80', '15732773053', 'QR028', '6', null, '0', '0', '2017-11-27 10:43:11', '201711271043115167');
INSERT INTO `ceb_order_head` VALUES ('1511', '2017112752496713', '44079610EA', '广东就手电子商务有限公司', '44079610EA', '广东就手电子商务有限公司', '300.00', '0.00', '0.00', '0.00', '300.00', '142', '', '严米费', '18684985254', '1', '430203199007017528', '', '', '', '严米费', '18684985254', '湖南省株洲市石峰区化工厂生活区一区34栋', '9977926773512', '9610', '', '', '303', '0.00', '0.00', '5', '6.60', '5.40', '15732773053', 'QR028', '6', null, '0', '0', '2017-11-27 10:43:11', '201711271043115167');
INSERT INTO `ceb_order_head` VALUES ('1514', '2017112752494168', '44079612EA', '广东就手电子商务有限公司', '44079612EA', '广东就手电子商务有限公司', '432.00', '0.00', '0.00', '0.00', '432.00', '144', '', '左林芳', '17707433556', '1', '433101198810160024', '', '', '', '左林芳', '17707433556', '湖南省吉首市乾州建设工程质量检测中心', '9977926773520', '9610', '', '', '303', '0.00', '0.00', '5', '5.70', '4.80', '15732773053', 'QR028', '6', null, '0', '0', '2017-11-27 10:43:11', '201711271043115167');

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
