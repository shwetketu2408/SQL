-------------IN CASE STATEMENT WE DON'T USE COMMA(,)
USE DATABASE DEMO_DATABASE;
CREATE or replace table SK_CONSUMER_COMPLAINTS

(    DATE_RECEIVED STRING,
     PRODUCT_NAME VARCHAR2(50),
     SUB_PRODUCT VARCHAR2(100),
     ISSUE VARCHAR2(100),
     SUB_ISSUE VARCHAR2(100),
     CONSUMER_COMPLAINT_NARRATIVE string,
     Company_Public_Response STRING,
     Company VARCHAR(100),
     State_Name CHAR(4),
     Zip_Code string,
     Tags VARCHAR(40),
     Consumer_Consent_Provided CHAR(25),
     Submitted_via STRING,
     Date_Sent_to_Company STRING,
     Company_Response_to_Consumer VARCHAR(40),
     Timely_Response CHAR(4),
     CONSUMER_DISPUTED CHAR(4),
     COMPLAINT_ID NUMBER(12,0) NOT NULL PRIMARY KEY
);
DESCRIBE TABLE SK_CONSUMER_COMPLAINTS;
SELECT * FROM SK_CONSUMER_COMPLAINTS;
SELECT DISTINCT SUBMITTED_VIA FROM SK_CONSUMER_COMPLAINTS; 
-------------------------------------------------------------------------------------------------------
SELECT * , --SELECT * IS USED HERE TO SELECT ALL THE rows and display it
       CASE WHEN SUBMITTED_VIA IN ('Phone','Web') THEN 'INBOUND' --THEN FILTRING ROWS(BY USING SUBMITTED_VIA) BASED ON THE CONDITION
            WHEN SUBMITTED_VIA IN ('Referral','Postal mail','Email') THEN 'OUTBOUND'
            ELSE 'Electronics'--OR WE CAN ALSO WRITE AS ELSE SUBMITTED_VIA = 'Fax' THEN 'Electronics'(but in this lots of computational power is involved and not optimised version of coding){we need this sratement when NULL value is present}
       END AS Submission_Type
FROM SK_CONSUMER_COMPLAINTS; 

---When you want to display your filtered column whereever you want to show
SELECT DATE_RECEIVED,PRODUCT_NAME,SUB_PRODUCT,ISSUE,SUBMITTED_VIA,--COMMA IS GIVEN TO DISPLAY THAT COLUMN
       CASE WHEN SUBMITTED_VIA IN ('Phone','Web') THEN 'INBOUND' 
            WHEN SUBMITTED_VIA IN ('Referral','Postal mail','Email') THEN 'OUTBOUND'
            ELSE 'Electronics'
       END AS Submission_Type,
       COMPANY,STATE_NAME,ZIP_CODE--THESE COLUMNS ARE WRITTEN HERE TO REPRESENT THESE COLUMNS AFTER SUBMISSION TYPE
FROM SK_CONSUMER_COMPLAINTS; 
------------------------------------------------------------------------------------------------------------------------
SELECT *  ,
           CASE WHEN PRODUCT_NAME IN ('Consumer Loan','Student loan','Payday loan') then 'Loan'
                WHEN PRODUCT_NAME IN ('Bank account or service','Mortgage','Debt collection','Credit card','Credit reporting','Money transfers') then 'SERVICE'
                ELSE 'OTHER'
                END AS FINANCE_TYPE
                FROM SK_CONSUMER_COMPLAINTS; 
---OR
SELECT *  ,
           CASE WHEN PRODUCT_NAME IN ('Consumer Loan','Student loan','Payday loan') then 'Loan'
                WHEN PRODUCT_NAME IN ('Bank account or service','Mortgage','Debt collection','Credit card','Credit reporting','Money transfers') then 'SERVICE'
                ELSE 'OTHER'
                END AS FINANCE_TYPE
                FROM SK_CONSUMER_COMPLAINTS;
---OR
SELECT *  ,
           CASE 
                WHEN PRODUCT_NAME LIKE '%Loan%' or PRODUCT_NAME like '%loan%' then 'Loan Type'
                WHEN PRODUCT_NAME IN ('Bank account or service','Mortgage','Debt collection','Credit card','Credit reporting','Money transfers') then 'SERVICE'
                ELSE 'OTHER'
                END AS FINANCE_TYPE
                FROM SK_CONSUMER_COMPLAINTS;
---OR
SELECT *  ,
           CASE 
                WHEN UPPER(PRODUCT_NAME) LIKE '%LOAN%' then 'Loan Type' --UPPER COVERTS ALL PRODUCT_NAME INTO CAPITAL LETTER
                WHEN UPPER(PRODUCT_NAME) IN ('BANK ACCOUNT or SERVICE','MORTAGE','DEBT COLLECTION','CREDIT CARD','CREDIT REPORTING','MONEY TRANSFERS') then 'SERVICE'---WHEN UPPER CASE COMMAND IS USED THEN ALL INSIDE THE BRACKET SHOULD BE IN CAPITAL LETTER
                ELSE 'OTHER'
                END AS FINANCE_TYPE
                FROM SK_CONSUMER_COMPLAINTS;
---OR(UPPER AND LOWER IS USED FOR CLEANING WHERE NAME IS WRITTEN LIKE ShwEt )
SELECT *  ,
           CASE 
                WHEN LOWER(PRODUCT_NAME) LIKE '%LOAN%' then 'Loan Type' --UPPER COVERTS ALL PRODUCT_NAME INTO CAPITAL LETTER
                WHEN LOWER(PRODUCT_NAME) IN ('Bank account or service','Mortgage','Debt collection','Credit card','Credit reporting','Money transfers') then 'SERVICE'
                ELSE 'OTHER'
                END AS FINANCE_TYPE
                FROM SK_CONSUMER_COMPLAINTS;
---OR
SELECT DATE_RECEIVED,PRODUCT_NAME,
           CASE 
                WHEN UPPER(PRODUCT_NAME) LIKE '%LOAN%' then 'Loan Type' --UPPER COVERTS ALL PRODUCT_NAME INTO CAPITAL LETTER
                WHEN UPPER(PRODUCT_NAME) IN ('BANK ACCOUNT OR SERVICE','Mortgage','Debt collection','Credit card','Credit reporting','Money transfers') then 'SERVICE'
                ELSE 'OTHER'
                END AS FINANCE_TYPE,
                ISSUE,CONSUMER_COMPLAINT_NARRATIVE
                FROM SK_CONSUMER_COMPLAINTS;
                
----------------------------------------------------------------------------------------------------------------------
SELECT DISTINCT * FROM SK_CONSUMER_COMPLAINTS;
SELECT DISTINCT SUB_PRODUCT FROM SK_CONSUMER_COMPLAINTS;
SELECT *,
         CASE WHEN SUB_PRODUCT LIKE '%loan%' then 'LOAN' 
              WHEN SUB_PRODUCT ='I do not know'OR SUB_PRODUCT IS NULL THEN 'NA'-----FOR WRITTING ANYTHING IN PLACE OF NULL WE HAVE TO USE 'IS NULL(COMMAND)' WAY WE CAN'T USE IN
              WHEN SUB_PRODUCT LIKE '%card%' then 'CARD'
              WHEN SUB_PRODUCT LIKE '%mortgage%' then 'MORTAGE'
              ELSE SUB_PRODUCT----HERE IT WILL GIVE EARLIER VALUE WHICH WAS ASSIGNED TO (SUB_PRODUCT) 
              END AS SUB_PRODUCT_TYPE
              FROM SK_CONSUMER_COMPLAINTS;
---OR
SELECT *,
         CASE WHEN LOWER (SUB_PRODUCT) LIKE '%loan%' then 'LOAN' 
              WHEN SUB_PRODUCT ='I do not know'OR SUB_PRODUCT IS NULL THEN 'NA'-----FOR WRITTING ANYTHING IN PLACE OF NULL WE HAVE TO USE THIS WAY WE CAN'T USE IN
              WHEN LOWER (SUB_PRODUCT) LIKE '%card%' then 'CARD'
              WHEN LOWER (SUB_PRODUCT) LIKE '%mortgage%' then 'MORTAGE'
              ELSE SUB_PRODUCT
              END AS SUB_PRODUCT_TYPE
              FROM SK_CONSUMER_COMPLAINTS;
----------------------------------------------------------------------------------------------------------------------------------
SELECT DISTINCT COMPANY_RESPONSE_TO_CONSUMER FROM SK_CONSUMER_COMPLAINTS;
SELECT *,
         CASE WHEN COMPANY_RESPONSE_TO_CONSUMER IN ('Closed with explanation') THEN 'EXPLAINED'
              WHEN UPPER(COMPANY_RESPONSE_TO_CONSUMER) IN ('Closed','Closed with non-monetary relief') then 'Closed'
              WHEN COMPANY_RESPONSE_TO_CONSUMER IN ('Closed with monetary relief') THEN 'MONETARY RELIEF PROVIDED'
              ELSE 'AS IT IS'
              END AS NEW_COMPANY_RESPONSE_TO_CONSUMER
              FROM SK_CONSUMER_COMPLAINTS;
              
------------------------------------------------------------------------------------------------------------------------------------
create or replace view SK_COMPANY_RESPONSE_TO_CONSUMER AS
SELECT DATE_RECEIVED,PRODUCT_NAME,SUB_PRODUCT,ISSUE,COMPANY,STATE_NAME,ZIP_CODE,SUBMITTED_VIA,
       
       CASE WHEN SUBMITTED_VIA IN ('Phone','Web') THEN 'INBOUND' 
            WHEN SUBMITTED_VIA IN ('Referral','Postal mail','Email') THEN 'OUTBOUND'
            ELSE 'Electronics'
       END AS Submission_Type,
      
       CASE WHEN PRODUCT_NAME IN ('Consumer Loan','Student loan','Payday loan') then 'Loan'
                WHEN PRODUCT_NAME IN ('Bank account or service','Mortgage','Debt collection','Credit card','Credit reporting','Money transfers') then 'SERVICE'
                ELSE 'OTHER'
                END AS FINANCE_TYPE,
                
      
       CASE WHEN LOWER (SUB_PRODUCT) LIKE '%loan%' then 'LOAN' 
              WHEN SUB_PRODUCT ='I do not know'OR SUB_PRODUCT IS NULL THEN 'NA'-----FOR WRITTING ANYTHING IN PLACE OF NULL WE HAVE TO USE THIS WAY WE CAN'T USE IN
              WHEN LOWER (SUB_PRODUCT) LIKE '%card%' then 'CARD'
              WHEN LOWER (SUB_PRODUCT) LIKE '%mortgage%' then 'MORTAGE'
              ELSE SUB_PRODUCT
              END AS SUB_PRODUCT_TYPE,
            
       CASE WHEN COMPANY_RESPONSE_TO_CONSUMER IN ('Closed with explanation') THEN 'EXPLAINED'
              WHEN UPPER(COMPANY_RESPONSE_TO_CONSUMER) IN ('Closed','Closed with non-monetary relief') then 'Closed'
              WHEN COMPANY_RESPONSE_TO_CONSUMER IN ('Closed with monetary relief') THEN 'MONETARY RELIEF PROVIDED'
              ELSE 'AS IT IS'
              END AS NEW_COMPANY_RESPONSE_TO_CONSUMER
FROM SK_CONSUMER_COMPLAINTS;
SELECT * FROM SK_COMPANY_RESPONSE_TO_CONSUMER;
-------------------------------------------------------------------------------------------------------------------------------
