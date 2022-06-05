::some echo settings, for printing things
@echo off
setlocal EnableDelayedExpansion

SET "sourcedir=%CD%"
::SET "destdir=u:\your results"

echo !sourcedir!

for /r %%G in (*.html) do (
    SET "linecount="
    echo %%G
    FOR /f "delims=:" %%e IN ('findstr /n /c:"u-backlink u-clearfix u-grey-80" "%%G"') DO (
        SET /a linecount=%%e 
    )
    ::echo there
    IF DEFINED linecount (
        FOR /f "usebackqdelims=" %%b IN ("%%G") DO (
            SET /a linecount-=1
            ::echo hello
            IF !linecount! gtr 0 ECHO %%b
            IF !linecount! lss -10 ECHO %%b
        )
    )>"%sourcedir%\temphtml\tempfile.html"
)
GOTO :EOF