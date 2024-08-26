insert into dbo.Courses
values
(1, 1, 'SQL', 'Structured Query Language is a proprietary relational database management system', 100, 50, null),
(2, 1, 'C#', 'Versatile, modern programming language.', 100, 50, null),
(3, 1, 'OOP', 'Object-Oriented Programming', 100, 50, null)


-- Inserting True/False Questions
insert into Question.Questions (Question_Text, Question_Type, degree, course_id)
values
('SQL Server supports both Windows and SQL Server authentication.', 'TF', 1, 1),
('A primary key in SQL Server can contain NULL values.', 'TF', 1, 1),
('SQL Server uses the Transact-SQL (T-SQL) language.', 'TF', 1, 1),
('SQL Server Agent is used to schedule and execute jobs.', 'TF', 1, 1),
('A clustered index is an index where the logical order of the rows matches the physical order of rows.', 'TF', 1, 1),
('SQL Server Management Studio (SSMS) is a separate product from SQL Server.', 'TF', 1, 1),
('SQL Server does not support foreign key constraints.', 'TF', 1, 1),
('A single SQL Server instance can host multiple databases.', 'TF', 1, 1),
('SQL Server Integration Services (SSIS) is a platform for data integration.', 'TF', 1, 1),
('SQL Server does not support the execution of stored procedures.', 'TF', 1, 1);

-- Inserting Multiple Choice Questions
insert into Question.Questions (Question_Text, Question_Type, degree, course_id)
values
('What is the default port number for SQL Server?', 'MCQ', 1, 1),
('Which tool is used to create and manage SQL Server databases?', 'MCQ', 1, 1),
('What is a clustered index?', 'MCQ', 1, 1),
('What is the maximum size of a row in SQL Server?', 'MCQ', 1, 1),
('Which feature allows for the execution of tasks at scheduled times in SQL Server?', 'MCQ', 1, 1),
('What type of join returns all rows from the left table and the matched rows from the right table?', 'MCQ', 1, 1),
('Which data type is used to store variable-length character strings in SQL Server?', 'MCQ', 1, 1),
('What does the acronym T-SQL stand for?', 'MCQ', 1, 1),
('What is a foreign key?', 'MCQ', 1, 1),
('What is SQL Server Reporting Services (SSRS) used for?', 'MCQ', 1, 1);

-- Inserting Article Questions
insert into Question.Questions (Question_Text, Question_Type, degree, course_id)
values
('Describe the differences between clustered and non-clustered indexes in SQL Server.', 'ART', 1, 1),
('Explain the role and importance of SQL Server Agent in database management.', 'ART', 1, 1),
('Discuss the advantages and disadvantages of using SQL Server Integration Services (SSIS).', 'ART', 1, 1),
('What are the benefits of using SQL Server Management Studio (SSMS) for database administration?', 'ART', 1, 1),
('Explain how foreign key constraints help maintain data integrity in SQL Server.', 'ART', 1, 1),
('Describe the process of creating and using stored procedures in SQL Server.', 'ART', 1, 1),
('What are the key features of SQL Server Reporting Services (SSRS) and how do they support business intelligence?', 'ART', 1, 1),
('Discuss the impact of indexing on query performance in SQL Server.', 'ART', 1, 1),
('Explain the concept of transactions in SQL Server and how they ensure data consistency.', 'ART', 1, 1),
('Describe the steps involved in setting up a backup and restore strategy in SQL Server.', 'ART', 1, 1);


insert into Question.True_Or_False_Question(TF_Question_ID, correct_answer)
values
(1, 1),
(2, 0),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 0),
(8, 1),
(9, 1),
(10, 0);


insert into Question.Multichoice_Question (MC_Question_ID, Choice1, Choice2, Choice3, Choice4, correct_answer)
values
(11, '3306', '5432', '1433', '1521', '1433'),
(12, 'SQL Developer', 'MySQL Workbench', 'SQL Server Management Studio (SSMS)', 'pgAdmin', 'SQL Server Management Studio (SSMS)'),
(13, 'An index where the logical order of the rows matches the physical order of rows.', 'An index used only for text columns.', 'An index that does not affect the physical order of rows.', 'An index that can only be created on primary keys.', 'An index where the logical order of the rows matches the physical order of rows.'),
(14, '4 KB', '8 KB', '16 KB', '64 KB', '8 KB'),
(15, 'SQL Profiler', 'SQL Server Agent', 'Database Engine Tuning Advisor', 'Integration Services', 'SQL Server Agent'),
(16, 'Inner join', 'Right join', 'Full join', 'Left join', 'Left join'),
(17, 'CHAR', 'VARCHAR', 'TEXT', 'NVARCHAR', 'VARCHAR'),
(18, 'Technical SQL', 'Text SQL', 'Transact-SQL', 'Transactional SQL', 'Transact-SQL'),
(19, 'A unique identifier for a row.', 'A key used to enforce a link between two tables.', 'A column that cannot have duplicate values.', 'A key used to encrypt the database.', 'A key used to enforce a link between two tables.'),
(20, 'Data integration', 'Data analysis', 'Data reporting', 'Data transformation', 'Data reporting');


insert into Question.Article_Question (Art_Question_ID, best_correct_answer)
values
(21, 'Clustered indexes sort and store the data rows in the table based on their key values, whereas non-clustered indexes store a pointer to the data rows.'),
(22, 'SQL Server Agent automates and schedules tasks, making database management more efficient.'),
(23, 'SSIS offers powerful data integration capabilities but can be complex and resource-intensive.'),
(24, 'SSMS provides a user-friendly interface for managing databases, running queries, and configuring settings.'),
(25, 'Foreign key constraints ensure that the data between related tables remains consistent.'),
(26, 'Stored procedures encapsulate T-SQL code, providing reusability, security, and performance benefits.'),
(27, 'SSRS supports comprehensive reporting capabilities, enhancing decision-making processes.'),
(28, 'Indexes improve query performance by allowing faster data retrieval but can slow down data modification operations.'),
(29, 'Transactions ensure data consistency by treating a sequence of operations as a single unit of work.'),
(30, 'A well-defined backup and restore strategy protects data from loss and ensures business continuity.');
