* macro that create "sysTime" macro variable with system date in hh:mm:ss format ;
%macro sysTime(fmt=time8.); 
   %global sysTime;
   data _null_;
       stime = trim(left(put("&systime."t, &fmt.)));
	   if length(stime) lt 8 then stime = '0'||trim(left(stime));
      call symput("sysTime", stime);
   run;
%mend sysTime;