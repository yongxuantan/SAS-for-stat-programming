* macro to drop working dataset if it exist ;
* tmpData: name of working dataset ;
%macro checkDrop(tmpData);
%if %SYSFUNC(exist(&tmpData)) %then %do;
    proc sql;
    drop table &tmpData;
    quit;
%end; 
%mend;
