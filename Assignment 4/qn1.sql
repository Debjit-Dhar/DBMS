-- your code goes here
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

-- Insert values into DESIGNATION table
INSERT INTO DESIGNATION (DESIG_CODE, DESIG_DESC) VALUES 
('MGR', 'Manager'),
('EXE', 'Executive'),
('OFR', 'Officer'),
('CLK', 'Clerk'),
('HLP', 'Helper'),
('CEO', 'Ceo');

-- Insert values into DEPARTMENT table
INSERT INTO DEPARTMENT (DEPT_CODE, DEPT_NAME) VALUES 
('PRL', 'Personnel'),
('PRO', 'Production'),
('PUR', 'Purchase'),
('FIN', 'Finance'),
('RES', 'Research'),
('DEB', 'Debugger');

-- Insert values into EMP table
INSERT INTO EMP (EMP_CODE, EMP_NAME, DEPT_CODE, DESIG_CODE, SEX, ADDRESS, CITY, STATE, PIN, BASIC, JN_DT) VALUES 
('E001', 'John Doe', 'PRL', 'MGR', 'M', '123 Main St', 'New York', 'NY', '10001', 80000, TO_DATE('2022-05-10', 'YYYY-MM-DD')),
('E002', 'Jane Smith', 'PRO', 'EXE', 'F', '456 Park Ave', 'Los Angeles', 'CA', '90001', 60000, TO_DATE('2021-07-15', 'YYYY-MM-DD')),
('E003', 'Michael Brown', 'PUR', 'OFR', 'M', '789 Elm St', 'Chicago', 'IL', '60601', 50000, TO_DATE('2020-08-20', 'YYYY-MM-DD')),
('E004', 'Emily Davis', 'FIN', 'CLK', 'F', '101 Pine St', 'Houston', 'TX', '77001', 0, TO_DATE('2019-09-25', 'YYYY-MM-DD')),
('E005', 'Robert Wilson', 'RES', 'HLP', 'M', '202 Cedar Rd', 'San Francisco', 'CA', '94101', 30000, TO_DATE('2018-10-30', 'YYYY-MM-DD'));
-- Insert values into EMP table without DEPT_CODE and BASIC,QUESTION 4
INSERT INTO EMP (EMP_CODE, EMP_NAME, DESIG_CODE, SEX, ADDRESS, CITY, STATE, PIN, JN_DT) VALUES 
('E006', 'Alice Johnson', 'EXE', 'F', '303 Maple St', 'Boston', 'MA', '02101', TO_DATE('2023-01-12', 'YYYY-MM-DD')),
('E007', 'David Lee', 'CLK', 'M', '404 Oak St', 'Seattle', 'WA', '98101', TO_DATE('2022-06-15', 'YYYY-MM-DD')),
('E008', 'Sophia Martinez', 'MGR', 'F', '505 Birch Rd', 'Denver', 'CO', '80201', TO_DATE('2021-11-20', 'YYYY-MM-DD'));
DECLARE
    v_emp_code EMP.EMP_CODE%TYPE;
    v_emp_name EMP.EMP_NAME%TYPE;
BEGIN
    -- Accept user input
    
    v_emp_code := '&EMP_CODE';

    -- Fetch employee name
    SELECT EMP_NAME INTO v_emp_name
    FROM EMP
    WHERE EMP_CODE = v_emp_code;

    -- Display employee name
    DBMS_OUTPUT.PUT_LINE('Employee Name: ' || v_emp_name);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Employee does not exist.');
END;
/
