CREATE OR REPLACE FUNCTION sf_tax_calc(p_employee_id employees.employee_id%TYPE)
RETURN NUMBER
IS --AS
    v_salary            employees.salary%TYPE ;
    v_tax_percentage    NUMBER(2);
    v_tax_amount        NUMBER(8,2);
BEGIN
    --fetching salary of the given employee
    SELECT salary INTO v_salary FROM employees
    WHERE employee_id = p_employee_id;
    
    --logic for tax percentage computation
    IF v_salary        >=15000 THEN
        v_tax_percentage := 15;
    ELSIF v_salary      < 15000 AND v_salary >= 8000 THEN
        v_tax_percentage := 10;
    ELSE
        v_tax_percentage := 0;
    END IF;
    
    --formula for tax calculation
    v_tax_amount:=v_salary*v_tax_percentage*0.01;
    RETURN v_tax_amount;
    
EXCEPTION
    WHEN OTHERS THEN
        RETURN -1;
END;
/