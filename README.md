# Amazon_Vine_Analysis
Data source: https://s3.amazonaws.com/amazon-reviews-pds/tsv/amazon_reviews_us_Watches_v1_00.tsv.gz
Software: Google Colab, spark-3.1.2, pgAdmin 4, AWS PostgreSQL 12.8

## Project Overview
This project leverages big data cloud technologies: AWS & PySpark to analyze Amazon Vine program that enncorages and forsters customers to provide products comments, reviews and Star rating. The goal is to identify any potential bias for Vine vs non-Vine reviews for watch products.


## Results

Based on the following criteria: 
    * Equal or more than 20 total votes
    * Equal or more than 50% of helpful votes


- How many Vine reviews and non-Vine reviews were there?
    
        Vine: 47 Total reviews
        Non-Vine: 8,362 Total reviews

- How many Vine reviews were 5 stars? How many non-Vine reviews were 5 stars?
        
        Vine: 15 Total reviews
        Non-Vine: 4,332 Total reviews

- What percentage of Vine reviews were 5 stars? What percentage of non-Vine reviews were 5 stars?
       
        Vine: 31.9% 
        Non-Vine: 51.8%

![Watch Product: Vine vs Non-Vine](https://github.com/Mejikano/Amazon_Vine_Analysis/blob/main/Resources/Watch_Vine_NonVine_results.png)





## Summary

First of all our watches product data set has a little percentige of participating Vine products which may skew a little bit the analysis. However altough the previous results suggest that there is not positive bias for Vine products because non-Vine products have a better 5 star rate, the following more detailed analysis using additional views and perspectives of the information show that overall a Vine product has a better STAR rating average and grouping the rated Star performance: 1) 0 to 3 Stars as **Poor-Medium** and 2) 4 to 5 Stars as **Good**. Vine products have better performance results than non-Vine products. 

### Star Rating average

**key take away**: Vine producs Star average 3.9 over 3.7 of Non-Vine producs

![Watch Product: Vine vs Non-Vine](https://github.com/Mejikano/Amazon_Vine_Analysis/blob/main/Resources/Watch_Vine_NonVine_results_STARavg.png)

Reference, SQL Query statement of the analysis:

```
SELECT vt.vine, 
COUNT(vt.review_id) AS TotalNum_Review, 
COUNT(CASE WHEN vt.star_rating =5 THEN 1 END) AS Total5Star, 
TRUNC((COUNT(CASE WHEN vt.star_rating =5 THEN 1 END)::decimal/COUNT(vt.review_id)::decimal) *100, 2)  AS Percentage5Star,
AVG(vt.star_rating) AS AvgStarRating
FROM public.vine_table vt
WHERE
vt.total_votes>=20
AND CAST(vt.helpful_votes AS FLOAT)/CAST(vt.total_votes AS FLOAT) >=0.5
GROUP BY vt.vine
```


### Star Rating average

**key take away**: Vine producs Star 74.46% of the reviews have a good rating (4 or 5 Star) over 67.7% of Non-Vine products

![Watch Product: Vine vs Non-Vine 0 to 5 STARs](https://github.com/Mejikano/Amazon_Vine_Analysis/blob/main/Resources/Watch_Vine_NonVine_0to3_4to5_Stars.png)


Reference, SQL Query statement of the analysis:

```
SELECT vt.vine, 
COUNT(vt.review_id) AS TotalNum_Review, 
COUNT(CASE WHEN vt.star_rating between 4 and 5 THEN 1 END) AS Total4to5Star,
TRUNC((COUNT(CASE WHEN vt.star_rating between 4 and 5 THEN 1 END)::decimal/COUNT(vt.review_id)::decimal) *100, 2)  AS Percentage4To5Star,
COUNT(CASE WHEN vt.star_rating between 0 and 3 THEN 1 END) AS Total4to5Star,
TRUNC((COUNT(CASE WHEN vt.star_rating between 0 and 3 THEN 1 END)::decimal/COUNT(vt.review_id)::decimal) *100, 2)  AS Percentage0To3Star
FROM public.vine_table vt
WHERE
vt.total_votes>=20
AND CAST(vt.helpful_votes AS FLOAT)/CAST(vt.total_votes AS FLOAT) >=0.5
GROUP BY vt.vine
```






