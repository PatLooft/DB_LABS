spool SetupMGSDB.log;

prompt>Creating mgs DB users
start create_mgs_user

prompt>Creating mgs DB tables and inserting data
start create_mgs_tables

spool off;

exit;