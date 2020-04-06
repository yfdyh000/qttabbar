::::::::::::::::::::::::::::::::::::::::::::
:: Elevate.cmd - Version 4
:: Automatically check & get admin rights
:: see "https://stackoverflow.com/a/12264592/1016343" for description
::::::::::::::::::::::::::::::::::::::::::::
 @echo off
 CLS
 ECHO.
 ECHO =============================
 ECHO Running Admin shell
 ECHO =============================

:init
 setlocal DisableDelayedExpansion
 set cmdInvoke=1
 set winSysFolder=System32
 set "batchPath=%~0"
 for %%k in (%0) do set batchName=%%~nk
 set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
 setlocal EnableDelayedExpansion

:checkPrivileges
  NET FILE 1>NUL 2>NUL
  if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
  if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
  ECHO.
  ECHO **************************************
  ECHO Invoking UAC for Privilege Escalation
  ECHO **************************************

  ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
  ECHO args = "ELEV " >> "%vbsGetPrivileges%"
  ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
  ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
  ECHO Next >> "%vbsGetPrivileges%"

  if '%cmdInvoke%'=='1' goto InvokeCmd 

  ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
  goto ExecElevation

:InvokeCmd
  ECHO args = "/c """ + "!batchPath!" + """ " + args >> "%vbsGetPrivileges%"
  ECHO UAC.ShellExecute "%SystemRoot%\%winSysFolder%\cmd.exe", args, "", "runas", 1 >> "%vbsGetPrivileges%"

:ExecElevation
 "%SystemRoot%\%winSysFolder%\WScript.exe" "%vbsGetPrivileges%" %*
 exit /B

:gotPrivileges
 setlocal & cd /d %~dp0
 if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)

 ::::::::::::::::::::::::::::
 ::START
 ::::::::::::::::::::::::::::

call VCVarsQueryRegistry.bat 32bit 64bit
cd ..\QTTabBar\bin\%1
IF EXIST QTTabBar.dll (
    gacutil /if QTTabBar.dll
	call %FrameworkDir32%\%FrameworkVersion32%\regasm.exe QTTabBar.dll
    if not "%FrameworkDir64%"=="" (
        call %FrameworkDir64%\%FrameworkVersion64%\regasm.exe QTTabBar.dll
    )
    pause
)
cd ..\..\

cd ..\QTPluginLib\bin\%1
IF EXIST QTPluginLib.dll (
    gacutil /if QTPluginLib.dll
)

cd ..\..\..\BandObjectLib\bin\%1
IF EXIST BandObjectLib.dll (
    gacutil /if BandObjectLib.dll
)
IF EXIST Interop.SHDocVw.dll (
    gacutil /if Interop.SHDocVw.dll
)

cd ..\..\..\QTHookLib\bin\%1
REG ADD HKLM\SOFTWARE\Quizo\QTTabBar /v InstallPath /t REG_SZ /d "%cd%" /f /reg:32
REG ADD HKLM\SOFTWARE\Quizo\QTTabBar /v InstallPath /t REG_SZ /d "%cd%" /f /reg:64

cd ..\..\..\Register
pause