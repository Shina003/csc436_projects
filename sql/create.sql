DROP DATABASE IF EXISTS video_games_db;
CREATE DATABASE video_games_db;
USE video_games_db;

-- Create table for video games
CREATE TABLE video_games (
    gameID INT AUTO_INCREMENT,  
    title VARCHAR(255),      
    publisher VARCHAR(255),     
    genre VARCHAR(100),     
    year VARCHAR(10),            
    PRIMARY KEY (gameID)
);

-- Create table for platform
CREATE TABLE platform (
    name VARCHAR(50),  
    PRIMARY KEY (name)     
);

-- Create table for sales data
CREATE TABLE sales_data (
    salesID INT AUTO_INCREMENT,
    NA_sales DECIMAL(10,2),    -- 2 decimal places
    EU_sales DECIMAL(10,2),
    JP_sales DECIMAL(10,2),
    other_sales DECIMAL(10,2),
    tot_sales DECIMAL(10,2),
    gameID INT,
    PRIMARY KEY (salesID),
    FOREIGN KEY (gameID) REFERENCES video_games(gameID)  -- Links to the games table
);

CREATE TABLE hosted_on (
    gameID INT,
    platform_name VARCHAR(50),
    PRIMARY KEY (gameID, platform_name),
    FOREIGN KEY (gameID) REFERENCES video_games(gameID),
    FOREIGN KEY (platform_name) REFERENCES platform(name)
);

-- Create temporary table to hold CSV data
CREATE TABLE temp_import (
    `Rank` INT,
    Name VARCHAR(255),
    Platform VARCHAR(50),
    Year INT,
    Genre VARCHAR(100),
    Publisher VARCHAR(255),
    NA_Sales DECIMAL(10,2),
    EU_Sales DECIMAL(10,2),
    JP_Sales DECIMAL(10,2),
    Other_Sales DECIMAL(10,2),
    Global_Sales DECIMAL(10,2)
);