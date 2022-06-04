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

for /L %%i in (1,1,%n%) do echo !array[%%i]!

set j = 0
for /L %%i in (1,1,%n%) do (
    for /f "delims=" %%a in ('findstr /n /c:"u-backlink u-clearfix u-grey-80" !array[%%i]!') do (
        set var=%%a



        ::todelete
        set /A j+=1
        set array[!j!]=!var:~0,3!
    )
)

::todelete
set m=%j%
for /L %%j in (1,1,%m%) do echo !array[%%j]!




    ::  echo !var:~0,3!