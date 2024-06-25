@set TOOLSET=%1

:CHECK_TOOLSET_MSVC2019
@if not "%TOOLSET%"=="msvc2019" goto CHECK_TOOLSET_MSVC2022
@goto TOOLSET_GOOD

:CHECK_TOOLSET_MSVC2022
@if not "%TOOLSET%"=="msvc2022" goto CHECK_TOOLSET_MSVC2025
@goto TOOLSET_GOOD

:CHECK_TOOLSET_MSVC2025
@echo "Unknown MSVC version taken"
@goto ERR

:TOOLSET_GOOD

@if not exist %~dp0\.out @mkdir                       %~dp0\.out
@if not exist %~dp0\.out\%TOOLSET% @mkdir             %~dp0\.out\%TOOLSET%
@if not exist %~dp0\.out\%TOOLSET%\x86 @mkdir         %~dp0\.out\%TOOLSET%\x86
@if not exist %~dp0\.out\%TOOLSET%\x64 @mkdir         %~dp0\.out\%TOOLSET%\x64
@if not exist %~dp0\.out\%TOOLSET%\x86\Release @mkdir %~dp0\.out\%TOOLSET%\x86\Release
@if not exist %~dp0\.out\%TOOLSET%\x86\Debug   @mkdir %~dp0\.out\%TOOLSET%\x86\Debug
@if not exist %~dp0\.out\%TOOLSET%\x64\Release @mkdir %~dp0\.out\%TOOLSET%\x64\Release
@if not exist %~dp0\.out\%TOOLSET%\x64\Debug   @mkdir %~dp0\.out\%TOOLSET%\x64\Debug


set BUILD_BAT_NAME=_build_all_%TOOLSET%.bat

@cd %~dp0\..
@echo Scanning directory:
@cd

@for /F %%i in ('dir /B /A:D') do @(
    @echo Looking for: %~dp0\..\%%i\%BUILD_BAT_NAME%
    @if exist %~dp0\..\%%i\%BUILD_BAT_NAME% @(
    @echo Script found && @cd %~dp0\..\%%i && @call %BUILD_BAT_NAME% && @cd %~dp0\..
        @if ERRORLEVEL 1 goto ERR_GO_BACK
        if exist %~dp0\..\%%i\.out\\%TOOLSET%\\x86\Release\*.exe  copy /B /Y %~dp0\..\%%i\.out\\%TOOLSET%\\x86\Release\*.exe  %~dp0\.out\%TOOLSET%\x86\Release
        if exist %~dp0\..\%%i\.out\\%TOOLSET%\\x86\Debug\*.exe    copy /B /Y %~dp0\..\%%i\.out\\%TOOLSET%\\x86\Debug\*.exe    %~dp0\.out\%TOOLSET%\x86\Debug  
        if exist %~dp0\..\%%i\.out\\%TOOLSET%\\x64\Release\*.exe  copy /B /Y %~dp0\..\%%i\.out\\%TOOLSET%\\x64\Release\*.exe  %~dp0\.out\%TOOLSET%\x64\Release
        if exist %~dp0\..\%%i\.out\\%TOOLSET%\\x64\Debug\*.exe    copy /B /Y %~dp0\..\%%i\.out\\%TOOLSET%\\x64\Debug\*.exe    %~dp0\.out\%TOOLSET%\x64\Debug  
    )
)

:ERR
exit /b 1

:ERR_GO_BACK
@cd %~dp0
exit /b 1

:END
exit /b 0

