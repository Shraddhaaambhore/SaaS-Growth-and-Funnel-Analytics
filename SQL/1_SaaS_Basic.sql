create table users(
  user_id varchar(10) primary key,
  signup_date date,
  country varchar(50),
  device varchar(20),
  acquisition_channel varchar(50),
  plan_type varchar(20)
);

select count(*) from users;
select * from users limit 10;

create table user_journey (
    user_id varchar(10) primary key,
    onboarding_started boolean,
    onboarding_completed boolean,
    activated boolean,
    feature_used boolean,
    trial_started boolean,
    paid boolean
);


select count(*) from user_journey ;


create table events (
    event_id varchar(20) primary key,
    user_id varchar(10),
    event_timestamp timestamp,
    event_type varchar(50),
    feature_name varchar(100),
    session_id varchar(50),
    revenue numeric(10,2)
);


select count(*) from events;


select 'users' as table_name, count(*) as total_rows
from users
union all
select 'user_journey', count(*)
from user_journey
union all
select 'events', count(*)
from events;