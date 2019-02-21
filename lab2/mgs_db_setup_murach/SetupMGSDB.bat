@ECHO off
:: 
:: Uses SQL*Plus utility to run the SQL scripts that create
:: user UV, create and populate the tables in the university database.

:: If necessary, edit the username/password
sqlplus system/system @SetupMGSDB

:: Display a message about the log file
ECHO.
ECHO For details, check the SetupMGSDB.log file in the current directory.
ECHO.

:: Display 'press any key to continue' message
PAUSE