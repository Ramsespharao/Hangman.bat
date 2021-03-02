@echo off&setlocal
title Hangman
mode 70,25
:start
cls
echo.
set /p playeramount=Enter the amount of players: 
if %playeramount% lss 2 (
	echo.&echo. The minimum amount of players is 2!
	echo. Try again...
	pause>nul
	goto start
	)
:playernames
set /a countplayernames=%countplayernames%+1
cls
echo.
set /p player%countplayernames%=Enter name of Player %countplayernames%: 
if %countplayernames%==%playeramount% (goto chooseword)
goto playernames
:chooseword
set /a row=%row%+1
set tempvar=player%row%
if %row%==%playeramount% (set row=0)
echo set host=%%%tempvar%%%>temp.bat
call temp.bat
del temp.bat
cls
echo.
set /p word=Enter a word %host%: 
set T=%temp%\4L.tmp
>%T% echo %word%
for %%i in (%T%) do set /a LenVar=%%~zi-2
del %T%
set wordlenght=%lenvar%
if %wordlenght% gtr 64 (
	echo. The maximum size of the word is 64 letter
	echo. Try again...
	pause>nul
	goto chooseword
	)
set str=----------------------------------------------------------------
echo set invword=%%str:~0,%wordlenght%%%>temp.bat
call temp.bat
del temp.bat
:::::::::::::::::::::::
set realinvword=%invword%
set countspaces=-1
:countspaces
set /a countspaces=%countspaces%+1
set /a countspacesminus=%countspaces%
if %countspacesminus%==%wordlenght% (
	goto continue1
	)
set str=%word%
echo set spaces=%%str:~%countspaces%,1%%>temp.bat
call temp.bat
del temp.bat
if /I "%spaces%"==" " (goto makespaces)
goto countspaces
:makespaces
set /a tempcountspaces=%countspaces%
set str=%invword%
echo set invword2=%%str:~0,%tempcountspaces%%%>temp.bat
call temp.bat
del temp.bat
set /a tempcountspaces=%countspaces%+1
set str=%invword%
echo set invword1=%%str:~%tempcountspaces%%%>temp.bat
call temp.bat
del temp.bat
set invword=%invword2% %invword1%
goto countspaces
:::::::::::::::::::::::
:continue1
set wrongtry=0
set row2=0
set picture1= &set picture2= &set picture3= &set picture4= &set picture5= &set picture6= 
set wrongletter1= &set wrongletter2= &set wrongletter3= &set wrongletter4= &set wrongletter5= &set wrongletter6= 
:guess
if %row2%==%playeramount% (set row2=0)
set /a row2=%row2%+1
if %row2%==%row% (goto guess)
set tempvar=player%row2%
echo set playerturn=%%%tempvar%%%>temp.bat
call temp.bat
del temp.bat
cls
echo.
echo. %picture1%
echo. %picture2%
echo. %picture3%
echo. %picture4%
echo. %picture5%
echo. %picture6%
echo.                 %wrongletter1% %wrongletter2% %wrongletter3% %wrongletter4% %wrongletter5% %wrongletter6%&echo.
if %wrongtry%==6 (
	echo.    %word%&echo.
	echo.&echo. You lost!
	echo. Press a key to play again...
	pause>nul
	goto chooseword
	)
if "%invword%"=="%word%" (
	echo.    %word%&echo.
	echo.&echo. You won!
	echo. Press a key to play again...
	pause>nul
	goto chooseword
	)
echo.    %invword%&echo.
set /p letter=Guess a letter %playerturn%: 
set T=%temp%\4L.tmp
>%T% echo %letter%
for %%i in (%T%) do set /a LenVar=%%~zi-2
del %T%
set letterlenght=%lenvar%
if %letterlenght% geq 2 (
	echo.&echo. You can only enter one letter!
	echo. Try again...
	pause>nul
	goto guess
	)
if "%letterlenght%"=="" (
	echo.&echo. You can only enter one letter!
	echo. Try again...
	pause>nul
	goto guess
	)
set try=-1
set rightletternumber=0
:tryletter
set /a try=%try%+1
if %try%==%wordlenght% (
	if %rightletternumber%==0 (goto wrongletter)
	goto guess
	)
set "str=%word%"
echo set tempvar=%%str:~%try%,1%%>temp.bat
call temp.bat
del temp.bat
if /I "%letter%"=="%tempvar%" (
	set "rightletter=%tempvar%"
	goto setinvword
	)
goto tryletter
:setinvword
set /a rightletternumber=%rightletternumber%+1
set /a temptry=%try%+1
set "str=%invword%"
echo set invwordpart1=%%str:~%temptry%%%>temp.bat
call temp.bat
del temp.bat
set /a temptry=%try%
set "str=%invword%"
echo set invwordpart2=%%str:~0,%temptry%%%>temp.bat
call temp.bat
del temp.bat
set "invword=%invwordpart2%%rightletter%%invwordpart1%"
goto tryletter
:wrongletter
set /a wrongtry=%wrongtry%+1
if %wrongtry%==1 (
pause
	set "wrongletter1=%letter%"
	set picture1=
	set picture2=                  บ
	set picture3=                  บ
	set picture4=                  บ
	set picture5=                  บ
	set picture6=                
	)
if %wrongtry%==2 (
	set "wrongletter2=%letter%"
	set picture1=                
	set picture2=                  บ
	set picture3=                  บ
	set picture4=                  บ
	set picture5=                  บ
	set picture6=                 อสออออออออ
	)
if %wrongtry%==3 (
	set "wrongletter3=%letter%"
	set picture1=                  ษอออออออ
	set picture2=                  บ
	set picture3=                  บ
	set picture4=                  บ
	set picture5=                  บ
	set picture6=                 อสออออออออ
	)
if %wrongtry%==4 (
	set "wrongletter4=%letter%"
	set picture1=                  ษออออออห
	set picture2=                  บ      ณ
	set picture3=                  บ
	set picture4=                  บ
	set picture5=                  บ
	set picture6=                 อสออออออออ
	)
if %wrongtry%==5 (
	set "wrongletter5=%letter%"
	set picture1=                  ษออออออห
	set picture2=                  บ      ณ
	set picture3=                  บ      
	set picture4=                  บ      บ
	set picture5=                  บ     / \
	set picture6=                 อสออออออออ
	)
if %wrongtry%==6 (
	set "wrongletter6=%letter%"
	set picture1=                  ษออออออห
	set picture2=                  บ      ณ
	set picture3=                  บ      O
	set picture4=                  บ     /บ\
	set picture5=                  บ     / \
	set picture6=                 อสออออออออ
	)
goto guess