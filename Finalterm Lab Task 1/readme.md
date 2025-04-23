## Final Term Lab Task 1- Multi Level Company Database
* The following are the tasks that need to be implemented using MySQL statements. Make sure to
complete them in the order specified

# Task 1
* <ins>Create a table named employees with the following fields:
> <sup> employee_id: Unique integer, auto-increment, primary key.\
employee_name: String (VARCHAR) with up to 255 characters, not null.\
manager_id: Integer, foreign key referencing employee_id in the same table (employees).

![Sample Output](image/task1.png)

# Task 2
* <ins>Create a table named departments with the following fields:
> <sup> department_id: Unique integer, auto-increment, primary key.\
department_name: String (VARCHAR) with up to 255 characters, not null.

![Sample Output](image/task2.png)

# Task 3
* <ins>Create a table named employee_departments with the following fields:
> <sup> employee_id: Integer, foreign key referencing employee_id in employees.\
department_id: Integer, foreign key referencing department_id in departments.
Composite primary key (employee_id, department_id).

![Sample Output](image/task3.png)

# Task 4
* <ins>Create a table named employee_projects with the following fields:
> <sup> employee_id: Integer, foreign key referencing employee_id in employees.\
project_name: String (VARCHAR) with up to 255 characters, not null.

![Sample Output](image/task4.png)

# Task 5
* <ins>Create a table named managers with the following fields:
> <sup> manager_id: Unique integer, auto-increment, primary key.\
employee_id: Integer, foreign key referencing employee_id in employees.

![Sample Output](image/task5.png)

## Task 1 Table
![Sample Output](image/employeetbl.png)
## Task 2 Table
![Sample Output](image/mantbl.png)
## Task 3 Table
![Sample Output](image/deptbl.png)
## Task 4 Table
![Sample Output](image/empproj.png)
## Task 5 Table
![Sample Output](image/emploproj.png)

## ER Diagram
![Sample Output](image/er1.png)
