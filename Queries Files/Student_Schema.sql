create Schema Students;

--Login
alter procedure Students.Login
    @email varchar(200),
    @password varchar(100),
	@stud_id int output
as
begin
    begin try
        select @stud_id = stud_id
        from student
        where email = @email and password = @password;

        if @stud_id is not null
        begin
            select 'login successfully' as status;
        end
        else
        begin
            select 'login failed' as status;
        end
    end try
    begin catch
        throw 6000,'Something Error during Login!',1
    end catch
end;

--Avalibale exams according to couse (view)
alter procedure students.AvailbleExams
	@stud_id int
as
begin
    begin try
        if @stud_id is null
        begin
            select 'You are Logout!'
            return;
        end

        select distinct e.id as exam_id, c.cname as course_name
        from exam e
        join studentanswer sa 
		on e.id = sa.exam_id
        join question q 
		on q.qid = sa.q_id
        join course c 
		on c.cid = q.cid
        where sa.stud_id = @stud_id;
    end try
    begin catch
        throw 6000,'Something Wrong during this process!',1
    end catch
end;

-- store its answer (call sp)
Students.ExamAnswers 1,2,'True,True,False,string,default,const,for';

-- see its grade (call sp)
alter procedure Students.Show_Grade_SpecificExam
    @exam_id int,
	@stud_id int
as
begin
    begin try
        if @stud_id is null
        begin
            select 'You are Logout!' as error_message;
            return;
        end

        select grade
        from examstudent
        where stud_id = @stud_id and examid = @exam_id;
    end try
    begin catch
        throw 6000,'Something Error during this process!',1
    end catch
end;

-- see all its histoy grades :Course Exam Student 
alter procedure students.Show_AllGrades
	@stud_id int
as
begin
    begin try
        if @stud_id is null
        begin
            select 'You are Logout!' as error_message;
            return;
        end

        select ces.examid as exam_num, ces.grade
        from examstudent ces
        where ces.stud_id = @stud_id;
    end try
    begin catch
        throw 6000,'Something Error during this process!',1
    end catch
end;

declare @studId int;
exec Students.Login 'moali@example.com','89%452',@studId output
exec Students.AvailbleExams @studId;
exec Students.Show_Grade_SpecificExam 3,@studId
exec Students.Show_AllGrades @studId