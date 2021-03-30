SELECT Surname, FirstName, Patronymic, GroupName, DisciplineName, TotalHours, TypeControl, Student_Mark FROM STUDENTS, GROUPS, DISCIPLINES, STUDENTS_MARKS
	WHERE (DISCIPLINES.TotalHours=120 OR DISCIPLINES.TotalHours=180) AND DISCIPLINES.TypeControl='зачёт'
	AND STUDENTS_MARKS.DisciplineID = DISCIPLINES.IDdiscipline AND STUDENTS.GroupID=GROUPS.IDGroup AND STUDENTS_MARKS.StudentID = STUDENTS.IDstudent

----------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT Surname, FirstName, Patronymic, GroupName, DisciplineName, Student_Mark FROM STUDENTS, GROUPS, DISCIPLINES, STUDENTS_MARKS
	WHERE (DISCIPLINES.DisciplineName='Математический анализ' OR DISCIPLINES.DisciplineName='Физика') 
	AND STUDENTS_MARKS.DisciplineID = DISCIPLINES.IDdiscipline AND (GROUPS.GroupName='ФИ-81' OR GROUPS.GroupName='ФИ-61')
	AND STUDENTS.GroupID=GROUPS.IDGroup AND STUDENTS_MARKS.StudentID = STUDENTS.IDstudent
  
  ----------------------------------------------------------------------------------------------------------------------------------------------------------
  
  SELECT GroupName, Semester, DisciplineName FROM GROUPS, DISCIPLINES, STUDENTS, STUDENTS_MARKS
	WHERE GROUPS.Semester=7 AND (GROUPS.GroupName='ФИ-71' OR GROUPS.GroupName='ФИ-72') 
	AND STUDENTS.GroupID=GROUPS.IDGroup AND STUDENTS_MARKS.StudentID = STUDENTS.IDstudent
	AND STUDENTS_MARKS.DisciplineID=DISCIPLINES.IDdiscipline

  ----------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT Surname, FirstName, Patronymic, GroupName, SUM(Student_Mark) AS SumMarks FROM STUDENTS, GROUPS, STUDENTS_MARKS
	WHERE STUDENTS.GroupID=GROUPS.IDGroup AND STUDENTS_MARKS.StudentID = STUDENTS.IDstudent
	GROUP BY Surname, FirstName, Patronymic, GroupName
