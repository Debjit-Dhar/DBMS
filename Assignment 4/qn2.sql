DECLARE
    v_count NUMBER;
    v_dept_count NUMBER;
BEGIN
    -- Check if the EMP_CODE already exists
    SELECT COUNT(*) INTO v_count FROM EMP WHERE EMP_CODE = 'E1234';
    
    IF v_count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Error: Employee code already exists. Row cannot be added.');
    ELSE
        -- Check if the DEPT_CODE exists in the DEPARTMENT table
        SELECT COUNT(*) INTO v_dept_count FROM DEPARTMENT WHERE DEPT_CODE = 'D001';
        
        IF v_dept_count = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Error: Department code does not exist. Row cannot be added.');
        ELSE
            -- Insert the new employee record
            INSERT INTO EMP (EMP_CODE, EMP_NAME, DEPT_CODE, DESIG_CODE, SEX, ADDRESS, CITY, STATE, PIN, BASIC, JN_DT)
            VALUES ('E1234', 'John Doe', 'D001', 'DSG01', 'M', '123 Street', 'New York', 'NY', '10001', 50000, SYSDATE);
            
            DBMS_OUTPUT.PUT_LINE('Employee record added successfully.');
        END IF;
    END IF;
END;
