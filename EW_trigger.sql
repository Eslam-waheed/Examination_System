-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  trigger   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
-- **********************************************************************************************
create trigger delete_dpt   ---------------- Eslam
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
-- **********************************************************************************************

go

-- **********************************************************************************************
create trigger delete_intake   ---------------- Eslam
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

-- **********************************************************************************************

go

-- **********************************************************************************************
create trigger delete_track   ---------------- Eslam
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
-- **********************************************************************************************

-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

--- prevent student to add question
CREATE TRIGGER Trg_PreventStudentAddQuestion   ---------------- Hadder
ON question.questions
INSTEAD OF INSERT
AS
BEGIN
    -- Check if the current user is a student
    IF EXISTS (SELECT * FROM users WHERE Name = SYSTEM_USER AND Role = 'Student')
    BEGIN
        -- Raise an error if the user is a student
        RAISERROR ('Students are not allowed to add questions.', 16, 1);
        RETURN;
    END;

    -- Insert the questions if the user is not a student
    INSERT INTO question.questions (Question_Text, Question_Type, degree, course_id)
    SELECT Question_Text, Question_Type, degree, course_id
    FROM inserted;
END;


--*********************************************************************

--- Prevent student to update a question

CREATE TRIGGER Trg_PreventStudentUpdateQuestion    ---------------- Hadeer
ON question.questions
INSTEAD OF UPDATE
AS
BEGIN
    -- Check if the current user is a student
    IF EXISTS (SELECT * FROM users WHERE Name = SYSTEM_USER AND Role = 'Student')
    BEGIN
        -- Raise an error if the user is a student
        RAISERROR ('Students are not allowed to update questions.', 16, 1);
        RETURN;
    END;

    -- Update the questions if the user is not a student
    UPDATE q
    SET q.Question_Text = i.Question_Text,
        q.Question_Type = i.Question_Type,
        q.degree = i.degree,
        q.course_id = i.course_id
    FROM question.questions q
    INNER JOIN inserted i ON q.Question_ID = i.Question_ID;
END;


--*************************************************************************

--- Prevent student to delete a question

CREATE TRIGGER Trg_PreventStudentDeleteQuestion    ---------------- Hadeer
ON question.questions
INSTEAD OF DELETE
AS
BEGIN
    -- Check if the current user is a student
    IF EXISTS (SELECT * FROM users WHERE Name = SYSTEM_USER AND Role = 'Student')
    BEGIN
        -- Raise an error if the user is a student
        RAISERROR ('Students are not allowed to delete questions.', 16, 1);
        RETURN;
    END;

    -- Delete the questions if the user is not a student
    DELETE q
    FROM question.questions q
    INNER JOIN deleted d ON q.Question_ID = d.Question_ID;
END;
-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&



