SELECT vt.vine, 
COUNT(vt.review_id) AS TotalNum_Review, 
COUNT(CASE WHEN vt.star_rating =5 THEN 1 END) AS Total5Star, 
TRUNC((COUNT(CASE WHEN vt.star_rating =5 THEN 1 END)::decimal/COUNT(vt.review_id)::decimal) *100, 2)  AS Percentage5Star
FROM public.vine_table vt
WHERE
vt.total_votes>=20
AND CAST(vt.helpful_votes AS FLOAT)/CAST(vt.total_votes AS FLOAT) >=0.5
GROUP BY vt.vine