/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50714
Source Host           : localhost:3306
Source Database       : ceb_orders

Target Server Type    : MYSQL
Target Server Version : 50714
File Encoding         : 65001

Date: 2017-09-20 15:08:52
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `ceb_order_batch`
-- ----------------------------
DROP TABLE IF EXISTS `ceb_order_batch`;
CREATE TABLE `ceb_order_batch` (
  `id` int(11) NOT NULL,
  `batch_time` datetime NOT NULL COMMENT '导入的批次号',
  `batch_note` varchar(1000) DEFAULT NULL COMMENT '导入批次的备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `batch_time` (`batch_time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ceb_order_batch
-- ----------------------------

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
  `gtype_num` varchar(100) NOT NULL COMMENT '商品规格型号',
  `price` decimal(19,2) NOT NULL COMMENT '商品单价。赠品单价填写为“0”。',
  `total_price` decimal(19,2) NOT NULL COMMENT '商品总价，等于单价乘以数量。',
  `currency` char(3) NOT NULL COMMENT '限定为人民币，填写“142”。',
  `goods_note` varchar(1000) DEFAULT NULL COMMENT '促销活动，商品单价偏离市场价格的，可以在此说明。',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ceb_order_goods
-- ----------------------------

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
  `batch_time` datetime NOT NULL COMMENT '导入批次，用datetime类型表示',
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_no` (`order_no`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ceb_order_head
-- ----------------------------
