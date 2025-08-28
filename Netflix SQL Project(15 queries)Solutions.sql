-- NETFLIX PROJECT 

drop table if exists Netflix;
Create table Netflix
(
	show_id VARCHAR(10),
	type VARCHAR(10),
	title VARCHAR(120),
	director VARCHAR(220),
	casts VARCHAR(1000),
	country	VARCHAR(150),
	date_added VARCHAR(50),
	release_year INT,
	rating VARCHAR(10),
	duration VARCHAR(20),	
	listed_in VARCHAR(100),
	description VARCHAR(300)
);


select * from Netflix;


select 
   count(*) as Total_content 
from Netflix;


select 
   DISTINCT type
from Netflix;


select * from Netflix;


-- 15 Business Problems 


-- 1. Count the number of Movies vs TV Shows


Select 
   type ,
   count(*) as Total_content
from Netflix
group by type


-- 2. Find the most common rating for movies and TV shows


Select
  type,
  rating
FROM
(
Select 
   type,
   rating,
   count(*) as No_of_ratings,
   rank() over(partition by type order by count(*) desc) as ranking
from Netflix
group by 1,2
)as T1
where 
  ranking = 1


-- 3. List all movies released in a specific year (e.g., 2020)


Select * from Netflix
where 
    type = 'Movie'
	and
	release_year = 2020


-- 4. Find the top 5 countries with the most content on Netflix


select
   UNNEST(STRING_TO_ARRAY(country,','))as new_country,
   count(show_id) as Total_content
from Netflix 
group by 1
order by 2 desc
limit 5


-- 5. Identify the longest movie


select * from Netflix
where
   type = 'Movie'
   and 
   Duration = (select Max(Duration) from Netflix)


-- 6. Find content added in the last 5 years


select 
   * 
from Netflix
where
   to_date(date_added,'Month DD, YYYY') >= current_date - Interval '5 years'


-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

select * from Netflix
where 
   Director ILIKE '%Rajiv Chilaka%'



-- 8. List all TV shows with more than 5 seasons

Select 
   *
from Netflix 
where 
   type = 'TV Show'
   and
   SPLIT_PART(duration,' ',1)::numeric > 5



-- 9. Count the number of content items in each genre

select
   UNNEST(STRING_TO_ARRAY(listed_in, ',')) as Genre,
   count(Show_id) as Total_content
from Netflix
Group by 1



-- 10.Find each year and the average numbers of content release in India on netflix.return top 5 year with highest avg content release!

select 
   Extract(Year FROM TO_DATE(date_added , 'Month DD, YYYY')) as Year,
   COUNT(*) as yearly_content,
   Round(Count(*)::numeric/(Select count(*) from Netflix where country = 'India')*100::numeric,2) as Avg_content
from Netflix
where 
   country = 'India'
Group by 1 
order by Avg_content desc
limit 5 


-- 11. List all movies that are documentaries

select * from Netflix
where
	listed_in ILIKE '%documentaries%'
   

-- 12. Find all content without a director

select * from Netflix
where
	director IS NULL

-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!

select * from Netflix
where
	casts ILIKE '%Salman Khan%'
	and
	release_year > Extract(Year from current_date)-10
	

	
-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.

Select 
	-- Show_id,
	-- casts,
	UNNEST(STRING_TO_ARRAY(casts,',')) as Actors,
	count(*) as Total_no_of_films
from Netflix
where country ILIKE '%India%'
group by 1
Order by 2 desc 
limit 10




-- 15.Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
-- the description field. Label content containing these keywords as 'Bad' and all other 
-- content as 'Good'. Count how many items fall into each category.


With new_table 
as
(
Select 
*,
	CASE
	WHEN description ILIKE '%kill%' or
		 description ILIKE '%violence%' THEN 'Bad_film'
		 ELSE 'Good_film'
	END as Category
from Netflix
)
Select 
	Category,
	count(*) as Total_type_of_content
from new_table
group by 1

