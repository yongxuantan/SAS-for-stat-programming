* macro to determine if a variable exist in dataset or not ;
* ds: dataset to check ;
* var: variable to check ;
%macro varCheck(ds, var);
    %local rc dsid result;
    %let dsid = %sysfunc(open(&ds));
 
    %if %sysfunc(varnum(&dsid, &var)) > 0 %then %do;
        %let result = 1;
        %put NOTE: Var &var exists in &ds;
    %end;
    %else %do;
        %let result = 0;
        %put NOTE: Var &var not exists in &ds;
    %end;
 
    %let rc = %sysfunc(close(&dsid));
    %if &result=1 %then 1;
	%else 0; 
%mend varCheck;
