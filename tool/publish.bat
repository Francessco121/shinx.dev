@echo off
setlocal

rem Enter project root
cd ..

rem Build the project
echo Building...
call pub run build_runner build -o build -r

rem Save the dev commit hash for later
for /F "delims=" %%i in ('git rev-parse HEAD') do set commitHash=%%i

rem Enter build web directory
cd build\web

rem Delete unnecessary packages sym link
echo Deleting packages sym link...
rmdir packages

rem Initialize a git repo
echo Initializing git repository...
call git init
call git remote add origin https://github.com/Francessco121/francessco121.github.io.git
call git fetch

rem Reset to master
echo Resetting to master...
call git reset --mixed origin/master

rem Commit changes
echo Commiting...
call git add .
call git commit -m "Deploy from dev/%commitHash%"

rem Push
echo "Pushing..."
call git push --set-upstream origin master

rem All done!
echo Successfully deployed!
pause

endlocal
