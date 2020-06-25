* macro to delete working datasets ;
* dslist: the list of datasets to be deleted, separated by a space, " " ;
%macro removeWorkDS(dslist);
%if %length(&dslist)>0 %then %do;
	proc datasets lib=work memtype=data nolist;
		delete &dslist;
	quit;
%end;
%mend removeWorkDS;