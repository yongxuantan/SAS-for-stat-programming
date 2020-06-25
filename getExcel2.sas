* macro to import xlsx, method 2 ;
* path: directory and filename.ext of specification file ;
* ds: sheetname in the excel file ;
%macro getExcel2(path,ds);
proc import out=&ds. datafile = "&path"
	dbms=excel REPLACE;
	sheet="&ds";
	getnames=yes;
	mixed=yes;
run;
%mend getExcel2;