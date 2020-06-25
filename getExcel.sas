* macro to import XLSX file content assuming excel file exists ;
* path: directory and filename.ext of excel file ;
* sheet: sheetname of interest ;
* out: name of working output dataset ;
%macro getExcel(path,sheet,out);
* create temporary library;
libname tmpExcel xlsx "&path";

* this check function always return true at the moment, if quotes are remove 
* then sheetname must not have spaces ;
%if %sysfunc(exist(tmpExcel."&sheet."n)) %then %do;    
    data &out;
		set tmpExcel."&sheet."n;
	run;
%end;
%else %do;
	%PUT WARNING: &sheet. is not in &path.;
	data &out;
	run;
%end; 

%mend getExcel;
