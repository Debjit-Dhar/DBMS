CREATE OR REPLACE TRIGGER request_delete_trigger
AFTER DELETE ON REQUEST
FOR EACH ROW
DECLARE
    v_entry_no NUMBER;
BEGIN
    -- Get the last ENTRY_NO and increment it
    SELECT COALESCE(MAX(ENTRY_NO), 0) + 1 INTO v_entry_no FROM SERVICE_LOG;

    -- Insert a new entry in SERVICE_LOG
    INSERT INTO SERVICE_LOG (ENTRY_NO, REQ_NO, SERVICE_DT)
    VALUES (v_entry_no, :OLD.REQ_NO, SYSDATE);
END;
/
