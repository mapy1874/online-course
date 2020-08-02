drop table if exists `chapter`;
create table `chapter` (
    `id` char(8) not null comment 'ID',
    `course_id` char(8) comment 'course id',
    `name` varchar(50) comment 'name',
    primary key (`id`)
) engine=innodb default charset=utf8mb4 comment 'chapter';

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