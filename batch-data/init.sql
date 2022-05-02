drop table if exists `BATCH_JOB_SEQ`;
drop table if exists `BATCH_JOB_EXECUTION_SEQ`;
drop table if exists `BATCH_STEP_EXECUTION_SEQ`;
drop table if exists `BATCH_JOB_EXECUTION_CONTEXT`;
drop table if exists `BATCH_STEP_EXECUTION_CONTEXT`;
drop table if exists `BATCH_STEP_EXECUTION`;
drop table if exists `BATCH_JOB_EXECUTION_PARAMS`;
drop table if exists `BATCH_JOB_EXECUTION`;
drop table if exists `BATCH_JOB_INSTANCE`;

create table BATCH_JOB_INSTANCE  (
    JOB_INSTANCE_ID bigint  not null primary key ,
    version bigint ,
    JOB_NAME varchar(100) not null,
    JOB_KEY varchar(32) not null,
    constraint JOB_INST_UN unique (JOB_NAME, JOB_KEY)
) engine=innodb;
-- 该BATCH_JOB_EXECUTION表包含与该JobExecution对象相关的所有信息
create table BATCH_JOB_EXECUTION  (
    JOB_EXECUTION_ID bigint  not null primary key ,
    version bigint  ,
    JOB_INSTANCE_ID bigint not null,
    CREATE_TIME datetime not null,
    START_TIME datetime default null ,
    END_TIME datetime default null ,
    status varchar(10) ,
    EXIT_CODE varchar(2500) ,
    EXIT_MESSAGE varchar(2500) ,
    LAST_UPDATED datetime,
    JOB_CONFIGURATION_LOCATION varchar(2500) null,
    constraint JOB_INST_EXEC_FK foreign key (JOB_INSTANCE_ID)
    references BATCH_JOB_INSTANCE(JOB_INSTANCE_ID)
) engine=innodb;
-- 该表包含与该JobParameters对象相关的所有信息
create table BATCH_JOB_EXECUTION_PARAMS  (
    JOB_EXECUTION_ID bigint not null ,
    TYPE_CD varchar(6) not null ,
    KEY_NAME varchar(100) not null ,
    STRING_VAL varchar(250) ,
    DATE_VAL datetime default null ,
    LONG_VAL bigint ,
    DOUBLE_VAL double precision ,
    IDENTIFYING char(1) not null ,
    constraint JOB_EXEC_PARAMS_FK foreign key (JOB_EXECUTION_ID)
    references BATCH_JOB_EXECUTION(JOB_EXECUTION_ID)
) engine=innodb;
-- 该表包含与该StepExecution 对象相关的所有信息
create table BATCH_STEP_EXECUTION  (
    STEP_EXECUTION_ID bigint  not null primary key ,
    version bigint not null,
    STEP_NAME varchar(100) not null,
    JOB_EXECUTION_ID bigint not null,
    START_TIME datetime not null ,
    END_TIME datetime default null ,
    status varchar(10) ,
    COMMIT_COUNT bigint ,
    READ_COUNT bigint ,
    FILTER_COUNT bigint ,
    WRITE_COUNT bigint ,
    READ_SKIP_COUNT bigint ,
    WRITE_SKIP_COUNT bigint ,
    PROCESS_SKIP_COUNT bigint ,
    ROLLBACK_COUNT bigint ,
    EXIT_CODE varchar(2500) ,
    EXIT_MESSAGE varchar(2500) ,
    LAST_UPDATED datetime,
    constraint JOB_EXEC_STEP_FK foreign key (JOB_EXECUTION_ID)
    references BATCH_JOB_EXECUTION(JOB_EXECUTION_ID)
) engine=innodb;
-- 该BATCH_STEP_EXECUTION_CONTEXT表包含ExecutionContext与Step相关的所有信息
create table BATCH_STEP_EXECUTION_CONTEXT  (
    STEP_EXECUTION_ID bigint not null primary key,
    SHORT_CONTEXT varchar(2500) not null,
    SERIALIZED_CONTEXT text ,
    constraint STEP_EXEC_CTX_FK foreign key (STEP_EXECUTION_ID)
    references BATCH_STEP_EXECUTION(STEP_EXECUTION_ID)
) engine=innodb;
-- 该表包含ExecutionContext与Job相关的所有信息
create table BATCH_JOB_EXECUTION_CONTEXT  (
    JOB_EXECUTION_ID bigint not null primary key,
    SHORT_CONTEXT varchar(2500) not null,
    SERIALIZED_CONTEXT text ,
    constraint JOB_EXEC_CTX_FK foreign key (JOB_EXECUTION_ID)
    references BATCH_JOB_EXECUTION(JOB_EXECUTION_ID)
) engine=innodb;
create table BATCH_STEP_EXECUTION_SEQ (
    ID bigint not null,
    UNIQUE_KEY char(1) not null,
    constraint UNIQUE_KEY_UN unique (UNIQUE_KEY)
) engine=innodb;
insert into BATCH_STEP_EXECUTION_SEQ (ID, UNIQUE_KEY) select * from (select 0 as ID, '0' as UNIQUE_KEY) as tmp where not exists(select * from BATCH_STEP_EXECUTION_SEQ);
create table BATCH_JOB_EXECUTION_SEQ (
    ID bigint not null,
    UNIQUE_KEY char(1) not null,
    constraint UNIQUE_KEY_UN unique (UNIQUE_KEY)
) engine=innodb;
insert into BATCH_JOB_EXECUTION_SEQ (ID, UNIQUE_KEY) select * from (select 0 as ID, '0' as UNIQUE_KEY) as tmp where not exists(select * from BATCH_JOB_EXECUTION_SEQ);
create table BATCH_JOB_SEQ (
    ID bigint not null,
    UNIQUE_KEY char(1) not null,
    constraint UNIQUE_KEY_UN unique (UNIQUE_KEY)
) engine=innodb;
insert into BATCH_JOB_SEQ (ID, UNIQUE_KEY) select * from (select 0 as ID, '0' as UNIQUE_KEY) as tmp where not exists(select * from BATCH_JOB_SEQ);

select count(*) from t_product;