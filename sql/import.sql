USE video_games_db;
-- Load the CSV data into a temporary table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/data/vgsales.csv' -- Path to the CSV file
INTO TABLE temp_import -- Temporary table
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
(Name, Platform, Year, Genre, Publisher, NA_Sales, EU_Sales, JP_Sales, Other_Sales, Global_Sales)
SET Year = NULLIF(Year, 'N/A');

-- platform table
INSERT INTO platform (name) 
SELECT DISTINCT Platform
FROM temp_import;

-- video games table
INSERT INTO video_games (title, publisher, genre, year)
SELECT DISTINCT Name, Publisher, Genre, Year
FROM temp_import;

-- sales data table
INSERT INTO sales_data (
    gameID,
    NA_sales,
    EU_sales, 
    JP_sales,
    other_sales,
    tot_sales
)
SELECT 
    video_games.gameID,
    temp_import.NA_Sales,
    temp_import.EU_Sales,
    temp_import.JP_Sales,
    temp_import.Other_Sales,
    temp_import.Global_Sales
FROM temp_import
JOIN video_games ON temp_import.Name = video_games.title;

-- hosted on table (relationship)
INSERT INTO hosted_on (
    gameID,
    platform_name
)
SELECT DISTINCT
    video_games.gameID,
    temp_import.Platform
FROM temp_import
JOIN video_games ON temp_import.Name = video_games.title;

-- Remove the temporary import table
DROP TABLE temp_import;