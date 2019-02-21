spool SeupUnivDB.log;

prompt>Creating user uv
start CreateUserUV

prompt>Creating UV tables
start ReCreateUVTables

prompt>Inserting small UV table data
start InsertSmallUnivDBData

spool off;

exit;