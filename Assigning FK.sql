CREATE DATABASE SQLProject1;
USE SQLProject1;

CREATE TABLE Student(
id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(50),
age INT,
contact BIGINT,
PRIMARY KEY(id)
);


CREATE TABLE Courses(
id INT NOT NULL AUTO_INCREMENT,
course_name VARCHAR(50),
price DOUBLE,
PRIMARY KEY(id)
);

CREATE TABLE StdCourses(
Studentid INT NOT NULL,
Courseid INT NOT NULL
);

ALTER TABLE StdCourses ADD FOREIGN KEY(Studentid) REFERENCES Student(id);
ALTER TABLE StdCourses ADD FOREIGN KEY(Courseid) REFERENCES Courses(id);
SHOW TABLES;

INSERT INTO Student(id, name, age, contact)
VALUES (1,"Ben", 20, 12345687),
(2, "Tom", 19, 23457892),
(3, "Marry", 21, 4568213),
(4, "Paul", 21, 23485961),
(5, "Riya", 25, 96453215);

INSERT INTO Courses(id, course_name, price)
VALUES (101,"Math", 500),
(102, "Dance", 190),
(103, "History", 210),
(104, "Science", 450);

INSERT INTO StdCourses (Studentid, Courseid)
VALUES (1, 104),
(2, 101), (3, 103), (4, 102), (5, 101);

SELECT * FROM Student;
SELECT * FROM Courses;
SELECT * FROM StdCourses;