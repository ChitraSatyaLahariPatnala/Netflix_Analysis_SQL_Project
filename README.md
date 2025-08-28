# Netflix Movies and TV Shows Analysis using SQL


![Netflix logo](https://github.com/ChitraSatyaLahariPatnala/Netflix_Analysis_SQL_Project/blob/main/logo.png)

## Overview

This project presents a comprehensive analysis of Netflix’s movies and TV shows dataset using SQL. The objective is to extract meaningful insights and address key business questions related to content trends, genres, ratings, and availability. The README provides a structured overview of the project, including : Objectives of the analysis,Business questions explored,SQL-based solutions to those questions,Key findings derived from the queries,Conclusions highlighting major insights

## Objectives

- Analyze the distribution of content types (movies vs TV shows). 
- Identify the most common ratings for movies and TV shows. 
- List and analyze content based on release years, countries, and durations. 
- Explore and categorize content based on specific criteria and keywords.

## Dataset

The data for this project is sourced from the Kaggle Netflix Movies and TV Shows dataset:
- Dataset link : [Netflix Movies and TV Shows dataset](https://www.kaggle.com/datasets/shivamb/netflix-shows?resource=download)

## Schema

```sql
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
```

## Business Problem and Solutions

## 1. Count the number of Movies vs TV Shows

```sql
Select 
   type ,
   count(*) as Total_content
from Netflix
group by type
```

