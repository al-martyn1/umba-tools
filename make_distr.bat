@SETLOCAL ENABLEDELAYEDEXPANSION

@rem VS150COMNTOOLS=C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\Tools\
@rem VS160COMNTOOLS=C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\Tools\

@rem echo %VS150COMNTOOLS%
@rem C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\Tools\

@rem https://devblogs.microsoft.com/setup/vswhere-available/
@rem https://devblogs.microsoft.com/setup/fast-acquisition-of-vswhere/
@rem https://github.com/Microsoft/vswhere

@set MSVC2017_COMNTOOLS=%VS150COMNTOOLS%\
@set MSVC2019_COMNTOOLS=%VS160COMNTOOLS%\

@set MSVC2017_VSINSTALLDIR=%MSVC2017_COMNTOOLS%\..\..\
@set MSVC2019_VSINSTALLDIR=%MSVC2019_COMNTOOLS%\..\..\

@set MSVC2017_VSIDEInstallDir=%MSVC2017_VSINSTALLDIR%\Common7\IDE\VC\
@set MSVC2019_VSIDEInstallDir=%MSVC2019_VSINSTALLDIR%\Common7\IDE\VC\


@rem call copy_distr_conf_to_msvc2019_out.bat


@set DISTR_ROOT=.distr
@if not exist %DISTR_ROOT% mkdir %DISTR_ROOT%

@set DISTR_NAME=umba-tools
@set MAIN_EXE_NAME=umba-brief-scanner
@set BUILD_OUTPUT_ROOT=.out\msvc2019


:TRY_X64_DEBUG
@if not exist %BUILD_OUTPUT_ROOT%\x64\Debug\%MAIN_EXE_NAME%.exe goto TRY_X64_RELEASE
@rem call :MK_DISTR x64 Debug msvc2019_64


:TRY_X64_RELEASE
@if not exist %BUILD_OUTPUT_ROOT%\x64\Release\%MAIN_EXE_NAME%.exe goto TRY_X86_DEBUG
@call :MK_DISTR x64 Release msvc2019_64


:TRY_X86_DEBUG
@if not exist %BUILD_OUTPUT_ROOT%\x86\Debug\%MAIN_EXE_NAME%.exe goto TRY_X86_RELEASE
@rem call :MK_DISTR x86 Debug msvc2019

:TRY_X86_RELEASE
@if not exist %BUILD_OUTPUT_ROOT%\x86\Release\%MAIN_EXE_NAME%.exe goto END
@call :MK_DISTR x86 Release msvc2019

goto END



:MK_DISTR

@set PLATFORM=%1
@set CONFIGURATION=%2
@set QTSUBPATH=%3
@set WINDEPLOYQTRELOPT=%2
@call :LoCase WINDEPLOYQTRELOPT
@set LCCONFIGURATION=%CONFIGURATION%
@call :LoCase LCCONFIGURATION

@echo Make distr for %PLATFORM%-%CONFIGURATION%, Qt Config: %QTSUBPATH%, deploy opt - %WINDEPLOYQTRELOPT%

@if exist %DISTR_ROOT%\%PLATFORM% rd /S /Q %DISTR_ROOT%\%PLATFORM%

@set BUILD_OUTPUT=%BUILD_OUTPUT_ROOT%\%PLATFORM%\%CONFIGURATION%
@rem set TARGET_ROOT=%DISTR_ROOT%\%PLATFORM%\%CONFIGURATION%\%MAIN_EXE_NAME%
@set TARGET_ROOT=%DISTR_ROOT%\%PLATFORM%\%CONFIGURATION%\%DISTR_NAME%
@set RD_ROOT=%DISTR_ROOT%\%PLATFORM%
@set ZIP_ROOT=%DISTR_ROOT%\%PLATFORM%\%CONFIGURATION%

@mkdir %TARGET_ROOT%\bin
@xcopy /Y /S /E /I /F /R  ..\umba-2c\_distr_conf\conf\*                                                 %TARGET_ROOT%\conf
@xcopy /Y /S /E /I /F /R  ..\umba-brief-scanner\_distr_conf\conf\*                                      %TARGET_ROOT%\conf
@xcopy /Y /S /E /I /F /R  ..\umba-enum-gen\_distr_conf\conf\*                                           %TARGET_ROOT%\conf
@copy /Y                  ..\umba-pretty-headers\_distr_conf\conf\umba-pretty-headers.custom.options    %TARGET_ROOT%\conf\umba-pretty-headers.custom.options.example
@copy /Y                  ..\umba-sort-headers\_distr_conf\conf\umba-sort-headers.options               %TARGET_ROOT%\conf\umba-sort-headers.options
@copy /Y                  ..\umba-tabtool\_distr_conf\conf\umba-tabtool.options                         %TARGET_ROOT%\conf\umba-tabtool.options

@copy %BUILD_OUTPUT%\umba-2c.exe                %TARGET_ROOT%\bin\umba-2c.exe
@copy %BUILD_OUTPUT%\umba-brief-scanner.exe     %TARGET_ROOT%\bin\umba-brief-scanner.exe
@copy %BUILD_OUTPUT%\umba-enum-gen.exe          %TARGET_ROOT%\bin\umba-enum-gen.exe
@copy %BUILD_OUTPUT%\umba-make-headers.exe      %TARGET_ROOT%\bin\umba-make-headers.exe
@copy %BUILD_OUTPUT%\umba-pretty-headers.exe    %TARGET_ROOT%\bin\umba-pretty-headers.exe
@copy %BUILD_OUTPUT%\umba-sort-headers.exe      %TARGET_ROOT%\bin\umba-sort-headers.exe
@copy %BUILD_OUTPUT%\umba-subst-macros.exe      %TARGET_ROOT%\bin\umba-subst-macros.exe
@copy %BUILD_OUTPUT%\umba-tabtool.exe           %TARGET_ROOT%\bin\umba-tabtool.exe
@copy %BUILD_OUTPUT%\umba-tr.exe                %TARGET_ROOT%\bin\umba-tr.exe
@copy %BUILD_OUTPUT%\qt_stub.exe                %TARGET_ROOT%\bin\qt_stub.exe


@if not exist %TARGET_ROOT%\doc             mkdir %TARGET_ROOT%\doc
@if not exist %TARGET_ROOT%\doc\cli-help    mkdir %TARGET_ROOT%\doc\cli-help

%TARGET_ROOT%\bin\umba-2c.exe               --help >%TARGET_ROOT%\doc\cli-help\umba-2c.txt               || goto FAIL
%TARGET_ROOT%\bin\umba-brief-scanner.exe    --help >%TARGET_ROOT%\doc\cli-help\umba-brief-scanner.txt    || goto FAIL
%TARGET_ROOT%\bin\umba-enum-gen.exe         --help >%TARGET_ROOT%\doc\cli-help\umba-enum-gen.txt         || goto FAIL
%TARGET_ROOT%\bin\umba-make-headers.exe     --help >%TARGET_ROOT%\doc\cli-help\umba-make-headers.txt     || goto FAIL
%TARGET_ROOT%\bin\umba-pretty-headers.exe   --help >%TARGET_ROOT%\doc\cli-help\umba-pretty-headers.txt   || goto FAIL
%TARGET_ROOT%\bin\umba-sort-headers.exe     --help >%TARGET_ROOT%\doc\cli-help\umba-sort-headers.txt     || goto FAIL
%TARGET_ROOT%\bin\umba-subst-macros.exe     --help >%TARGET_ROOT%\doc\cli-help\umba-subst-macros.txt     || goto FAIL
%TARGET_ROOT%\bin\umba-tabtool.exe          --help >%TARGET_ROOT%\doc\cli-help\umba-tabtool.txt          || goto FAIL
%TARGET_ROOT%\bin\umba-tr.exe               --help >%TARGET_ROOT%\doc\cli-help\umba-tr.txt               || goto FAIL
@if exist doc\umba-tools-brief-ru.txt       copy /Y doc\umba-tools-brief-ru.txt %TARGET_ROOT%\doc\umba-tools-brief-ru.txt
@if exist doc\umba-tools-brief-en.txt       copy /Y doc\umba-tools-brief-en.txt %TARGET_ROOT%\doc\umba-tools-brief-en.txt


@if exist version.txt del version.txt
@%BUILD_OUTPUT%\%MAIN_EXE_NAME%.exe -v >version.txt
@set /P VERSION=<version.txt
@echo Version (from version.txt): %VERSION%
@rem del version.txt


set "VCINSTALLDIR=%MSVC2019_VSINSTALLDIR%\VC"
@rem set "VCIDEInstallDir=%MSVC2019_VSIDEInstallDir%\VC"

@set WINDEPLOYQT=%MSVC2019_QTROOT%\%QTSUBPATH%\bin\windeployqt.exe
@%WINDEPLOYQT% >windeployqt.txt

rem set "VCINSTALLDIR=%MSVC2019_VSINSTALLDIR%\VC"
@%WINDEPLOYQT% --%WINDEPLOYQTRELOPT% --compiler-runtime %TARGET_ROOT%\bin\  > windeployqt-%PLATFORM%-%CONFIGURATION%.log 2>&1

set CLANG_INCLUDE=G:\llvm-built\msvc2019\x64\Release\lib\clang\13.0.1\include
@if not exist %CLANG_INCLUDE% goto NO_CLANG_ICLUDES
@xcopy /Y /S /E /I /F /R %CLANG_INCLUDE%\* %TARGET_ROOT%\lib\clang\13.0.1\include

:NO_CLANG_ICLUDES

@del %TARGET_ROOT%\bin\qt_stub.exe
@rd /S /Q   %TARGET_ROOT%\bin\translations
@del /S /Q  %TARGET_ROOT%\bin\Qt5*.dll

@set ZIPDISTRNAME=%DISTR_NAME%_windows_%PLATFORM%_%LCCONFIGURATION%_%VERSION%.zip
@echo Zip: %ZIPDISTRNAME%

@set ZIP_TARGET_FOLDER=%TARGET_ROOT%\..
@echo ZIP_TARGET_FOLDER: %ZIP_TARGET_FOLDER%
@rem Be good zip %DISTR_ROOT%\%ZIPDISTRNAME% -r %ZIP_TARGET_FOLDER%.zip %TARGET_ROOT%
@rem zip %ZIP_ROOT%\%ZIPDISTRNAME% -r %ZIP_TARGET_FOLDER%.zip %TARGET_ROOT%
@cd %ZIP_TARGET_FOLDER%
@echo Calling ZIP: zip %ZIPDISTRNAME% -r %ZIPDISTRNAME% %DISTR_NAME%
@zip %ZIPDISTRNAME% -r %ZIPDISTRNAME% %DISTR_NAME%
@move %ZIPDISTRNAME% ..\..
@cd ..\..\..
@rem echo RD_ROOT = %RD_ROOT%
@rd /S /Q %RD_ROOT%

@exit /b





@rem https://www.robvanderwoude.com/battech_convertcase.php
:LoCase
@rem Subroutine to convert a variable VALUE to all lower case.
@rem  The argument for this subroutine is the variable NAME.
@SET %~1=!%~1:A=a!
@SET %~1=!%~1:B=b!
@SET %~1=!%~1:C=c!
@SET %~1=!%~1:D=d!
@SET %~1=!%~1:E=e!
@SET %~1=!%~1:F=f!
@SET %~1=!%~1:G=g!
@SET %~1=!%~1:H=h!
@SET %~1=!%~1:I=i!
@SET %~1=!%~1:J=j!
@SET %~1=!%~1:K=k!
@SET %~1=!%~1:L=l!
@SET %~1=!%~1:M=m!
@SET %~1=!%~1:N=n!
@SET %~1=!%~1:O=o!
@SET %~1=!%~1:P=p!
@SET %~1=!%~1:Q=q!
@SET %~1=!%~1:R=r!
@SET %~1=!%~1:S=s!
@SET %~1=!%~1:T=t!
@SET %~1=!%~1:U=u!
@SET %~1=!%~1:V=v!
@SET %~1=!%~1:W=w!
@SET %~1=!%~1:X=x!
@SET %~1=!%~1:Y=y!
@SET %~1=!%~1:Z=z!
@exit /b




:END
@exit /b


:FAIL
@echo.
@echo Something goes wrong
@echo.
@echo.
@echo.
@exit /b 1

