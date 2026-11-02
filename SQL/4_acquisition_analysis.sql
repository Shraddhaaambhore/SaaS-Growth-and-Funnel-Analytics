--which channel brings the most users?
select 
  u.acquisition_channel,
  count(*) as Total_signups,
  count(*) filter(where paid=true) as Paid_users 
  from users u
 inner join user_journey j
 on u.user_id=j.user_id
 group by u.acquisition_channel;

--conversion rate by channel 
select 
  u.acquisition_channel,
  count(*) as Total_signups,
  count(*) filter(where paid=true) as Paid_users ,
  round(count(*) filter (where j.paid = true) * 100.0 / count(*),2) as Signup_to_Paid_conversion_rate
  from users u
 inner join user_journey j
 on u.user_id=j.user_id
 group by u.acquisition_channel;

-- share of total signups and share of total paid users for each acquisition channel
select 
  u.acquisition_channel,
  count(*) as Total_signups,
  count(*) filter(where paid=true) as Paid_users ,
  round(count(*) filter (where j.paid = true) * 100.0 / count(*),2) as Signup_to_Paid_conversion_rate,
  round(count(*)*100.0/(select count(*) from users),2) as signup_share,
  round(count(*) filter(where j.paid = true) *100.0/(select count(*)  from user_journey where paid=true),2)
   as paid_user_share
  from users u
 inner join user_journey j
 on u.user_id=j.user_id
 group by u.acquisition_channel;
    --signup_to_paid_conversion_rate uses the channel's paid users divided by the channel's signups.
    --signup_share uses the channel's signups divided by all signups.
    --paid_user_share uses the channel's paid users divided by all paid users.


--comparing acquisition performance by device and country
select
    u.acquisition_channel,
    u.device,
    count(*) as total_signups,
    count(*) filter (where j.paid = true) as paid_users,
    round(
        count(*) filter (where j.paid = true) * 100.0 / count(*),
        2
    ) as signup_to_paid_conversion_pct
from users u
inner join user_journey j
    on u.user_id = j.user_id
group by
    u.acquisition_channel,
    u.device
order by
    u.acquisition_channel,
    signup_to_paid_conversion_pct desc;


--acquisition performance by country
select
    u.acquisition_channel,
    u.country,
    count(*) as total_signups,
    count(*) filter (where j.paid = true) as paid_users,
    round(
        count(*) filter (where j.paid = true) * 100.0 / count(*),
        2
    ) as signup_to_paid_conversion_pct
from users u
inner join user_journey j
    on u.user_id = j.user_id
group by
    u.acquisition_channel,
    u.country
order by
    u.acquisition_channel,
    signup_to_paid_conversion_pct desc;
  