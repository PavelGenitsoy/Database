ALTER TABLE GROUPS ADD CONSTRAINT Сourse CHECK (Сourse BETWEEN 1 AND 6)
ALTER TABLE GROUPS ADD CONSTRAINT Semester CHECK (Semester BETWEEN 1 AND 12)
ALTER TABLE STUDENTS ADD CONSTRAINT Birthday CHECK (Birthday BETWEEN '1920.01.01' AND '2005.01.01')
ALTER TABLE STUDENTS_MARKS ADD CONSTRAINT Student_Mark CHECK (Student_Mark BETWEEN 2 AND 5)

---------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE STUDENTS DROP CONSTRAINT StudentsGroupID
ALTER TABLE STUDENTS ADD CONSTRAINT StudentsGroupID FOREIGN KEY (GroupID) REFERENCES GROUPS(IDGroup)ON DELETE CASCADE
ALTER TABLE STUDENTS_MARKS DROP CONSTRAINT StudID
ALTER TABLE STUDENTS_MARKS ADD CONSTRAINT StudID FOREIGN KEY (StudentID) REFERENCES STUDENTS(IDstudent)ON DELETE CASCADE
ALTER TABLE STUDENTS_MARKS DROP CONSTRAINT DiscipID
ALTER TABLE STUDENTS_MARKS ADD CONSTRAINT DiscipID FOREIGN KEY (DisciplineID) REFERENCES DISCIPLINES(IDdiscipline)ON DELETE CASCADE

---------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE GROUPS NOCHECK CONSTRAINT Semester 
INSERT INTO GROUPS(GroupName, Сourse, Semester) VALUES ('ФИ-72', 4, 15)
SELECT IDGroup, GroupName, Сourse, Semester FROM GROUPS
ALTER TABLE GROUPS WITH CHECK CHECK CONSTRAINT Semester

---------------------------------------------------------------------------------------------------------------------------------

DELETE FROM GROUPS WHERE Semester > 12;
SELECT IDGroup, GroupName, Сourse, Semester FROM GROUPS
ALTER TABLE GROUPS WITH CHECK CHECK CONSTRAINT Semester
INSERT INTO GROUPS(GroupName, Сourse, Semester) VALUES ('ФИ-72', 4, 15)
SELECT IDGroup, GroupName, Сourse, Semester FROM GROUPS

---------------------------------------------------------------------------------------------------------------------------------

DBCC CHECKIDENT('STUDENTS',RESEED,1) 
GO 
DBCC CHECKIDENT('GROUPS',RESEED,1) 
GO 

ALTER TABLE STUDENTS DROP CONSTRAINT StudentUnique
ALTER TABLE STUDENTS ADD CONSTRAINT StudentUnique UNIQUE (Surname, FirstName, Patronymic, Gender, Birthday, RegistrationAddress, GroupID)

INSERT INTO GROUPS(GroupName, Сourse, Semester) VALUES ('ФИ-72', 4, 7)
INSERT INTO GROUPS(GroupName, Сourse, Semester) VALUES ('ФИ-71', 4, 7)
INSERT INTO GROUPS(GroupName, Сourse, Semester) VALUES ('ФИ-82', 3, 5)
INSERT INTO GROUPS(GroupName, Сourse, Semester) VALUES ('ФИ-81', 3, 5)

INSERT INTO STUDENTS(Surname, FirstName, Patronymic, Gender, Birthday, RegistrationAddress, GroupID) 
	VALUES ('Петров', 'Пётр', 'Петрович', 'мужчина', '1999.02.11', 'ул. Бажана 7А', (SELECT IDGroup FROM GROUPS WHERE IDGroup=3))
INSERT INTO STUDENTS(Surname, FirstName, Patronymic, Gender, Birthday, RegistrationAddress, GroupID) 
	VALUES ('Петров', 'Пётр', 'Петрович', 'мужчина', '1999.02.11', 'ул. Бажана 7А', (SELECT IDGroup FROM GROUPS WHERE IDGroup=4))
INSERT INTO STUDENTS(Surname, FirstName, Patronymic, Gender, Birthday, RegistrationAddress, GroupID) 
	VALUES ('Азаров', 'Пётр', 'Викторович', 'мужчина', '1965.05.11', 'ул. Вербицкого 7/10', (SELECT IDGroup FROM GROUPS WHERE IDGroup=2))
INSERT INTO STUDENTS(Surname, FirstName, Patronymic, Gender, Birthday, RegistrationAddress, GroupID) 
	VALUES ('Порошенко', 'Пётр', 'Николаевич', 'мужчина', '1975.02.24', 'ул. Тростянецкого 15', (SELECT IDGroup FROM GROUPS WHERE IDGroup=1))

SELECT IDGroup, GroupName, Сourse, Semester FROM GROUPS
SELECT IDstudent, Surname, FirstName, Patronymic, Gender, Birthday, RegistrationAddress, GroupID FROM STUDENTS

---------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE DISCIPLINES ADD Single VARCHAR(3) 
SELECT * FROM DISCIPLINES

ALTER TABLE DISCIPLINES DROP COLUMN Single
SELECT * FROM DISCIPLINES

---------------------------------------------------------------------------------------------------------------------------------

EXEC sp_rename 'DISCIPLINES', 'SUBJECTS'
INSERT INTO SUBJECTS(DisciplineName) VALUES ('Физика')
SELECT * FROM SUBJECTS

---------------------------------------------------------------------------------------------------------------------------------

EXEC sp_rename 'SUBJECTS', 'DISCIPLINES'
INSERT INTO DISCIPLINES(DisciplineName) VALUES ('Чертение')
SELECT * FROM DISCIPLINES
