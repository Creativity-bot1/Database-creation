DROP TABLE IF EXISTS course; 
DROP TABLE IF EXISTS session; 
DROP TABLE IF EXISTS take;
DROP TABLE IF EXISTS module;
DROP TABLE IF EXISTS delegate ;

CREATE TABLE course
(
	code CHAR(3),
	name VARCHAR(30),
	CONSTRAINT code PRIMARY KEY (code),
	credits TINYINT);

CREATE TABLE module
(
code CHAR(2),
name VARCHAR(30) NOT NULL,
cost DECIMAL(8,2)NOT NULL,
credits TINYINT NOT NULL,
course_code CHAR(3),
CONSTRAINT code PRIMARY KEY (code)
);
CREATE TABLE session
(
code CHAR(2) NOT NULL ,
date Date PRIMARY KEY,
room VARCHAR(30) NULL,
CONSTRAINT code FOREIGN KEY (code) REFERENCES module (code)
);

CREATE TABLE delegate 
(
no INT,
name VARCHAR(30) NOT NULL,
phone VARCHAR(30) NULL, 
CONSTRAINT no PRIMARY KEY (no)
);

CREATE TABLE take 
(
code CHAR(2) ,
no INT NOT NULL,
grade TINYINT NOT NULL,

CONSTRAINT codex PRIMARY KEY (code, no),
CONSTRAINT codey FOREIGN KEY (code) REFERENCES module (code),
CONSTRAINT no1 FOREIGN KEY (no) REFERENCES delegate (no)
);

INSERT INTO course (code,name,credits)
VALUES
('WSD','Web Systems Development','75'),
('DDM','Database Design & Management','100'),
('NSF','Network Security & Forensics','75');

INSERT INTO module (code,name,cost,credits,course_code)
VALUES
('A2','ASP.NET',250,25,'WSD'),
('A3','PHP',250,25,'WSD'),
('A4','JavaFX',350,25,'WSD'),
('B2','Oracle',750,50,'DDM'),
('B3','SQLS',750,50,'DDM'),
('C2','Law',250,25,'NSF'),
('C3','Forensics',350,25,'NSF'),
('C4','Networks',250,25,'NSF');

INSERT INTO session (code,date,room)
VALUES
('A2','2023.06.05',305),  
('A3','2023.06.06',307),
('A4','2023.06.07',305),
('B2','2023.08.22',208),
('B3','2023.08.23',208),
('A2','2024.05.01',303),
('A3','2024.05.02',305),
('A4','2024.05.03',303),
('B2','2024.07.10',NULL),
('B3','2024.07.11',NULL);

INSERT INTO delegate (no,name,phone)
VALUES
(2001,'Mike',NULL),
(2002,'Andy',NULL),
(2003,'Sarah',NULL),
(2004,'Karen',NULL),
(2005,'Lucy',NULL),
(2006,'Steve',NULL),
(2007,'Jenny',NULL),
(2008,'Tom',NULL);

INSERT INTO take (code,no,grade)
VALUES
('A2','2003',68),
('A3','2003',72),
('A4','2003',53),
('A2','2005',48),
('A3','2005',52),
('A2','2002',20),
('A3','2002',30),
('A4','2002',50),
('B2','2008',90),
('B2','2007',73),
('B3','2007',63);



