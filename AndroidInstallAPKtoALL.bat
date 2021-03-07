@echo off
setlocal EnableDelayedExpansion
set index=0
adb devices -l

set /p apk=Enter APK location: 

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
set /a index-=1
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
echo Install APKs?
pause

echo ===Install APKs===
for /l %%n in (0,1,%index%) do ( 
   echo Serial: !serial[%%n]! - Transport ID: !transids[%%n]!
   adb -t !transids[%%n]! install -r %apk%
)

timeout 2
adb devices -l
echo End of File
pause