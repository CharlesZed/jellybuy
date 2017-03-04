
-- ----------------------------
-- 商品分类表 `jb_category`
-- ----------------------------
DROP TABLE IF EXISTS `jb_category`;
CREATE TABLE `jb_category`(
  `cate_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品分类ID',
  `cate_name` varchar(100) NOT NULL COMMENT '商品分类名称',
  `cate_fid` smallint(5) unsigned NOT NULL default '0' COMMENT '分类父ID  顶级分类为0',
  `cate_sort` smallint(5) unsigned NOT NULL default '0' COMMENT '分类排序字段',
  `create_time` int NOT NULL COMMENT '分类创建时间',
   primary key(`cate_id`)
) ENGINE=Innodb AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='商品分类表';

-- ----------------------------
-- 活动标记表 `jb_flag`
-- ----------------------------
DROP TABLE IF EXISTS `jb_flag`;
CREATE TABLE `jb_flag`(
  `flag_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '活动标记id',
  `is_publish` tinyint(1) unsigned default 0 NOT NULL COMMENT '首发标记 1为商品首发',
  `is_deprice` decimal(5,2) NOT NULL default '0' comment '降价标记 0 为原价',
  `is_limit` tinyint(2) unsigned NOT NULL default '0' comment '商品限量购买标记 MAX=99',
  `is_gift`  tinyint(2) unsigned NOT NULL default '0' comment '赠品标记 关联gifts 表 ',
  `is_hot` tinyint(1) unsigned default 0 NOT NULL COMMENT '热销标记',
  `is_new` tinyint(1) unsigned NOT NULL default '0' COMMENT '新品标记',
  `is_preferential` tinyint(1) unsigned NOT NULL default '0' COMMENT '特惠标记',
  primary key(`flag_id`)
) ENGINE=Innodb AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='活动标记表';

-- ----------------------------
-- 商品活动表 `jb_active` ~!请在商品ID列 增加一个索引
-- ----------------------------
DROP TABLE IF EXISTS `jb_active`;
CREATE TABLE `jb_active`(
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT ,
  `flag_id` smallint(5) unsigned NOT NULL COMMENT '关联jb_flag表',
  `goods_id` smallint(5) unsigned NOT NULL COMMENT '关联商品表 goods_id',
  `create_time` int unsigned NOT NULL COMMENT '活动创建时间',
  `end_time` int unsigned NOT NULL COMMENT '活动结束时间',
  primary key(`id`),
  KEY `goods_id` (`goods_id`)
) ENGINE=Innodb AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='商品活动表';


-- ----------------------------
-- 活动赠品表 `jb_gifts`
-- ----------------------------
DROP TABLE IF EXISTS `jb_gifts`;
CREATE TABLE `jb_gifts`(
  `gift_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '赠品ID',
  `gift_goods_id` mediumint(8) unsigned NOT NULL COMMENT '附送 商品ID',
  `gift_goods_count` smallint(5) unsigned NOT NULL default '0' COMMENT '限制每日赠送数量 0为不限制',
  primary key(`gift_id`)
) ENGINE=Innodb AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='活动赠品表';


-- ----------------------------
-- 产品SKU选项值 `jb_product_sku`
-- ----------------------------
DROP TABLE IF EXISTS `jb_product_sku`;
CREATE TABLE `jb_product_sku`(
  `product_sku_option_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '产品SKU选型值ID',
  `product_skuid` int(11) NOT NULL COMMENT '产品SKUID',
  `sku_option_id` int(11) NOT NULL COMMENT 'SKU可选项ID',
  `option_img` varchar(255) NOT NULL COMMENT '选项值配图',
  primary key(`product_sku_option_id`)
) ENGINE=Innodb AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='产品SKU选项值表';

-- ----------------------------
-- 产品SKU `jb_product_sku`
-- ----------------------------
DROP TABLE IF EXISTS `jb_product_sku`;
CREATE TABLE `jb_product_sku`(
  `product_skuid` int(11) NOT NULL AUTO_INCREMENT COMMENT '产品SKUID',
  `goods_id` int(11) NOT NULL COMMENT '商品ID',
  `sku_code` varchar(20) NOT NULL COMMENT 'SKU编码',
  `product_price` decimal(10,2) NOT NULL COMMENT '产品价格',
  primary key(`product_skuid`)
) ENGINE=Innodb AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='产品SKU表';

-- ----------------------------
-- 商品数据表 / 产品product表 `jb_goods` `jb_product`
-- ----------------------------
DROP TABLE IF EXISTS `jb_goods_sku`;
CREATE TABLE `jb_goods_sku` (
  `goods_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `attr_set_id`	mediumint(8) unsigned NOT NULL COMMENT '属性集ID',
  `cat_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '商品分类id',
  `goods_name` varchar(120) NOT NULL DEFAULT '' COMMENT '商品名称',
  `goods_number` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '库存',
  `market_price` decimal(10,2) unsigned NOT NULL DEFAULT '0' COMMENT '市场价格',
  `shop_price` decimal(10,2) unsigned NOT NULL DEFAULT '0' COMMENT '本店售价',
  `goods_brief` varchar(255) NOT NULL DEFAULT '' COMMENT '简单描述',
  `goods_desc` text NOT NULL COMMENT '详细介绍',
  `goods_img` varchar(255) NOT NULL DEFAULT '' COMMENT '高清图',
  `photo` varchar(255) NOT NULL DEFAULT '' COMMENT '相册',
  `proportion` tinyint(1) unsigned NOT NULL default '1' COMMENT '积分返还比例 默认1:1',
  `is_on_sale` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否上架',
  `create_time` int(10) NOT NULL DEFAULT '0' COMMENT '商品创建时间',
  `sort_order` smallint(4) unsigned NOT NULL DEFAULT '100' COMMENT '排序字段',
  `is_delete` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '活动商品标记', 
  `is_sale` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '非卖品标记', 
  PRIMARY KEY (`goods_id`)
) ENGINE=Innodb AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='商品数据表';

-- ----------------------------
-- 属性集 `jb_set_sku`
-- ----------------------------
DROP TABLE IF EXISTS `jb_set_sku`;
CREATE TABLE `jb_set_sku`(
  `attr_set_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '属性集ID',
  `set_name` varchar(60) NOT NULL COMMENT '属性集名称',
  `set_sort` tinyint NOT NULL COMMENT '属性集排序',
  `set_create_time` int NOT NULL COMMENT '属性集创建时间',
  primary key(`attr_set_id`)
) ENGINE=Innodb AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='属性集表';

-- ----------------------------
-- 属性集关联SKU表 `jb_relation_sku`
-- ----------------------------
DROP TABLE IF EXISTS `jb_relation_sku`;
CREATE TABLE `jb_relation_sku`(
  `relation_set_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '属性集关联SKUID',
  `attr_set_id` mediumint(8) unsigned NOT NULL COMMENT '属性集ID',
  `sku_id` mediumint(8) unsigned NOT NULL COMMENT '属性集排序',
  `set_create_time` int NOT NULL COMMENT '属性集创建时间',
  primary key(`relation_set_id`)
) ENGINE=Innodb AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='属性集关联SKU表';

-- ----------------------------
-- SKU属性表 `jb_attribute_sku`
-- ----------------------------
DROP TABLE IF EXISTS `jb_attribute`;
CREATE TABLE `jb_attribute`(
  `sku_attr_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'SKU属性ID',
  `ft_name` varchar(60) NOT NULL COMMENT '前台显示名称',
  `bg_name` varchar(60) NOT NULL COMMENT '后台显示名称',
  `create_time` int NOT NULL COMMENT 'SKUID创建时间',
  primary key(`sku_attr_id`)
) ENGINE=Innodb AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='SKU属性表';

-- ----------------------------
-- SKU可选项 `jb_optional_sku`
-- ----------------------------
DROP TABLE IF EXISTS `jb_optional`;
CREATE TABLE `jb_optional`(
	`sku_optional_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'SKU可选项ID',
	`sku_attr_id` mediumint(8) unsigned NOT NULL COMMENT 'SKU属性ID',
	`create_time` int NOT NULL COMMENT '可选项创建时间',
	primary key(`sku_optional_id`)
) ENGINE=Innodb AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='SKU可选项';

-- ----------------------------
-- 用户表 `jb_users`
-- ----------------------------
DROP TABLE IF EXISTS `jb_users`;
create table `jb_users`(
	`id` int not null auto_increment,
	`user_id` int not null comment '用户id',
	`user_name` varchar(10) not null comment '用户名',
	`user_password` char(32) not null comment '用户密码',
	`user_nickname` varchar(10) not null comment '用户昵称',
	`user_email` varchar(64) not null default '' comment '用户邮箱',
	`user_phone` char(11) not null default '' comment '用户手机',
	`user_salt` char(11) comment '用户盐',
	`user_create_time` int not null comment '创建时间',
	`user_update_time` int not null comment '更新时间',
	`user_login_time` int not null comment '最后登录',
	`user_able` int(4) not null comment '是否可用',
	primary key (`id`),
	KEY `user_id` (`user_id`)
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- 密码找回 `jb_password_resets`
-- ----------------------------
DROP TABLE IF EXISTS `jb_password_resets`;
create table `jb_password_resets`(
	`email` varchar(64) not null default '' comment '邮箱',
	`token` varchar(11) not null comment '令牌',
	`create_time` int not null comment '创建时间',
	KEY `email` (`email`),
	KEY `token` (`token`)
)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='密码找回';

-- ----------------------------
-- 用户信息 `jb_user_info`
-- ----------------------------
DROP TABLE IF EXISTS `jb_user_info`;
create table `jb_user_info`(
	`id` int not null auto_increment,
	`avatar` varchar(20) not null default '' comment '头像',
	`real_name` varchar(20) not null comment '真实姓名',
	`qq` int not null comment 'QQ号码',
	`wechat` varchar(20) not null comment '微信号码 ',
	`github` varchar(20) not null comment 'github账号',
	primary key (`id`)
)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='用户信息';

-- ----------------------------
-- 收货地址 `jb_place_of_receipt`
-- ----------------------------
DROP TABLE IF EXISTS `jb_place_of_receipt`;
create table `jb_place_of_receipt`(
	`id` int not null auto_increment,
	`user_id` int not null comment '用户id',
	`province` varchar(20) not null comment '省',
	`city` varchar(20) not null comment '市',
	`region` varchar(20) not null comment '区',
	`address` varchar(20) not null comment '地址',
	`recipients` varchar(20) not null comment '收件人',
	`phone` varchar(11) not null comment '联系电话',
	`is_defautl` tinyint(1) not null default '1' comment '是否为默认地址',
	`postal_code` int(6) not null comment '邮编',
	primary key (`id`),
	KEY `user_id` (`user_id`)
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='收货地址';

-- ----------------------------
-- 站内信 `jb_site_messages`
-- ----------------------------
DROP TABLE IF EXISTS `jb_site_messages`;
create table `jb_site_messages`(
	`id` int not null auto_increment,
	`sender` int not null default '0' comment '发信人id,0为系统信',
	`recipient_id` int not null comment '收信人id',
	`create_time` int not null comment '创建时间,时间戳',
	`title` varchar(20) not null comment '标题??',
	`content` varchar(120) not null comment '内容',
	`is_read` tinyint(1) not null comment '是否已读',
	primary key (`id`),
	KEY `sender` (`sender`), 
	KEY `recipient_id` (`recipient_id`)
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='站内信';

-- ----------------------------
-- 商品收藏 `jb_favorite_goods`
-- ----------------------------
DROP TABLE IF EXISTS `jb_favorite_goods`;
create table `jb_favorite_goods`(
	`id` int not null auto_increment,
	`user_id` int not null comment '用户id',
	`goods_id` int not null comment '商品id',
	`create_time` int not null comment '收藏时间',
	`add_price` decimal(7.2) not null comment '加入价格',
	`is_pull_notice` tinyint(1) not null comment '是否订阅推送通知,1为订阅',
	primary key (`id`),
	KEY `user_id` (`user_id`), 
	KEY `goods_id` (`goods_id`)
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='商品收藏';


-- ----------------------------
-- 缺货登记 `jb_mark_goods`
-- ----------------------------
DROP TABLE IF EXISTS `jb_mark_goods`;
create table `jb_mark_goods`(
	`id` int not null auto_increment,
	`user_id` int not null comment '用户id',
	`goods_id` int not null comment '商品id',
	`create_time` int not null comment '登记时间',
	`phone` char(11) not null comment '推送手机',
	`email` varchar(64) not null comment '推送邮箱',
	`pull_status` tinyint(1) not null comment '推送状态,1为已推送',
	primary key (`id`)
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='缺货登记';


-- ----------------------------
-- 订单业务表 `jb_orders`
-- ----------------------------
DROP TABLE IF EXISTS `jb_orders`;
create table `jb_orders`(
	`id` int not null auto_increment,
	`user_id` int not null comment '用户id',
	`order_id` int not null comment '订单id,业务编码+uid+年后两位+月+日+订单数',
	`order_stauts` int not null comment '未付款,已付款,待发货,待确认,已签收,退货中,已退货,已取消,已过期,已删除 ',
	`addr_snapshoot` varchar(32) not null comment '地址快照',
	`remark` varchar(140) not null comment '留言',
	`create_time` int(11) not null comment '创建时间',
	`is_delete` tinyint(1) default '0' not null comment '已删除.1为删除,默认0',
	`express_id` tinyint(1) not null comment '快递id',
	`express_sn` char(25) not null UNIQUE comment '快递订单号,索引',
	primary key (`id`),
	KEY `order_id` (`order_id`), 
	KEY `user_id` (`user_id`), 
	KEY `express_id` (`express_id`)
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='订单业务表';

-- ----------------------------
-- 订单属性表 `jb_orders_info`
-- ----------------------------
DROP TABLE IF EXISTS `jb_orders_info`;
create table `jb_orders_info`(
	`id` int not null auto_increment,
	`order_id` int(13) not null comment '订单id',
	`goods_id` int(13) not null comment '商品id',
	`goods_amount` int(4) not null comment '商品数量',
	`goods_price` decimal(7.2) not null comment '商品价格',
	`goods_snapshoot` text not null comment '商品快照',
	`score` tinyint(1) not null comment '评分',
	primary key (id),
	KEY `goods_id` (`goods_id`)
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='订单属性表';

-- ----------------------------
-- 快递表 `jb_experss`
-- ----------------------------
DROP TABLE IF EXISTS `jb_experss`;
create table `jb_experss`(
	`id` int not null auto_increment,
	`express_id` tinyint not null comment '快递id',
	`express_name` varchar(20) not null comment '快递名字',
	`express_logo` varchar(20) not null comment '快递LOGO',
	`express_phone` varchar(30) not null comment '快递电话',
	`express_code` varchar(30) not null comment '快递单号',
	primary key (`id`)
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='快递表';

-- ----------------------------
-- 购物车表 `jb_shopping_cart`
-- ----------------------------
DROP TABLE IF EXISTS `jb_shopping_cart`;
create table `jb_shopping_cart`(
	`id` int not null auto_increment,
	`user_id` int not null comment '用户id',
	`goods_id` int(13) not null comment '商品id',
	`goods_amount` int not null comment '商品数量',
	primary key (id)
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='购物车表';

-- ----------------------------
-- 评论表 `jb_comment`
-- ----------------------------
DROP TABLE IF EXISTS `jb_comment`;
create table `jb_comment`(
	`id` int not null auto_increment,
	`user_id` int not null comment '用户id',
	`goods_id` int(13) not null comment '商品id',
	`create_time` int(11) not null comment '创建时间',
	`content` text not null comment '评论内容',
	`pid` tinyint not null comment '父id,0为系统回复',
	primary key (`id`)
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='评论表';

-- ----------------------------
-- 底部节点表 `jb_footer_nodes`
-- ----------------------------
DROP TABLE IF EXISTS `jb_footer_nodes`;
create table `jb_footer_nodes`(
	`id` int not null auto_increment,
	`footer_node_id` int not null comment '节点id',
	`footer_node_name` varchar(20) not null comment '节点名字',
	`sort` int not null comment '排序',
	`create_time` int(11) not null comment '创建时间',
	primary key (`id`)
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='底部节点表';

-- ----------------------------
-- Banner轮播 `jb_banner_carousel`
-- ----------------------------
DROP TABLE IF EXISTS `jb_banner_carousel`;
create table `jb_banner_carousel`(
	`id` int not null auto_increment,
	`ad_name` varchar(20) not null comment '名字',
	`ad_desc` varchar(20) not null comment '描述',
	`ad_image` varchar(20) not null comment '图片',
	`ad_url` varchar(20) not null comment '链接',
	`ad_start_time` int(11) not null comment '开始时间',
	`ad_end_time` int(11) not null comment '结束时间',
	`create_time` int(11) not null comment '创建时间',
	`sort` int not null comment '排序',
	primary key (`id`)
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='Banner轮播';

-- ----------------------------
-- 广告楼层 `jb_floor_ads`
-- ----------------------------
DROP TABLE IF EXISTS `jb_floor_ads`;
create table `jb_floor_ads`(
	`id` int not null auto_increment,
	`position` varchar(20) not null comment '广告位置 navigation  ',
	`ad_name` varchar(20) not null comment '名称',
	`ad_desc` varchar(20) not null comment '描述',
	`ad_image` varchar(20) not null comment '图片',
	`ad_url` varchar(20) not null comment '链接',
	`ad_start_time` int(11) not null comment '开始时间',
	`ad_end_time` int(11) not null comment '结束时间',
	`create_time` int(11) not null comment '创建时间',
	`sort` int not null comment '排序',
	primary key (id)
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='广告楼层';

-- ----------------------------
-- think_auth_rule，规则表，
-- id:主键，name：规则唯一标识, title：规则中文名称 status 状态：为1正常，为0禁用，condition：规则表达式，为空表示存在就验证，不为空表示按照条件验证
-- ----------------------------
DROP TABLE IF EXISTS `jb_auth_rule`;
CREATE TABLE `jb_auth_rule` (  
    `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',  
    `name` char(80) NOT NULL DEFAULT '' COMMENT '规则唯一标识',  
    `title` char(20) NOT NULL DEFAULT '' COMMENT '规则中文名称',  
    `type` tinyint(1) NOT NULL DEFAULT '1' ,    
    `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：为1正常，为0禁用 ',  
    `condition` char(100) NOT NULL DEFAULT '' COMMENT '规则表达式，为空表示存在就验证，不为空表示按照条件验证 规则附件条件,满足附加条件的规则,才认为是有效的规则',  
    PRIMARY KEY (`id`),  
    UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='规则表';

-- ----------------------------
-- jb_auth_group 用户组表， 
-- id：主键， title:用户组中文名称， rules：用户组拥有的规则id， 多个规则","隔开，status 状态：为1正常，为0禁用
-- ----------------------------
DROP TABLE IF EXISTS `jb_auth_group`;
CREATE TABLE `jb_auth_group` ( 
    `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键', 
    `title` char(100) NOT NULL DEFAULT '' COMMENT '用户组中文名称', 
    `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：为1正常，为0禁用', 
    `rules` char(80) NOT NULL DEFAULT '' COMMENT '用户组拥有的规则id，', 
    PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='规则表';

-- ----------------------------
-- think_auth_group_access 用户组明细表
-- uid:用户id，group_id：用户组id
-- ----------------------------
DROP TABLE IF EXISTS `jb_auth_group_access`;
CREATE TABLE `jb_auth_group_access` (  
    `uid` mediumint(8) unsigned NOT NULL COMMENT '用户id',  
    `group_id` mediumint(8) unsigned NOT NULL COMMENT '用户组id', 
    UNIQUE KEY `uid_group_id` (`uid`,`group_id`),  
    KEY `uid` (`uid`), 
    KEY `group_id` (`group_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='规则表';

-- ----------------------------
-- 用户积分表 `jb_points`
-- ----------------------------
DROP TABLE IF EXISTS `jb_points`;
CREATE TABLE `jb_points`(
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL COMMENT '用户id',
  `points` INT NOT NULL COMMENT '积分',
  PRIMARY KEY (`id`)
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=UTF8 COMMENT='用户积分表';

-- ----------------------------
-- 用户积分变更表 `jb_point_log`
-- ----------------------------
DROP TABLE IF EXISTS `jb_point_log`;
CREATE TABLE `jb_point_log`(
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL COMMENT '用户id',
  `action_from` VARCHAR(255) NOT NULL COMMENT '行为来源',
  `change_amount` INT NOT NULL COMMENT '变更数量',
  `create_time` INT NOT NULL COMMENT '操作时间',
  `operating_user_id` INT NOT NULL COMMENT '执行操作人员id',
  PRIMARY KEY (`id`)
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=UTF8 COMMENT='用户积分变更表';

-- ----------------------------
-- 积分等级表 `jb_point_level`
-- ----------------------------
DROP TABLE IF EXISTS `jb_point_level`;
CREATE TABLE `jb_point_level`(
  `id` INT NOT NULL AUTO_INCREMENT,
  `level` INT NOT NULL COMMENT '等级',
  `level_name` VARCHAR(20) NOT NULL COMMENT '等级名称',
  `level_point` INT NOT NULL COMMENT '等级所需积分',
  `level_img` VARCHAR(100) NOT NULL COMMENT '等级图片',
  PRIMARY KEY(id)
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=UTF8 COMMENT='积分等级表';

-- ----------------------------
-- 专题表 `jb_special`
-- ----------------------------
DROP TABLE IF EXISTS `jb_special`;
CREATE TABLE `jb_special`(
  `id` INT NOT NULL AUTO_INCREMENT,
  `special_id` INT NOT NULL COMMENT '专题id',
  `special_name` VARCHAR(100) NOT NULL COMMENT '专题名字',
  `special_start_time` INT NOT NULL COMMENT '专题开始时间',
  `special_end_time` INT NOT NULL COMMENT '专题结束时间',
  `create_time` int NOT NULL COMMENT '专题创建时间',
  PRIMARY KEY(`id`)
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=UTF8 COMMENT='专题表';

-- ----------------------------
-- 专题属性表 `jb_special_attr`
-- ----------------------------
DROP TABLE IF EXISTS `jb_special_attr`;
CREATE TABLE `jb_special_attr`(
  `id` INT NOT NULL AUTO_INCREMENT,
  `special_id` INT NOT NULL COMMENT '所属专题id',
  `attr_name` VARCHAR(100) NOT NULL COMMENT '属性名字',
  `attr_url` VARCHAR(100) NOT NULL COMMENT '属性的链接',
  `attr_content` TEXT NOT NULL COMMENT '属性内容',
  `attr_sort` INT NOT NULL COMMENT '属性排序',
  PRIMARY KEY(id)
)ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=UTF8 COMMENT='专题属性表';