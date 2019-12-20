@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )
title francessco.us Proxy
cd ..
pub run tool/proxy.dart