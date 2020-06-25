* macro to check if directory is valid or not;
* path: path to directory;
%macro checkDir(path);

%local filrf rc;
%* open directory ;
%let rc=%sysfunc(filename(filrf,&path));
%let did=%sysfunc(dopen(&filrf)); 

%* check to make sure directory can be opened ;
%if &did eq 0 %then %do; 
	%put WARNING: directory &path cannot be open or does not exist.;
	%let result = 0;
%end;

%if &result=0 %then 0;
%else 1;

%mend checkDir;