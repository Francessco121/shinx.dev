@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )
title shinx.dev (Debug)
cd ..
webdev serve