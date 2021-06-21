CREATE TABLE  "EMPLOYEES" 
   (	"EMPLOYEE_ID" NUMBER(10,0) NOT NULL ENABLE, 
	"EMPLOYEE_NAME" VARCHAR2(50) NOT NULL ENABLE, 
	"JOB_TITLE" VARCHAR2(50) NOT NULL ENABLE, 
	"MANAGER_ID" NUMBER(10,0), 
	"DATE_HIRED" DATE NOT NULL ENABLE, 
	"SALARY" NUMBER(10,0), 
	"DEPARTMENT_ID" NUMBER(5,0), 
	 CONSTRAINT "EMPLOYEE_PK" PRIMARY KEY ("EMPLOYEE_ID")
  USING INDEX  ENABLE
   )
/
ALTER TABLE  "EMPLOYEES" ADD CONSTRAINT "EMPLOYEE_CON" FOREIGN KEY ("DEPARTMENT_ID")
	  REFERENCES  "DEPARTMENTS" ("DEPARTMENT_ID") ENABLE
/