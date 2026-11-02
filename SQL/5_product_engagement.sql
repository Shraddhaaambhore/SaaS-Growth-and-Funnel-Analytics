--Which product features do users engage with most?
select 
feature_name,
count(*) as total_feature_events
from events
where event_type='Feature_Used'
group by feature_name
order by total_feature_events desc;

--unique users per feature
select 
feature_name,
count(distinct user_id) as unique_users
from events
where event_type='Feature_Used'
group by feature_name
order by unique_users desc;

--Which product features are associated with higher paid conversion?
select
	e.feature_name,
	count(distinct e.user_id) as users,
	count(distinct e.user_id) filter(where j.paid=true) as paid_users,
	round(count(distinct e.user_id) filter(where j.paid=true)*100.0/count(distinct e.user_id),2)
	as paid_convr_percent
   from events as e
inner join user_journey as j
on e.user_id= j.user_id
where e.event_type='Feature_Used'
group by e.feature_name
order by paid_convr_percent desc;


--Do users who use more product features have a higher paid conversion rate?
  
 with user_feature_count as (      -- how many distinct features each user has used?
    select
        u.user_id,
        count(distinct e.feature_name) as features_used
    from users u
    left join events e
        on u.user_id = e.user_id
        and e.event_type = 'Feature_Used'
    group by u.user_id
)
select    --connect users to paid status
    ufc.features_used,
    count(*) as total_users,
    count(*) filter (
        where j.paid = true
    ) as paid_users,
    round(
        count(*) filter (
            where j.paid = true
        ) * 100.0 / count(*),
        2
    ) as paid_conversion_pct
from user_feature_count ufc
inner join user_journey j 
    on ufc.user_id = j.user_id
group by ufc.features_used
order by ufc.features_used;
   --Using more features does not show a consistent increase in paid conversion in these results
  










