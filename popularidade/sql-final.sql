SELECT user1,
       (qtd / count(*) OVER ()::decimal) * 100 perc
FROM
  (SELECT v.user1,
          count(*) qtd
   FROM
     (SELECT user1,
             user2
      FROM facebook_friends
      UNION SELECT user2 AS user1,
                   user1 AS user2
      FROM facebook_friends) v
   GROUP BY v.user1) v
ORDER BY 1