REM FOR /r %G IN (*.html) do @echo %G

::some echo settings, for printing things
@echo off
setlocal EnableDelayedExpansion


::start by creating a list of html files
set i=0
for /r %%G in (*.html) do (
    set /A i+=1
    set array[!i!]=%%G
)
set n=%i%

REM for /L %%i in (1,1,%n%) do echo !array[%%i]!

for /L %%i in (1,1,%n%) do (
    for /F "delims=" %%a in ('findstr /n /c:"u-backlink u-clearfix u-grey-80" !array[%%i]!') do (
        set var=%%a
        echo !var!
    )
)

    ::for /f "tokens=*" %%a in (!array[%%i]!) do (
    ::echo line=%%a

    ::)