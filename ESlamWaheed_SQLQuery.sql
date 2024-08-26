create schema Question

create table Question.Questions(
	Question_ID int identity(1, 1),
	Question_Text nvarchar(max) not null,
	Question_Type varchar(3) not null,
	degree int,
	course_id int,
	--inst_id int,

	-- constraints
	constraint PK_Questions primary key (Question_ID),
	constraint CK_Question_Type check (Question_Type in ('TF', 'MCQ', 'ART'))
	constraint FK_Courses foreign key (course_id) references Courses(Course_ID),
	--constraint FK_Instructors foreign key (inst_id) references Instructors(User_ID)
)


create table Question.Article_Question(
	Art_Question_ID int,
	best_correct_answer nvarchar(max) not null,

	-- constraints
	constraint PK_Art_Question primary key (Art_Question_ID),
	constraint FK_Article_Question foreign key (Art_Question_ID) references Question.Questions(Question_ID)
)

create table Question.True_Or_False_Question
(
	TF_Question_ID int,
	correct_answer bit not null,

	-- constraints
	constraint PK_True_Or_False_Question primary key (TF_Question_ID),
	constraint FK_True_Or_False_Question foreign key (TF_Question_ID) references Question.Questions(Question_ID)
)

create table Question.Multichoice_Question
(
	MC_Question_ID int,
	Choice1 nvarchar(max) not null,
	Choice2 nvarchar(max) not null,
	Choice3 nvarchar(max) not null,
	Choice4 nvarchar(max) not null,
	correct_answer nvarchar(max) not null,

	-- constraints
	constraint PK_Multichoice_Question primary key (MC_Question_ID),
	constraint FK_Multichoice_Question foreign key (MC_Question_ID) references Question.Questions(Question_ID)
)