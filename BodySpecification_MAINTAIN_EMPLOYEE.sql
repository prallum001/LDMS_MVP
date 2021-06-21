create or replace package body "MAINTAIN_EMPLOYEE" is

--#######################################################################################################################################################################################
-- PROCEDURE      : TRANSFER_EMPLOYEE
--
-- PARAMETERS     : EMPLOYEE_ID NUMBER IN
--                  NEW_DEPARTMENT_ID NUMBER IN
--
-- RETURN         : Nothing 
--
-- DESCRIPTION    : Transfer an employee from a current department to a new department by selecting the specific employee by using the primary for the employee with the employee id
--#######################################################################################################################################################################################

procedure TRANSFER_EMPLOYEE(
    P_EMPLOYEE_ID NUMBER,
    P_NEW_DEPARTMENT_ID NUMBER
)
as

lv_unit_name constant VARCHAR2(30) := 'TRANSFER_EMPLOYEE';
lv_package_component constant varchar2(30) := 'TRANSFER_EMPLOYEE';

begin

   UPDATE EMPLOYEES
      SET DEPARTMENT_ID = P_NEW_DEPARTMENT_ID
   WHERE EMPLOYEE_ID = P_EMPLOYEE_ID;

   COMMIT;

exception
   -- Place holder for error handler process.
   when others then
      ROLLBACK;
      raise;
      
end;

--#######################################################################################################################################################################################
-- PROCEDURE      : INSERT_EMPLOYEE
--
-- PARAMETERS     : EMPLOYEE_NAME VARCHAR IN
--                  JOB_TITLE NUMBER IN
--                  MANAGER_ID
--                  DATE_HIRED
--                  SALARY
--                  DEPARTMENT_ID
--
-- RETURN         : Nothing 
--
-- DESCRIPTION    : Insert a new employee to the employees table. Select a new employee id from a specific employee dedicated employee sequence.
--#######################################################################################################################################################################################

procedure INSERT_EMPLOYEE(       
       P_EMPLOYEE_NAME IN VARCHAR2
      ,P_JOB_TITLE IN VARCHAR2
      ,P_MANAGER_ID IN NUMBER
      ,P_DATE_HIRED IN DATE
      ,P_SALARY IN NUMBER
      ,p_DEPARTMENT_ID IN NUMBER
)
as

lv_unit_name constant VARCHAR2(30) := 'INSERT_EMPLOYEE';

begin

   INSERT INTO EMPLOYEES
   (EMPLOYEE_ID,
   EMPLOYEE_NAME,
   JOB_TITLE,
   MANAGER_ID,
   DATE_HIRED,
   SALARY,
   DEPARTMENT_ID)
   VALUES
   (EMPLOYEES_SEQ.NEXTVAL,
   p_employee_name,
   p_job_title,
   p_manager_id,
   p_date_hired,
   p_salary,
   p_department_id);

   COMMIT;

exception

-- Place holder for error handler process.
   when others then
   ROLLBACK;
   raise;
   
end INSERT_EMPLOYEE;

--#######################################################################################################################################################################################
-- PROCEDURE      : UPDATE_SALARY
--
-- PARAMETERS     : EMPLOYEE_ID NUMBER IN
--                  SALARY_NEW NUMBER IN
--
-- RETURN         : Nothing 
--
-- DESCRIPTION    : Alter the salary by selecting the specific employee by using the primary for the employee with the employee id. This is a private procedure and is called by other
--                  units within the package body.
--#######################################################################################################################################################################################

procedure UPDATE_SALARY(       
       P_EMPLOYEE_ID IN NUMBER
      ,P_SALARY_NEW IN NUMBER
)
as

lv_unit_name constant VARCHAR2(30) := 'UPDATE_SALARY';

begin

   UPDATE EMPLOYEES
      SET SALARY = P_SALARY_NEW
   WHERE EMPLOYEE_ID = P_EMPLOYEE_ID;

exception

-- Place holder for error handler process.
   when others then
   raise;
   
end UPDATE_SALARY;

--#######################################################################################################################################################################################
-- PROCEDURE      : ALTER_SALARY_BY_PERCENT
--
-- PARAMETERS     : EMPLOYEE_ID NUMBER IN
--                  PERCENT_CHANGE NUMBER IN
--                  ACTION_FLAG VARCHAR2
--
-- RETURN         : Nothing 
--
-- DESCRIPTION    : Alter the salary by selecting the specific employee by using the primary for the employee with the employee id. This procedure calculates changes for the salary of a specific
--                  employee. Using a pecentage passed in the product is calculated and applied to the original salary as retrieved from the GET_EMPLOYEE_SALARY function. A flag passed 
--                  in for either values of INCREASE OR DECREASE will apply the product to the current salary. The private UPDATE_SALARY procedure unit is called to update the salary
--                  with either an increase or decrease depending upon the percentage passedinto the unit.
--#######################################################################################################################################################################################

procedure ALTER_SALARY_BY_PERCENT(       P_EMPLOYEE_ID IN NUMBER
      ,P_PERCENT_CHANGE IN NUMBER
      ,p_ACTION_FLAG in varchar2
)
as

   lv_unit_name constant VARCHAR2(30) := 'ALTER_SALARY_BY_PERCENT';

   ln_salary_current EMPLOYEES.SALARY%TYPE;
   ln_percent_fraction NUMBER(5,2);
   ln_salary_product EMPLOYEES.SALARY%TYPE;
   ln_salary_new EMPLOYEES.SALARY%TYPE;
   cn_percent constant NUMBER(3):= 100;

begin

   ln_percent_fraction := (P_PERCENT_CHANGE/cn_percent);

   ln_salary_current := GET_EMPLOYEE_SALARY(p_EMPLOYEE_ID);

   ln_salary_product := ln_salary_current * ln_percent_fraction;

-- These hard coded values will be replaced with package constants
   if p_ACTION_FLAG = 'DECREASE'
   then
      ln_salary_new := TRUNC(ln_salary_current - ln_salary_product);
   elsif p_ACTION_FLAG = 'INCREASE'
   then
      ln_salary_new := TRUNC(ln_salary_current + ln_salary_product);
   end if;

   UPDATE_SALARY(P_EMPLOYEE_ID,ln_salary_new);

   COMMIT;

exception 

-- Place holder for error handler process.
   when others then
   ROLLBACK;
   raise;

end ALTER_SALARY_BY_PERCENT;

--#######################################################################################################################################################################################
-- PROCEDURE      : DECREASE_SALARY
--
-- PARAMETERS     : EMPLOYEE_ID NUMBER IN
--                  PERCENT_CHANGE NUMBER IN
--
-- RETURN         : Nothing 
--
-- DESCRIPTION    : This procedure is redundant and has been replace by unit ALTER_SALARY_BY_PERCENT.
--#######################################################################################################################################################################################
procedure DECREASE_SALARY(       P_EMPLOYEE_ID IN NUMBER
      ,P_PERCENT_CHANGE IN NUMBER
)
as

   lv_unit_name constant VARCHAR2(30) := 'DECREASE_SALARY';

   ln_salary_current EMPLOYEES.SALARY%TYPE;
   ln_percent_fraction NUMBER(5,2);
   ln_salary_product EMPLOYEES.SALARY%TYPE;
   ln_salary_new EMPLOYEES.SALARY%TYPE;
   cn_percent constant NUMBER(3):= 100;

begin

   ln_percent_fraction := (P_PERCENT_CHANGE/cn_percent);

   ln_salary_current := GET_EMPLOYEE_SALARY(p_EMPLOYEE_ID);

   ln_salary_product := ln_salary_current * ln_percent_fraction;

   ln_salary_new := TRUNC(ln_salary_current - ln_salary_product);

   UPDATE_SALARY(P_EMPLOYEE_ID,ln_salary_new);

   COMMIT;

exception 

-- Place holder for error handler process.
   when others then
   raise;

end DECREASE_SALARY;

--#######################################################################################################################################################################################
-- PROCEDURE      : INCREASE_SALARY
--
-- PARAMETERS     : EMPLOYEE_ID NUMBER IN
--                  PERCENT_CHANGE NUMBER IN
--
-- RETURN         : Nothing 
--
-- DESCRIPTION    : This procedure is redundant and has been replace by unit ALTER_SALARY_BY_PERCENT.
--#######################################################################################################################################################################################
procedure INCREASE_SALARY(       P_EMPLOYEE_ID IN NUMBER
      ,P_PERCENT_CHANGE IN NUMBER
)
as

   lv_unit_name constant VARCHAR2(30) := 'INCREASE_SALARY';

   ln_salary_current EMPLOYEES.SALARY%TYPE;
   ln_percent_fraction NUMBER(5,2);
   ln_salary_product EMPLOYEES.SALARY%TYPE;
   ln_salary_new EMPLOYEES.SALARY%TYPE;
   cn_percent constant NUMBER(3):= 100;

begin

   ln_percent_fraction := (P_PERCENT_CHANGE/cn_percent);

   ln_salary_current := GET_EMPLOYEE_SALARY(p_EMPLOYEE_ID);

   ln_salary_product := ln_salary_current * ln_percent_fraction;

   ln_salary_new := TRUNC(ln_salary_current + ln_salary_product);

   UPDATE_SALARY(P_EMPLOYEE_ID,ln_salary_new);

   COMMIT;

exception 

-- Place holder for error handler process.
   when others then
   rollback;
   raise;

end INCREASE_SALARY;

--#######################################################################################################################################################################################
-- FUNCTION       : GET_EMPLOYEE_SALARY
--
-- PARAMETERS     : EMPLOYEE_ID NUMBER IN
--
-- RETURN         : NUMBER
--
-- DESCRIPTION    : Return the current salary for a specific employee using the primary key of the table
--#######################################################################################################################################################################################

function GET_EMPLOYEE_SALARY(       P_EMPLOYEE_ID IN NUMBER
) return NUMBER

as

   lv_unit_name constant VARCHAR2(30) := 'GET_EMPLOYEE_SALARY';
   ln_salary EMPLOYEES.SALARY%TYPE;

begin

  select salary
  into ln_salary
  from EMPLOYEES
  WHERE EMPLOYEE_ID = P_EMPLOYEE_ID;

  return ln_salary;

exception

-- Place holder for error handler process.
   when others then
      raise;

end GET_EMPLOYEE_SALARY;

end "MAINTAIN_EMPLOYEE";