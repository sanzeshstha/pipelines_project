select
    job_location,
    count (*) as postings
from {{ ref('job_posting') }}
group by job_location
order by 2 desc