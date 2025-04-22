DROP DATABASE task2;
CREATE DATABASE task2;
USE task2;
SHOW DATABASES;

CREATE TABLE student (
    username VARCHAR(50) PRIMARY KEY
);

DESCRIBE student;

CREATE TABLE assignment (
    shortname VARCHAR(50) PRIMARY KEY,
    due_date DATE NOT NULL,
    url VARCHAR(255)
);

DESCRIBE assignment;

CREATE TABLE submission (
    username VARCHAR(50),
    shortname VARCHAR(50),
    version INT,
    submit_date DATE NOT NULL,
    data TEXT,
    PRIMARY KEY (username, shortname, version),
    FOREIGN KEY (username) REFERENCES student(username) ON DELETE CASCADE,
    FOREIGN KEY (shortname) REFERENCES assignment(shortname) ON DELETE CASCADE
);

DESCRIBES submission;

## Table in student
## Table in assignment
## Table in submission
## Entity Diagram Relationship
