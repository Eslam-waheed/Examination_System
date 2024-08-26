-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  stoder proc   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
-- **********************************************************************************************
create procedure view_all_instructors   ---------------- Eslam
as
	if exists (select 1 from dbo.users where Name=SYSTEM_USER and Role='Training_Manager') or SYSTEM_USER='AdminUser'
		begin
			select Name, phone, email
			from dbo.users
			where Role != 'Student'
		end
	else
		begin
			RAISERROR ('Only Training Managers are authorized to view all instructors.', 16, 1);
			RETURN;
		end
-- **********************************************************************************************

go

-- **********************************************************************************************
alter table users
add constraint UQ_username unique(username)

-- have an error becoase the duplicate data
alter table users
add constraint UQ_phone unique(phone)

alter table users
add constraint UQ_email unique(email)

alter table users
add constraint ck_role check(role in ('instructor', 'Training_Manager', 'Student'))

create proc add_instructor   ---------------- Eslam
	@user_id int, 
	@user_name nvarchar(50),
	@pass nvarchar(50),
	@name nvarchar(100),
	@phone nvarchar(20),
	@role nvarchar(20),
	@email nvarchar(100),
	@branch_id int,
	@traning_manager_id int,
	@field nvarchar(50)
as
	if @role='Student'
		begin
			RAISERROR ('please enter a correct data.', 16, 1);
			RETURN;
		end
	else if exists (select 1 from dbo.users where Name=SYSTEM_USER and Role='Training_Manager') or SYSTEM_USER='AdminUser'
		begin
			begin try
				insert into dbo.users(User_ID, userName, password, Name, phone, role, email)
				values(@user_id, @user_name, @pass, @name, @phone, @role, @email)

				-- what is the manager role in this table
				insert into dbo.Instructors(User_ID, branch_ID, Traning_ManagerID, Field)
				values(@user_id, @branch_id, @traning_manager_id, @field)
			end try
			begin catch
				print 'please enter a correct data'
			end catch
		end
	else
		begin
			RAISERROR ('Only Training Managers are authorized to add instructor.', 16, 1);
			RETURN;
		end
-- **********************************************************************************************

go

-- **********************************************************************************************
create proc update_instructor   ---------------- Eslam
	@user_id int, 
	@user_name nvarchar(50),
	@pass nvarchar(50),
	@name nvarchar(100),
	@phone nvarchar(20),
	@role nvarchar(20),
	@email nvarchar(100),
	@branch_id int,
	@traning_manager_id int,
	@field nvarchar(50)
as

	if exists (select 1 from dbo.users where Name=SYSTEM_USER and Role='Training_Manager') or SYSTEM_USER='AdminUser'
		begin
			begin try
				update dbo.users
				set userName=@user_name, password=@pass, Name=@name, phone=@phone, role=@role, email=@email
				where USER_ID=@user_id

				update dbo.Instructors
				set branch_ID=@branch_id, Traning_ManagerID=@traning_manager_id, Field=@field
				where USER_ID=@user_id
			end try
			begin catch
				RAISERROR ('please enter a correct data.', 16, 1);
			end catch
		end
	else
		begin
			RAISERROR ('Only Training Managers are authorized to update the data of the instructor.', 16, 1);
			RETURN;
		end
-- **********************************************************************************************

go

-- **********************************************************************************************
create proc delete_instructor @user_id int   ---------------- Eslam
as
	declare @role nvarchar(20)
	select @role = role from users where USER_ID=@user_id
	
	if (@role!='Instructor')
		begin
			RAISERROR ('please enter a correct ID', 16, 1);
			RETURN;
		end
	else if exists (select 1 from dbo.users where Name=SYSTEM_USER and Role='Training_Manager') or SYSTEM_USER='AdminUser'
		begin
			begin try
				delete from dbo.Instructors
				where USER_ID=@user_id

				delete from dbo.users
				where USER_ID=@user_id
			end try
			begin catch
			RAISERROR ('please enter a correct data', 16, 1);
			end catch
		end
	else
		begin
			RAISERROR ('Only Training Managers are authorized to delete the data of the instructor.', 16, 1);
			RETURN;
		end
-- **********************************************************************************************

go

-- **********************************************************************************************
create proc add_track   ---------------- Eslam
	@track_id int,
	@dep_id int,
	@track_name nvarchar(50)
as
	if exists (select 1 from dbo.users where Name=SYSTEM_USER and Role='Training_Manager') or SYSTEM_USER='AdminUser'
		begin
			begin try
				insert into dbo.track(track_ID, dept_ID, track_name)
				values(@track_id, @dep_id, @track_name)
			end try
			begin catch
				RAISERROR ('please enter a correct data.', 16, 1);
			end catch
		end	
	else
		begin
			RAISERROR ('Only Training Managers are authorized to add a track.', 16, 1);
			RETURN;
		end


--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&


CREATE PROCEDURE Proc_AddInstructorToCourse ---------------- Hadeer
    @CourseID INT,
    @CourseName VARCHAR(255),
    @InstructorID INT
AS
BEGIN
    -- Check if the current user is a training manager
    IF EXISTS (SELECT * FROM users WHERE Name = SYSTEM_USER AND Role = 'Training_Manager') or SYSTEM_USER='AdminUser'
		BEGIN
		   -- Insert the instructor into the course
			INSERT INTO courses (Course_ID, Course_Name, Instractor_ID)
			VALUES (@CourseID, @CourseName, @InstructorID);
		END;
    else
		BEGIN
			-- Raise an error if the user is not a training manager
			RAISERROR ('Only the Training Manager can add an instructor to a course.', 16, 1);
			RETURN;
		END;
END;

--********************************************************************************

---- Update InstructorID

CREATE PROCEDURE Proc_UpdateInstructorID   ---------------- Hadeer
    @CourseID INT,
    @newInstructorID INT
AS
BEGIN
    -- Check if the current user is a training manager
    IF EXISTS (SELECT * FROM users WHERE Name = SYSTEM_USER AND Role = 'Training_Manager') or SYSTEM_USER='AdminUser'
		BEGIN
			-- Update the instructor ID for the specified course
			UPDATE courses
			SET Instractor_ID = @newInstructorID
			WHERE Course_ID = @CourseID;
		END;
	else
		BEGIN
			-- Raise an error if the user is not a training manager
			RAISERROR ('Only the Training Manager can update the instructor ID.', 16, 1);
			RETURN;
		END;
    
    
END;


--**********************************************************************************

---- Proc Delete InstructorID

CREATE PROCEDURE Proc_DeleteInstructorID   ---------------- Hadeer
    @CourseID INT
AS
BEGIN
    -- Check if the current user is a training manager
    IF EXISTS (SELECT * FROM users WHERE Name = SYSTEM_USER AND Role = 'Training_Manager')or SYSTEM_USER='AdminUser'
		BEGIN
			-- Delete the instructor ID for the specified course
			UPDATE courses
			SET Instractor_ID = NULL
			WHERE Course_ID = @CourseID;
		END;
	else
		BEGIN
			-- Raise an error if the user is not a training manager
			RAISERROR ('Only the Training Manager can delete the instructor ID.', 16, 1);
			RETURN;
		END;

    
END;

--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&



