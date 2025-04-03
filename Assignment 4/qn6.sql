DECLARE
    v_emp_no EMP.EMP_CODE%TYPE;
    v_basic EMP.BASIC%TYPE;
    v_leave_days LEAVE.NO_OF_DAYS%TYPE;
    v_days_in_month NUMBER;
    v_effective_basic NUMBER;
    CURSOR emp_cursor IS
        SELECT E.EMP_CODE, E.BASIC, COALESCE(L.NO_OF_DAYS, 0) AS NO_OF_DAYS
        FROM EMP E
        LEFT JOIN LEAVE L ON E.EMP_CODE = L.EMP_NO
        WHERE L.MONTH = EXTRACT(MONTH FROM SYSDATE);
BEGIN
    FOR emp_rec IN emp_cursor LOOP
        v_emp_no := emp_rec.EMP_CODE;
        v_basic := emp_rec.BASIC;
        v_leave_days := emp_rec.NO_OF_DAYS;
        v_days_in_month := EXTRACT(DAY FROM LAST_DAY(SYSDATE));
        
        -- Calculate effective basic salary
        v_effective_basic := v_basic - (v_basic * v_leave_days / v_days_in_month);
        
        -- Display the effective basic salary for each employee
        DBMS_OUTPUT.PUT_LINE('Employee: ' || v_emp_no || ', Effective Basic: ' || v_effective_basic);
    END LOOP;
END;
