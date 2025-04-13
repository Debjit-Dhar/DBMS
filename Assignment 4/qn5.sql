-- your code goes here
DECLARE
    v_member_exists NUMBER := 0;
    v_copy_status VARCHAR2(10);
    v_max_books INT;
    v_current_issues INT;
    v_trans_id CHAR(10) := 'T1002'; -- You may generate this dynamically
    v_member_id CHAR(5) := 'M001';
    v_book_id CHAR(5) := 'B002';
    v_serial_no INT := 1;

BEGIN
    -- Check if MEMBER exists
    SELECT COUNT(*) INTO v_member_exists
    FROM MEMBER
    WHERE MEMBER_ID = v_member_id;

    IF v_member_exists = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Member does not exist.');
    END IF;

    -- Check if the book copy is available
    SELECT STATUS INTO v_copy_status
    FROM BOOK_COPY
    WHERE BOOK_ID = v_book_id AND SERIAL_NO = v_serial_no;

    IF v_copy_status != 'Available' THEN
        RAISE_APPLICATION_ERROR(-20002, 'Book copy is not available.');
    END IF;

    -- Get MAX_BOOKS from STUDENT or FACULTY
    BEGIN
        SELECT MAX_BOOKS INTO v_max_books
        FROM STUDENT
        WHERE MEMBER_ID = v_member_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            SELECT MAX_BOOKS INTO v_max_books
            FROM FACULTY
            WHERE MEMBER_ID = v_member_id;
    END;

    -- Count current issued books (DT_RETURN IS NULL)
    SELECT COUNT(*) INTO v_current_issues
    FROM TRANSACTION
    WHERE MEMBER_ID = v_member_id AND DT_RETURN IS NULL;

    IF v_current_issues >= v_max_books THEN
        RAISE_APPLICATION_ERROR(-20003, 'Issue limit reached.');
    END IF;

    -- Insert into TRANSACTION
    INSERT INTO TRANSACTION (
        TRANS_ID, MEMBER_ID, BOOK_ID, SERIAL_NO,
        DT_ISSUE, TO_BE_RETURNED_BY
    ) VALUES (
        v_trans_id, v_member_id, v_book_id, v_serial_no,
        CURRENT_DATE, CURRENT_DATE + INTERVAL '7' DAY
    );

    -- Update BOOK_COPY status
    UPDATE BOOK_COPY
    SET STATUS = 'Issued'
    WHERE BOOK_ID = v_book_id AND SERIAL_NO = v_serial_no;

    DBMS_OUTPUT.PUT_LINE('Book issued successfully.');

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
DECLARE
    v_trans_id CHAR(10);
    v_member_id CHAR(5) := 'M001';
    v_book_id CHAR(5) := 'B002';
    v_serial_no INT := 1;

BEGIN
    -- Find the active transaction
    SELECT TRANS_ID INTO v_trans_id
    FROM TRANSACTION
    WHERE MEMBER_ID = v_member_id
      AND BOOK_ID = v_book_id
      AND SERIAL_NO = v_serial_no
      AND DT_RETURN IS NULL;

    -- Update return date
    UPDATE TRANSACTION
    SET DT_RETURN = CURRENT_DATE
    WHERE TRANS_ID = v_trans_id;

    -- Update BOOK_COPY to Available
    UPDATE BOOK_COPY
    SET STATUS = 'Available'
    WHERE BOOK_ID = v_book_id AND SERIAL_NO = v_serial_no;

    DBMS_OUTPUT.PUT_LINE('Book returned successfully.');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: This book was not issued to the member or already returned.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected Error: ' || SQLERRM);
END;
/
