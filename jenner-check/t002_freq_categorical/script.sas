data adam_adsl;
set raw_metabric;
STUDYID="ONC001";
USUBJID=catx("-",STUDYID,'Patient ID'n);
TRT01P="CHEMO";
run;

/* Gender Distribution Table */
proc freq data=adam_adsl;
tables sex;
title "Gender Distribution";
run;

/* Tumor Stage Table */
proc freq data=adam_adsl;
tables 'Tumor Stage'n;
title "Tumor Stage Distribution";
run;

/* Treatment Analysis */
proc freq data=adam_adsl;
tables Chemotherapy;
title "Chemotherapy Treatment Summary";
run;

/* ER / HER2 Status Analysis */
proc freq data=adam_adsl;
tables 'ER Status'n 'HER2 Status'n;
title "Biomarker Status Distribution";
run;
