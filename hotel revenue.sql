
with hotles as (
SELECT* FROM dbo.[2018]
union
SELECT* FROM dbo.[2019]
union
SELECT* FROM dbo.[2020])
select (stays_in_week_nights+stays_in_weekend_nights)*adr from hotles as Revenue 



--ii our revenue growing by year , so we do SQL analysis

with hotles as(
SELECT* FROM dbo.[2018]
union
SELECT* FROM dbo.[2019]
union
SELECT* FROM dbo.[2020])
select*from hotles


select arrival_date_year,
 sum((stays_in_week_nights+stays_in_weekend_nights)*adr) as Revenue from hotles 
 group by arrival_date_year 

-- we can do by hotel type as well
with hotles as(
SELECT* FROM dbo.[2018]
union
SELECT* FROM dbo.[2019]
union
SELECT* FROM dbo.[2020])
select* from hotles


select arrival_date_year,hotles,
round(sum((stays_in_week_nights+stays_in_weekend_nights)*adr),0) as Revenue from hotles 
 
 group by arrival_date_year ,hotles



with hotles as (
select*from dbo.[2018]
union
select*from dbo.[2019]
union
select*from dbo.[2020])

select*from hotles 
left join market_segment
on hotles.market_segment=market_segment.market_segment
left join dbo.meal_cost
on meal_cost.meal=hotles.meal

---- we can do by Market segment 


select h.lead_time ,h.stays_in_week_nights, h.hotel,t.lead_time ,t.stays_in_week_nights
FROM early_year as h
left join one_year  as t
on h.hotel=t.hotel;

WITH hotels AS (
    SELECT * FROM dbo.[2018]
    UNION ALL
    SELECT * FROM dbo.[2019]
    UNION ALL
    SELECT * FROM dbo.[2020]
)

SELECT 
    arrival_date_year,
    SUM((stays_in_week_nights + stays_in_weekend_nights) * adr) AS Revenue,
    LAG(SUM((stays_in_week_nights + stays_in_weekend_nights) * adr))
        OVER (ORDER BY arrival_date_year) AS Previous_Year_Revenue,
    ROUND(
        (SUM((stays_in_week_nights + stays_in_weekend_nights) * adr) -
        LAG(SUM((stays_in_week_nights + stays_in_weekend_nights) * adr))
        OVER (ORDER BY arrival_
 date_year))
        * 100.0 /
        LAG(SUM((stays_in_week_nights + stays_in_weekend_nights) * adr))
        OVER (ORDER BY arrival_date_year)
    ,2) AS Growth_Percentage
FROM hotels
GROUP BY arrival_date_year
ORDER BY arrival_date_year;

--Cancellation Rate by Year--

WITH hotels AS (
    SELECT * FROM dbo.[2018]
    UNION ALL
    SELECT * FROM dbo.[2019]
    UNION ALL
    SELECT * FROM dbo.[2020]
)

SELECT 
    arrival_date_year,
    COUNT(*) AS Total_Bookings,
    SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) AS Total_Cancellations,
    ROUND(
        SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)
    ,2) AS Cancellation_Rate_Percentage
FROM hotels
GROUP BY arrival_date_year;

--Revenue by Market Segment (Joined Tables)--
WITH hotels AS (
    SELECT * FROM dbo.[2018]
    UNION ALL
    SELECT * FROM dbo.[2019]
    UNION ALL
    SELECT * FROM dbo.[2020]
)

SELECT 
    h.market_segment,
    SUM((h.stays_in_week_nights + h.stays_in_weekend_nights) * h.adr) AS Revenue,
    COUNT(*) AS Total_Bookings
FROM hotels h
GROUP BY h.market_segment
ORDER BY Revenue DESC;

