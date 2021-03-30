DBCC CHECKIDENT('STUDENTS',RESEED,1) 
GO 
DBCC CHECKIDENT('GROUPS',RESEED,1) 
GO 
DBCC CHECKIDENT('DISCIPLINES',RESEED,1) 
GO 
DBCC CHECKIDENT('STUDENTS_MARKS',RESEED,1) 
GO
INSERT INTO DISCIPLINES(DisciplineName) 
	VALUES ('БЖД'),
	('Системный анализ'),
	('БД'),
	('Математический анализ'),
	('ОС'),
	('Физика'),
	('Политология'),
	('Экология'),
	('Случайные процессы'),
	('ММПР')
SELECT * FROM DISCIPLINES

INSERT INTO GROUPS(GroupName, Сourse, Semester)
	VALUES ('ФИ-72', 4, 7),
	('ФИ-71', 4, 7),
	('ФИ-82', 3, 5),
	('ФИ-81', 3, 5),
	('ФИ-62', 5, 7),
	('ФИ-61', 5, 7),
	('ФИ-92', 2, 5),
	('ФИ-91', 2, 5),
	('ФИ-52', 6, 7),
	('ФИ-51', 6, 7)
SELECT * FROM GROUPS

ALTER TABLE STUDENTS DROP CONSTRAINT StudentUnique
ALTER TABLE STUDENTS ADD CONSTRAINT StudentUnique UNIQUE (Surname, FirstName, Patronymic, Gender, Birthday, RegistrationAddress, GroupID)

INSERT INTO STUDENTS(Surname, FirstName, Patronymic, Gender, Birthday, RegistrationAddress, GroupID) 
	VALUES ('Петров', 'Пётр', 'Петрович', 'мужчина', '1999.02.11', 'ул. Бажана 7А', (SELECT IDGroup FROM GROUPS WHERE IDGroup=3)),
	('Петров', 'Пётр', 'Петрович', 'мужчина', '1999.02.11', 'ул. Бажана 7А', (SELECT IDGroup FROM GROUPS WHERE IDGroup=4)),
	('Азаров', 'Пётр', 'Викторович', 'мужчина', '1965.05.11', 'ул. Вербицкого 7/10', (SELECT IDGroup FROM GROUPS WHERE IDGroup=2)),
	('Порошенко', 'Пётр', 'Николаевич', 'мужчина', '1975.02.24', 'ул. Тростянецкого 15', (SELECT IDGroup FROM GROUPS WHERE IDGroup=1)),
	('Орешкина', 'Анна', 'Николаевна', 'женщина', '1999.08.10', 'ул. Ревуцкого 32', (SELECT IDGroup FROM GROUPS WHERE IDGroup=8)),
	('Сергеева', 'Надежда', 'Викторовна', 'женщина', '1965.08.11', 'ул. Вербицкого 15', (SELECT IDGroup FROM GROUPS WHERE IDGroup=7)),
	('Заглядова', 'Любовь', 'Николаевна', 'женщина', '1990.01.24', 'ул. Тростянецкого 164', (SELECT IDGroup FROM GROUPS WHERE IDGroup=10)),
	('Алексеев', 'Василий', 'Петрович', 'мужчина', '1999.08.01', 'ул. Бажана 16В', (SELECT IDGroup FROM GROUPS WHERE IDGroup=5)),
	('Калашников', 'Николай', 'Алексеевич', 'мужчина', '1996.05.11', 'ул. Вербицкого 3', (SELECT IDGroup FROM GROUPS WHERE IDGroup=9)),
	('Семенова', 'Мария', 'Надеждовна', 'мужчина', '1994.02.24', 'ул. Тростянецкого 169', (SELECT IDGroup FROM GROUPS WHERE IDGroup=6))
SELECT * FROM STUDENTS

INSERT INTO STUDENTS_MARKS(StudentID, DisciplineID, Student_Mark)
	VALUES ((SELECT IDstudent FROM STUDENTS WHERE IDstudent=3), (SELECT IDGroup FROM GROUPS WHERE IDGroup=3), 4),
	((SELECT IDstudent FROM STUDENTS WHERE IDstudent=2), (SELECT IDGroup FROM GROUPS WHERE IDGroup=4), 3),
	((SELECT IDstudent FROM STUDENTS WHERE IDstudent=1), (SELECT IDGroup FROM GROUPS WHERE IDGroup=8), 3),
	((SELECT IDstudent FROM STUDENTS WHERE IDstudent=5), (SELECT IDGroup FROM GROUPS WHERE IDGroup=10), 4),
	((SELECT IDstudent FROM STUDENTS WHERE IDstudent=8), (SELECT IDGroup FROM GROUPS WHERE IDGroup=7), 5),
	((SELECT IDstudent FROM STUDENTS WHERE IDstudent=6), (SELECT IDGroup FROM GROUPS WHERE IDGroup=2), 2),
	((SELECT IDstudent FROM STUDENTS WHERE IDstudent=9), (SELECT IDGroup FROM GROUPS WHERE IDGroup=1), 3),
	((SELECT IDstudent FROM STUDENTS WHERE IDstudent=7), (SELECT IDGroup FROM GROUPS WHERE IDGroup=5), 3),
	((SELECT IDstudent FROM STUDENTS WHERE IDstudent=10), (SELECT IDGroup FROM GROUPS WHERE IDGroup=6), 4),
	((SELECT IDstudent FROM STUDENTS WHERE IDstudent=4), (SELECT IDGroup FROM GROUPS WHERE IDGroup=9), 5)
SELECT * FROM STUDENTS_MARKS
