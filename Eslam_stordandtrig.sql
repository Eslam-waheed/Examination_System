-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  stoder proc   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
-- **********************************************************************************************
create procedure view_all_instructors
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
--alter table users
--add constraint UQ_phone unique(phone)

alter table users
add constraint UQ_email unique(email)

alter table users
add constraint ck_role check(role in ('instructor', 'Training_Manager', 'Student'))

create proc add_instructor
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
create proc update_instructor
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
create proc delete_instructor @user_id int
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
create proc add_track
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
-- **********************************************************************************************

go

-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  trigger   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
-- **********************************************************************************************
create trigger delete_dpt
on dbo.department
instead of delete
as
	begin
		if suser_sname() = 'AdminUser'
			begin
				delete from dbo.department
				where dept_ID in (select dept_ID from deleted);
			end
		else
			begin
				declare @errorMessage nvarchar(255);
				set @errorMessage = 'Not allowed for user ' + suser_sname() + ' to delete the department';
				raiserror(@errorMessage, 16, 1);
			end
	end


ALTER TABLE department
ADD CONSTRAINT FK_Constraint FOREIGN KEY (intake_ID) REFERENCES intake(intake_ID) ON DELETE SET NULL  
-- **********************************************************************************************

go

-- **********************************************************************************************
create trigger delete_intake
on dbo.intake
instead of delete
as
	begin
		if suser_sname() = 'AdminUser'
			begin
				delete from dbo.intake
				where intake_ID in (select intake_ID from deleted);
			end
		else
			begin
				declare @errorMessage nvarchar(255);
				set @errorMessage = 'Not allowed for user ' + suser_sname() + ' to delete the intake';
				raiserror(@errorMessage, 16, 1);
			end
	end



ALTER TABLE [dbo].[track]
ADD CONSTRAINT FK_Constraint2 FOREIGN KEY ([dept_ID]) REFERENCES [dbo].[department]([dept_ID]) ON DELETE SET NULL
-- **********************************************************************************************

go

-- **********************************************************************************************
create trigger delete_track
on dbo.track
instead of delete
as
	begin
		if suser_sname() = 'AdminUser'
			begin
				delete from dbo.track
				where track_ID in (select track_ID from deleted);
			end
		else
			begin
				declare @errorMessage nvarchar(255);
				set @errorMessage = 'Not allowed for user ' + suser_sname() + ' to delete the track';
				raiserror(@errorMessage, 16, 1);
			end
	end
