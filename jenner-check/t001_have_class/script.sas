/* From utl-python-...-feather-file.sas: the SAS step that builds SD1.HAVE.     */
/* The upstream libname points at a local Windows path (d:/sd1); redirected to  */
/* WORK here so the step runs in isolation. Logic, option and source unchanged.  */
options validvarname=upcase;
libname sd1 (work);
data sd1.have;
  set sashelp.class;
run;quit;

proc print data=sd1.have;
run;quit;
