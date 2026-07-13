options validvarname=any;

/* The upstream script reads "Breast Cancer METABRIC.csv" via PROC IMPORT.   */
/* This bundle inlines a small sample of the same columns so the survival    */
/* analysis is self-contained; variable names are kept verbatim.             */
data raw_metabric;
  infile datalines dsd dlm='|' truncover;
  length 'Patient ID'n $12 'Overall Survival Status'n $12;
  input 'Patient ID'n $
        'Age at Diagnosis'n
        Sex $
        'Tumor Stage'n
        'Tumor Size'n
        'ER Status'n $
        'HER2 Status'n $
        Chemotherapy $
        'Overall Survival (Months)'n
        'Overall Survival Status'n $;
datalines;
MB-0000|75.65|Female|2.0|22.0|Positive|Negative|No|140.5|Living
MB-0005|48.87|Female|2.0|15.0|Positive|Negative|Yes|163.7|Deceased
MB-0002|43.19|Female|1.0|10.0|Positive|Negative|No|84.63333333|Living
MB-0008|76.97|Female|2.0|40.0|Positive|Negative|Yes|41.36666667|Deceased
MB-0006|47.68|Female|2.0|25.0|Positive|Negative|Yes|164.93333330000002|Living
MB-0010|78.77|Female|4.0|31.0|Positive|Negative|No|7.8|Deceased
MB-0014|56.45|Female|2.0|10.0|Positive|Negative|Yes|164.33333330000002|Living
MB-0020|70.0|Female|3.0|65.0|Negative|Negative|Yes|22.4|Deceased
MB-0039|70.91|Female|1.0|21.0|Positive|Negative|No|163.5333333|Living
MB-0022|89.08|Female|2.0|29.0|Positive|Negative|No|99.53333333|Deceased
MB-0045|45.27|Female|2.0|19.0|Negative|Negative|Yes|164.9|Living
MB-0028|86.41|Female|2.0|16.0|Positive|Negative|No|36.56666667|Deceased
MB-0048|51.46|Female|2.0|25.0|Positive|Positive|Yes|103.83333329999999|Living
MB-0035|84.22|Female|2.0|28.0|Positive|Negative|No|36.26666667|Deceased
MB-0050|44.64|Female|2.0|33.0|Positive|Negative|Yes|75.33333333|Living
MB-0036|85.49|Female|4.0|22.0|Positive|Negative|No|132.03333329999998|Deceased
MB-0053|70.02|Female|2.0|23.0|Positive|Negative|No|161.06666669999998|Living
MB-0046|83.02|Female|2.0|36.0|Positive|Positive|No|14.13333333|Deceased
MB-0054|66.91|Female|2.0|36.0|Positive|Negative|No|160.3|Living
MB-0071|68.42|Female|2.0|50.0|Positive|Negative|No|131.0|Deceased
MB-0056|62.62|Female|1.0|29.0|Positive|Negative|No|62.86666667|Living
MB-0079|50.42|Female|2.0|40.0|Negative|Negative|Yes|28.5|Deceased
MB-0059|75.58|Female|1.0|17.0|Positive|Negative|No|160.9|Living
MB-0083|64.85|Female|1.0|13.0|Positive|Negative|No|86.06666667|Deceased
MB-0060|45.43|Female|2.0|23.0|Positive|Negative|Yes|140.8666667|Living
MB-0095|80.5|Female|3.0|55.0|Positive|Negative|No|49.76666667|Deceased
MB-0062|52.14|Female|1.0|17.0|Negative|Negative|Yes|153.9666667|Living
MB-0099|51.58|Female|2.0|21.0|Positive|Negative|Yes|132.1|Deceased
MB-0064|69.13|Female|1.0|18.0|Positive|Negative|No|108.93333329999999|Living
MB-0100|68.68|Female|2.0|39.0|Negative|Negative|Yes|8.066666667|Deceased
MB-0066|61.49|Female|2.0|16.0|Positive|Negative|No|157.43333330000002|Living
MB-0102|51.38|Female|2.0|40.0|Positive|Negative|Yes|140.7666667|Deceased
MB-0068|51.01|Female|2.0|12.0|Positive|Negative|No|103.1333333|Living
MB-0108|43.15|Female|1.0|18.0|Positive|Negative|Yes|42.7|Deceased
MB-0081|49.61|Female|2.0|24.0|Positive|Negative|No|69.5|Living
MB-0109|82.53|Female|2.0|45.0|Positive|Negative|No|112.4|Deceased
MB-0093|43.55|Female|2.0|14.0|Positive|Negative|No|153.2|Living
MB-0112|83.89|Female|3.0|150.0|Positive|Negative|No|39.16666667|Deceased
MB-0097|78.19|Female|2.0|30.0|Positive|Negative|No|98.7|Living
MB-0115|39.84|Female|2.0|25.0|Negative|Negative|Yes|66.73333333|Deceased
;
run;

data adam_adsl;
set raw_metabric;
STUDYID="ONC001";
USUBJID=catx("-",STUDYID,'Patient ID'n);
run;

/* Survival Analysis Dataset */
data adam_adtte;
set adam_adsl;

AVAL='Overall Survival (Months)'n;

if 'Overall Survival Status'n="Deceased" then CNSR=0;
else CNSR=1;

run;

/* Kaplan-Meier Survival Curve */
proc lifetest data=adam_adtte plots=survival;
time AVAL*CNSR(1);
title "Kaplan-Meier Survival Curve";
run;
