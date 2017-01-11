CREATE OR REPLACE FUNCTION ABOVEORBELOW 
( P_INPUT IN NUMBER 
, P_SAL IN NUMBER 
) RETURN VARCHAR2 AS 
v_diff number := 0;
BEGIN
v_diff := GETSALARYDIFFBYDEPT(P_INPUT,P_SAL);

  IF v_diff >0 THEN
    RETURN 'Above department average';
  ELSIF v_diff < 0 THEN
    RETURN 'Below department average';
  ELSE  
    RETURN 'At department average';
  End If;
  
END ABOVEORBELOW;