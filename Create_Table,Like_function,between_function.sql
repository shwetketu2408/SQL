CREATE DATABASE DEMO_DATABASE;
DROP TABLE Agents;
create or replace database DEMO_DATABASE;
create or replace Table Agents
( Agent_code varchar(15),
 Agent_Name char(35),
 designation varchar(100),
 Commission_Number number(10,2) DEFAULT 0.05,
 Phone_No Varchar(15),
 Country varchar(50)
); 
 
 Describe Table Agents;
 
 insert into Agents
 values(123, 'Shwet','Analytics','458.96','4567876543','India');
 
 insert into Agents
 values(544, 'Mahi','Analytics','345.98','5487980012','India');
 
 insert into Agents(Agent_Name,Phone_No,Country)
 values('Vivek','5487980012','India');
 
 insert into Agents(Agent_Code,designation)
 values('123','Developer');
 
 select * From Agents;
select * from agents
where agent_name = 'Mahi';
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

USE DATABASE DEMO_DATABASE;
CREATE or replace table SK_COUNTRY
(COUNTRYid VARCHAR(50),
 COUNTRYNAME STRING(50),
 COUNTRYNAME_LOCAL STRING(50),
 CountryFlagURL VARCHAR(200));
 
DESCRIBE TABLE SK_COUNTRY;
SELECT * FROM SK_COUNTRY;

--LIMIT function(HELPS TO GET NUMBER OF ROWS WHICH WE WANT )
SELECT * FROM SK_COUNTRY limit 2;--TOP WORKS IN MYSQL

--Distinct function(For avoiding the duplicate rows{IT MEANS WHOLE ROW EVERY COLUMN DATA SHOULD BE DUPLICATE WITH ANOTHER ROW 
-- COMPLETE DATA THEN DISTINCT WILL REMOVE IT.IT DOESN'T REMOVE THE ROW IF ANY ONE COLUMN DATA OF A ROW IS DUPLICATE WITH ANOTHER
-- ROW DATA })
select distinct * from sk_country;
select distinct * from SK_CONSUMER_COMPLAINTS;
--SYNTAX:SELECT DISTINCT COL_NAME FROM TABLE_NAME {for avoiding duplicate column(Helps to get unique columns)}
select distinct product_name from SK_CONSUMER_COMPLAINTS;
select distinct sub_product from SK_CONSUMER_COMPLAINTS;

--------------LIKE function-->HIGHLY USED IN SQL-------------
-- % represents zero,one,or multiple characters
-- _ underscore represnts one,singe chracter
/*

a% - any values that starts with a
%a - any values that ends with a
%word% - any values that has word in any position

_a% - any values that has a in the second position
a_% - any values that starts with "a" and are atleast 2 chracters in length
a__% - any values that starts with "a" and are atleast 3 chracters in length
a%r - any values that starts with a and ends with r

ab%cd%de%f - any values that starts with ab followed by any characters and then cd and then followed by any characters 
and then de followed by any charcaters and ending with f
*/

SELECT DISTINCT*FROM SK_CONSUMER_COMPLAINTS WHERE PRODUCT_NAME LIKE 'Bank%';--where work as filter and % at the end means Bank followed by any sequence of character doesn't matter to me
--when client says that when customer says that give me account written anywhere in the word
SELECT DISTINCT*FROM SK_CONSUMER_COMPLAINTS WHERE PRODUCT_NAME LIKE '%account%';--write the word which we are fetching in the same form as written in the table
SELECT DISTINCT*FROM SK_CONSUMER_COMPLAINTS WHERE PRODUCT_NAME LIKE 'account%';--at the end account is not at the end
SELECT DISTINCT*FROM SK_CONSUMER_COMPLAINTS WHERE PRODUCT_NAME LIKE '%loan';--at the end i need loan keyword to be there
SELECT DISTINCT PRODUCT_NAME FROM SK_CONSUMER_COMPLAINTS ;
---LIKE FOR SINGLE CHARACTER
SELECT DISTINCT*FROM SK_CONSUMER_COMPLAINTS WHERE PRODUCT_NAME LIKE '_o%';

-----------------------------------------------------
create or replace table like_ex(subject varchar(20));
insert into like_ex values
 ('John dddoe'),
 ('Joe Doe'),
 ('John_down'),
 ('Joe down'),
 ('Elaine'),
 (''), --empty string
 (null);
select * from like_ex;
select subject from like_ex where subject like '%Jo%oe%' ;
select distinct COMPANY from SK_CONSUMER_COMPLAINTS;
 
 --_a% - any values that has a in the second position
 SELECT distinct company FROM SK_CONSUMER_COMPLAINTS WHERE COMPANY LIKE '_a%'; /*here between '' after LIKE it is case sensitive*/

--a_% - any values that starts with "a" and are atleast 2 chracters in length
 SELECT * FROM SK_CONSUMER_COMPLAINTS WHERE SUBMITTED_VIA LIKE 'F_%';--WHEN * IS INSERTED BETWEEN SELECT AND FROM THEN IT WILL SEARCH WITHIN WHOLE ROW
 SELECT DISTINCT SUBMITTED_VIA FROM SK_CONSUMER_COMPLAINTS WHERE SUBMITTED_VIA LIKE 'F_%';--BUT IN THIS CASE IT WILL SEARCH DISTINCTIVELY WITHIN SUBMITTED_VIA 

--a__% - any values that starts with "a" and are atleast 3 chracters in length
 SELECT * FROM SK_CONSUMER_COMPLAINTS WHERE CONSUMER_COMPLAINT_NARRATIVE LIKE 'a__%';
 
--a%r - any values that starts with a and ends with r
select * from SK_CONSUMER_COMPLAINTS WHERE ISSUE LIKE 'M%e';
select * from SK_CONSUMER_COMPLAINTS WHERE product_name LIKE 'C%n';

-------------------------IN KEYWORD{(IT MEANS EITHER)IT IS USED WHEN CLIENT HAS GIVEN CERTAIN CATEGORY SUCH AS TO CHOOSE FROM ANY OF THE 4 COUNTRIES}----------------------------------------------------
SELECT DISTINCT * FROM SK_CONSUMER_COMPLAINTS;
SELECT DISTINCT * FROM SK_CONSUMER_COMPLAINTS WHERE PRODUCT_NAME IN ('Consumer Loan','Mortgage','Debt collection');--OR ANOTHER WAY TO WRITE IT
SELECT DISTINCT * FROM SK_CONSUMER_COMPLAINTS WHERE PRODUCT_NAME = 'Consumer Loan' OR PRODUCT_NAME ='Mortgage' OR 
PRODUCT_NAME ='Debt collection';---BUT DON'T USE THIS WAY IT IS NOT CONVINIENT 
SELECT DISTINCT * FROM SK_CONSUMER_COMPLAINTS WHERE COMPANY IN('Wells Fargo & Company','Bank of America','JPMorgan Chase & Co.');
---IN-->USED AS EITHER
---AND-->USED AS ONLY TRUE OR FALSE
---OR-->USED AS TRUE OR FALSE
--eg of IN
--PAY_IN_METHOD IN ('BANK ACCOUNT','MOBILE','CREDIT CARD/DEBIT CARD');
--EG OF OR,AND
--WHEN R12_WEBSITE_TXNS > 0 AND R12_APP_TXNS > 0 THEN 'Website+App'
--WHEN R12_WEBSITE_TXNS > 0 AND R12_APP_TXNS = 0 THEN 'Website_only'
--WHEN R12_WEBSITE_TXNS = 0 AND R12_APP_TXNS > 0 THEN 'App only'
SELECT DISTINCT * FROM SK_CONSUMER_COMPLAINTS;
SELECT DISTINCT * FROM SK_CONSUMER_COMPLAINTS WHERE DATE_RECEIVED BETWEEN '29-07-2013' AND '31-07-2013';--BETWEEN ALSO INCLUDE THE INITIAL AS WELL AS FINAL
--MEANS RESULT WILL INCLUDE 29,30 AND 31-07-2013
--BETWEEN USED IN CONTINUOUS DATA WHEREVER RANGE IS GIVEN
SELECT DISTINCT * FROM SK_CONSUMER_COMPLAINTS WHERE DATE_RECEIVED BETWEEN '29-07-2013' AND '31-07-2013';