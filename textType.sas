* macro to convert numerical type assignment to categorical text ;
* source: numerical source variable to evaluate ;
* outvar: character variable to store assignment ;
%macro textType(source, outvar);

* if data type is empty string;
if &source=90 then &outvar="text";

* if data type is missing, original data was numeric;
else if &source=80 then &outvar="integer";

else if &source=2 then &outvar="datetime";
else if &source=3 then &outvar="partialDatetime";
else if &source=4 then &outvar="date";
else if &source=5 then &outvar="partialDate";
else if &source=6 then &outvar="time";
else if &source=7 then &outvar="partialTime";
else if &source=8 then &outvar="durationDatetime";
else if &source=9 then &outvar="incompleteDatetime";
else if &source=10 then &outvar="text";
else if &source=30 then &outvar="float";
else if &source=35 then &outvar="integer";
else &outvar="text";                              * default ;
%mend textType;