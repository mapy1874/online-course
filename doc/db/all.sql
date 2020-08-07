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

INSERT INTO section (id, title, course_id, chapter_id, video, time, charge, sort, created_at, updated_at)
VALUES ('00000001','test section 01', '00000001', '00000000', '', 500, 'F', 1, now(), now());

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