SELECT v.date,
       v.total_energy
FROM
  (SELECT e.date,
          e.consumption total_energy,
          rank () over(
                       ORDER BY e.consumption DESC) rnk
   FROM
     (SELECT e.date,
             sum(e.consumption) consumption
      FROM
        (SELECT *
         FROM fb_eu_energy eu
         UNION ALL SELECT *
         FROM fb_asia_energy asi
         UNION ALL SELECT *
         FROM fb_na_energy na) e
      GROUP BY e.date) e
   ORDER BY 1) v
WHERE v.rnk = 1