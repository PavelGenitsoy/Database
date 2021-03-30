SELECT Surname, FirstName, Patronymic, GroupName, Student_Mark FROM STUDENTS, GROUPS, STUDENTS_MARKS
	WHERE STUDENTS.GroupID=GROUPS.IDGroup AND STUDENTS_MARKS.StudentID = STUDENTS.IDstudent
	AND (Student_Mark=5 OR Student_Mark=4)

---------------------------------------------------------------------------------------------------------------------

SELECT Surname, FirstName, Patronymic, Gender, Birthday, RegistrationAddress, GroupName, Student_Mark FROM STUDENTS, GROUPS, STUDENTS_MARKS
	WHERE STUDENTS.GroupID=GROUPS.IDGroup AND STUDENTS_MARKS.StudentID = STUDENTS.IDstudent
	AND (SUBSTRING(Surname,1,1)= 'П' OR SUBSTRING(Surname,1,1)= 'А') AND Gender='мужчина'

---------------------------------------------------------------------------------------------------------------------

SELECT Surname, FirstName, Patronymic, GroupName, Student_Mark FROM STUDENTS, GROUPS, STUDENTS_MARKS
	WHERE STUDENTS.GroupID=GROUPS.IDGroup AND STUDENTS_MARKS.StudentID = STUDENTS.IDstudent
	AND (STUDENTS_MARKS.Student_Mark<=(SELECT AVG(Student_Mark) FROM STUDENTS_MARKS))

---------------------------------------------------------------------------------------------------------------------

SELECT Surname, FirstName, Patronymic, GroupName, Max_SumMarks
	FROM (SELECT Surname, FirstName, Patronymic, GroupName, SUM(Student_Mark) AS Max_SumMarks
		FROM STUDENTS, GROUPS, STUDENTS_MARKS WHERE STUDENTS.GroupID=GROUPS.IDGroup AND STUDENTS_MARKS.StudentID = STUDENTS.IDstudent
		GROUP BY Surname, FirstName, Patronymic, GroupName) x
		WHERE Max_SumMarks=(SELECT MAX(Max_SumMarks)
			FROM(SELECT Surname, FirstName, Patronymic, GroupName, SUM(Student_Mark) AS Max_SumMarks
			FROM STUDENTS, GROUPS, STUDENTS_MARKS WHERE STUDENTS.GroupID=GROUPS.IDGroup AND STUDENTS_MARKS.StudentID = STUDENTS.IDstudent
			GROUP BY Surname, FirstName, Patronymic, GroupName) x)
