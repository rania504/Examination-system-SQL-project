Create table Department (
    Dept_no int primary key,
    Dept_name varchar(100) not null 
);

Create table Student (
    stud_ID int primary key identity(1,1), 
	fname varchar(50) not null,
    lname varchar(50) not null,
    email varchar(100) not null unique,
    password varchar(100) not null, 
	Dept_no int,
	Supervisor_ID int,
    constraint c20 foreign key (Dept_no) references Department(Dept_no) on update cascade,
    constraint c21 CHECK (email LIKE '%_@__%.__%'),
	constraint c22 foreign key (Supervisor_ID) references Instructor(Ins_id)
);

create table Course(
	CID int primary key,
	Cname varchar(100) not null unique,
	CDescription varchar(500),
	CminDegree int default 50 not null , 
	CmaxDegree int default 100 not null ,
	Dep_ID int,
	constraint c30 foreign key(Dep_ID) references department(Dept_no) on update cascade,
	constraint c31 check ( CminDegree < CmaxDegree ) ,
	constraint c32 check ( CminDegree >= 0 and CmaxDegree >= 0) 
);

create table Topic(
	CID int,
	TID int identity(1,1), 
	Tname varchar(200) not null,
	primary key (TID,Cid),
	constraint c40 foreign key(Cid) references Course(CID) on delete cascade on update cascade
);
drop table Topic


Create Table Instructor(
	Ins_id int primary key identity(1,1),
	fname varchar(50) not null,
	lname varchar(50) not null,
	email varchar(200) unique not null,
	password varchar(100) not null,
	Dept_id int,
	constraint c50 foreign key(Dept_id) references Department(Dept_no) on update cascade,
	constraint c51 CHECK (email LIKE '%_@__%.__%')
);

CREATE TABLE Ins_Course(
    Ins_id int,
    C_id int,
    PRIMARY KEY (Ins_id, C_id),
    constraint c60 foreign key (Ins_Id) references Instructor(Ins_id) on update no action on delete no action,
    constraint c61 foreign key (C_id) references Course(CID) on update no action on delete no action
);

Create table Question(
		QID int primary key identity(1,1), 
		Body varchar(500) not null unique,
		Type int not null,					--1 for True/Flase Question, 2 for MCQ
		CorrectAnswer varchar(500) not null,
		Marks int not null default 0,
		constraint c70 CHECK (Marks >= 0),
		constraint c71 check (Type IN (1, 2))
);

Create table QuestionChoices( 
    QID int,
	Choice varchar(500),
	primary key (QID,Choice),
	constraint c80 foreign key (QID) references Question(QID) on delete cascade on update cascade,
);
create table QuestionCourse(
	CID int,
	QID int, 
	primary key (Cid,Qid),
	constraint c90 Foreign key(CID) references Course(CID) on delete cascade on update cascade,
	constraint c91 Foreign key(QID) references Question(QID) on delete cascade on update cascade
);

Create table Exam( 
	ID int primary key identity(1,1),
	CreationTime datetime not null,
	TotalMarks int,
	Ins_ID int,
	constraint c100 foreign key (Ins_ID) references Instructor(Ins_ID),
	constraint c101 check (TotalMarks >= 0),
);

create table Question_Exam(
	Q_id int,
	Exam_id int,
	primary key (Q_id,Exam_id),
	constraint c110 foreign key(Q_id) references Question(QID) on delete cascade on update cascade,
	constraint c111 foreign key(Exam_id) references Exam(ID) on delete cascade on update cascade,
);

CREATE TABLE ExamStudent(
    grade int default 0 check (grade >= 0),
    stud_ID int,
    ExamID int,
    primary key (stud_ID, CID, ExamID),
    constraint c120 foreign key (stud_ID) references Student(stud_ID),
    constraint c122 foreign key (ExamID) references Exam(ID)
);
CREATE TABLE StudentAnswer (
    Stud_ID int,
    Exam_ID int,
    Q_ID int,
    Answer varchar(500), 
    primary key (Stud_ID, Exam_ID, Q_ID),
    constraint sa_foreign_stud foreign key (Stud_ID) references Student(stud_ID) on delete cascade on update cascade,
    constraint sa_foreign_exam foreign key (Exam_ID) references Exam(ID) on delete cascade on update cascade,
    constraint sa_foreign_question foreign key(Q_ID) references Question(QID) on delete cascade on update cascade,
);
