with totals as (
    select month,sum(postings) as total_postings
    from {{ ref('jobs_per_month') }}
    group by month
),
remote as (
    select date_trunc('month',search_date) as month, count(*) as remote_postings
    from {{ ref('job_posting') }}
    where job_work_from_home = true
    group by month
)
select month,total_postings, remote_postings, round((remote_postings/total_postings*100),2) as pct_remote_postings
from totals
join remote using (month)
order by month