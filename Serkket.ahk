﻿#NoEnv
; #Warn
SendMode Input
SetWorkingDir %A_ScriptDir%
if !FileExist("Servers") {
FileCreateDir, Servers
}
SetWorkingDir Servers
; It's pronounced "Circut" not "sEErket"
RunWait cmd.exe /c "dir /B /A:D>List.txt"
FileRead, List, List.txt
FileDelete, List.txt
InputBox, UserInput, Server, Please enter the name of a server you want to run `n Some available servers are: `n %List% `n You can also make a new one by typing its name, , 640, 480
if ErrorLevel
ExitApp 0
else
if !FileExist(%UserInput%) {
FileCreateDir, %UserInput%
}
SetWorkingDir %UserInput%
if !FileExist("spigot-1.16.5.jar") {
UrlDownloadToFile, https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar, BuildTools.jar
RunWait, cmd.exe /c "java -jar BuildTools.jar --rev 1.16.5", C:\Windows\System32, Hide
FileDelete, Buildtools.jar
}
if !FileExist("Tunnel.exe") {
UrlDownloadToFile, https://playit.gg/downloads/playit-win_64-0.4.3-rc2.exe, Tunnel.exe
}
if !FileExist("eula.txt") {
FileAppend, eula=true, eula.txt
}
if !FileExist("Run.bat") {
FileAppend,
(
@echo off
Title Serkket Server v0.1.3
color 03
cls
Run Tunnel.exe
java -Xmx4G -XX:+UnlockExperimentalVMOptions -jar spigot-1.16.5.jar nogui
taskkill /F /IM Tunnel.exe
color 04
echo Server Stopped.
pause>nul
), Run.Bat
}
Run, Run.Bat

