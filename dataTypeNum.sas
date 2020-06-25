* macro to determine what class type a value is, run inside data step ;
* source: source variable to evaluate ;
* vartype: numeric variable to store numerical equivalent of datatype ;
%macro dataTypeNum(source, vartype);

if strip(&source)="" then &vartype=90;									    * empty string;
else if strip(&source)="." then &vartype=80; 								* numeric ;

* for more perl regular expressions, search SUGI paper ;
* datetime: xxxx-xx-xxTxx:xx or xxxx-xx-xxTxx:xx:xx;
else if prxmatch("/[12]\d\d\d-[01]\d-[0-3]\dT[01]\d(:\d{2}){1,2}/",&source) and
	length(strip(&source)) le 19 then &vartype=2;
* partialDatetime: xxxx-xx-xxTxx;
else if prxmatch("/[12]\d\d\d-[01]\d-[0-3]\dT[01]\d/",&source) and
	length(strip(&source)) le 13 then &vartype=3;
* date: xxxx-xx-xx;
else if prxmatch("/[12]\d\d\d-[01]\d-[0-3]\d/",&source) and
	length(strip(&source)) le 10 then &vartype=4;
* partialDate: xxxx-xx;
else if prxmatch("/[12]\d\d\d-[01]\d/",&source) and
	length(strip(&source)) le 7 then &vartype=5;

* if contains any letters;
else if prxmatch("/[a-zA-Z]/",&source) then &vartype=10;

* does not contain letters ;
else if prxmatch("/[^a-zA-Z]/",&source) then do;
	* if contains only digits, period, and dash ;
	if prxmatch("/[^0-9\-\.]/",strip(&source))=0 then do;
		&vartype=11;
		* if dash after digits ;
		if prxmatch("/\d+\-/",strip(&source)) then &vartype=10;
		* if two or more periods ;
		else if prxmatch("/\-*\d*\.\d*\.\d*/",strip(&source)) then &vartype=10;

		else if prxmatch("/(^-?)\d+\.\d+/",&source) then &vartype=30;
		else &vartype=35;
	end;
	else &vartype=10;
end;
else &vartype=999;         
%mend dataTypeNum;