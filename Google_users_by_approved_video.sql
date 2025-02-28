with cte as (select 
f.user_firstname, f.user_lastname,
count(distinct video_id) as approve_count,
dense_rank() over (order by count(distinct video_id) desc) as rn
from
users_flag f
join flag_review r
on f.flag_id = r.flag_id
where lower(r.reviewed_outcome) = 'approved'
group by f.user_firstname, f.user_lastname)

select CONCAT(user_firstname, ' ', user_lastname) as username
from cte
where rn = 1
