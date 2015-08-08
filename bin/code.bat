@echo off
powershell -ExecutionPolicy RemoteSigned -File %~DP0..\code.ps1 %1
