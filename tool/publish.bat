@echo off
setlocal

rem Enter project root
cd ..

rem Build the project
echo Building...
rmdir /Q /S build
call dart run build_runner build -o web:build -r

rem Save the dev commit hash for later
for /F "delims=" %%i in ('git rev-parse HEAD') do set commitHash=%%i

rem Enter build web directory
cd build

rem Delete unnecessary packages folder
echo Deleting packages folder...
rmdir /Q /S packages

rem Delete unnecessary build metadata
echo Deleting build metadata...
del .build.manifest
del .packages
rmdir /Q /S .dart_tool

rem Initialize a git repo
echo Initializing git repository...
call git init -b master
call git remote add origin https://github.com/Francessco121/shinx.dev.git
call git fetch

rem Reset to master
echo Resetting to master...
call git reset --mixed origin/master

rem Commit changes
echo Commiting...
call git add .
call git commit -m "Deploy from %commitHash%"

rem Push
echo Pushing...
call git push --set-upstream origin master

rem All done!
echo Successfully deployed!
pause

endlocal
