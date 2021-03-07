@echo off
pause
::adb disconnect
setlocal EnableDelayedExpansion
set index=0
@echo on
adb devices -l
@echo off

echo vvvvvvvvGetting Device infovvvvvvvv
echo.
echo.
echo ===Getting Serials===
for /f "tokens=1 skip=1" %%s in ('adb devices -l') do (

	call echo Getting device %%index%% device SERIAL: %%s
	::call echo Index=%%index%%
	call set serial[%%index%%]=%%s
	set /A index+=1
)
echo Index: %index%
echo.
echo ===Getting Transport IDs===
set idIndex=0
for /f "skip=1 tokens=6" %%d in ('adb devices -l') do (
	call echo Getting device %%idIndex%% transport ID: %%d
	::call echo transID=%%transids[%%idIndex%%]
	call set transids[%%idIndex%%]=%%d
	set /A idIndex+=1
)
echo idIndex: %idIndex%
echo.
echo ===Removing transport_id===
set removeIndex=0
for /f "tokens=2 delims=:" %%d in ('set transids[') do (
		echo %%d
		call set transids[%%removeIndex%%]=%%d
		::set !transids[%removeIndex%]!=%%d
		set /a removeIndex+=1
)

echo.
::pause 

set /a index-=1
echo Index: %index%
::pause
::for /l %%n in (0,1,%index%) do ( 
::   echo Serial: !serial[%%n]! Transport ID: !transids[%%n]!
::)


set ipIndex=0
echo.
echo ===Getting IPs===
for /l %%n in (0,1,%index%) do ( 
	::for loop to get ip
   for /f "tokens=9" %%a in ('adb -t !transids[%%n]! shell ip route') do (
	call echo IP of Device %%n: %%a
	call set ipadds[%%n]=%%a
	
   )
	set /a ipIndex+=1
)

::pause
echo.
echo ===Devices===
for /l %%n in (0,1,%index%) do ( 
   echo Serial: !serial[%%n]! - Transport ID: !transids[%%n]! - IP: !ipadds[%%n]!
)
::for /l %%n in (0,1,%idIndex%) do ( 
::   echo Transport ID: !transids[%%n]!
::)
echo.
echo Any key to continue connecting
pause

echo.
echo ===TCPIP to 5555 and connect===
for /l %%n in (0,1,%index%) do ( 
   echo Serial: !serial[%%n]! - Transport ID: !transids[%%n]! - IP: !ipadds[%%n]!
   adb -t !transids[%%n]! tcpip 5555
   adb connect !ipadds[%%n]!
)

timeout 2
adb devices -l
echo End of File
pause