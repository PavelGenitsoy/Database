DROP PROC IF EXISTS List_of_Students_without_Exam;

GO
CREATE PROC List_of_Students_without_Exam
	@GroupName NVARCHAR (20),
	@TypeControl NVARCHAR(10)
AS
	SELECT Surname, FirstName, Patronymic, GroupName, DisciplineName, TypeControl, Student_Mark
	FROM STUDENTS_MARKS INNER JOIN (STUDENTS INNER JOIN GROUPS ON GROUPS.IDGroup=STUDENTS.GroupID) ON STUDENTS.IDstudent=STUDENTS_MARKS.StudentID
	INNER JOIN DISCIPLINES ON DISCIPLINES.IDdiscipline=STUDENTS_MARKS.DisciplineID
	WHERE GROUPS.GroupName=@GroupName AND DISCIPLINES.TypeControl=@TypeControl AND STUDENTS_MARKS.Student_Mark IS NULL
GO

EXEC List_of_Students_without_Exam 'ФИ-51', 'экзамен'

-------------------------------------------------------------------------------------------------------------------------------------------------

SET IDENTITY_INSERT GROUPS ON

GO
CREATE PROC AddNewStudent
	@Surname NVARCHAR (50),
	@FirstName NVARCHAR(50),
	@Patronymic NVARCHAR (50),
	@Gender NVARCHAR (10),
	@Birthday DATE,
	@RegistrationAddress NVARCHAR (100),
	@GroupName NVARCHAR (20),
	@Сourse INT,
	@Semester INT
AS
	SET NOCOUNT ON
	BEGIN
		IF (SELECT COUNT(s.IDstudent) FROM STUDENTS AS s JOIN GROUPS AS g ON s.GroupID=g.IDGroup
		WHERE s.Surname=@Surname AND s.FirstName=@FirstName AND s.Patronymic=@Patronymic AND s.Gender=@Gender AND s.Birthday=@Birthday
		AND s.RegistrationAddress=@RegistrationAddress AND g.GroupName=@GroupName) > 0
			BEGIN 
				PRINT 'Exists'
			END
		ELSE
			BEGIN
				DECLARE @temp INT
				IF (SELECT COUNT(g.IDGroup) FROM GROUPS AS g WHERE g.GroupName=@GroupName) > 0
					SET @temp = (SELECT IDGroup FROM GROUPS AS g WHERE g.GroupName=@GroupName)
				ELSE
					BEGIN
						SET @temp = (SELECT MAX(IDGroup) + 1 FROM GROUPS)
						INSERT INTO GROUPS(IDGroup, GroupName, Сourse, Semester) VALUES (@temp, @GroupName, @Сourse, @Semester)
					END
				IF (SELECT COUNT(s.IDstudent) FROM STUDENTS AS s WHERE s.Surname=@Surname) = 0
					BEGIN
						SET IDENTITY_INSERT GROUPS OFF
						SET IDENTITY_INSERT STUDENTS ON
						DECLARE @tmp INT
						SET @tmp = (SELECT MAX(IDstudent) + 1 FROM STUDENTS)
						INSERT INTO STUDENTS(IDstudent, Surname, FirstName, Patronymic, Gender, Birthday, RegistrationAddress, GroupID)
							VALUES (@tmp, @Surname, @FirstName, @Patronymic, @Gender, @Birthday, @RegistrationAddress, 
							(SELECT IDGroup FROM GROUPS WHERE GROUPS.IDGroup=@temp))
					END
			END
	END
GO
SET IDENTITY_INSERT STUDENTS OFF

SELECT s.Surname, s.FirstName, s.Patronymic, s.Gender, s.Birthday, s.RegistrationAddress, g.GroupName, g.Сourse, g.Semester 
FROM STUDENTS AS s JOIN GROUPS AS g ON s.GroupID=g.IDGroup

EXEC AddNewStudent 'Довошкин', 'Ксений', 'Афенович', 'мужчина', '1988.06.17', 'ул. Богатырского 12А', 'ФИ-53', 6, 11

SELECT s.Surname, s.FirstName, s.Patronymic, s.Gender, s.Birthday, s.RegistrationAddress, g.GroupName, g.Сourse, g.Semester 
FROM STUDENTS AS s JOIN GROUPS AS g ON s.GroupID=g.IDGroup

DELETE FROM STUDENTS WHERE STUDENTS.Surname='Довошкин'
