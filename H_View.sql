
----------------------------------------- View -----------------------------------------

-- Training manager
-- view all tracks

CREATE VIEW View_Tracks AS   ------------- Hadeer
SELECT *
FROM track
WHERE EXISTS (
    SELECT *
    FROM users
    WHERE (Name = SYSTEM_USER AND Role = 'Training_Manager') or SYSTEM_USER='AdminUser'
);

--select * from View_Tracks
--select SUSER_NAME()