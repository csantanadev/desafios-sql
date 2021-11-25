SELECT *
FROM
  (SELECT d.date,
          sum(CASE
                  WHEN (a.paying_customer = 'no') THEN d.downloads
                  ELSE 0
              END) AS non_paying,
          sum(CASE
                  WHEN (a.paying_customer = 'yes') THEN d.downloads
                  ELSE 0
              END) AS paying
   FROM ms_user_dimension u
   JOIN ms_acc_dimension a ON (u.acc_id = a.acc_id)
   JOIN ms_download_facts d ON (d.user_id = u.user_id)
   GROUP BY d.date) v
WHERE v.non_paying > v.paying
ORDER BY 1