@echo off
setlocal enabledelayedexpansion

set "collections=Alpha.json alphaEnum_contribution_Portfolio-onerld.postman_collection.json SIMPLICI-ALL.postman_collection.json"

set "failed=0"

for %%c in (%collections%) do (
    echo Running %%c...
    newman run %%c
    if errorlevel 1 (
        echo %%c failed
        set /a failed+=1
    )
)

if %failed% gtr 0 (
    echo Some collections failed
) else (
    echo All collections passed
)

exit 0
