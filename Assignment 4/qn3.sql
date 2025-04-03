DECLARE
    CURSOR emp_cursor IS
        SELECT EMP_NAME, BASIC 
        FROM EMP
        ORDER BY BASIC DESC
        FETCH FIRST 5 ROWS ONLY;
BEGIN
    FOR emp_rec IN emp_cursor LOOP
        DBMS_OUTPUT.PUT_LINE('Employee: ' || emp_rec.EMP_NAME || ', Salary: ' || emp_rec.BASIC);
    END LOOP;
END;