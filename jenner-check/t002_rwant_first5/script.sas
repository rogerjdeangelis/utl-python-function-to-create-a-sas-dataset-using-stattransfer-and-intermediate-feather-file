/* From utl-python-...-feather-file.sas: the "first five rows" result the       */
/* worked example produces as SD1.RWANT (documented output block in the file).   */
/* The upstream selects the first five rows of sashelp.class via Python (pandasql */
/* "limit 5"); reproduced here in pure SAS with obs=5, per the author's own       */
/* comment "select the first five rows from sashelp.class". proc print unchanged. */
options validvarname=upcase;
libname sd1 (work);
data sd1.rwant;
  set sashelp.class(obs=5);
run;quit;

proc print data=sd1.rwant;
run;quit;
