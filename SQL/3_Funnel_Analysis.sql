--How many users reach each stage, and where do we lose the most users?
---how many users reach each stage?
select 
 count(*) as Total_signups,
 count(*) filter (where onboarding_started=true) as Onboarding_started,
 count(*) filter (where onboarding_completed=true) as Onboarding_completed,
 count(*) filter (where activated=true) as Actiavted,
 count(*) filter (where feature_used=true) as Feature_used,
 count(*) filter (where trial_started=true) as Trial_started,
 count(*) filter (where paid=true) as paid_users
from user_journey;


--users lost
with funnel_count as(
  select 
   1 as stage_order,
   'Signup' as funnel_stage,
   count(*) as users
  from user_journey 
  
 union all 
  select
  2, 
  'onboarding_started', 
  count(*) filter (where onboarding_started=true)
  from user_journey
  
 union all 
  select
  3, 
  'onboarding_completed', 
  count(*) filter (where onboarding_completed=true)
  from user_journey

 union all 
  select
  4, 
  'activated', 
  count(*) filter (where activated=true)
  from user_journey  

 union all 
  select
  5, 
  'feature_used', 
  count(*) filter (where feature_used=true)
  from user_journey

 union all 
  select
  6, 
  'trial_started', 
  count(*) filter (where trial_started=true)
  from user_journey 

 union all 
  select
  7, 
  'paid', 
  count(*) filter (where paid=true)
  from user_journey 
)
select 
	stage_order,
	funnel_stage,
	users,
	lag(users) over(order by stage_order) - users as Lost_Users
from funnel_count
order by stage_order;	

--conversion rate and dropoff rate

/*Stage Conversion %=
Previous Stage Users/
Current Stage Users
×100
Stage Drop-off %=100−Stage Conversion %*/
with funnel_count as(
  select 
   1 as stage_order,
   'Signup' as funnel_stage,
   count(*) as users
  from user_journey 
  
 union all 
  select
  2, 
  'onboarding_started', 
  count(*) filter (where onboarding_started=true)
  from user_journey
  
 union all 
  select
  3, 
  'onboarding_completed', 
  count(*) filter (where onboarding_completed=true)
  from user_journey

 union all 
  select
  4, 
  'activated', 
  count(*) filter (where activated=true)
  from user_journey  

 union all 
  select
  5, 
  'feature_used', 
  count(*) filter (where feature_used=true)
  from user_journey

 union all 
  select
  6, 
  'trial_started', 
  count(*) filter (where trial_started=true)
  from user_journey 

 union all 
  select
  7, 
  'paid', 
  count(*) filter (where paid=true)
  from user_journey 
)
select 
	stage_order,
	funnel_stage,
	users,
	lag(users) over(order by stage_order) - users as Lost_Users,
	round(users*100.0/lag(users) over(order by stage_order),2) as stage_conversion_percent,
	round((lag(users) over(order by stage_order) - users)*100.0/lag(users) over(order by stage_order),2) 
	 as stage_dropOff_percent
from funnel_count
order by stage_order;

--overall signup-to-paid conversion rate
select 
 count(*) as signUp,
 count(*) filter(where paid=true) as paid_users,
 round(count(*) filter(where paid=true)*100.0/count(*),2) as signUp_to_paid_conversion_rate
from user_journey;
 









