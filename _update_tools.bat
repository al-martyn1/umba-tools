@cd ..
@call :DO_JOB umba-brief-scanner
@call :DO_JOB umba-make-headers
@call :DO_JOB umba-pretty-headers
@call :DO_JOB umba-sort-headers
@call :DO_JOB umba-subst-macros
@cd umba-tools
@exit /B


:DO_JOB
@echo Updating %1
@set "CUR_PATH=%cd%"
@rem echo Current path: %CUR_PATH%
@if not exist %1 goto DONE
@cd %1
@echo Updating %1 tool main sources
@git pull
@if not exist _libs goto DONE_UP1
@if not exist _libs\update_libs.bat goto DONE_UP1
@echo Updating %1 tool libs
@set "CUR_PATH=%cd%"
@rem echo Calling _libs\update_libs.bat, path: %CUR_PATH%
@cd _libs
@call update_libs.bat
@goto DONE_UP2


:DONE_UP3
@set "CUR_PATH=%cd%"
@rem echo DONE_UP3, path: %CUR_PATH%, go to upper level
@cd ..

:DONE_UP2
@set "CUR_PATH=%cd%"
@rem echo DONE_UP2, path: %CUR_PATH%, go to upper level
@cd ..

:DONE_UP1
@set "CUR_PATH=%cd%"
@rem echo DONE_UP1, path: %CUR_PATH%, go to upper level
@cd ..

:DONE
@echo.
@echo.
@exit /B
