@echo off
setlocal enabledelayedexpansion

cd /d %~dp0

set "collections=Alpha.json SIMPLICIALLpostmancollectionNewman.json alphaEnum_contribution_Portfolio-onerld.postman_collection.json"
set "failed=0"

:: Create/empty the report file
set "reportFile=consolidated_report.txt"
echo > %reportFile%

:: Loop through each collection
for %%c in (%collections%) do (
    echo Running %%c...
    newman run %%c > temp_output.txt
    if errorlevel 1 (
        echo %%c failed >> %reportFile%
        set /a failed+=1
    ) else (
        echo %%c passed >> %reportFile%
    )
    
    :: Append collection results to the report file
    echo --- Results for %%c --- >> %reportFile%
    type temp_output.txt >> %reportFile%
    echo. >> %reportFile%
)

:: Check for any failures
if %failed% gtr 0 (
    echo Some collections failed
    echo Some collections failed >> %reportFile%
) else (
    echo All collections passed
    echo All collections passed >> %reportFile%
)

:: Clean up temporary file
del temp_output.txt

exit 0
