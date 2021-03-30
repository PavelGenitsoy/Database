GO
CREATE TRIGGER Discipline_Mark ON DISCIPLINES FOR DELETE
AS
	SET NOCOUNT ON
	BEGIN
		DECLARE	@IDdiscipline INT
		SELECT @IDdiscipline=IDdiscipline FROM DELETED
		IF EXISTS (SELECT IDdiscipline FROM DISCIPLINES AS d, STUDENTS_MARKS AS sm
		WHERE @IDdiscipline=d.IDdiscipline AND d.IDdiscipline=sm.DisciplineID AND sm.Student_Mark IS NOT NULL
		GROUP BY IDdiscipline)
		RAISERROR('The deletion process is prohibited: there are mark for this discipline.',16,1)WITH NOWAIT
		ROLLBACK TRAN
	END
GO

SELECT 'MAIN TABLE' 
SELECT * FROM DISCIPLINES
SELECT IDdiscipline, Student_Mark FROM DISCIPLINES AS d, STUDENTS_MARKS AS sm
	WHERE d.IDdiscipline=sm.DisciplineID

GO
DELETE FROM DISCIPLINES WHERE IDdiscipline=1
GO

SELECT'Trigger is ON. Trying to delete records of disciplines in DISCIPLINES where id is equal 1'
SELECT * FROM DISCIPLINES
SELECT IDdiscipline, Student_Mark FROM DISCIPLINES AS d, STUDENTS_MARKS AS sm
	WHERE d.IDdiscipline=sm.DisciplineID

GO 
DISABLE TRIGGER Discipline_Mark ON DISCIPLINES
GO

DELETE FROM DISCIPLINES WHERE IDdiscipline=1

SELECT'Trigger is OFF. Trying to delete records of disciplines in DISCIPLINES where id is equal 1'
SELECT * FROM DISCIPLINES
SELECT IDdiscipline, Student_Mark FROM DISCIPLINES AS d, STUDENTS_MARKS AS sm
	WHERE d.IDdiscipline=sm.DisciplineID

-------------------------------------------------------------------------------------------------------------

GO
CREATE VIEW Debtors 
	AS SELECT IDstudent, Surname, FirstName, Patronymic, GroupName, IDdiscipline, DisciplineName, TypeControl, IDstudent_mark, Student_Mark
	FROM STUDENTS_MARKS AS sm INNER JOIN (STUDENTS AS s INNER JOIN GROUPS AS g ON g.IDGroup=s.GroupID) ON s.IDstudent=sm.StudentID
	INNER JOIN DISCIPLINES AS d ON d.IDdiscipline=sm.DisciplineID
GO


SELECT IDstudent, Surname, IDdiscipline, COUNT(IDstudent_mark) AS Number_of_Failed_Exams FROM Debtors
WHERE Student_Mark IS NULL AND TypeControl='экзамен'
GROUP BY IDstudent, Surname, IDdiscipline

SELECT IDstudent, Surname, COUNT(IDstudent_mark) AS Number_of_Failed_Exams FROM Debtors
WHERE Student_Mark IS NULL AND TypeControl='экзамен'
GROUP BY IDstudent, Surname
