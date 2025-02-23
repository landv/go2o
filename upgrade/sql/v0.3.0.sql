-- 更换为POSTGRESQL --
ALTER TABLE "public".mm_member ADD COLUMN flag int4 DEFAULT 0 NOT NULL;

-- mm_balance_log  mm_wallet_log  mm_integral_log 表结构更改
CREATE TABLE "public".mm_integral_log (id serial NOT NULL, member_id int4 NOT NULL, kind int4 NOT NULL, title varchar(60) DEFAULT '""'::character varying NOT NULL, outer_no varchar(40) DEFAULT '""'::character varying NOT NULL, value int4 NOT NULL, remark varchar(40) NOT NULL, rel_user int4 DEFAULT 0 NOT NULL, review_state int2 DEFAULT 0 NOT NULL, create_time int8 NOT NULL, update_time int8 DEFAULT 0 NOT NULL, CONSTRAINT mm_integral_log_pkey PRIMARY KEY (id));
COMMENT ON TABLE "public".mm_integral_log IS '积分明细';
COMMENT ON COLUMN "public".mm_integral_log.id IS '编号';
COMMENT ON COLUMN "public".mm_integral_log.member_id IS '会员编号';
COMMENT ON COLUMN "public".mm_integral_log.kind IS '类型';
COMMENT ON COLUMN "public".mm_integral_log.title IS '标题';
COMMENT ON COLUMN "public".mm_integral_log.outer_no IS '关联的编号';
COMMENT ON COLUMN "public".mm_integral_log.value IS '积分值';
COMMENT ON COLUMN "public".mm_integral_log.remark IS '备注';
COMMENT ON COLUMN "public".mm_integral_log.rel_user IS '关联用户';
COMMENT ON COLUMN "public".mm_integral_log.review_state IS '审核状态';
COMMENT ON COLUMN "public".mm_integral_log.create_time IS '创建时间';
COMMENT ON COLUMN "public".mm_integral_log.update_time IS '更新时间';

CREATE INDEX mm_member_code ON "public".mm_member (code);
CREATE INDEX mm_member_user ON "public".mm_member ("user");

ALTER TABLE "public".mm_member ADD COLUMN avatar varchar(80) DEFAULT '' NOT NULL;
ALTER TABLE "public".mm_member ADD COLUMN phone varchar(15) DEFAULT '' NOT NULL;
 ALTER TABLE "public".mm_member ADD COLUMN email varchar(50) DEFAULT '' NOT NULL;
COMMENT ON COLUMN "public".mm_member.flag IS '会员标志';


ALTER TABLE "public".mm_member ADD COLUMN name varchar(20) DEFAULT '' NOT NULL;
  COMMENT ON COLUMN "public".mm_member.name IS '昵称';

CREATE TABLE mm_flow_log (id serial NOT NULL, member_id int4 NOT NULL, kind int2 NOT NULL, title varchar(60) NOT NULL, outer_no varchar(40) NOT NULL, amount float8 NOT NULL, csn_fee float8 NOT NULL, review_state int2 DEFAULT 0 NOT NULL, rel_user int4 NOT NULL, remark varchar(60) NOT NULL, create_time int4 NOT NULL, update_time int4 NOT NULL, PRIMARY KEY (id));
COMMENT ON TABLE mm_flow_log IS '活动账户明细';
COMMENT ON COLUMN mm_flow_log.id IS '编号';
COMMENT ON COLUMN mm_flow_log.member_id IS '会员编号';
COMMENT ON COLUMN mm_flow_log.kind IS '类型';
COMMENT ON COLUMN mm_flow_log.title IS '标题';
COMMENT ON COLUMN mm_flow_log.outer_no IS '外部交易号';
COMMENT ON COLUMN mm_flow_log.amount IS '金额';
COMMENT ON COLUMN mm_flow_log.csn_fee IS '手续费';
COMMENT ON COLUMN mm_flow_log.review_state IS '审核状态';
COMMENT ON COLUMN mm_flow_log.rel_user IS '关联用户';
COMMENT ON COLUMN mm_flow_log.remark IS '备注';
COMMENT ON COLUMN mm_flow_log.create_time IS '创建时间';
COMMENT ON COLUMN mm_flow_log.update_time IS '更新时间';


/** --- 会员关系: mm_relation,  删除: mm_income_log */

CREATE TABLE mm_receipts_code (id  SERIAL NOT NULL, member_id int4 NOT NULL, "identity" varchar(10) NOT NULL, name varchar(10) NOT NULL, account_id varchar(40) NOT NULL, code_url varchar(120) NOT NULL, state int2 NOT NULL, PRIMARY KEY (id));
COMMENT ON TABLE mm_receipts_code IS '收款码';
COMMENT ON COLUMN mm_receipts_code.id IS '编号';
COMMENT ON COLUMN mm_receipts_code.member_id IS '会员编号';
COMMENT ON COLUMN mm_receipts_code."identity" IS '账户标识,如:alipay';
COMMENT ON COLUMN mm_receipts_code.name IS '账户名称';
COMMENT ON COLUMN mm_receipts_code.account_id IS '账号';
COMMENT ON COLUMN mm_receipts_code.code_url IS '收款码地址';
COMMENT ON COLUMN mm_receipts_code.state IS '是否启用';

/** 实名认证 */
CREATE TABLE "public".mm_trusted_info (member_id  SERIAL NOT NULL, real_name varchar(10) NOT NULL, country_code varchar(10) NOT NULL, card_type int4 NOT NULL, card_id varchar(20) NOT NULL, card_image varchar(120) NOT NULL, card_reverse_image varchar(120) DEFAULT ' ' NOT NULL, trust_image varchar(120) NOT NULL, manual_review int4 NOT NULL, review_state int2 DEFAULT 0 NOT NULL, review_time int4 NOT NULL, remark varchar(120) NOT NULL, update_time int4 NOT NULL, CONSTRAINT mm_trusted_info_pkey PRIMARY KEY (member_id));
COMMENT ON COLUMN "public".mm_trusted_info.member_id IS '会员编号';
COMMENT ON COLUMN "public".mm_trusted_info.real_name IS '真实姓名';
COMMENT ON COLUMN "public".mm_trusted_info.country_code IS '国家代码';
COMMENT ON COLUMN "public".mm_trusted_info.card_type IS '证件类型';
COMMENT ON COLUMN "public".mm_trusted_info.card_id IS '证件编号';
COMMENT ON COLUMN "public".mm_trusted_info.card_image IS '证件图片';
COMMENT ON COLUMN "public".mm_trusted_info.card_reverse_image IS '证件反面图片';
COMMENT ON COLUMN "public".mm_trusted_info.trust_image IS '认证图片,人与身份证的图像等';
COMMENT ON COLUMN "public".mm_trusted_info.manual_review IS '人工审核';
COMMENT ON COLUMN "public".mm_trusted_info.review_state IS '审核状态';
COMMENT ON COLUMN "public".mm_trusted_info.review_time IS '审核时间';
COMMENT ON COLUMN "public".mm_trusted_info.remark IS '备注';
COMMENT ON COLUMN "public".mm_trusted_info.update_time IS '更新时间';

/** invitation_code => invite_code */

/** 订单状态, break改为7, complete改为8 */


/** mm_levelup 重新创建 */
CREATE TABLE mm_levelup (
  id            SERIAL NOT NULL,
  member_id    int4 NOT NULL,
  origin_level int4 NOT NULL,
  target_level int4 NOT NULL,
  is_free      int2 NOT NULL,
  payment_id   int4 NOT NULL,
  upgrade_mode int4 NOT NULL,
  review_state int4 NOT NULL,
  create_time  int8 NOT NULL,
  PRIMARY KEY (id));
COMMENT ON TABLE mm_levelup IS '会员升级日志表';
COMMENT ON COLUMN mm_levelup.member_id IS '会员编号';
COMMENT ON COLUMN mm_levelup.origin_level IS '原来等级';
COMMENT ON COLUMN mm_levelup.target_level IS '现在等级';
COMMENT ON COLUMN mm_levelup.is_free IS '是否为免费升级的会员';
COMMENT ON COLUMN mm_levelup.payment_id IS '支付单编号';
COMMENT ON COLUMN mm_levelup.create_time IS '升级时间';

/** 会员表 */
ALTER TABLE public.mm_member
    ADD COLUMN real_name character varying(20) NOT NULL ;
COMMENT ON COLUMN public.mm_member.real_name
    IS '真实姓名';

