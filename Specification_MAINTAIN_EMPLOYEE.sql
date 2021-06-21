create or replace package MAINTAIN_EMPLOYEE as

procedure INSERT_EMPLOYEE (
   p_EMPLOYEE_NAME in varchar2,
   p_JOB_TITLE in varchar2,
   p_MANAGER_ID in number   default null,
   p_DATE_HIRED in date,
   p_SALARY in number,
   p_DEPARTMENT_ID in number);

procedure ALTER_SALARY_BY_PERCENT (
   p_EMPLOYEE_ID in number,
   p_PERCENT_CHANGE in number,
   p_ACTION_FLAG in varchar2);

procedure INCREASE_SALARY (
   p_EMPLOYEE_ID in number,
   p_PERCENT_CHANGE in number);

procedure DECREASE_SALARY (
   p_EMPLOYEE_ID in number,
   p_PERCENT_CHANGE in number);

procedure TRANSFER_EMPLOYEE (
   p_EMPLOYEE_ID in number,
   p_NEW_DEPARTMENT_ID in number);

function GET_EMPLOYEE_SALARY (
    p_EMPLOYEE_ID in number )
    return number;

end;