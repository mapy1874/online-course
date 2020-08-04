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