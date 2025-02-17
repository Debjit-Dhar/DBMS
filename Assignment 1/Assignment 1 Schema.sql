-- your code goes here
--Display each table
CREATE TABLE EMP(
  	EMP_CODE  	char(5) PRIMARY KEY,
   	EMP_NAME	char(20),
	DEPT_CODE	char(5),
	DESIG_CODE	char(5),
	SEX 		char(1),
    ADDRESS 	char (25),
    CITY 		char (20),
    STATE       char (20),
    PIN    		char (6),
    BASIC 		Number,
    JN_DT		Date);	
CREATE TABLE DESIGNATION(
	DESIG_CODE 	char(5) PRIMARY KEY,
	DESIG_DESC	char(20));
	
CREATE TABLE DEPARTMENT(
	DEPT_CODE 	char(5) PRIMARY KEY,
	DEPT_NAME	char(15));

DESC EMP;
DESC DEPARTMENT;
DESC DESIGNATION;