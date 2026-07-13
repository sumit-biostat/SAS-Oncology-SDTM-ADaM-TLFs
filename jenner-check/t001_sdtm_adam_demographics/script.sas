/* Create SDTM DM (Demographics) */
data sdtm_dm;
set raw_metabric;

STUDYID="ONC001";
DOMAIN="DM";

USUBJID=catx("-",STUDYID,'Patient ID'n);

AGE='Age at Diagnosis'n;

run;

/* Create ADaM Dataset */
data adam_adsl;
set sdtm_dm;

TRT01P="CHEMO";
SAFFL="Y";

run;

/* Validate ADaM Dataset */
proc contents data=adam_adsl;
run;

proc print data=adam_adsl(obs=10);
run;

/* Create Demographic Summary Table */
proc means data=adam_adsl n mean std min max;
var 'Age at Diagnosis'n;
title "Demographic Summary - Age";
run;

/* Tumor Size Summary Table */
proc means data=adam_adsl n mean std min max;
var 'Tumor Size'n;
title "Tumor Size Summary";
run;
