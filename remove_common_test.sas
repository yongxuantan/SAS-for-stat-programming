* macro to remove common text between two variables ;
* inds: input dataset ;
* outds: output dataset ;
* varx: variable 1 ;
* vary: variable 2 ;
%macro remove_common_test(inds, outds, varx, vary);
data &outds(drop=i numword word tempvarx tempvary);
	set &inds;
	
	* create temporary variable, might need to increase size ;
	length tempvarx tempvary $1000 word $25;
	
	* replace space with parenthesis for further processing ;
	tempvarx="("||tranwrd(strip(&varx),' ',')(')||")";
	tempvary="("||tranwrd(strip(&vary),' ',')(')||")";
	word='';

	* count number of words in variable 2 ;
	numword = countw(&vary, ' ');
	* for each word in variable 2, remove it from variable 1 if found ;
	do i = 1 to numword;
		word = "("||scan(&vary, i, ' ')||")";
		tempvarx = strip(tranwrd(tempvarx, strip(word), ''));
	end;
	* remove beginning/ending parenthesis ;
	tempvarx=tranwrd(strip(tempvarx),"(", "");
	tempvarx=tranwrd(strip(tempvarx),")", "");

	* count number of words in variable 1 ;
	numword = countw(&varx, ' ');
	* for each word in variable 1, remove it from variable 2 if found ;
	do i = 1 to numword;
		word = "("||scan(&varx, i, ' ')||")";
		tempvary = strip(tranwrd(tempvary, strip(word), ''));
	end;
	* remove beginning/ending parenthesis ;
	tempvary=tranwrd(strip(tempvary),"(", "");
	tempvary=tranwrd(strip(tempvary),")", "");

	* assign original variables to temporary variables ;
	&varx = strip(tempvarx);
	&vary = strip(tempvary);
run;
%mend remove_common_test;