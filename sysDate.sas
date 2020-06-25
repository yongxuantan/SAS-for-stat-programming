* macro that create "sysDate" macro variable with system date in yyyy-mm-dd format ;
%macro sysDate(fmt=yymmdd10.);
   %global sysDate;
   data _null_;
      call symput("sysDate",trim(left(put("&sysdate"d,&fmt.))));
   run; 
%mend sysDate;
