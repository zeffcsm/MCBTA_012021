-- COPY PASTE THE INITIAL CODE FROM THE ASSESSMENT.


--(1) Create copy of main raw data into new table
CREATE TABLE XXBCM_ORDER_MGT_CLEANED
AS SELECT
    *
FROM
    XXBCM_ORDER_MGT;

--------------------------------------------------------------------------------

--(2) Clean, format and standardize the copied raw data through new table XXBCM_ORDER_MGT_CLEANED. Replace inconsistent data input.

--Impute correct data for ORDER_LINE_AMOUNT
UPDATE XXBCM_ORDER_MGT_CLEANED SET ORDER_LINE_AMOUNT = '100000' WHERE ORDER_REF = 'PO002-1' and INVOICE_REFERENCE = 'INV_PO002.1';
UPDATE XXBCM_ORDER_MGT_CLEANED SET ORDER_LINE_AMOUNT = '5000' WHERE ORDER_REF = 'PO003-3';
UPDATE XXBCM_ORDER_MGT_CLEANED SET ORDER_LINE_AMOUNT = '1200' WHERE ORDER_REF = 'PO004-2';
UPDATE XXBCM_ORDER_MGT_CLEANED SET ORDER_LINE_AMOUNT = '30250' WHERE ORDER_REF = 'PO008-1' and INVOICE_REFERENCE = 'INV_PO008.1';
UPDATE XXBCM_ORDER_MGT_CLEANED SET ORDER_LINE_AMOUNT = '21000' WHERE ORDER_REF = 'PO010-3';
UPDATE XXBCM_ORDER_MGT_CLEANED SET ORDER_LINE_AMOUNT = '3450' WHERE ORDER_REF = 'PO012-1' and INVOICE_REFERENCE = 'INV_PO012.1';

-- Impute correct data for INVOICE_AMOUNT
UPDATE XXBCM_ORDER_MGT_CLEANED SET INVOICE_AMOUNT = '2500' WHERE ORDER_REF = 'PO001-1';
UPDATE XXBCM_ORDER_MGT_CLEANED SET INVOICE_AMOUNT = '1200' WHERE ORDER_REF = 'PO004-2';
UPDATE XXBCM_ORDER_MGT_CLEANED SET INVOICE_AMOUNT = '5000' WHERE ORDER_REF = 'PO005-4';

-- Impute correct data for ORDER_DATE
UPDATE XXBCM_ORDER_MGT_CLEANED SET ORDER_DATE = '16-FEB-2017' WHERE ORDER_REF = 'PO006-1' and LENGTH(ORDER_DATE) = 10;
UPDATE XXBCM_ORDER_MGT_CLEANED SET ORDER_DATE = '03-JUN-2017' WHERE ORDER_REF = 'PO007' and LENGTH(ORDER_DATE) = 10;
UPDATE XXBCM_ORDER_MGT_CLEANED SET ORDER_DATE = '03-JUL-2017' WHERE ORDER_REF = 'PO010-3' and LENGTH(ORDER_DATE) = 10;
UPDATE XXBCM_ORDER_MGT_CLEANED SET ORDER_DATE = '06-JUL-2017' WHERE ORDER_REF = 'PO011' and LENGTH(ORDER_DATE) = 10;
UPDATE XXBCM_ORDER_MGT_CLEANED SET ORDER_DATE = '20-AUG-2017' WHERE ORDER_REF = 'PO013-1' and LENGTH(ORDER_DATE) = 10;
UPDATE XXBCM_ORDER_MGT_CLEANED SET ORDER_DATE = '15-SEP-2017' WHERE ORDER_REF = 'PO014-2' and LENGTH(ORDER_DATE) = 10;
UPDATE XXBCM_ORDER_MGT_CLEANED SET ORDER_DATE = '15-SEP-2017' WHERE ORDER_REF = 'PO014-5' and LENGTH(ORDER_DATE) = 10;

-- Impute correct data for INVOICE_DATE
UPDATE XXBCM_ORDER_MGT_CLEANED SET INVOICE_DATE = '17-JUN-2017' WHERE INVOICE_REFERENCE = 'INV_PO006.4' and LENGTH(INVOICE_DATE) = 10;
UPDATE XXBCM_ORDER_MGT_CLEANED SET INVOICE_DATE = '16-AUG-2017' WHERE INVOICE_REFERENCE = 'INV_PO006.6' and LENGTH(INVOICE_DATE) = 10;
UPDATE XXBCM_ORDER_MGT_CLEANED SET INVOICE_DATE = '18-APR-2017' WHERE INVOICE_REFERENCE = 'INV_PO006.2' and LENGTH(INVOICE_DATE) = 10;
UPDATE XXBCM_ORDER_MGT_CLEANED SET INVOICE_DATE = '30-JUL-2017' WHERE INVOICE_REFERENCE = 'INV_PO007.1' and LENGTH(INVOICE_DATE) = 10;
UPDATE XXBCM_ORDER_MGT_CLEANED SET INVOICE_DATE = '28-AUG-2017' WHERE INVOICE_REFERENCE = 'INV_PO008.2' and LENGTH(INVOICE_DATE) = 10;
UPDATE XXBCM_ORDER_MGT_CLEANED SET INVOICE_DATE = '02-SEP-2017' WHERE INVOICE_REFERENCE = 'INV_PO010.1' and LENGTH(INVOICE_DATE) = 10;
UPDATE XXBCM_ORDER_MGT_CLEANED SET INVOICE_DATE = '04-SEP-2017' WHERE INVOICE_REFERENCE = 'INV_PO012.2' and LENGTH(INVOICE_DATE) = 10;
UPDATE XXBCM_ORDER_MGT_CLEANED SET INVOICE_DATE = '28-SEP-2017' WHERE INVOICE_REFERENCE = 'INV_PO013.1' and LENGTH(INVOICE_DATE) = 10;
UPDATE XXBCM_ORDER_MGT_CLEANED SET INVOICE_DATE = '05-NOV-2017' WHERE INVOICE_REFERENCE = 'INV_PO014.4' and LENGTH(INVOICE_DATE) = 10;
UPDATE XXBCM_ORDER_MGT_CLEANED SET INVOICE_DATE = '27-OCT-2017' WHERE INVOICE_REFERENCE = 'INV_PO014.3' and LENGTH(INVOICE_DATE) = 10;

-- Impute correct data for SUPP_CONTACT_NUMBER
UPDATE XXBCM_ORDER_MGT_CLEANED SET SUPP_CONTACT_NUMBER = '5874 1002, 217 4512' WHERE SUPP_CONTACT_NUMBER = '5874 1002, 2I7 4512';
UPDATE XXBCM_ORDER_MGT_CLEANED SET SUPP_CONTACT_NUMBER = '461 5841, 57412545' WHERE SUPP_CONTACT_NUMBER = '461 5841, 5741254S';
UPDATE XXBCM_ORDER_MGT_CLEANED SET SUPP_CONTACT_NUMBER = '57841266, 6028010' WHERE SUPP_CONTACT_NUMBER = '57841266, 602801o';

--Cleaning numbers, Remove all commas
UPDATE XXBCM_ORDER_MGT_CLEANED SET ORDER_LINE_AMOUNT = REPLACE(ORDER_LINE_AMOUNT,',');
UPDATE XXBCM_ORDER_MGT_CLEANED SET INVOICE_AMOUNT = REPLACE(INVOICE_AMOUNT,',');
UPDATE XXBCM_ORDER_MGT_CLEANED SET ORDER_TOTAL_AMOUNT = REPLACE(ORDER_TOTAL_AMOUNT,',');

--FORMAT COLUMNS FOR MORE EFFICIENT MEMORY USAGE

--format columns - for ORDER_TOTAL_AMOUNT
ALTER TABLE XXBCM_ORDER_MGT_CLEANED DROP COLUMN ORDER_TOTAL_AMOUNT_1;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED
  ADD (ORDER_TOTAL_AMOUNT_1 number(10,2));
UPDATE XXBCM_ORDER_MGT_CLEANED SET ORDER_TOTAL_AMOUNT_1 = TO_NUMBER(ORDER_TOTAL_AMOUNT,'9999999');
ALTER TABLE XXBCM_ORDER_MGT_CLEANED DROP COLUMN ORDER_TOTAL_AMOUNT;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED
  RENAME COLUMN ORDER_TOTAL_AMOUNT_1 TO ORDER_TOTAL_AMOUNT;
  
--format columns - for INVOICE_AMOUNT 
ALTER TABLE XXBCM_ORDER_MGT_CLEANED DROP COLUMN INVOICE_AMOUNT_1;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED
  ADD (INVOICE_AMOUNT_1 number(10,2));
UPDATE XXBCM_ORDER_MGT_CLEANED SET INVOICE_AMOUNT_1 = TO_NUMBER(INVOICE_AMOUNT,'9999999');
ALTER TABLE XXBCM_ORDER_MGT_CLEANED DROP COLUMN INVOICE_AMOUNT;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED
  RENAME COLUMN INVOICE_AMOUNT_1 TO INVOICE_AMOUNT;  
  
--format columns - for ORDER_LINE_AMOUNT
ALTER TABLE XXBCM_ORDER_MGT_CLEANED DROP COLUMN ORDER_LINE_AMOUNT_1;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED
  ADD (ORDER_LINE_AMOUNT_1 number(10,2));
UPDATE XXBCM_ORDER_MGT_CLEANED SET ORDER_LINE_AMOUNT_1 = TO_NUMBER(ORDER_LINE_AMOUNT,'9999999');
ALTER TABLE XXBCM_ORDER_MGT_CLEANED DROP COLUMN ORDER_LINE_AMOUNT;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED
  RENAME COLUMN ORDER_LINE_AMOUNT_1 TO ORDER_LINE_AMOUNT;  
  
--format columns - for ORDER_DATE
ALTER TABLE XXBCM_ORDER_MGT_CLEANED DROP COLUMN ORDER_DATE_2;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED
  ADD (ORDER_DATE_2 DATE);
UPDATE XXBCM_ORDER_MGT_CLEANED SET ORDER_DATE_2 = TO_DATE(ORDER_DATE,'DD-MON-YYYY');
ALTER TABLE XXBCM_ORDER_MGT_CLEANED DROP COLUMN ORDER_DATE;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED
  RENAME COLUMN ORDER_DATE_2 TO ORDER_DATE;  

--format columns - for SUPPLIER_NAME VARCHAR2 (40)
ALTER TABLE XXBCM_ORDER_MGT_CLEANED DROP COLUMN SUPPLIER_NAME_2;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED
  ADD (SUPPLIER_NAME_2 VARCHAR2 (40));
UPDATE XXBCM_ORDER_MGT_CLEANED SET SUPPLIER_NAME_2 = SUPPLIER_NAME;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED DROP COLUMN SUPPLIER_NAME;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED
  RENAME COLUMN SUPPLIER_NAME_2 TO SUPPLIER_NAME;  
--format columns - for SUPP_CONTACT_NAME VARCHAR2 (40)
ALTER TABLE XXBCM_ORDER_MGT_CLEANED DROP COLUMN SUPP_CONTACT_NAME_2;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED
  ADD (SUPP_CONTACT_NAME_2 VARCHAR2 (40));
UPDATE XXBCM_ORDER_MGT_CLEANED SET SUPP_CONTACT_NAME_2 = SUPP_CONTACT_NAME;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED DROP COLUMN SUPP_CONTACT_NAME;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED
  RENAME COLUMN SUPP_CONTACT_NAME_2 TO SUPP_CONTACT_NAME;
--format columns - for SUPP_ADDRESS VARCHAR2 (65)
ALTER TABLE XXBCM_ORDER_MGT_CLEANED DROP COLUMN SUPP_ADDRESS_2;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED
  ADD (SUPP_ADDRESS_2 VARCHAR2 (65));
UPDATE XXBCM_ORDER_MGT_CLEANED SET SUPP_ADDRESS_2 = SUPP_ADDRESS;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED DROP COLUMN SUPP_ADDRESS;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED
  RENAME COLUMN SUPP_ADDRESS_2 TO SUPP_ADDRESS;
--format columns - for SUPP_CONTACT_NUMBER VARCHAR2 (30)
ALTER TABLE XXBCM_ORDER_MGT_CLEANED DROP COLUMN SUPP_CONTACT_NUMBER_2;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED
  ADD (SUPP_CONTACT_NUMBER_2 VARCHAR2 (30));
UPDATE XXBCM_ORDER_MGT_CLEANED SET SUPP_CONTACT_NUMBER_2 = SUPP_CONTACT_NUMBER;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED DROP COLUMN SUPP_CONTACT_NUMBER;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED
  RENAME COLUMN SUPP_CONTACT_NUMBER_2 TO SUPP_CONTACT_NUMBER;
--format columns - for SUPP_EMAIL VARCHAR2 (30)
ALTER TABLE XXBCM_ORDER_MGT_CLEANED DROP COLUMN SUPP_EMAIL_2;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED
  ADD (SUPP_EMAIL_2 VARCHAR2 (30));
UPDATE XXBCM_ORDER_MGT_CLEANED SET SUPP_EMAIL_2 = SUPP_EMAIL;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED DROP COLUMN SUPP_EMAIL;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED
  RENAME COLUMN SUPP_EMAIL_2 TO SUPP_EMAIL;
  
--format columns - for ORDER_DESCRIPTION VARCHAR (60)
ALTER TABLE XXBCM_ORDER_MGT_CLEANED DROP COLUMN ORDER_DESCRIPTION_2;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED
  ADD (ORDER_DESCRIPTION_2 VARCHAR2 (60));
UPDATE XXBCM_ORDER_MGT_CLEANED SET ORDER_DESCRIPTION_2 = ORDER_DESCRIPTION;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED DROP COLUMN ORDER_DESCRIPTION;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED
  RENAME COLUMN ORDER_DESCRIPTION_2 TO ORDER_DESCRIPTION;
--format columns - for ORDER_STATUS VARCHAR (10)
ALTER TABLE XXBCM_ORDER_MGT_CLEANED DROP COLUMN ORDER_STATUS_2;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED
  ADD (ORDER_STATUS_2 VARCHAR2 (10));
UPDATE XXBCM_ORDER_MGT_CLEANED SET ORDER_STATUS_2 = ORDER_STATUS;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED DROP COLUMN ORDER_STATUS;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED
  RENAME COLUMN ORDER_STATUS_2 TO ORDER_STATUS;

--format columns - for INVOICE_REFERENCE VARCHAR2 (15)
ALTER TABLE XXBCM_ORDER_MGT_CLEANED DROP COLUMN INVOICE_REFERENCE_2;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED
  ADD (INVOICE_REFERENCE_2 VARCHAR2 (15));
UPDATE XXBCM_ORDER_MGT_CLEANED SET INVOICE_REFERENCE_2 = INVOICE_REFERENCE;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED DROP COLUMN INVOICE_REFERENCE;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED
  RENAME COLUMN INVOICE_REFERENCE_2 TO INVOICE_REFERENCE;
--format columns - for INVOICE_DATE DATE
ALTER TABLE XXBCM_ORDER_MGT_CLEANED DROP COLUMN INVOICE_DATE_2;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED
  ADD (INVOICE_DATE_2 DATE);
UPDATE XXBCM_ORDER_MGT_CLEANED SET INVOICE_DATE_2 = TO_DATE(INVOICE_DATE,'DD-MON-YYYY');
ALTER TABLE XXBCM_ORDER_MGT_CLEANED DROP COLUMN INVOICE_DATE;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED
  RENAME COLUMN INVOICE_DATE_2 TO INVOICE_DATE;  
--format columns - for INVOICE_STATUS VARCHAR2 (15)
ALTER TABLE XXBCM_ORDER_MGT_CLEANED DROP COLUMN INVOICE_STATUS_2;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED
  ADD (INVOICE_STATUS_2 VARCHAR2 (15));
UPDATE XXBCM_ORDER_MGT_CLEANED SET INVOICE_STATUS_2 = INVOICE_STATUS;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED DROP COLUMN INVOICE_STATUS;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED
  RENAME COLUMN INVOICE_STATUS_2 TO INVOICE_STATUS;
--format columns - for INVOICE_HOLD_REASON VARCHAR2 (40)
ALTER TABLE XXBCM_ORDER_MGT_CLEANED DROP COLUMN INVOICE_HOLD_REASON_2;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED
  ADD (INVOICE_HOLD_REASON_2 VARCHAR2 (40));
UPDATE XXBCM_ORDER_MGT_CLEANED SET INVOICE_HOLD_REASON_2 = INVOICE_HOLD_REASON;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED DROP COLUMN INVOICE_HOLD_REASON;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED
  RENAME COLUMN INVOICE_HOLD_REASON_2 TO INVOICE_HOLD_REASON;
--format columns - for INVOICE_DESCRIPTION VARCHAR2 (40)
ALTER TABLE XXBCM_ORDER_MGT_CLEANED DROP COLUMN INVOICE_DESCRIPTION_2;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED
  ADD (INVOICE_DESCRIPTION_2 VARCHAR2 (40));
UPDATE XXBCM_ORDER_MGT_CLEANED SET INVOICE_DESCRIPTION_2 = INVOICE_DESCRIPTION;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED DROP COLUMN INVOICE_DESCRIPTION;
ALTER TABLE XXBCM_ORDER_MGT_CLEANED
  RENAME COLUMN INVOICE_DESCRIPTION_2 TO INVOICE_DESCRIPTION;


------------------------------------------------------------
--(3) Create Main tables
-- (3.1) Create and format ORDER_TABLE
CREATE TABLE ORDER_TABLE
AS SELECT
    ORDER_REF, ORDER_DATE,	SUPPLIER_NAME,	ORDER_TOTAL_AMOUNT,	ORDER_DESCRIPTION,	ORDER_STATUS
FROM
    XXBCM_ORDER_MGT_CLEANED
WHERE
    LENGTH(ORDER_REF) = 5;
--format ORDER_REF and set as PK
ALTER TABLE ORDER_TABLE DROP COLUMN ORDER_REF_2;
ALTER TABLE ORDER_TABLE
  ADD (ORDER_REF_2 VARCHAR (5));
UPDATE ORDER_TABLE SET ORDER_REF_2 = ORDER_REF;
ALTER TABLE ORDER_TABLE DROP COLUMN ORDER_REF;
ALTER TABLE ORDER_TABLE
  RENAME COLUMN ORDER_REF_2 TO ORDER_REF;  
  
ALTER TABLE ORDER_TABLE
ADD CONSTRAINT ORDER_REF_PK PRIMARY KEY (ORDER_REF);

-- (3.2) Create and format ORDER_LINES_TABLE 
CREATE TABLE ORDER_LINES_FACT 
AS SELECT
    ORDER_REF,	ORDER_DATE, SUPPLIER_NAME,	ORDER_DESCRIPTION,	ORDER_STATUS,	ORDER_LINE_AMOUNT,	INVOICE_REFERENCE,	INVOICE_DATE,	INVOICE_STATUS,	INVOICE_HOLD_REASON,	INVOICE_AMOUNT,	INVOICE_DESCRIPTION
FROM
    XXBCM_ORDER_MGT_CLEANED
WHERE
  LENGTH(ORDER_REF) = 7;

--FORMAT ORDER_LINES_REF COLUMN
--ALTER TABLE ORDER_LINES_FACT DROP COLUMN ORDER_LINE_REF;
ALTER TABLE ORDER_LINES_FACT
  ADD (ORDER_LINE_REF VARCHAR (7));
UPDATE ORDER_LINES_FACT SET ORDER_LINE_REF = ORDER_REF;
ALTER TABLE ORDER_LINES_FACT DROP COLUMN ORDER_REF;

--FORMAT ORDER_REF COLUMN
ALTER TABLE ORDER_LINES_FACT
  ADD (ORDER_REF VARCHAR (5));
UPDATE ORDER_LINES_FACT SET ORDER_REF = SUBSTR(ORDER_LINE_REF,1,5);


-- (3.3) Create and format INVOICE_TABLE 
--drop table invoice_table;
CREATE TABLE INVOICE_TABLE 
AS SELECT
    distinct(INVOICE_REFERENCE)
FROM
    XXBCM_ORDER_MGT_CLEANED
WHERE
    INVOICE_REFERENCE IS NOT NULL;


ALTER TABLE INVOICE_TABLE
ADD CONSTRAINT INVOICE_REF_PK PRIMARY KEY (INVOICE_REFERENCE);

-- (3.4) Create and format SUPPLIER_TABLE 
--DROP TABLE SUPPLIER_TABLE;
CREATE TABLE SUPPLIER_TABLE 
AS SELECT
    DISTINCT(SUPPLIER_NAME),	SUPP_CONTACT_NAME,	SUPP_ADDRESS,	SUPP_CONTACT_NUMBER, SUPP_EMAIL
FROM
    XXBCM_ORDER_MGT_CLEANED;

-- ADD PK FOR SUPPLIER_TABLE
ALTER TABLE SUPPLIER_TABLE
ADD CONSTRAINT SUPPLIER_ID_PK PRIMARY KEY (SUPPLIER_NAME);

--Format columns - SUPPLIER_CONTACT_NUMBER_1 and SUPPLIER_CONTACT_NUMBER_2
ALTER TABLE SUPPLIER_TABLE
  ADD (SUPPLIER_CONTACT_NUMBER_1 VARCHAR (9) ,
       SUPPLIER_CONTACT_NUMBER_2 VARCHAR (9));
-- remove spaces and dot       
UPDATE SUPPLIER_TABLE SET SUPP_CONTACT_NUMBER = REPLACE(SUPP_CONTACT_NUMBER,' ');
UPDATE SUPPLIER_TABLE SET SUPP_CONTACT_NUMBER = REPLACE(SUPP_CONTACT_NUMBER,'.');
-- use regex to split string into two columns
UPDATE SUPPLIER_TABLE SET SUPPLIER_CONTACT_NUMBER_1 = REGEXP_SUBSTR(SUPP_CONTACT_NUMBER, '[^,]+', 1, 1);
UPDATE SUPPLIER_TABLE SET SUPPLIER_CONTACT_NUMBER_2 = REGEXP_SUBSTR (SUPP_CONTACT_NUMBER, '[^,]+', 1, 2);
--add - character in between numbers for SUPPLIER_CONTACT_NUMBER_1
UPDATE SUPPLIER_TABLE SET SUPPLIER_CONTACT_NUMBER_1 = SUBSTR(SUPPLIER_CONTACT_NUMBER_1,1,4) || '-' || SUBSTR(SUPPLIER_CONTACT_NUMBER_1,5) WHERE LENGTH(SUPPLIER_CONTACT_NUMBER_1) = 8;
UPDATE SUPPLIER_TABLE SET SUPPLIER_CONTACT_NUMBER_1 = SUBSTR(SUPPLIER_CONTACT_NUMBER_1,1,3) || '-' || SUBSTR(SUPPLIER_CONTACT_NUMBER_1,4) WHERE LENGTH(SUPPLIER_CONTACT_NUMBER_1) = 7;
--add - character in between numbers for SUPPLIER_CONTACT_NUMBER_2
UPDATE SUPPLIER_TABLE SET SUPPLIER_CONTACT_NUMBER_2 = SUBSTR(SUPPLIER_CONTACT_NUMBER_2,1,4) || '-' || SUBSTR(SUPPLIER_CONTACT_NUMBER_2,5) WHERE LENGTH(SUPPLIER_CONTACT_NUMBER_2) = 8;
UPDATE SUPPLIER_TABLE SET SUPPLIER_CONTACT_NUMBER_2 = SUBSTR(SUPPLIER_CONTACT_NUMBER_2,1,3) || '-' || SUBSTR(SUPPLIER_CONTACT_NUMBER_2,4) WHERE LENGTH(SUPPLIER_CONTACT_NUMBER_2) = 7;


--(3.5) Add foreign keys for ORDER_LINES_FACT
ALTER TABLE ORDER_LINES_FACT
ADD CONSTRAINT SUPPLIER_FK
  FOREIGN KEY (SUPPLIER_NAME)
  REFERENCES SUPPLIER_TABLE(SUPPLIER_NAME);
  
ALTER TABLE ORDER_LINES_FACT
ADD CONSTRAINT ORDER_REF_FK
  FOREIGN KEY (ORDER_REF)
  REFERENCES ORDER_TABLE(ORDER_REF);  
  
ALTER TABLE ORDER_LINES_FACT
ADD CONSTRAINT INVOICE_FK
  FOREIGN KEY (INVOICE_REFERENCE)
  REFERENCES INVOICE_TABLE(INVOICE_REFERENCE);  
  
----------------------- ALL TABLES CREATED ------------------------


-- TASK 1
-- Report displaying a summary of Orders with their corresponding list of distinct invoices and their total amount. Order by ORDER_DATE (descending)

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
ORDER BY o.ORDER_DATE desc;
-- figure out usage of functions/stored procedures to return the value for "Action"

--SELECT ORDER_REF, INVOICE_REFERENCE, sum(INVOICE_AMOUNT) as Invoice_Amount
--FROM XXBCM_ORDER_MGT_CLEANED
--GROUP BY ORDER_REF, INVOICE_REFERENCE
--ORDER BY ORDER_DATE desc;

--TASK 2
-- Return only third highest total order amount record. Combine two sub queries and use join.
select ORDER_REFERENCE, ORDER_DATE, SUPPLIER_NAME, ORDER_TOTAL_AMOUNT, ORDER_STATUS, INVOICE_REFERENCES from
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
ON Q1.ORDER_REFERENCE = Q2.ORDER_REF;

-- Breaking the problem into sub problems. Sub Query 1
SELECT ORDER_REFERENCE, ORDER_DATE, SUPPLIER_NAME, ORDER_TOTAL_AMOUNT, ORDER_STATUS
FROM(
SELECT TO_NUMBER(SUBSTR(ORDER_TABLE.ORDER_REF,3)) as Order_Reference,
to_char(ORDER_TABLE.ORDER_DATE, 'Month dd, YYYY') as Order_Date,
ORDER_TABLE.SUPPLIER_NAME as Supplier_Name,
TO_CHAR(ORDER_TABLE.ORDER_TOTAL_AMOUNT, '99,999,999.00') as Order_Total_Amount,
ORDER_TABLE.ORDER_STATUS,
dense_rank() OVER(ORDER BY ORDER_TOTAL_AMOUNT DESC)n FROM ORDER_TABLE)
WHERE n=3;

-- Breaking the problem into sub problems. Sub Query 2
SELECT TO_NUMBER(SUBSTR(ORDER_REF,3)) as ORDER_REF, LISTAGG(INVOICE_REFERENCE, ',') WITHIN GROUP (ORDER BY INVOICE_REFERENCE) as INVOICES
FROM (
   SELECT distinct OL.INVOICE_REFERENCE ,OL.ORDER_REF
   FROM ORDER_LINES_FACT OL
)
GROUP BY ORDER_REF;


-- TASK 3 - List all suppliers with number of orders and total amount ordered from them between 01 JANUARY 2017 AND 31 AUGUST 2017
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
GROUP BY O.SUPPLIER_NAME, S.SUPP_CONTACT_NAME,S.SUPPLIER_CONTACT_NUMBER_1 , S.SUPPLIER_CONTACT_NUMBER_2;



select ORDER_TOTAL_AMOUNT, ORDER_TOTAL_AMOUNT_1 from XXBCM_ORDER_MGT_CLEANED;
select sum(ORDER_TOTAL_AMOUNT),sum(ORDER_TOTAL_AMOUNT_1) from XXBCM_ORDER_MGT_CLEANED;
-- for adding trailing decimals
select to_char('100000.50', '99999999.000') from dual;
