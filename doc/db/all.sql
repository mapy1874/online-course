# chapter table
drop table if exists `chapter`;
create table `chapter` (
    `id` char(8) not null comment 'ID',
    `course_id` char(8) comment 'course id',
    `name` varchar(50) comment 'name',
    primary key (`id`)
) engine=innodb default charset=utf8mb4 comment 'chapter';

insert into `chapter` (id, course_id, name)
values ('00000001', '00000000', 'test chapter 01'),
       ('00000002', '00000000', 'test chapter 02'),
       ('00000003', '00000000', 'test chapter 03'),
       ('00000004', '00000000', 'test chapter 04'),
       ('00000005', '00000000', 'test chapter 05'),
       ('00000006', '00000000', 'test chapter 06'),
       ('00000007', '00000000', 'test chapter 07'),
       ('00000008', '00000000', 'test chapter 08'),
       ('00000009', '00000000', 'test chapter 09'),
       ('00000010', '00000000', 'test chapter 10'),
       ('00000011', '00000000', 'test chapter 11'),
       ('00000012', '00000000', 'test chapter 12'),
       ('00000013', '00000000', 'test chapter 13'),
       ('00000014', '00000000', 'test chapter 14'),
       ('00000015', '00000000', 'test chapter 15'),
       ('00000016', '00000000', 'test chapter 16'),
       ('00000017', '00000000', 'test chapter 17'),
       ('00000018', '00000000', 'test chapter 18'),
       ('00000019', '00000000', 'test chapter 19'),
       ('00000020', '00000000', 'test chapter 20'),
       ('00000021', '00000000', 'test chapter 21'),
       ('00000022', '00000000', 'test chapter 22'),
       ('00000023', '00000000', 'test chapter 23'),
       ('00000024', '00000000', 'test chapter 24');

# section table
DROP TABLE IF EXISTS `section`;
CREATE TABLE `section` (
    `id` CHAR(8) NOT NULL DEFAULT '' COMMENT 'ID',
    `title` VARCHAR(50) NOT NULL COMMENT 'title',
    `course_id` CHAR(8) COMMENT 'course.id',
    `chapter_id` CHAR(8) COMMENT 'chapter.id',
    `video` VARCHAR(200) COMMENT 'video',
    `time` INT COMMENT 'time (s)',
    `charge` CHAR(1) COMMENT 'charge or not| C: charge, F: free',
    `sort` INT COMMENT 'order',
    `created_at` DATETIME(3) COMMENT 'created time',
    `updated_at` DATETIME(3) COMMENT 'revision time',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT 'section';

insert into course (id, name, summary, time, price, image, level, charge, status, enroll, sort, created_at, updated_at)
values ('00000001', '测试课程01', '这是一门测试课程', 7200, 19.9, '', 1, 'c', 'd', 100, 0, now(), now());

alter table `course` add column (`teacher_id` char(8) comment '讲师|teacher.id');

# course table
-- 课程
drop table if exists course;
create table course (
    id char(8) not null default '' comment 'id',
    name varchar(50) not null comment 'name',
    summary varchar(2000) comment 'summary',
    time int default 0 comment 'time|s',
    price decimal(8,2) default 0.00 comment 'price (CNY)',
    image varchar(100) comment 'cover',
    level char(1) comment 'level|enum[CourseLevelEnum]: ONE("1", "Beginner"),TWO("2", "intermediate"),THREE("3", "Advanced")',
    charge char(1) comment 'Charge|enum[CourseChargeEnum]：CHARGE("C", "Charge"),FREE("F", "Free")',
    status char(1) comment 'Status|enum[CourseStatusEnum]：PUBLISH("P", "Published"),DRAFT("D", "Draft")',
    enroll integer default 0 comment 'enrollment',
    sort int comment 'sort',
    created_at datetime(3) comment 'created at',
    updated_at datetime(3) comment 'updated at',
    primary key (id)
) engine=innodb default charset=utf8mb4 comment='course';

INSERT INTO course (id, name, summary, time, price, image, level, charge, status, enroll, sort, created_at, updated_at)
        VALUES ('00000001', '测试课程01', '这是一门测试课程', 7200, 19.9, '', 1, 'C', 'D', 100, 0, now(), now());



# test
drop table if exists `test`;

create table `test` (
    `id` char(8) not null default '' comment 'id',
    `name` varchar(50) comment 'name',
    primary key (`id`)
) engine=innodb default charset=utf8mb4 comment='test';

insert into `test` (`id`, `name`)
    values (1, 'test'),
            (2, 'second');

show full columns from `section`


UPDATE course c set `time`  = (SELECT sum(`time`) FROM `section` WHERE course_id='00000001')
    WHERE c.id = '00000001';

# category
drop table if exists `category`;
create table `category` (
                            `id` char(8) not null default '' comment 'id',
                            `parent` char(8) not null default '' comment 'parent_id',
                            `name` varchar(50) not null comment 'name',
                            `sort` int comment 'sort',
                            primary key (`id`)
) engine=innodb default charset=utf8mb4 comment='category';

insert into `category` (id, parent, name, sort) values ('00000100', '00000000', 'frontend', 100);
insert into `category` (id, parent, name, sort) values ('00000101', '00000100', 'html/css', 101);
insert into `category` (id, parent, name, sort) values ('00000102', '00000100', 'javascript', 102);
insert into `category` (id, parent, name, sort) values ('00000103', '00000100', 'vue.js', 103);
insert into `category` (id, parent, name, sort) values ('00000104', '00000100', 'react.js', 104);
insert into `category` (id, parent, name, sort) values ('00000105', '00000100', 'angular', 105);
insert into `category` (id, parent, name, sort) values ('00000106', '00000100', 'node.js', 106);
insert into `category` (id, parent, name, sort) values ('00000107', '00000100', 'jquery', 107);
insert into `category` (id, parent, name, sort) values ('00000108', '00000100', 'mini program', 108);
insert into `category` (id, parent, name, sort) values ('00000200', '00000000', 'backend', 200);
insert into `category` (id, parent, name, sort) values ('00000201', '00000200', 'java', 201);
insert into `category` (id, parent, name, sort) values ('00000202', '00000200', 'springboot', 202);
insert into `category` (id, parent, name, sort) values ('00000203', '00000200', 'spring cloud', 203);
insert into `category` (id, parent, name, sort) values ('00000204', '00000200', 'ssm', 204);
insert into `category` (id, parent, name, sort) values ('00000205', '00000200', 'python', 205);
insert into `category` (id, parent, name, sort) values ('00000206', '00000200', 'web crawler', 206);
insert into `category` (id, parent, name, sort) values ('00000300', '00000000', 'mobile dev', 300);
insert into `category` (id, parent, name, sort) values ('00000301', '00000300', 'android', 301);
insert into `category` (id, parent, name, sort) values ('00000302', '00000300', 'ios', 302);
insert into `category` (id, parent, name, sort) values ('00000303', '00000300', 'react native', 303);
insert into `category` (id, parent, name, sort) values ('00000304', '00000300', 'ionic', 304);
insert into `category` (id, parent, name, sort) values ('00000400', '00000000', 'frontier tech', 400);
insert into `category` (id, parent, name, sort) values ('00000401', '00000400', 'microservice', 401);
insert into `category` (id, parent, name, sort) values ('00000402', '00000400', 'blockchain', 402);
insert into `category` (id, parent, name, sort) values ('00000403', '00000400', 'machine learning', 403);
insert into `category` (id, parent, name, sort) values ('00000404', '00000400', 'deep learning', 404);
insert into `category` (id, parent, name, sort) values ('00000405', '00000400', 'data analysis', 405);
insert into `category` (id, parent, name, sort) values ('00000500', '00000000', 'cloud computing', 500);
insert into `category` (id, parent, name, sort) values ('00000501', '00000500', 'big data', 501);
insert into `category` (id, parent, name, sort) values ('00000502', '00000500', 'hadoop', 502);
insert into `category` (id, parent, name, sort) values ('00000503', '00000500', 'spark', 503);
insert into `category` (id, parent, name, sort) values ('00000504', '00000500', 'hbase', 504);
insert into `category` (id, parent, name, sort) values ('00000505', '00000500', 'alicloud', 505);
insert into `category` (id, parent, name, sort) values ('00000506', '00000500', 'docker', 506);
insert into `category` (id, parent, name, sort) values ('00000507', '00000500', 'kubernetes', 507);
insert into `category` (id, parent, name, sort) values ('00000600', '00000000', 'DevOps&test', 600);
insert into `category` (id, parent, name, sort) values ('00000601', '00000600', 'ops', 601);
insert into `category` (id, parent, name, sort) values ('00000602', '00000600', 'auto ops', 602);
insert into `category` (id, parent, name, sort) values ('00000603', '00000600', 'middleware', 603);
insert into `category` (id, parent, name, sort) values ('00000604', '00000600', 'linux', 604);
insert into `category` (id, parent, name, sort) values ('00000605', '00000600', 'test', 605);
insert into `category` (id, parent, name, sort) values ('00000606', '00000600', 'auto test', 606);
insert into `category` (id, parent, name, sort) values ('00000700', '00000000', 'databases', 700);
insert into `category` (id, parent, name, sort) values ('00000701', '00000700', 'mysql', 701);
insert into `category` (id, parent, name, sort) values ('00000702', '00000700', 'redis', 702);
insert into `category` (id, parent, name, sort) values ('00000703', '00000700', 'mongodb', 703);

# course category
drop table if exists `course_category`;
create table `course_category` (
  `id` char(8) not null default '' comment 'id',
  `course_id` char(8) comment 'course|course.id',
  `category_id` char(8) comment 'category|course.id',
  primary key (`id`)
) engine=innodb default charset=utf8mb4 comment='course category';


# 课程内容
# 大文本字段或经常更新的字段一般拆分成单独的一张表
drop table if exists `course_content`;
create table `course_content` (
    `id` char(8) not null default '' comment 'course id',
    `content` mediumtext not null comment 'course content',
    primary key (`id`)
) engine=innodb default charset=utf8mb4 comment='course content';

