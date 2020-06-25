* macro to determine each variable type in a dataset;
* ds: name of working dataset;
* out: name of output working dataset with variables and datatypes;
%macro getVarType(ds,out);

* get dataset variable attributes ;
proc contents data=&ds.  out=c&ds. noprint;

%let numvar=DUMMY;  				*initialize macro variable in case no numeric variables in this dataset ;
************* find the number of variables in dataset;
proc sql noprint;
  select count(unique VARIABLE) into : vnum
  from c&ds.;
*********************** Create macro variable with all variable names;
  select VARIABLE into :allvar separated by ' '
  from c&ds.;
*********************** Create macro variable for numeric variables;
  select VARIABLE into :numvar separated by ' '
  from c&ds. where type=1;

%put NOTE: There are >>&vnum.<< variables in >>&ds.<<;
%put NOTE: Variables are >>&allvar.<<;
%put NOTE: Numeric Variables are >>&numvar.<<;
run;

********* start do loop by variable;
%do m=1 %to %eval(&vnum.);  
%put NOTE: This var is >>&&var&m.<<;

data &&var&m.;
	set &ds.;
	
	attrib VARIABLE length=$32.; 				
	attrib varvalue length = $200.;				* content of source variable;
	attrib vartype length = 8.;					* variable type;

	VARIABLE=upcase(strip("&&var&m."));

	* if variable is numeric, convert it first ;
	%if &&var&m. in (&numvar.) %then %do;
		varvalue = strip(put(&&var&m.,best.));
	%end;
	%else %do;
		varvalue = strip(&&var&m.);
	%end;

	vartype = 99;							* default variable type for debugging;

	* get variable type ;
	%dataTypeNum(varvalue, vartype);

	keep VARIABLE vartype;
run;

%end;
********* end do loop by variable;

* combine individual variable datasets in to one;
data temp_allvars;
	set &allvar.;
run;

proc sql;
	* aggregate min vartype grouped by variable ;
	create table aggr_allvars as 
	select variable, min(vartype) as vartype
	from temp_allvars
	group by variable
	
	* append min vartype to dataset contents ;
	create table aggr_allvars2 as
	select a.variable, a.label, b.vartype
	from c&ds. as a left join aggr_allvars as b
	on a.variable=b.variable;

quit;

data &out;
	set aggr_allvars2;
	length TYPE $32.;

	* get text version of variable type ;
	%textType(vartype, type);

	keep VARIABLE LABEL TYPE;
run; 

%mend getVarType;
