--How many users used a product feature on a later calendar date than their signup date?
select 
 count(distinct u.user_id) as users_late_feature_used
from users u
inner join events e
on u.user_id=e.user_id
where e.event_type='Feature_Used'
     and e.event_timestamp::date > u.signup_date;



--What percentage of users return to use a product feature within seven days of signup?
--or
--Do users return to use a feature within 7 days of signup?
with users_with_7_day_activity as (
    select distinct e.user_id
    from events e
    join users u
        on e.user_id = u.user_id
    where e.event_type = 'Feature_Used'
      and e.event_timestamp::date > u.signup_date
      and e.event_timestamp::date <= u.signup_date + 7
)
select
    count(*) as total_signups,
    count(a.user_id) as users_within_7_day_activity,
    round(
        count(a.user_id) * 100.0 / count(*),
        2
    ) as seven_day_activity_pct
from users u
left join users_with_7_day_activity a
    on u.user_id = a.user_id;


