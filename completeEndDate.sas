* macro to populate missing portion of an ending date ;
* for missing month and day, set to Dec 31st, for missing day, set to last day of the month ;
* invar: the source date variable ;
* outvar: the output date variable ;
%macro completeEndDate(invar,outvar);
	if length(strip(&invar))>10 then &outvar.=substr(strip(&invar),1,10);
	else if length(strip(&invar))=4 then &outvar.=substr(strip(&invar),1,4) || "-12-31";
	else if length(strip(&invar))=7 then &outvar.=put(intnx('month',
		mdy(input(substr(strip(&invar),6,2),best8.),01,input(substr(strip(&invar),1,4),best8.))
		,0,'E'),yymmdd10.);
	else &outvar.=strip(&invar);
%mend completeEndDate;