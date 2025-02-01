--Schema Instructor
create Schema Instructors;


alter procedure Instructors.Login
    @Email varchar(200),
    @Pass varchar(100),
	@ID int output
AS
begin
    declare @Status varchar(50);
    declare @Timestamp datetime = GETDATE();

    select @ID = ins_id
    from Instructor
    where email = @Email AND password = @Pass;

   if @ID IS not NULL
    begin
        set @Status = 'Success';
        select 'Login Successfully';
    end
    else
    begin
        SET @Status = 'Failed';
        select 'Login Failed';
    end;
	
	insert into Login_Audit values(@Email,@Pass,@Status,SUSER_SNAME(),GETDATE())
end;

create proc Instructors.AvailbleCourses
	@ins_id INT
as
	select distinct Cname Course_Name
	from Instructor ins
	join Ins_Course insC
	on ins.Ins_id=insC.Ins_id and ins.Ins_id=@ins_id
	join Course c
	on insC.C_id=CID

--Generate Exam
alter proc Instructors.GenerateExamByIns
     @courseName varchar(100),
	 @QnumT int,
	 @QnumM int,
	 @ins_id INT
as
begin
	begin TRY
		if @ins_id IS NULL
		begin
			raiserror('Please log in.',16,1);
		end;
		if not exists (select 1 from Course where Cname = @courseName)
		begin
			select 'Invalid course name.'
		end;
		declare @GeneratedExamId int=null
		exec ExamGeneration @courseName, @ins_id, @QnumT, @QnumM,@GeneratedExamId output;
		select 'Generated Exam ID: ' + CAST(@GeneratedExamId AS varchar);

	end try

	 begin catch
        insert into Error_Log(ErrorMessage, ErrorTime, UserName)
		values (error_message(), getdate(), suser_sname()); 
    end catch
end;

--Correct Exam
declare @Grade MonEY;
exec Instructors.ExamCorrection 1, 32, @Grade OUTPUT;
select 'Final Grade: ' + CAST(@Grade AS varchar);

declare @id int
exec Instructors.Login 'ahmed@gmail.com','ahmed1234',@id output
exec Instructors.AvailbleCourses @id
exec Instructors.GenerateExamByIns 'Advanced C#',2,5,@id
