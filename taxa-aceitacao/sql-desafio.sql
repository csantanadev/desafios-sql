SELECT v.date_s,
       v.realizado::decimal / v.count::decimal
FROM
  (SELECT DISTINCT v.date_s,
                   v.count,
                   v.realizado
   FROM
     (SELECT vs.*,
             va.*,
             count(*) OVER (PARTITION BY vs.date_s) realizado
      FROM
        (SELECT date date_s,
                     user_id_receiver,
                     count(*) OVER (PARTITION BY date)
         FROM fb_friend_requests
         WHERE action = 'sent'
         ORDER BY 1) vs
      LEFT OUTER JOIN
        (SELECT date date_a,
                     user_id_receiver
         FROM fb_friend_requests
         WHERE action = 'accepted'
         ORDER BY 1) va ON vs.user_id_receiver = va.user_id_receiver
      WHERE va.date_a IS NOT NULL) v) v