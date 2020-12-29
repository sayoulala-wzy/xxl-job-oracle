CREATE sequence XXL_JOB_INFO_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle;
CREATE TABLE xxl_job_info (
	id numeric ( 11, 0 ) PRIMARY KEY NOT NULL,
	job_group numeric ( 11, 0 ) NOT NULL,
	job_cron VARCHAR2 ( 128 ) NOT NULL,
	job_desc VARCHAR2 ( 255 ) NOT NULL,
	add_time timestamp DEFAULT NULL,
	update_time timestamp DEFAULT NULL,
	author VARCHAR2 ( 64 ) DEFAULT NULL,
	alarm_email VARCHAR2 ( 255 ) DEFAULT NULL,
	executor_route_strategy VARCHAR2 ( 50 ) DEFAULT NULL,
	executor_handler VARCHAR2 ( 255 ) DEFAULT NULL,
	executor_param VARCHAR2 ( 512 ) DEFAULT NULL,
	executor_block_strategy VARCHAR2 ( 50 ) DEFAULT NULL,
	executor_timeout numeric ( 11, 0 ) DEFAULT 0 NOT NULL,
	executor_fail_retry_count numeric ( 11, 0 ) DEFAULT 0 NOT NULL,
	glue_type VARCHAR2 ( 50 ) NOT NULL,
	glue_source clob,
	glue_remark VARCHAR2 ( 128 ) DEFAULT NULL,
	glue_updatetime timestamp DEFAULT NULL,
	child_jobid VARCHAR2 ( 255 ) DEFAULT NULL,
	trigger_status numeric ( 4 ) DEFAULT 0 NOT NULL,
	trigger_last_time numeric ( 13 ) DEFAULT 0 NOT NULL,
	trigger_next_time numeric ( 13 ) DEFAULT 0 NOT NULL 
);
COMMENT ON COLUMN xxl_job_info.job_group IS '执行器主键ID';
COMMENT ON COLUMN xxl_job_info.job_cron IS '任务执行CRON';
COMMENT ON COLUMN xxl_job_info.author IS '作者';
COMMENT ON COLUMN xxl_job_info.alarm_email IS '报警邮件';
COMMENT ON COLUMN xxl_job_info.executor_route_strategy IS '执行器路由策略';
COMMENT ON COLUMN xxl_job_info.executor_handler IS '执行器任务handler';
COMMENT ON COLUMN xxl_job_info.executor_param IS '执行器任务参数';
COMMENT ON COLUMN xxl_job_info.executor_block_strategy IS '阻塞处理策略';
COMMENT ON COLUMN xxl_job_info.executor_timeout IS '任务执行超时时间，单位秒';
COMMENT ON COLUMN xxl_job_info.executor_fail_retry_count IS '失败重试次数';
COMMENT ON COLUMN xxl_job_info.glue_type IS 'GLUE类型';
COMMENT ON COLUMN xxl_job_info.glue_source IS 'GLUE源代码';
COMMENT ON COLUMN xxl_job_info.glue_remark IS 'GLUE备注';
COMMENT ON COLUMN xxl_job_info.glue_updatetime IS 'GLUE更新时间';
COMMENT ON COLUMN xxl_job_info.child_jobid IS '子任务ID，多个逗号分隔';
COMMENT ON COLUMN xxl_job_info.trigger_status IS '调度状态：0-停止，1-运行';
COMMENT ON COLUMN xxl_job_info.trigger_last_time IS '上次调度时间';
COMMENT ON COLUMN xxl_job_info.trigger_next_time IS '下次调度时间';
CREATE sequence XXL_JOB_LOG_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle;
CREATE TABLE xxl_job_log (
	id numeric ( 11, 0 ) PRIMARY KEY NOT NULL,
	job_group numeric ( 11, 0 ) NOT NULL,
	job_id numeric ( 11, 0 ) NOT NULL,
	executor_address VARCHAR2 ( 255 ) DEFAULT NULL,
	executor_handler VARCHAR2 ( 255 ) DEFAULT NULL,
	executor_param VARCHAR2 ( 512 ) DEFAULT NULL,
	executor_sharding_param VARCHAR2 ( 20 ) DEFAULT NULL,
	executor_fail_retry_count numeric ( 11, 0 ) DEFAULT 0 NOT NULL,
	trigger_time timestamp DEFAULT NULL,
	trigger_code numeric ( 11, 0 ) NOT NULL,
	trigger_msg CLOB,
	handle_time timestamp DEFAULT NULL,
	handle_code numeric ( 11, 0 ) NOT NULL,
	handle_msg CLOB,
	alarm_status numeric ( 4 ) DEFAULT 0 NOT NULL 
);
CREATE INDEX JOBLOG_TRIGGERTIME_INDEX ON xxl_job_log ( trigger_time );
CREATE INDEX JOBLOG_HANDLECODE_INDEX ON xxl_job_log ( handle_code );
COMMENT ON COLUMN xxl_job_log.job_group IS '执行器主键ID';
COMMENT ON COLUMN xxl_job_log.job_id IS '任务，主键ID';
COMMENT ON COLUMN xxl_job_log.executor_address IS '执行器地址，本次执行的地址';
COMMENT ON COLUMN xxl_job_log.executor_handler IS '执行器任务handler';
COMMENT ON COLUMN xxl_job_log.executor_param IS '执行器任务参数';
COMMENT ON COLUMN xxl_job_log.executor_sharding_param IS '执行器任务分片参数，格式如 1/2';
COMMENT ON COLUMN xxl_job_log.executor_fail_retry_count IS '失败重试次数';
COMMENT ON COLUMN xxl_job_log.trigger_time IS '调度-时间';
COMMENT ON COLUMN xxl_job_log.trigger_code IS '调度-结果';
COMMENT ON COLUMN xxl_job_log.trigger_msg IS '调度-日志';
COMMENT ON COLUMN xxl_job_log.handle_code IS '执行-状态';
COMMENT ON COLUMN xxl_job_log.handle_msg IS '执行-日志';
COMMENT ON COLUMN xxl_job_log.alarm_status IS '告警状态：0-默认、1-无需告警、2-告警成功、3-告警失败';
CREATE sequence XXL_JOB_LOG_REPORT_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle;
CREATE TABLE xxl_job_log_report (
	id numeric ( 11, 0 ) PRIMARY KEY NOT NULL,
	trigger_day timestamp DEFAULT NULL,
	running_count numeric ( 11, 0 ) DEFAULT 0 NOT NULL,
	suc_count numeric ( 11, 0 ) DEFAULT 0 NOT NULL,
	fail_count numeric ( 11, 0 ) DEFAULT 0 NOT NULL 
);
CREATE UNIQUE INDEX JOBLOGREPORT_TRIGGERDAY_UINDEX ON xxl_job_log_report ( trigger_day );
COMMENT ON COLUMN xxl_job_log_report.trigger_day IS '调度-时间';
COMMENT ON COLUMN xxl_job_log_report.running_count IS '运行中-日志数量';
COMMENT ON COLUMN xxl_job_log_report.suc_count IS '执行成功-日志数量';
COMMENT ON COLUMN xxl_job_log_report.fail_count IS '执行失败-日志数量';
CREATE sequence XXL_JOB_LOGGLUE_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle;
CREATE TABLE xxl_job_logglue (
	id numeric ( 11, 0 ) PRIMARY KEY NOT NULL,
	job_id numeric ( 11, 0 ) NOT NULL,
	glue_type VARCHAR2 ( 50 ) DEFAULT NULL,
	glue_source clob,
	glue_remark VARCHAR2 ( 128 ) NOT NULL,
	add_time timestamp DEFAULT NULL,
	update_time timestamp DEFAULT NULL 
);
COMMENT ON COLUMN xxl_job_logglue.job_id IS '任务，主键ID';
COMMENT ON COLUMN xxl_job_logglue.glue_type IS 'GLUE类型';
COMMENT ON COLUMN xxl_job_logglue.glue_source IS 'GLUE源代码';
COMMENT ON COLUMN xxl_job_logglue.glue_remark IS 'GLUE备注';
CREATE SEQUENCE XXL_JOB_REGISTRY_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle;
CREATE TABLE xxl_job_registry (
	id numeric ( 11, 0 ) PRIMARY KEY NOT NULL,
	registry_group VARCHAR2 ( 255 ) NOT NULL,
	registry_key VARCHAR2 ( 255 ) NOT NULL,
	registry_value VARCHAR2 ( 255 ) NOT NULL,
	update_time timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL 
);
CREATE INDEX JOBREGISTRY_G_K_V_INDEX ON xxl_job_registry ( registry_group, registry_key, registry_value );
CREATE sequence XXL_JOB_GROUP_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle;
CREATE TABLE xxl_job_group (
	id numeric ( 11, 0 ) PRIMARY KEY NOT NULL,
	app_name VARCHAR2 ( 64 ) NOT NULL,
	title VARCHAR2 ( 64 ) DEFAULT 0 NOT NULL,
	address_type numeric ( 4 ) DEFAULT 0 NOT NULL,
	address_list VARCHAR2 ( 512 ) DEFAULT NULL
);
COMMENT ON TABLE xxl_job_group IS '执行器定义表';
COMMENT ON COLUMN xxl_job_group.app_name IS '执行器AppName';
COMMENT ON COLUMN xxl_job_group.title IS '执行器名称';
COMMENT ON COLUMN xxl_job_group.address_type IS '执行器地址类型：0=自动注册、1=手动录入';
COMMENT ON COLUMN xxl_job_group.address_list IS '执行器地址列表，多地址逗号分隔';
CREATE SEQUENCE XXL_JOB_USER_ID
minvalue 1
maxvalue 999999999999
start with 1
increment by 1
cache 20
cycle;
CREATE TABLE xxl_job_user (
	id numeric ( 11, 0 ) PRIMARY KEY NOT NULL,
	username VARCHAR2 ( 50 ) NOT NULL,
	password VARCHAR2 ( 50 ) NOT NULL,
	role numeric ( 4, 0 ) NOT NULL,
	permission VARCHAR2 ( 255 ) DEFAULT NULL 
);
CREATE UNIQUE INDEX JOBUSER_USERNAME_UINDEX ON xxl_job_user ( username );
COMMENT ON TABLE xxl_job_user IS '用户定义表';
COMMENT ON COLUMN xxl_job_user.username IS '账号';
COMMENT ON COLUMN xxl_job_user.password IS '密码';
COMMENT ON COLUMN xxl_job_user.role IS '角色：0-普通用户、1-管理员';
COMMENT ON COLUMN xxl_job_user.permission IS '权限：执行器ID列表，多个逗号分割';
CREATE TABLE xxl_job_lock ( lock_name VARCHAR2 ( 50 ) PRIMARY KEY NOT NULL );
COMMENT ON COLUMN xxl_job_lock.lock_name IS '锁名称';
--初始化数据
INSERT INTO xxl_job_group ( id, app_name, title, address_type, address_list )
VALUES
	( '1', 'xxl-job-executor-sample', '示例执行器', '0', NULL );
INSERT INTO xxl_job_info (
	id,
	job_group,
	job_cron,
	job_desc,
	add_time,
	update_time,
	author,
	alarm_email,
	executor_route_strategy,
	executor_handler,
	executor_param,
	executor_block_strategy,
	executor_timeout,
	executor_fail_retry_count,
	glue_type,
	glue_source,
	glue_remark,
	glue_updatetime,
	child_jobid 
)
VALUES
	(
		'1',
		'1',
		'0 0 0 * * ? *',
		'测试任务1',
		to_date( '2018-11-03 22:21:31', 'yyyy-mm-dd hh24:mi:ss' ),
		to_date( '2018-11-03 22:21:31', 'yyyy-mm-dd hh24:mi:ss' ),
		'XXL',
		'',
		'FIRST',
		'demoJobHandler',
		'',
		'SERIAL_EXECUTION',
		0,
		0,
		'BEAN',
		'',
		'GLUE代码初始化',
		to_date( '2018-11-03 22:21:31', 'yyyy-mm-dd hh24:mi:ss' ),
		'' 
	);
INSERT INTO xxl_job_user ( id, username, password, role, permission )
VALUES
	( '1', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '1', NULL );
INSERT INTO xxl_job_lock ( lock_name )
VALUES
	( 'schedule_lock' );
commit;