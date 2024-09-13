# utl-python-function-to-create-a-sas-dataset-using-stattransfer-and-intermediate-feather-file
Python function to create a sas dataset using stattransfer and intermediate feather file
    %let pgm=utl-python-function-to-create-a-sas-dataset-using-stattransfer-and-intermediate-feather-file;

    Python function to create a sas dataset using stattransfer and intermediate feather file

      Contents

        1 copy python function to your autocall library
        2 export panda dataframe to sas7bdat


    github
    https://tinyurl.com/26pkbyzb
    https://github.com/rogerjdeangelis/utl-python-function-to-create-a-sas-dataset-using-stattransfer-and-intermediate-feather-file

    Obviously I am not an expert python programmer, but the code works.
    I failed to create temp files.
    /*               _   _                   __                  _   _               _                _
    / |  _ __  _   _| |_| |__   ___  _ __   / _|_   _ _ __   ___| |_(_) ___  _ __   | |_ ___     ___ | |_ ___
    | | | `_ \| | | | __| `_ \ / _ \| `_ \ | |_| | | | `_ \ / __| __| |/ _ \| `_ \  | __/ _ \   / _ \| __/ _ \
    | | | |_) | |_| | |_| | | | (_) | | | ||  _| |_| | | | | (__| |_| | (_) | | | | | || (_) | | (_) | || (_) |
    |_| | .__/ \__, |\__|_| |_|\___/|_| |_||_|  \__,_|_| |_|\___|\__|_|\___/|_| |_|  \__\___/   \___/ \__\___/
        |_|    |___/
    */

    filename ft15f001 "c:/oto/fn_tosas9x.py";
    parmcards4;
    def fn_tosas9x(df,outlib="d:/sd1/",outdsn="txm",timeest=3):

        pthsd1  = outlib + outdsn + ".sas7bdat"
        fthout  = outlib + outdsn + ".feather"
        statcmd = outlib + "statcmd.stcmd"

        if os.path.exists(pthsd1):
           os.remove(pthsd1)

        if os.path.exists(fthout):
           os.remove(fthout)

        if os.path.exists(statcmd):
           os.remove(statcmd)

        feather.write_feather(df,fthout,version=1)

        f = open(statcmd, "a")
        f.writelines([
         "set numeric-names        n                "
        ,"\nset log-level          e                "
        ,"\nset in-encoding        system           "
        ,"\nset out-encoding       system           "
        ,"\nset enc-errors         sub              "
        ,"\nset enc-sub-char       _                "
        ,"\nset enc-error-limit    100              "
        ,"\nset var-case-ci        preserve-always  "
        ,"\nset preserve-label-sets y               "
        ,"\nset preserve-str-widths n               "
        ,"\nset preserve-num-widths n               "
        ,"\nset recs-to-optimize   all              "
        ,"\nset map-miss-with-labs n                "
        ,"\nset user-miss          all              "
        ,"\nset map-user-miss      n                "
        ,"\nset sas-date-fmt       mmddyy           "
        ,"\nset sas-time-fmt       time             "
        ,"\nset sas-datetime-fmt   datetime         "
        ,"\nset write-file-label   none             "
        ,"\nset write-sas-fmts     n                "
        ,"\nset sas-outrep         windows_64       "
        ,"\nset write-old-ver      1                "
        ,"\ncopy " + fthout + " sas9 " + pthsd1 ])
        f.close()
        cmds="c:/PROGRA~1/StatTransfer17-64/st.exe " + outlib + "statcmd.stcmd"
        devnull = open('NUL', 'w');
        rc = subprocess.Popen(cmds, stdout=devnull, stderr=devnull)
        time.sleep(timeest)
        os.system(f"taskkill /f /im {'st.exe'}")
    ;;;;
    run;quit;

    filename ft15f001 clear;

    /*___                          _            _       _         __                            ____                _____ _         _       _
    |___ \   _ __   __ _ _ __   __| | __ _   __| | __ _| |_ __ _ / _|_ __ __ _ _ __ ___   ___  |___ \  ___  __ _ __|___  | |__   __| | __ _| |_
      __) | | `_ \ / _` | `_ \ / _` |/ _` | / _` |/ _` | __/ _` | |_| `__/ _` | `_ ` _ \ / _ \   __) |/ __|/ _` / __| / /| `_ \ / _` |/ _` | __|
     / __/  | |_) | (_| | | | | (_| | (_| || (_| | (_| | || (_| |  _| | | (_| | | | | | |  __/  / __/ \__ \ (_| \__ \/ / | |_) | (_| | (_| | |_
    |_____| | .__/ \__,_|_| |_|\__,_|\__,_| \__,_|\__,_|\__\__,_|_| |_|  \__,_|_| |_| |_|\___| |_____||___/\__,_|___/_/  |_.__/ \__,_|\__,_|\__|
            |_|

    */

    options validvarname=upcase;
    libname sd1 "d:/sd1";
    data sd1.have;
      set sashelp.class;
    run;quit;

    /**************************************************************************************************************************/
    /*                                                                                                                        */
    /*                                                                                                                        */
    /*  SD1.HAVE total obs=19 13SEP2024:10:13:18                                                                              */
    /*                                                                                                                        */
    /*  Obs   NAME       SEX    AGE    HEIGHT    WEIGHT                                                                       */
    /*                                                                                                                        */
    /*    1   Alfred      M      14     69.0      112.5                                                                       */
    /*    2   Alice       F      13     56.5       84.0                                                                       */
    /*    3   Barbara     F      13     65.3       98.0                                                                       */
    /*   ...                                                                                                                  */
    /*   17   Ronald      M      15     67.0      133.0                                                                       */
    /*   18   Thomas      M      11     57.5       85.0                                                                       */
    /*   19   William     M      15     66.5      112.0                                                                       */
    /*                                                                                                                        */
    /**************************************************************************************************************************/

    * select the first five rows from sashelp.class;
    * I import all these packages which I feel support BASIC python;

    %utl_pybeginx;
    parmcards4;
    import pyarrow.feather as feather
    import tempfile
    import pyperclip
    import os
    import sys
    import subprocess
    import time
    import pandas as pd
    import pyreadstat as ps
    import numpy as np
    from pandasql import sqldf
    mysql = lambda q: sqldf(q, globals())
    from pandasql import PandaSQL
    pdsql = PandaSQL(persist=True)
    sqlite3conn = next(pdsql.conn.gen).connection.connection
    sqlite3conn.enable_load_extension(True)
    sqlite3conn.load_extension('c:/temp/libsqlitefunctions.dll')
    mysql = lambda q: sqldf(q, globals())
    have, meta = ps.read_sas7bdat("d:/sd1/have.sas7bdat")
    want=pdsql("""
       select
         *
       from
         have
       limit
            5
       """)
    print(want)
    exec(open('c:/oto/fn_tosas9x.py').read())
    fn_tosas9x(want,outlib="d:/sd1/",outdsn="rwant",timeest=3)
    ;;;;
    %utl_pyendx;

    libname sd1 "d:/sd1";
    proc print data=sd1.rwant;
    run;quit;

    /**************************************************************************************************************************/
    /*                                                                                                                        */
    /* PYTHON                                                                                                                 */
    /*                                                                                                                        */
    /*         NAME SEX   AGE  HEIGHT  WEIGHT                                                                                 */
    /*   0   Alfred   M  14.0    69.0   112.5                                                                                 */
    /*   1    Alice   F  13.0    56.5    84.0                                                                                 */
    /*   2  Barbara   F  13.0    65.3    98.0                                                                                 */
    /*   3    Carol   F  14.0    62.8   102.5                                                                                 */
    /*   4    Henry   M  14.0    63.5   102.5                                                                                 */
    /*                                                                                                                        */
    /* SAS                                                                                                                    */
    /*                                                                                                                        */
    /* SD1.RWANT total                                                                                                        */
    /*                                                                                                                        */
    /*  Obs     NAME      SEX    AGE    HEIGHT    WEIGHT                                                                      */
    /*                                                                                                                        */
    /*   1     Alfred      M      14     69.0      112.5                                                                      */
    /*   2     Alice       F      13     56.5       84.0                                                                      */
    /*   3     Barbara     F      13     65.3       98.0                                                                      */
    /*   4     Carol       F      14     62.8      102.5                                                                      */
    /*   5     Henry       M      14     63.5      102.5                                                                      */
    /*                                                                                                                        */
    /**************************************************************************************************************************/

    /*              _
      ___ _ __   __| |
     / _ \ `_ \ / _` |
    |  __/ | | | (_| |
     \___|_| |_|\__,_|

    */
