CREATE OR REPLACE TRIGGER result_trigger
AFTER INSERT OR UPDATE ON RESULT
FOR EACH ROW
BEGIN
    -- If marks are 50 or more, remove from BACKPAPER if it exists
    IF :NEW.MARKS >= 50 THEN
        DELETE FROM BACKPAPER 
        WHERE ROLL = :NEW.ROLL 
        AND SCODE = :NEW.SCODE;
    ELSE
        -- If marks are less than 50, ensure entry exists in BACKPAPER
        INSERT INTO BACKPAPER (ROLL, SCODE)
        SELECT :NEW.ROLL, :NEW.SCODE 
        FROM DUAL
        WHERE NOT EXISTS (
            SELECT 1 FROM BACKPAPER 
            WHERE ROLL = :NEW.ROLL 
            AND SCODE = :NEW.SCODE
        );
    END IF;
END;
/
