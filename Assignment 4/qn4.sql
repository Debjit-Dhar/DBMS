DECLARE
    v_dept_code DEPARTMENT.DEPT_CODE%TYPE;
    v_deleted_count NUMBER;
BEGIN
    -- Accept department code from the user
    v_dept_code := '&Enter_Dept_Code';
    
    -- Delete employees with the given department code
    DELETE FROM EMP WHERE DEPT_CODE = v_dept_code;
    
    -- Get the number of rows deleted
    v_deleted_count := SQL%ROWCOUNT;
    
    -- Display the result
    DBMS_OUTPUT.PUT_LINE(v_deleted_count || ' employee(s) deleted from department ' || v_dept_code);
END;