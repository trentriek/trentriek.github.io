@echo off
setlocal EnableDelayedExpansion

rem first get the source directory for reference
SET "sourcedir=%CD%"
rem second create a temporary folder to put all temp files in (as to not tamper with files until we need to)
md temphtml

rem third for each html file: read through the file with findstr to find the line(s) to be deleted. 
for /r %%G in (*.html) do (
    SET "linecount="
    rem this for loop read through the file and finds the line equivalent to the string below.
    FOR /f "delims=:" %%e IN ('findstr /n /c:"u-backlink u-clearfix u-grey-80" "%%G"') DO (
        SET /a linecount=%%e 
    )
    rem if/when found (when linecount is valid), copy contents to new file.
    rem to remove multiple lines, itterate backwards from the line to delete by subtracting 1. 
    rem when at the line to delete this will be 0; if linecount is 0, do not copy. Same for linecount - n lines
    IF DEFINED linecount (
        FOR /f "usebackqdelims=" %%b IN ("%%G") DO (
            SET /a linecount-=1
            
            IF !linecount! gtr 0 ECHO.%%b
            IF !linecount! lss -10 ECHO.%%b
        )
    )>"%sourcedir%\temphtml\tempfile"& MOVE /y "%sourcedir%\temphtml\tempfile" "%%G" >nul
)

rem delete any temp files
rd "temphtml"

GOTO :EOF