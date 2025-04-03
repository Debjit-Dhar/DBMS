DECLARE
    v_start_date DATE;
    v_end_date DATE;
    CURSOR pending_deliveries IS
        SELECT OD.ORDER_NO, OD.ITEM_NO, OD.QTY - COALESCE(SUM(DD.QTY), 0) AS PENDING_QTY
        FROM ORDERDETAILS OD
        JOIN ORDERMAST OM ON OD.ORDER_NO = OM.ORDER_NO
        LEFT JOIN DELIVERY_DETAILS DD ON OD.ORDER_NO = DD.ORDER_NO AND OD.ITEM_NO = DD.ITEM_NO
        WHERE OM.ORDER_DT BETWEEN v_start_date AND v_end_date
        GROUP BY OD.ORDER_NO, OD.ITEM_NO, OD.QTY
        HAVING (OD.QTY - COALESCE(SUM(DD.QTY), 0)) > 0;
BEGIN
    -- Accept user input for date range
    v_start_date := TO_DATE('&Enter_Start_Date', 'YYYY-MM-DD');
    v_end_date := TO_DATE('&Enter_End_Date', 'YYYY-MM-DD');
    
    -- Process pending deliveries
    FOR rec IN pending_deliveries LOOP
        DBMS_OUTPUT.PUT_LINE('Order No: ' || rec.ORDER_NO || ', Item No: ' || rec.ITEM_NO || ', Pending Qty: ' || rec.PENDING_QTY);
    END LOOP;
END;
