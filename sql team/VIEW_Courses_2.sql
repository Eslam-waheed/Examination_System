CREATE OR ALTER VIEW ViewAllCourses AS
SELECT 
    Cr.Course_Name, 
    Cr.Course_Description, 
    Tr.track_name, 
    US.userName AS Instructor_Name, 
    B.branch_name, 
    DEP.dept_name, 
    I.quarter_round
FROM 
    Courses Cr
JOIN 
    Courses_In_Track CT ON Cr.Course_ID = CT.Course_ID
JOIN 
    track Tr ON Tr.track_ID = CT.track_ID
JOIN 
    users US ON Cr.Instractor_ID = US.User_ID
JOIN 
    department DEP ON Tr.dept_ID = DEP.dept_ID
JOIN 
    intake I ON DEP.intake_ID = I.intake_ID
JOIN 
    branch B ON B.branch_ID = I.branch_ID
WHERE 
    B.branch_name = 'iti minia';

-- Create Stored Procedure
GO
CREATE OR ALTER PROCEDURE Proc_ViewAllCourses
AS
BEGIN
    -- Check if the SYSTEM_USER has the role of 'Training_Manager'
    IF EXISTS (
        SELECT 1 
        FROM UserRoles UR
        JOIN users US ON UR.User_ID = US.User_ID
        WHERE US.userName = SYSTEM_USER AND UR.Role = 'Training Manager' 
		or SYSTEM_USER='AdminUser'
    )
    BEGIN
        -- If the user is a training manager, select from the view
        SELECT *
        FROM ViewAllCourses;
    END
    ELSE
    BEGIN
        -- If the user is not a training manager, raise an error
        RAISERROR('Only training managers are allowed to view all courses.', 16, 1);
    END
END;

-- Grant EXECUTE permission on the stored procedure to the Training_Manager role
GRANT EXECUTE ON Proc_ViewAllCourses TO [Training_Manager];

-- Example call to the stored procedure
EXEC Proc_ViewAllCourses;


SELECT * FROM ViewAllCourses

execute as user = 'AdminUser'