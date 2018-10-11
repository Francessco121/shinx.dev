@echo off

rem Build the project
pub run build_runner build -o build -r

rem Save the dev commit hash for later
for /F "delims=" %i in ('git rev-parse HEAD') do set commitHash=%i

rem Enter build web directory
cd build\web

rem Delete unnecessary packages sym link
rmdir packages

rem Initialize a git repo
git init
git remote add origin https://github.com/Francessco121/francessco121.github.io.git
git fetch

rem Reset to master
git reset --mixed origin/master

rem Commit changes
git add .
git commit -m "Deploy from dev/%variable%"

rem Push
git push

rem All done!
pause
