CREATE TABLE `major_league_baseball_project.players_final_full`
AS
SELECT 
NULLIF(pcf.string_field_0, "NULL") AS playerID,
SAFE_CAST(NULLIF(LOWER(TRIM(pcf.string_field_1)), 'null') AS INT64) AS birthYear,
SAFE_CAST(NULLIF(LOWER(TRIM(pcf.string_field_2)), 'null') AS INT64) AS birthMonth,
SAFE_CAST(NULLIF(LOWER(TRIM(pcf.string_field_3)), 'null') AS INT64) AS birthDay,
NULLIF(pcf.string_field_4, "NULL") AS birthCountry, 
NULLIF(pcf.string_field_5, "NULL") birthState,
NULLIF(pcf.string_field_6, "NULL") AS birthCity,
SAFE_CAST(NULLIF(LOWER(TRIM(pcf.string_field_7)), 'null') AS INT64) AS deathYear,
SAFE_CAST(NULLIF(LOWER(TRIM(pcf.string_field_8)), 'null') AS INT64) AS deathMonth,
SAFE_CAST(NULLIF(LOWER(TRIM(pcf.string_field_9)), 'null') AS INT64) AS deathDay,
NULLIF(pcf.string_field_10, "NULL") AS deathCountry,
NULLIF(pcf.string_field_11, "NULL") AS deathState, 
NULLIF(pcf.string_field_12, "NULL") deathCity,
NULLIF(pcf.string_field_13, "NULL") as nameFirst,
NULLIF(pcf.string_field_14, "NULL") as nameLast,
NULLIF(pcf.string_field_15, "NULL") as nameGiven,
SAFE_CAST(NULLIF(LOWER(TRIM(pcf.string_field_16)), 'null') AS INT64) AS weight,
SAFE_CAST(NULLIF(LOWER(TRIM(pcf.string_field_17)), 'null') AS INT64) AS height,
NULLIF(pcf.string_field_18, "NULL") AS bats,
NULLIF(pcf.string_field_19, "NULL") AS throws,
NULLIF(pcf.string_field_20, "NULL") as debut,
NULLIF(pcf.string_field_21, "NULL") AS finalGame,
NULLIF(pcf.string_field_22, "NULL") AS retroID,
NULLIF(pcf.string_field_23, "NULL") AS bbredID
FROM `major_league_baseball_project.players_clean_full` pcf;
