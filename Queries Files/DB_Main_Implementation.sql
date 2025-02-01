--Helper SP
create procedure Get_Questions_By_Type
    @courseName varchar(100),
    @QuesNum int,
    @type int
AS
begin
    select TOP (@QuesNum) QID, Body, Type
    from Question Q
    join Course C 
	on Q.CID = C.CID
    where C.Cname = @courseName AND Q.Type = @type
    order by NEWID();
end;
--------

create view Q_QE_join
as
	select *
	from Question Q
	join Question_Exam QE
	on Q.QID = QE.Q_id
---------

alter procedure Cal_TotalMarks
    @examid int,
	@totalMarks int output
AS
begin
    begin Transaction;
    begin try
        select @totalMarks = SUM(Q.Marks)
        from dbo.Q_QE_join Q
        where Q.Exam_ID = @examid;

        update Exam
        set TotalMarks = @totalMarks
        where ID = @examid;

        commit Transaction;
    end try
    begin catch
		select 'Something error during calculate Total Marks of Current Exam';
        rollback Transaction;
    end catch;
end;

--------------------------------------------
alter procedure ExamGeneration
    @courseName varchar(100),
    @InsId int,
    @QnumT int,
    @QnumM int,
	@ExamId int OUTPUT

with encryption
AS
begin
    begin Transaction;
    begin try
        insert into Exam (Ins_ID, CreationTime) 
		values (@InsId, GETDATE());

        set @ExamId = SCOPE_IDENTITY();

        create table #TempQuestions (
		QID int, 
		QBody varchar(500),
		Type int
		);

        insert into #TempQuestions
        exec Get_Questions_By_Type @courseName, @QnumT, 1;

        insert into #TempQuestions
        exec Get_Questions_By_Type @courseName, @QnumM, 2;

        insert into Question_Exam (Q_id, Exam_ID)
        select QID, @ExamId 
		from #TempQuestions;

        create table #TF_Choices (c varchar(10));

        insert into #TF_Choices (c) 
		values ('True'), ('False');

        select TQ.QID, TQ.QBody AS QuestionBody,
            CASE 
                WHEN TQ.Type = 1 THEN TC.c
                ELSE QC.Choice
            end AS Choice
        from #TempQuestions TQ
        LEFT join QuestionChoices QC 
		on TQ.QID = QC.QID
        LEFT join #TF_Choices TC 
		on TQ.Type = 1
        order by TQ.QID;

		declare @ExamTotalMarks int;
		exec Cal_TotalMarks @ExamId, @ExamTotalMarks OUTPUT;
		select 'Total Marks for Exam: ' + CAST(@ExamTotalMarks AS varchar);

        drop table #TempQuestions;
        drop table #TF_Choices;

        commit Transaction;
    end try
    begin catch 
		select 'Something error at During Generating an Exam';
        rollback Transaction;
    end catch;
end;

declare @GeneratedExamId int;
exec ExamGeneration 'Basic C#', 1, 2, 5, @GeneratedExamId OUTPUT;
select 'Generated Exam ID: ' + CAST(@GeneratedExamId AS varchar);
-------------------

alter procedure ExamAnswers
    @stuId int,
    @examid int,
    @Answer varchar(MAX)

with encryption
AS
begin
    begin Transaction;
    begin try

        declare @totalQ int;
        select @totalQ = COUNT(QID)
        from Q_QE_join
        where Exam_ID = @examid;

        declare @Questiontable table (
		QNum int IDENTITY(1, 1),
		QID int
		);

        insert into @Questiontable (QID)
        select QID 
		from Q_QE_join 
		where Exam_ID = @examid;

        declare @ind int = 1, @curQ int, @curAns varchar(500);

        while @ind <= @totalQ
        begin

            select @curQ = QID 
			from @Questiontable 
			where QNum = @ind;

            select @curAns = newtable.ans
            from (
                select Value AS ans, ROW_NUMBER() OVER (order by (select NULL)) AS Num
                from STRING_SPLIT(@Answer, ',')
            ) AS newtable
            where Num = @ind;

            if EXISTS (
                select 1
                from StudentAnswer
                where Stud_ID = @stuId AND Exam_ID = @examid AND Q_ID = @curQ
            )
            begin
                PRint 'Answer for question ' + CAST(@curQ AS varchar) + ' already exists.';
            end
            ELSE
            begin
                insert into StudentAnswer (Stud_ID, Exam_ID, Q_ID, Answer)
                values (@stuId, @examid, @curQ, @curAns);
            end;
            set @ind = @ind + 1;
        end;
        commit Transaction;
    end try
    begin catch
        select 'Something error at Storing Student Answers';
        rollback Transaction;
    end catch;
end;

Students.ExamAnswers 1,3,'True,True,False,string,default,const,for';

---------------------------
alter procedure ExamCorrection
    @examid int,
    @stuId int,
	@finalGrade MonEY OUTPUT

with encryption
AS
begin
    begin Transaction;
    begin try

        create table #Temp_Stud_Ans(
		QID int,
		Ans varchar(500)
		);

        insert into #Temp_Stud_Ans
        select Q_ID, Answer
        from StudentAnswer
        where Exam_ID = @examid AND Stud_ID = @stuId;

        declare @curQ int, @curAns varchar(500), @mark int, @stud_grade int = 0;
        declare @studAns varchar(500);
        declare c1 CURSOR 
		for
			select QID, CorrectAnswer, Marks from Question 
		for read only;
        open c1;
        fetch c1 intO @curQ, @curAns, @mark;
        while @@fetch_STATUS = 0
        begin
            select @studAns = Ans 
			from #Temp_Stud_Ans 
			where QID = @curQ;

            if @studAns = @curAns
                set @stud_grade = @stud_grade + @mark;

            fetch c1 intO @curQ, @curAns, @mark;
        end;
        close c1;
        deallocate c1;

        declare @totalM int;
		exec Cal_TotalMarks @examid, @totalM OUTPUT;
        
        set @finalGrade = (@stud_grade * 1.0 / @totalM) * 100;

	    if not exists(
			select 1 from ExamStudent
			where Stud_ID = @stuId AND ExamID = @examid
		)
			begin
				insert into ExamStudent (Grade, Stud_ID, ExamID)
				values (@finalGrade, @stuId, @examid);
			end
		ELSE
			begin
				select 'Student Already has a grade for this exam!';
			end

        commit Transaction;
    end try
    begin catch
		select 'Something error during Correcting Exam';
        rollback Transaction;
    end catch;
end;

declare @Grade MonEY;
exec Instructors.ExamCorrection 19, 30, @Grade OUTPUT;
select 'Final Grade: ' + CAST(@Grade AS varchar);
---------------------------------------------------