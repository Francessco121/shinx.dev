@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )
title shinx.dev Proxy
cd ..
dart run tool/proxy.dart