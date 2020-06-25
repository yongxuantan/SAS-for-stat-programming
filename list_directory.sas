* macro to loop through directory and select files by type ;
* dir: directory ;
* ext: file type ;
%macro list_directory(dir,ext);

%* clear necessary datasets first ;
%checkDrop(file_list);

  %local filrf rc did name i nameonly specfilrf specrc specdid;
  %* open directory ;
  %let rc=%sysfunc(filename(filrf,&dir));
  %let did=%sysfunc(dopen(&filrf));      

  %if &did eq 0 %then %do; 
    %put ERROR: Directory &dir cannot be open or does not exist, self destructing in 3, 2, 1.;
    %abort;
  %end;

  %* loop through all files in directory ;
  %do i = 1 %to %sysfunc(dnum(&did));   

    %let name=%qsysfunc(dread(&did,&i));   %* name of file and extension;

      %if %qupcase(%qscan(&name,-1,.)) = %upcase(&ext) %then %do; %* correct extension ;
	  	%* get upper case name of file ;
		%let nameonly = %qupcase(%qscan(&name,1,.));
		
		%* store found files in one table ;
	    data _tmp;
	      length dir $512 name $100 filename $20;
	      dir=symget("dir");
	      name=symget("name");
		  filename=symget("nameonly");
	    run;
	    proc append base=file_list data=_tmp;
	    run;quit;
      %end;

   %end;
   %let rc=%sysfunc(dclose(&did));
   %let rc=%sysfunc(filename(filrf));

%mend list_directory;