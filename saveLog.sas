* macro to save program log and list results to files ;
* dir: directory of sas program ;
* name: name of sas program without file extension ;
%macro saveLog(dir, name);
* clean working library ;
proc datasets library = work kill nolist;
run;

* setup log and list output, override any existing files ;
PROC PRINTTO LOG = "&dir.\&name..log" NEW;
RUN;
PROC PRINTTO PRINT = "&dir.\&name..lst" NEW;
RUN;

* load program and run;
%include "&dir.\&name..sas";
 
%mend saveLog;
