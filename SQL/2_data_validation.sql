--missing values in users
select 
 count(*) filter (where user_id is null) as nullID,
 count (*) filter (where signup_date is null) as nullsignup,
 count (*) filter (where country is null) as nullcountry,
 count (*) filter (where device is null) as nulldevice,
 count (*) filter (where acquisition_channel is null) as nullChannel,
 count (*) filter (where plan_type is null) as nullPlan
 from users;


--events without user id
select count(*) events_without_matched_userid
from events e
left join users u
 on e.user_id=u.user_id
 where u.user_id isnull;

--check duplicate event ids
select 
count(*) as duplicateId,
event_id
from events
group by event_id
having count(*)>1;


 --Does every journey record have a matching user?
 select
 count(*) as journey_without_matching_user
 from user_journey j
 left join users u
 on j.user_id=u.user_id
 where u.user_id is null;

 --Does every user have a matching journey record?or users without a journey record
  select
 count(*) as users_without_journey
 from users u
 left join user_journey j
 on j.user_id=u.user_id
 where j.user_id is null;

--Events occurring before signup?
select 
 count(*) as event_before_signup
from events e
inner join users u
on e.user_id=u.user_id
where e.event_timestamp::date < u.signup_date;


--journey-stage consistency
select
count(*) as invalid_journey
from user_journey
where (onboarding_completed=true and onboarding_started=false)
    or(activated=true and onboarding_completed=false)
	or(feature_used=true and activated=false)
	or(trial_started=true and feature_used=false)
	or(paid=true and trial_started=false);


--checking feature-event consistency	

select distinct event_type from events;

select 
count(*) feature_name
from events
where event_type='Feature_Used';

--count users with no feature used
select 
count(*) as feature_events_without_name
from events
where event_type='Feature_Used' and 
      (feature_name is null or trim(feature_name)='');



















 