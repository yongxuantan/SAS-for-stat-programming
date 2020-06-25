* macro to shift x days left (negative) or right (positive) of original date in yyyy-mm-dd format ;
* invar: the source date variable ;
* outvar: the output date variable ;
* day: number of days to offset by ;
%macro offset-days(invar,outvar,day); 
	&outvar = put(intnx('day',input(&invar,yymmdd10.),&day),yymmdd10.);
%mend offset-days;
