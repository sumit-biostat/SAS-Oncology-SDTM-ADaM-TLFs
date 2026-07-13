data adam_adsl;
set raw_metabric;
STUDYID="ONC001";
USUBJID=catx("-",STUDYID,'Patient ID'n);
run;

/* Tumor Stage Bar Graph */
proc sgplot data=adam_adsl;
vbar 'Tumor Stage'n;
title "Tumor Stage Distribution";
run;

/* Age Distribution Histogram */
proc sgplot data=adam_adsl;
histogram 'Age at Diagnosis'n;
density 'Age at Diagnosis'n;
title "Age Distribution of Patients";
run;

/* Tumor Size vs Survival Scatter Plot */
proc sgplot data=adam_adsl;
scatter x='Tumor Size'n y='Overall Survival (Months)'n;
title "Tumor Size vs Survival";
run;

/* ER Status vs Survival Box Plot */
proc sgplot data=adam_adsl;
vbox 'Overall Survival (Months)'n / category='ER Status'n;
title "Survival by ER Status";
run;
