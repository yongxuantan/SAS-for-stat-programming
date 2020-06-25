* macro to bring in dataset given path;
* if xpt is available then use xpt, otherwise check if sas7bdat;
* ds: name of data file in directory;
* path: path to dataset directory;
* out: specify different dataset name (optional);
%macro loadData(ds,path,out=);

%if %sysfunc(fileexist(&path.\&ds..xpt)) %then %do; 
	libname temp xport "&path\&ds..xpt";
	proc copy inlib=temp outlib=work;
	run;
%end;
%else %if %sysfunc(fileexist(&path.\&ds..sas7bdat)) %then %do; 
	libname temp "&path" inencoding=any;
	data &ds;
		set temp.&ds;
	run;
%end;
%else %put WARNING: &ds. not found in &path. directory;

	%if &out= %then %do;
		data &ds;
	%end;
	%else %do;
		data &out;
	%end;
		    set &ds;
		run;
%mend loadData;
