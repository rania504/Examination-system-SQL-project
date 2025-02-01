--Student
create procedure sp_Student_select
    @stud_id int = null
as
begin
    if @stud_id IS NULL
        select * from Student;
    else
        select * from Student where stud_ID = @stud_id;
end;

create procedure sp_Student_Insert
    @fname varchar(50),
    @lname varchar(50),
    @email varchar(100),
    @pass varchar(100),
    @dno int,
    @superid int
as
begin
    begin try
        insert into Student (fname, lname, email, password, Dept_no, Supervisor_ID)
        values (@fname, @lname, @email, @pass, @dno, @superid);
    end try
    begin catch
        select ERROR_NUMBER() as ErrorNumber, ERROR_MESSAGE() as ErrorMessage;
    end catch
end;

create procedure sp_Student_update
    @stud_id int,
    @fname varchar(50),
    @lname varchar(50),
    @email varchar(100),
    @pass varchar(100),
    @dno int,
    @superid int
as
begin
    begin try
        if @stud_id IS NOT null
        begin
            update Student
            set fname = @fname,
                lname = @lname,
                email = @email,
                password = @pass,
                Dept_no = @dno,
                Supervisor_ID = @superid
            where stud_ID = @stud_id;
        end
        else
        begin
            select 'Student ID is required for updating.' as ErrorMessage;
        end
    end try
    begin catch
        select ERROR_NUMBER() as ErrorNumber, ERROR_MESSAGE() as ErrorMessage;
    end catch
end;

create procedure sp_Student_delete
    @stud_id int
as
begin
    begin try
        if @stud_id IS NOT null
        begin
            delete from Student where stud_ID = @stud_id;
        end
        else
        begin
            select 'Student ID is required for deletion.' as ErrorMessage;
        end
    end try
    begin catch
        select ERROR_NUMBER() as ErrorNumber, ERROR_MESSAGE() as ErrorMessage;
    end catch
end;

---------------------------
--Department
create procedure sp_Department_select
    @dno int = null
as
begin
    if @dno IS NULL
        select * from Department;
    else
        select * from Department where Dept_no = @dno;
end;

create procedure sp_Department_Insert
    @dno int,
    @dname varchar(100)
as
begin
    begin try
        insert into Department (Dept_no, Dept_name)
        values (@dno, @dname);
    end try
    begin catch
        select ERROR_NUMBER() as ErrorNumber, ERROR_MESSAGE() as ErrorMessage;
    end catch
end;

create procedure sp_Department_update
    @dno int,
    @dname varchar(100)
as
begin
    begin try
        if @dno IS NOT null
        begin
            update Department
            set Dept_name = @dname
            where Dept_no = @dno;
        end
        else
        begin
            select 'Department number is required for updating.' as ErrorMessage;
        end
    end try
    begin catch
        select ERROR_NUMBER() as ErrorNumber, ERROR_MESSAGE() as ErrorMessage;
    end catch
end;

create procedure sp_Department_delete
    @dno int
as
begin
    begin try
        if @dno IS NOT null
        begin
            delete from Department where Dept_no = @dno;
        end
        else
        begin
            select 'Department number is required for deletion.' as ErrorMessage;
        end
    end try
    begin catch
        select ERROR_NUMBER() as ErrorNumber, ERROR_MESSAGE() as ErrorMessage;
    end catch
end;

------------------------
--Topic
create procedure sp_Coursetopic_select
    @cid int = null
as
begin
    if @cid IS NOT null
        select * from Topic where CID = @cid;
    else
        select * from Topic;
end;

create procedure sp_Coursetopic_Insert
    @cid int,
    @tname varchar(200)
as
begin
    begin try
        if @cid IS NOT null AND @tname IS NOT null
        begin
            insert into Topic (CID, Tname)
            values (@cid, @tname);
        end
        else
        begin
            select 'CID and Tname are required for insertion.' as ErrorMessage;
        end
    end try
    begin catch
        select ERROR_NUMBER() as ErrorNumber, ERROR_MESSAGE() as ErrorMessage;
    end catch
end;

create procedure sp_Coursetopic_update
    @tid int,
    @tname varchar(200)
as
begin
    begin try
        if @tid IS NOT null AND @tname IS NOT null
        begin
            update Topic
            set Tname = @tname
            where TID = @tid;
        end
        else
        begin
            select 'TID and Tname are required for updating.' as ErrorMessage;
        end
    end try
    begin catch
        select ERROR_NUMBER() as ErrorNumber, ERROR_MESSAGE() as ErrorMessage;
    end catch
end;

create procedure sp_Coursetopic_delete
    @tid int
as
begin
    begin try
        if @tid IS NOT null
        begin
            delete from Topic where TID = @tid;
        end
        else
        begin
            select 'TID is required for deletion.' as ErrorMessage;
        end
    end try
    begin catch
        select ERROR_NUMBER() as ErrorNumber, ERROR_MESSAGE() as ErrorMessage;
    end catch
end;

-------------------------------
--Question
create procedure sp_Question_select
    @QID int = null
as
begin
    if @QID IS NULL
        select QID as Question_ID, Body as Question_Body, Type as Question_Type, CorrectAnswer as Q_CorrectAnswer, Marks as Question_Mark
        from Question;
    else
        select QID as Question_ID, Body as Question_Body, Type as Question_Type, CorrectAnswer as Q_CorrectAnswer, Marks as Question_Mark
        from Question
        where QID = @QID;
end;

create procedure sp_Question_Insert
    @Body varchar(500),
    @Type int,
    @CorrectAnswer varchar(500),
    @Marks int
as
begin
    begin try
        if @Body IS NOT null AND @Type IS NOT null AND @CorrectAnswer IS NOT null AND @Marks IS NOT null
        begin
            insert into Question (Body, Type, CorrectAnswer, Marks)
            values (@Body, @Type, @CorrectAnswer, @Marks);
        end
        else
        begin
            select 'All fields (Body, Type, CorrectAnswer, Marks) are required for insertion.' as ErrorMessage;
        end
    end try
    begin catch
        select ERROR_NUMBER() as ErrorNumber, ERROR_MESSAGE() as ErrorMessage;
    end catch
end;

create procedure sp_Question_update
    @QID int,
    @Body varchar(500),
    @Type int,
    @CorrectAnswer varchar(500),
    @Marks int
as
begin
    begin try
        if @QID IS NOT null AND @Body IS NOT null AND @Type IS NOT null AND @CorrectAnswer IS NOT null AND @Marks IS NOT null
        begin
            update Question
            set Body = @Body,
                Type = @Type,
                CorrectAnswer = @CorrectAnswer,
                Marks = @Marks
            where QID = @QID;
        end
        else
        begin
            select 'All fields (QID, Body, Type, CorrectAnswer, Marks) are required for updating.' as ErrorMessage;
        end
    end try
    begin catch
        select ERROR_NUMBER() as ErrorNumber, ERROR_MESSAGE() as ErrorMessage;
    end catch
end;

create procedure sp_Question_delete
    @QID int
as
begin
    begin try
        if @QID IS NOT null
        begin
            delete from Question where QID = @QID;
        end
        else
        begin
            select 'QID is required for deletion.' as ErrorMessage;
        end
    end try
    begin catch
        select ERROR_NUMBER() as ErrorNumber, ERROR_MESSAGE() as ErrorMessage;
    end catch
end;

---------------------------
----Exam
CREATE PROCEDURE sp_exam_select
    @id INT = NULL
AS
BEGIN
    IF @id IS NULL
        SELECT * FROM exam;
    ELSE
        SELECT * FROM exam WHERE id = @id;
END;

CREATE PROCEDURE sp_exam_insert
    @creationtime DATETIME,
    @totalmarks INT,
    @ins_id INT
AS
BEGIN
    BEGIN TRY
        INSERT INTO exam (creationtime, TotalMarks, ins_id)
        VALUES (@creationtime, @totalmarks, @ins_id);
    END TRY
    BEGIN CATCH
        SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
    END CATCH
END;

CREATE PROCEDURE sp_exam_update
    @id INT,
    @creationtime DATETIME,
    @totalmarks INT,
    @ins_id INT
AS
BEGIN
    BEGIN TRY
        IF @id IS NOT NULL
        BEGIN
            UPDATE exam
            SET creationtime = @creationtime,
                totalmarks = @totalmarks,
                ins_id = @ins_id
            WHERE id = @id;
        END
        ELSE
        BEGIN
            SELECT 'exam id is required for updating.' AS errormessage;
        END
    END TRY
    BEGIN CATCH
        SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
    END CATCH
END;

CREATE PROCEDURE sp_exam_delete
    @id INT
AS
BEGIN
    BEGIN TRY
        IF @id IS NOT NULL
        BEGIN
            DELETE FROM exam WHERE id = @id;
        END
        ELSE
        BEGIN
            SELECT 'exam id is required for deletion.' AS errormessage;
        END
    END TRY
    BEGIN CATCH
        SELECT ERROR_NUMBER() AS errornumber, ERROR_MESSAGE() AS errormessage;
    END CATCH
END;
-------------------------
--Course---
--select
create procedure sp_course_select
    @cid int = null
as
begin
    if @cid IS NULL
        select * from course;
    else
        select * from course where cid = @cid;
end;

create procedure sp_course_insert
    @cname varchar(100),
    @cdescription varchar(500),
    @cmindegree int,
    @cmaxdegree int,
    @depid int
as
begin
    begin try
        if @cname IS NULL 
        begin
            select 'Course name cannot be null' as ErrorMessage;
            return;
        end

        if @cmindegree > @cmaxdegree
        begin
            select 'cmindegree cannot be greater than cmaxdegree.' as ErrorMessage;
            return;
        end
        begin transaction;
        insert into course (cname, cdescription, cmindegree, cmaxdegree, dep_id)
        values (@cname, @cdescription, @cmindegree, @cmaxdegree, @depid);
        commit transaction;
    end try
    begin catch
        if @@TRANCOUNT > 0
            rollback transaction;

        select error_number() as ErrorNumber, error_message() as ErrorMessage;
    end catch
end;

create procedure sp_course_update
    @cid int,
    @cname varchar(100),
    @cdescription varchar(500),
    @cmindegree int,
    @cmaxdegree int,
    @depid int
as
begin
    begin try
        -- validate parameters
        if @cname IS NULL 
        begin
            select 'Course name cannot be null' as ErrorMessage;
            return;
        end
        if @cmindegree > @cmaxdegree
        begin
            select 'cmindegree cannot be greater than cmaxdegree.' as ErrorMessage;
            return;
        end
        begin transaction;
        update course
        set cname = @cname,
            cdescription = @cdescription,
            cmindegree = @cmindegree,
            cmaxdegree = @cmaxdegree,
            dep_id = @depid
        where cid = @cid;

        commit transaction;
    end try
    begin catch
        if @@TRANCOUNT > 0
            rollback transaction;
        select error_number() as ErrorNumber, error_message() as ErrorMessage;
    end catch
end;

create procedure sp_course_delete @cid int
as
begin
    delete from course where cid = @cid;
end;
---------------------------
--Instructor
create view vw_Instructor 
as
select Ins_ID, FName, LName, Email, Dept_ID
from Instructor;
--25.01.2025

create procedure sp_Instructor_select
    @Ins_ID int = null
as
begin
    if @Ins_ID IS NULL
        select * from vw_Instructor;
    else
        select * from vw_Instructor where Ins_ID = @Ins_ID;
end;

-- 2. sp_Instructor_Insert
create procedure sp_Instructor_Insert
    @FName varchar(50),
    @LName varchar(50),
    @Email varchar(200),
    @Pass varchar(100),
    @Dept_ID int
as
begin
    begin try
        if @FName IS NOT null AND @LName IS NOT null AND @Email IS NOT null AND @Pass IS NOT null AND @Dept_ID IS NOT null
        begin
            insert into Instructor (FName, LName, Email, Password, Dept_ID)
            values (@FName, @LName, @Email, @Pass, @Dept_ID);
        end
        else
        begin
            select 'All fields (FName, LName, Email, Password, Dept_ID) are required for insertion.' as ErrorMessage;
        end
    end try
    begin catch
        select ERROR_NUMBER() as ErrorNumber, ERROR_MESSAGE() as ErrorMessage;
    end catch
end;

-- 3. sp_Instructor_update
create procedure sp_Instructor_update
    @Ins_ID int,
    @FName varchar(50),
    @LName varchar(50),
    @Email varchar(200),
    @Pass varchar(100),
    @Dept_ID int
as
begin
    begin try
        if @Ins_ID IS NOT null AND @FName IS NOT null AND @LName IS NOT null AND @Email IS NOT null AND @Pass IS NOT null AND @Dept_ID IS NOT null
        begin
            update Instructor
            set FName = @FName,
                LName = @LName,
                Email = @Email,
                Password = @Pass,
                Dept_ID = @Dept_ID
            where Ins_ID = @Ins_ID;
        end
        else
        begin
            select 'All fields (Ins_ID, FName, LName, Email, Password, Dept_ID) are required for updating.' as ErrorMessage;
        end
    end try
    begin catch
        select ERROR_NUMBER() as ErrorNumber, ERROR_MESSAGE() as ErrorMessage;
    end catch
end;

-- 4. sp_Instructor_delete
create procedure sp_Instructor_delete
    @Ins_ID int
as
begin
    begin try
        if @Ins_ID IS NOT null
        begin
            delete from Instructor where Ins_ID = @Ins_ID;
        end
        else
        begin
            select 'Ins_ID is required for deletion.' as ErrorMessage;
        end
    end try
    begin catch
        select ERROR_NUMBER() as ErrorNumber, ERROR_MESSAGE() as ErrorMessage;
    end catch
end;
-----------------------------------------------------------------------------------------------------------
--sp of Reports

alter proc Report_StudentInfo
	@Dept_no int
as
begin
		select *
		from Student
		where Dept_no=@Dept_no
		order by Dept_no
end;

alter proc StudentExam
	@stud_id int
as
begin
	select Distinct Cname,grade
	from ExamStudent ES
	join Exam E 
	on ES.ExamID=E.ID 
	join Question_Exam QE
	on QE.Exam_id=E.ID
	join Question Q
	on Q.QID=QE.Q_id
	join Course C
	on C.CID=Q.CID
	where ES.stud_ID = @stud_id;
	
end
StudentExam 1

create procedure GetInstructorCourses_StudentsCountCourse
    @InstructorID int
as
begin
    if NOT EXISTS (select 1 from Instructor where Ins_id = @InstructorID)
    begin
        select 'Instructor ID does not exist.';
        return;
    end;
    select 
        C.Cname as 'Course Name',
        COUNT(S.stud_ID) as 'Students Count'
    from 
        Instructor I
    join Ins_Course IC 
	on I.Ins_id = IC.Ins_id
    join Course C 
	on IC.C_id = C.CID
    join Department D 
	on C.Dep_ID = D.Dept_no
    join Student S 
	on S.Dept_no = D.Dept_no 
    where 
        I.Ins_id = @InstructorID
    group by 
        C.Cname
    order by 
        C.Cname; 
end; 


create proc ExamQuestionReport(@examid int)
as
begin
	select q.Body
	from exam e 
	join Question_Exam qe
	on e.ID=qe.Exam_id and e.ID=@examid
	join Question q
	on q.QID=qe.Q_id
end;

create proc StudentAnswers
	@stud_id int,
	@exam_id int
as
begin
	select Body,Answer
	from StudentAnswer SA 
	join Question Q
	on SA.Q_ID=Q.QID and sa.Stud_ID=@stud_id and sa.Exam_ID=@exam_id
end;

StudentAnswers 1,3

create proc Coursetopics
	@CID int
as
   select Tname
   from Topic
   where CID=@CID
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--Validation
--------------------------------------------------------------------------------
--Exam Validation
--global table
create table Error_Log(
ErrorMessage varchar(400),
ErrorTime datetime,
UserName varchar(50),

);
create table Login_Audit (
            Email varchar(200),
			password varchar(100),
            Status varchar(50),
			_user varchar(100),
            Time datetime
);

-----------------------------
create table Exam_Audit (
    AuditID int identity(1,1) primary key,
    Action varchar(30),       
    _user varchar(50),
    ActionTime datetime,
    OldValue int, 
    NewValue int null   
);
--------------------------------------
alter trigger Exam_Insert

on Exam
instead of insert
as
begin
begin try
		insert into Exam_Audit(Action,  _user, ActionTime)
		 values ('Insert Blocked',suser_sname(), getdate());

    end try
		begin catch
		 insert into Error_Log (ErrorMessage, ErrorTime, UserName)
         values (error_message(), getdate(), suser_sname());
		select 'Somthing Error during insert into table'		
		end catch

end;
-----------------------------------------

create trigger Exam_update
on Exam
instead of update
as
begin

begin try

declare @oldId int , @NewId int 
	if update(ID)
	begin
		select @oldId=ID from deleted
		select @NewId=ID  from inserted
		insert into Exam_Audit(Action,_user,ActionTime,OldValue,NewValue)
		values('update',suser_sname(),getdate(),@oldId,@NewId)
	end


end try

begin catch
insert into Error_Log (ErrorMessage, ErrorTime, UserName)
    values (error_message(), getdate(), suser_sname());
end catch;
end;
--------------------------
create trigger Exam_delete
on Exam
instead of delete
as
begin
    begin try

    declare @oldId int;
    select @oldId = ID from deleted;

    
    insert into Exam_Audit (Action, _user, ActionTime, OldValue, NewValue)
    values ('delete', suser_name(), getdate(), @oldId, null);

    select 'delete action handled and logged in Exam_Audit.';
	end try
	begin catch

	insert into Error_Log (ErrorMessage, ErrorTime, UserName)
    values (error_message(), getdate(), suser_sname());

	end catch
end;

--nonclustered index
create nonclustered index Ins_exam_index
on Exam (ins_ID)

------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
--Student Exam Validation
create table Student_Exam_Audit (
    AuditID int IDENTITY(1,1) PRIMARY KEY,
    Action Nvarchar(10),        -- INSERT, update, delete
    _user varchar(50),
    ActionTime DATETIME,
    OldValue int null,  -- only for updates
    NewValue int null   -- only for updates
);
-----------------------------

create trigger Student_Exam_insert
on ExamStudent
instead of Insert
as
begin
	
	 RAISERROR('You cannot insert into this table.', 16, 1);

	 insert into Student_Exam_Audit(action, _user,ActionTime)
    select 
        'insert', 
        SUSER_SNAME(),  
        GETDATE()
    from inserted;

end

-----------------------------------
create trigger Student_Exam_update
on ExamStudent
instead of update
as
begin

begin try
    
    declare @oldStudId int, @newStudId int;
    declare @oldExamId int, @newExamId int;
    declare @oldGrade money, @newGrade money;

  
    if update(stud_id) OR update(ExamId) OR update(Grade)
        begin           
            select 
                @newStudId = Stud_ID, 
                @newExamId = ExamID, 
                @newGrade = Grade
            from inserted
            where EXISTS (select 1 from deleted where Stud_ID = @oldStudId AND ExamID = @oldExamId);

            
            if @oldStudId != @newStudId
            begin
                insert into Student_Exam_Audit (Action, _user, ActionTime, oldvalue, newvalue)
                values ('update', suser_sname(), GETDATE(), @oldStudId, @newStudId);
            end

            if @oldExamId != @newExamId
            begin
                insert into Student_Exam_Audit (Action, _user, ActionTime, oldvalue, newvalue)
                values ('update', suser_sname(), GETDATE(), @oldExamId, @newExamId);
            end

            if @oldGrade != @newGrade
            begin
                insert into Student_Exam_Audit (Action, _user, ActionTime, oldvalue, newvalue)
                values ('update', suser_sname(), GETDATE(), @oldGrade, @newGrade);
            end

			end

			end try

			begin catch
				insert into Error_Log (ErrorMessage, ErrorTime, UserName)
			 values (error_message(), getdate(), suser_sname());


			end catch

end;

----------------------------------------------------

create trigger Student_Exam_delete
on ExamStudent
instead of delete
as
begin
begin try

declare @oldExamId int 		
		select @oldExamId = ExamID from deleted
		insert into Student_Exam_Audit(Action,_user , ActionTime , oldvalue )
		values('delete',suser_sname(),Getdate(),@oldExamId)

		end try

		begin catch
			insert into Error_Log (ErrorMessage, ErrorTime, UserName)
    values (error_message(), getdate(), suser_sname());

		end catch

end

--nonclustered index
create nonclustered index Exam_Student_grade
on ExamStudent(grade)
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
--Question_Exam Validation

create table Question_Exam_Audit_insert
(

_user varchar(30),
Q_id int,
Exam_id int,
_date datetime,

);
create table Question_Exam_Audit_update
(
_user varchar(30),
_date datetime,
oldvalue int,
newvalue int null,
);

-----------------------------------------------
alter trigger Question_Exam_Insert
on Question_Exam
instead of Insert
as
begin
	begin try

	 begin transaction;
	 raiserror('You cannot insert into this table.', 16, 1);
	commit transaction;

	
	end try

	begin catch
	if @@trancount > 0
            rollback transaction;

		insert into Error_Log (ErrorMessage, ErrorTime, UserName)
    values (error_message(), getdate(), suser_sname());
	insert into Question_Exam_Audit_insert(_user, Q_id,Exam_id,_date)
    select 
        suser_sname(), 
        Q_id, 
        Exam_ID, 
        GETDATE()
    from inserted;
	end catch
end
insert into Question_Exam values(2,2)
-------------------------------------------
alter trigger Question_Exam_update
on Question_Exam
after update
as
begin
begin try

declare @oldExamId int , @newExamId int 
		if update (Exam_id)
		begin
		
		select @oldExamId = Exam_id from deleted
		select @newExamId = Exam_id from inserted

		insert into Question_Exam_Audit_update(_user , _date , oldvalue , newvalue)
		values(suser_sname(),Getdate(),@oldExamId,@newExamId)
		end
		end try
		
		begin catch
insert into Error_Log (ErrorMessage, ErrorTime, UserName)
    values (error_message(), getdate(), suser_sname());
end catch;


end

select * from Question_Exam where Q_id=12 and Exam_id=21

update Question_Exam
set Exam_id=2
where Q_id=12 and Exam_id=21

-------------------------------------
alter trigger Question_Exam_delete
on Question_Exam
after delete
as
begin
begin try

declare @oldExamId int 
		
		
		
		select @oldExamId = Exam_id from deleted
		

		insert into Question_Exam_Audit_update(_user , _date , oldvalue )
		values(suser_sname(),Getdate(),@oldExamId)

	select 'delete action handled and logged in Question_Exam_Audit_update.';

	end try
	begin catch
	insert into Error_Log (ErrorMessage, ErrorTime, UserName)
    values (error_message(), getdate(), suser_sname());
	end catch
end


delete from Question_Exam
where Q_id=12
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
--Student Answer Validation
create table Student_Answer_Audit (
    AuditID int IDENTITY(1,1) PRIMARY KEY,
    Action Nvarchar(10),       
    _user varchar(50),
    ActionTime DATETIME,
    OldValue int null,  
    NewValue int null    
);
-----------------------------------------

create trigger Studen_Answer_insert
on StudentAnswer
instead of Insert
as
begin
begin try
	
	 insert into Student_Answer_Audit(action, _user,ActionTime)
    select 
        'insert', 
        suser_sname(),
       
        GETDATE()
    from inserted;
	RAISERROR('You cannot insert into this table.', 16, 1);

	end try

	begin catch
	insert into Error_Log (ErrorMessage, ErrorTime, UserName)
    values (error_message(), getdate(), suser_sname());
	end catch

end
---------------------------------------------

create trigger Student_Answer_update
on StudentAnswer
after update
as
begin
begin try

declare @oldExamId int , @newExamId int 
		if update (Exam_id)
		begin
		
		select @oldExamId = Exam_id from deleted
		select @newExamId = Exam_id from inserted

		insert into Student_Answer_Audit(Action,_user , ActionTime , oldvalue , newvalue)
		values('update',suser_sname(),Getdate(),@oldExamId,@newExamId)
		end
		end try

		begin catch
		insert into Error_Log (ErrorMessage, ErrorTime, UserName)
    values (error_message(), getdate(), suser_sname());

		end catch
end
--------------------------------------------------------------------

create trigger Student_Answer_delete
on StudentAnswer
after delete
as
begin
begin try

declare @oldExamId int 
			
		select @oldExamId = Exam_id from deleted
		insert into Student_Answer_Audit(Action,_user , ActionTime , oldvalue )
		values('delete',suser_sname(),Getdate(),@oldExamId)

		end try

		begin catch
			insert into Error_Log (ErrorMessage, ErrorTime, UserName)
    values (error_message(), getdate(), suser_sname());


		end catch
end