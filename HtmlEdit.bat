@echo off
setlocal EnableDelayedExpansion

rem get the source directory for reference & create a temporary folder to put all temp files in. 
SET "sourcedir=%CD%"
md temphtml

rem for each html, read through with findstr to find the line to be deleted. if found (linecount is valid), copy contents to new file.
rem to remove multiple lines, itterate backwards from the line to delete by subtracting 1. when at the line to delete this will be 0; if linecount is 0, do not copy. Same for linecount - n lines
for /r %%G in (*.html) do (
    SET "linecount="
    
    FOR /f "delims=:" %%e IN ('findstr /n /c:"u-backlink u-clearfix u-grey-80" "%%G"') DO (
        SET /a linecount=%%e 
    )
    ::echo there
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