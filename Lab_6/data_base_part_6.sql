GO
CREATE VIEW Deanery 
	AS SELECT Surname, FirstName, Patronymic, GroupName, DisciplineName, TotalHours, TypeControl, Student_Mark, Semester
	FROM STUDENTS_MARKS INNER JOIN (STUDENTS INNER JOIN GROUPS ON GROUPS.IDGroup=STUDENTS.GroupID) ON STUDENTS.IDstudent=STUDENTS_MARKS.StudentID
	INNER JOIN DISCIPLINES ON DISCIPLINES.IDdiscipline=STUDENTS_MARKS.DisciplineID
GO

--------------------------------------------------------------------------------------------------------------------------

SELECT Surname, FirstName, Patronymic, GroupName, DisciplineName, TotalHours, TypeControl, Student_Mark FROM Deanery
	WHERE (TotalHours=120 OR TotalHours=180) AND TypeControl='зачёт'

--------------------------------------------------------------------------------------------------------------------------

SELECT Surname, FirstName, Patronymic, GroupName, DisciplineName, Student_Mark FROM Deanery
	WHERE (DisciplineName='Математический анализ' OR DisciplineName='Физика') AND (GroupName='ФИ-81' OR GroupName='ФИ-61')

--------------------------------------------------------------------------------------------------------------------------

SELECT GroupName, Semester, DisciplineName FROM Deanery
	WHERE Semester=7 AND (GroupName='ФИ-71' OR GroupName='ФИ-72')
