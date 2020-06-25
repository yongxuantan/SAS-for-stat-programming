* macro to test if a file exist or not ;
* path: directory and filename.ext of the file we want to check ;
%macro findfile(path);
 %if %sysfunc(fileexist(&path)) %then 1;                                          
 %else 0;
%mend findfile; 