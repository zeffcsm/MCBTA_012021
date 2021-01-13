CREATE OR REPLACE PACKAGE XXBCM_ORDER_MGT_PKG IS 
  PROCEDURE USP_TASK1;
  PROCEDURE USP_TASK2;
  PROCEDURE USP_TASK3;

END XXBCM_ORDER_MGT_PKG;
/


CREATE OR REPLACE PACKAGE BODY XXBCM_ORDER_MGT_PKG AS

  PROCEDURE USP_TASK1 AS
  BEGIN
    for rec in (
    SELECT
    TO_NUMBER(SUBSTR(ol.ORDER_REF,3)) as Order_Reference,
    ol.INVOICE_REFERENCE as Invoice_Reference,
    TO_CHAR(o.ORDER_DATE,'MON-YYYY') as Order_Period,
    INITCAP(ol.SUPPLIER_NAME) as Supplier_Name,
    TO_CHAR(o.ORDER_TOTAL_AMOUNT, '99,999,999.00') as Order_Total_Amount,
    o.ORDER_STATUS as Order_Status,
    TO_CHAR(SUM(ol.INVOICE_AMOUNT),'99,999,999.00') as Invoice_Total_Amount
    FROM ORDER_TABLE o, ORDER_LINES_FACT ol
    WHERE o.ORDER_REF = ol.ORDER_REF
    GROUP BY ol.ORDER_REF, ol.INVOICE_REFERENCE,o.ORDER_DATE,ol.SUPPLIER_NAME,o.ORDER_TOTAL_AMOUNT,o.ORDER_STATUS
    ORDER BY o.ORDER_DATE desc)
    
    LOOP
        DBMS_OUTPUT.PUT_LINE ('Order_Reference: ' || rec.Order_Reference || ' | Invoice_Reference : ' || rec.Invoice_Reference || ' | Order_Period: ' || rec.Order_Period || ' | Supplier_Name: ' || rec.Supplier_Name );
        DBMS_OUTPUT.PUT_LINE ('Order_Total_Amount: ' || rec.Order_Total_Amount || ' | Order_Status: ' || rec.Order_Status ||
        ' | Invoice_Total_Amount: ' || rec.Invoice_Total_Amount);
        DBMS_OUTPUT.PUT_LINE ('-----------------------------------------------------------------------------------------------------');
    END LOOP;
  END USP_TASK1;


  PROCEDURE USP_TASK2 AS
  BEGIN
  for rec in (
    SELECT ORDER_REFERENCE, ORDER_DATE, SUPPLIER_NAME, ORDER_TOTAL_AMOUNT, ORDER_STATUS, INVOICE_REFERENCES from
    (SELECT ORDER_REFERENCE, ORDER_DATE, SUPPLIER_NAME, ORDER_TOTAL_AMOUNT, ORDER_STATUS
    FROM(
    SELECT TO_NUMBER(SUBSTR(ORDER_TABLE.ORDER_REF,3)) as Order_Reference,
    to_char(ORDER_TABLE.ORDER_DATE, 'Month dd, YYYY') as Order_Date,
    ORDER_TABLE.SUPPLIER_NAME as Supplier_Name,
    TO_CHAR(ORDER_TABLE.ORDER_TOTAL_AMOUNT, '99,999,999.00') as Order_Total_Amount,
    ORDER_TABLE.ORDER_STATUS,
    dense_rank() OVER(ORDER BY ORDER_TOTAL_AMOUNT DESC)n FROM ORDER_TABLE)
    WHERE n=3) Q1
    LEFT JOIN
    (SELECT TO_NUMBER(SUBSTR(ORDER_REF,3)) as ORDER_REF, LISTAGG(INVOICE_REFERENCE, ',') WITHIN GROUP (ORDER BY INVOICE_REFERENCE) as INVOICE_REFERENCES
    FROM (
    SELECT distinct OL.INVOICE_REFERENCE ,OL.ORDER_REF
    FROM ORDER_LINES_FACT OL
    )
    GROUP BY ORDER_REF) Q2
    ON Q1.ORDER_REFERENCE = Q2.ORDER_REF)

    LOOP
      DBMS_OUTPUT.PUT_LINE ('Order Reference: ' || rec.ORDER_REFERENCE || ' | Order Date : ' || rec.ORDER_DATE || ' | Supplier Name: ' || rec.SUPPLIER_NAME);
      DBMS_OUTPUT.PUT_LINE ('Order Total Amount: ' || rec.ORDER_TOTAL_AMOUNT || ' | Order Status: ' || rec.ORDER_STATUS ||' | Invoice References: ' || rec.INVOICE_REFERENCES);
    END LOOP;
  END USP_TASK2;


  PROCEDURE USP_TASK3 AS
  BEGIN
    for rec in (
    SELECT
    O.SUPPLIER_NAME,
    S.SUPP_CONTACT_NAME,
    S.SUPPLIER_CONTACT_NUMBER_1,
    S.SUPPLIER_CONTACT_NUMBER_2,
    COUNT(distinct(O.ORDER_REF)) as TOTAL_ORDERS,
    TO_CHAR(SUM(DISTINCT(O.ORDER_TOTAL_AMOUNT)), '99,999,999.00') as ORDER_TOTAL_AMOUNT
    FROM ORDER_TABLE O, ORDER_LINES_FACT OL, SUPPLIER_TABLE S
    WHERE O.ORDER_REF = OL.ORDER_REF AND OL.SUPPLIER_NAME = S.SUPPLIER_NAME AND S.SUPPLIER_NAME = O.SUPPLIER_NAME AND O.SUPPLIER_NAME = OL.SUPPLIER_NAME
    AND O.ORDER_DATE <= TO_DATE('31/08/2017', 'DD/MM/YYYY') AND O.ORDER_DATE >= TO_DATE('01/01/2017', 'DD/MM/YYYY')
    GROUP BY O.SUPPLIER_NAME, S.SUPP_CONTACT_NAME,S.SUPPLIER_CONTACT_NUMBER_1 , S.SUPPLIER_CONTACT_NUMBER_2)

    LOOP
      DBMS_OUTPUT.PUT_LINE ('Suppler Name: ' || rec.SUPPLIER_NAME || ' | Supplier Contact Name : ' || rec.SUPP_CONTACT_NAME || ' | Supplier Contact No.1: ' || rec.SUPPLIER_CONTACT_NUMBER_1 || ' | Supplier Contact No.2: ' || rec.SUPPLIER_CONTACT_NUMBER_2);
      DBMS_OUTPUT.PUT_LINE ('Total orders: ' || rec.TOTAL_ORDERS || ' | Order Total Amount: ' || rec.ORDER_TOTAL_AMOUNT);
      DBMS_OUTPUT.PUT_LINE ('-----------------------------------------------------------------------------------------------------');

    END LOOP;
  END USP_TASK3;

END XXBCM_ORDER_MGT_PKG;
/
