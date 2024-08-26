-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& triggers &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
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

-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& view &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
CREATE VIEW View_Tracks AS   ------------- Hadeer
SELECT *
FROM track
WHERE EXISTS (
    SELECT *
    FROM users
    WHERE (Name = SYSTEM_USER AND Role = 'Training_Manager') or SYSTEM_USER='AdminUser'
);
-- &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& proc &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&


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


