-- ############################################## Eslam ##############################################
-- # TEST	
EXECUTE AS USER = 'Eslam';
REVERT;
EXECUTE AS USER = 'Ali';
REVERT;
execute view_all_instructors

--SELECT * FROM sys.database_principals WHERE name = 'Ali';
select SYSTEM_USER

-- **************************************************************************************************

-- **************************************************************************************************

-- -- # TEST
EXECUTE AS USER = 'Eslam';
REVERT;
execute add_instructor 27, 'M_Fouly', '1234', 'Fouly','01112428080', 'instructor', 'fouly@gmail.com', 2, 6, 'FULL STACK.NET'

EXECUTE AS USER = 'Ali';
REVERT;
execute add_instructor 28, 'M_AbdElsalam', '4321', 'Abs','01015401588', 'instructor', 'M_abdElsalam@gmail.com', 1, 6, 'FULL STACK MERN'

EXECUTE AS USER = 'Eslam';
REVERT;
execute add_instructor 28, 'M_AbdElsalam', '4321', 'Abs','01015401588', 'Student', 'M_abdElsalam@gmail.com', 1, 6, 'FULL STACK MERN'

--SELECT * FROM sys.database_principals WHERE name = 'Ali';
select SYSTEM_USER

-- **************************************************************************************************

-- **************************************************************************************************
-- # TEST
EXECUTE AS USER = 'Eslam';
REVERT;
execute update_instructor 27, 'MMM_Fouly', '12*34', 'Fouly','01112428080', 'instructor', 'fouly@gmail.com', 2, 6, 'FULL STACK.NET'

EXECUTE AS USER = 'Ali';
execute update_instructor 28, 'M_AbdElsalam', '4321', 'Abs','01015401588', 'instructor', 'M_abdElsalam@gmail.com', 1, 6, 'FULL STACK MERN'

--SELECT * FROM sys.database_principals WHERE name = 'Ali';
select SYSTEM_USER
-- **************************************************************************************************

-- **************************************************************************************************
-- # TEST
EXECUTE AS USER = 'Eslam';
REVERT;
execute delete_instructor 27

EXECUTE AS USER = 'Ali';
execute delete_instructor 7

--SELECT * FROM sys.database_principals WHERE name = 'Ali';
select SYSTEM_USER
-- **************************************************************************************************

-- **************************************************************************************************
-- # TEST
EXECUTE AS USER = 'Eslam';
REVERT;
execute add_track 10, 1, 'cyber security'

EXECUTE AS USER = 'Ali';
execute add_track 11, 2, 'devops'

--SELECT * FROM sys.database_principals WHERE name = 'AdminUser';
select SYSTEM_USER
-- **************************************************************************************************

-- **************************************************************************************************
-- TEST
delete from department where dept_ID=3
--ALTER TABLE department
--ADD CONSTRAINT FK_Constraint FOREIGN KEY (intake_ID) REFERENCES intake(intake_ID) ON DELETE SET NULL  
-- **************************************************************************************************

-- **************************************************************************************************
-- TEST
delete from intake where intake_ID=1
--ALTER TABLE [dbo].[track]
--ADD CONSTRAINT FK_Constraint2 FOREIGN KEY ([dept_ID]) REFERENCES [dbo].[department]([dept_ID]) ON DELETE SET NULL
-- **************************************************************************************************

-- **************************************************************************************************
-- TEST
delete from track where track_ID=10
-- **************************************************************************************************