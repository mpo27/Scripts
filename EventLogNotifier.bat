@ECHO OFF
TITLE Windows Event Log Notifier
ECHO Windows Event Log Notifier
ECHO Written by: Jason Faulkner
ECHO JasonFaulkner.com
ECHO HowToGeek.com
ECHO.
ECHO.

REM Requires 'MyEventViewer' utility from Nirsoft.
REM For email functionality, the 'Blat' utility is required to be configured on your system.
REM The utilities should be available in a location set in the PATH variable (i.e. C:\Windows).

REM In order for this to work as intended, you should set up a Windows Scheduled Task to run at the same interval as the capture configuration.
REM For example, if you configure the capture to run once per day, your scheduled task should run once per day to ensure all events are captured.
REM The respective scheduled task _must_ be run with administrative permissions.

SETLOCAL EnableExtensions EnableDelayedExpansion

REM Automatic emailing of results configuration (requires 'Blat' to be preconfigured on your system).
REM To turn on, set "EmailResults" to 1 (any other value will turn this off) and enter the target email address.
REM -----
SET EmailResults=1
SET EmailTo=matthewo@4feldco.com

REM Save the results to a specific location.
REM To turn on, set "SaveResults" to 1 (any other value will turn this off) and enter the full destination path folder (no quotes).
REM The folder you specify must already exist.
REM -----
SET SaveResults=1
SET SaveTo=C:\EventNotifications

REM Interval to use to when querying the Event Logs.
REM 1 = Minutes
REM 2 = Hours
REM 3 = Days
REM -----
SET TimeInterval=3

REM Respective to the interval set above, the value to use for querying the Event Logs.
REM For example, if the interval is Days (3) and the value is set to 1, the events occuring in the last day will be returned.
REM -----
SET TimeValue=1

REM Event Logs (full system name in Event Log Properties) to return the results from.
REM Enter a comma separated list (no spaces between) of the entries you want in the order you want them to appear in the results.
REM Common Logs = Application, System
REM -----
SET Logs=Security

REM Event Types (Level column in the Event Log) to return results from.
REM Enter a comma separated list (no spaces between) of the entries you want in the order you want them to appear in the results.
REM Common Types = Information, Warning, Error
REM -----
SET Types=Error,Warning

REM -- End of configuration section --


REM Set date/time values.
REM This assumes system date format is as follows: Mon 01/31/2010
FOR /F "tokens=2,3,4 delims=/ " %%A IN ("%DATE%") DO SET DateYYYYMMDD=%%C-%%A-%%B
FOR /F "tokens=1 delims=." %%A IN ("%TIME%") DO SET TimeHHMMSS=%%A

SET TempFile1="%TEMP%\Events.%RANDOM%.csv"
SET TempFile2="%TEMP%\Events_%DateYYYYMMDD%_%TimeHHMMSS::=%.csv"

MyEventViewer /scomma %TempFile1% /ShowOnlyLastEvents 1 /LastEventsUnit %TimeInterval% /LastEventsValue %TimeValue% /sort "Log Type"

REM Get events from selected logs (supports up to 10)
FOR /F "tokens=1,2,3,4,5,6,7,8,9,10 delims=," %%A IN ("%Logs%") DO (
	IF NOT {%%A}=={} TYPE %TempFile1% | FIND ",%%A," >> %TempFile2%
	IF NOT {%%B}=={} TYPE %TempFile1% | FIND ",%%B," >> %TempFile2%
	IF NOT {%%C}=={} TYPE %TempFile1% | FIND ",%%C," >> %TempFile2%
	IF NOT {%%D}=={} TYPE %TempFile1% | FIND ",%%D," >> %TempFile2%
	IF NOT {%%E}=={} TYPE %TempFile1% | FIND ",%%E," >> %TempFile2%
	IF NOT {%%F}=={} TYPE %TempFile1% | FIND ",%%F," >> %TempFile2%
	IF NOT {%%G}=={} TYPE %TempFile1% | FIND ",%%G," >> %TempFile2%
	IF NOT {%%H}=={} TYPE %TempFile1% | FIND ",%%H," >> %TempFile2%
	IF NOT {%%I}=={} TYPE %TempFile1% | FIND ",%%I," >> %TempFile2%
	IF NOT {%%J}=={} TYPE %TempFile1% | FIND ",%%J," >> %TempFile2%
)

MOVE /Y %TempFile2% %TempFile1%
REM Filter event types from the selected logs (supports up to 5)
FOR /F "tokens=1,2,3,4,5 delims=," %%A IN ("%Types%") DO (
	IF NOT {%%A}=={} TYPE %TempFile1% | FIND ",%%A," >> %TempFile2%
	IF NOT {%%B}=={} TYPE %TempFile1% | FIND ",%%B," >> %TempFile2%
	IF NOT {%%C}=={} TYPE %TempFile1% | FIND ",%%C," >> %TempFile2%
	IF NOT {%%D}=={} TYPE %TempFile1% | FIND ",%%D," >> %TempFile2%
	IF NOT {%%E}=={} TYPE %TempFile1% | FIND ",%%E," >> %TempFile2%
)

TYPE %TempFile2% | FIND /C "," > %TempFile1%
SET /P TotalEvents=< %TempFile1%

IF NOT %TotalEvents%==0 (
	REM Deliver the filtered results
	IF {%EmailResults%}=={1} Blat - -body "%TotalEvents% Event Notices on %DATE% at %TimeHHMMSS%" -to %EmailTo% -subject "Event Notices %DateYYYYMMDD%+%TimeHHMMSS%" -attacht %TempFile2%
	IF {%SaveResults%}=={1} MOVE /Y %TempFile2% "%SaveTo%"
)


REM Clean up
IF EXIST %TempFile1% DEL /F /Q %TempFile1%
IF EXIST %TempFile2% DEL /F /Q %TempFile2%

ENDLOCAL