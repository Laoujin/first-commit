@echo off
:hoofdgroep
cls
echo.
echo.
echo				M’’K Jî KîUZî
echo				úúùùÄÄÄÄÄùùúú
echo.
echo.
echo			1. Prins
echo			2. Prins Megahit
echo			3. Spelgroep-1
echo			4. Ark2
echo			5. Exit
echo.
choice /c:12345
if errorlevel 5 goto allereinde
if errorlevel 4 goto ark2
if errorlevel 3 goto spel-1
if errorlevel 2 goto prinsM
if errorlevel 1 goto prins

:prins
call 1
goto end

:prinsM
call 2
goto end

:ark2
call 4
goto end

:spel-1
call 3
goto end

:end
cls
echo	1. Nog een spel op deze diskette ?
echo	2. Een spel op de harde schijf ?
echo.
choice /c:12
if errorlevel 2 goto 2
if errorlevel 1 goto 1

:2
call spel
goto allereinde

:1
goto hoofdgroep

:allereinde
c:
cd\
cls