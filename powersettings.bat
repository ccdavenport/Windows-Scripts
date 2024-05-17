@echo off

REM Sets active scheme to high perfomance
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
echo Setting active scheme to high performance

REM Removes balanced power plan
powercfg /delete 381b4222-f694-41f0-9685-ff5bb260df2e
echo Removing balanced power plan

REM Removes Power Saver power plan
powercfg /delete a1841308-3541-4fab-bc81-f71556f20b4a
echo Removing Power saver power plan

REM Disables USB 3 Link power management
powercfg /setacvalueindex scheme_current 2a737441-1930-4402-8d77-b2bebba308a3 d4e98f31-5ffe-4ce1-be31-1b38b384c009 0
echo Disabling USB 3 Link power management

REM Disables USB Selective Suspend
powercfg /setacvalueindex scheme_current 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0
echo Disabling USB Selective Suspend

REM Disables PCIE Link State Power Management
powercfg /setacvalueindex scheme_current 501a4d13-42af-4429-9fd1-a8218c268e20 ee12f906-d277-404b-b6da-e5fa1a576df5 0
echo Disabling PCI Express Link Power Management

REM Disables core parking (Disabled by default on high performance plan, but Win11 sometimes overrides this setting)
powercfg /setacvalueindex scheme_current 54533251-82be-4824-96c1-47b60b740d00 0cc5b647-c1df-4637-891a-dec35c318583 100
powercfg /setacvalueindex scheme_current 54533251-82be-4824-96c1-47b60b740d00 0cc5b647-c1df-4637-891a-dec35c318584 100
echo Forcing core parking to be disabled

REM Disables Standby states, can verify with powercfg -a
powercfg /setacvalueindex scheme_current 238c9fa8-0aad-41ed-83f4-97be242c8f20 abfc2519-3608-4c2a-94ea-171b0ed546ab 0
powercfg.exe /hibernate off
echo Disabling standby states, verify with powercfg -a

REM Disables throttle states
powercfg /setacvalueindex scheme_current 54533251-82be-4824-96c1-47b60b740d00 3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb 0
echo Disabling throttle states

REM Asks the user if a static frequency is set on the CPU. If yes, Processor performance time check interval is set to its maximum (5000) to prevent unnecessary DPC routines, otherwise skipped.
set /p staticfreq="Is your cpu set to a static frequency? y/n: "

IF /i staticfreq==y powercfg /setacvalueindex scheme_current 54533251-82be-4824-96c1-47b60b740d00 4d2b0152-7d5c-498b-88e2-34345392a2c5 5000 && echo Setting processor performance time check interval to 5000
IF /i staticfreq==n goto idlestate

goto idlestate

:idlestate
REM Asks the user if Hyperthreading/SMT is enabled. If yes, skipped. If no, Processor idle states are disabled.
set /p idle="Is Hyperthreading (Intel) / SMT (AMD) enabled currently? (y/n): "

IF /i idle==y goto end
IF /i idle==n powercfg /setacvalueindex scheme_current 54533251-82be-4824-96c1-47b60b740d00 5d76a2ca-e8c0-402f-a133-2158492d58ad 1 && echo Disabling idle states

goto end

:end
REM Sets the active scheme to the current scheme, so the above changes are applied
powercfg /setactive scheme_current
echo Setting the active scheme to the current scheme this script has just made changes to.
echo:
echo Power settings applied, you may now close this window.

@pause