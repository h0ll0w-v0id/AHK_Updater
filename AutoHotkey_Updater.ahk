; AutoHotkey Updater

; version 1.0.0
; tested on Windows 7 64bit, with AHK 1.1.16.5

; I started this project to better understand TaskDialogs
; and so I based code off of what TheGood and just me
; had developed...

; this script requires TaskDialog - written by TheGood
;  http://www.autohotkey.com/board/topic/54555-taskdialog-stdlib-compatible/

; for a way better AutoHotkey Update program, refer to the one that Lexikos made
; http://l.autohotkey.net/Update.ahk

#include TaskDialog.ahk
#SingleInstance Force

; main display label
taskDialog_Main:
	; download server version to temp file
	UrlDownloadToFile, http://ahkscript.org/download/1.1/version.txt,AutoHotkey_Updater_tmp.txt
	; read in file
	FileRead, Contents, AutoHotkey_Updater_tmp.txt
	; if read was successful
	If Not ErrorLevel
	{
		Latest_AhkVersion := Contents
		; remove temp file
		FileDelete, AutoHotkey_Updater_tmp.txt
		; free memory
		Contents =
	}
	; if new version is available
	If ( A_AhkVersion < Latest_AhkVersion )
	{
		iButtonID := TaskDialog("", "AutoHotkey Update||A new version of AutoHotkey is available!`n"
		 					. "||Installed version " A_AhkVersion, "Download latest version " Latest_AhkVersion
							. "`nClick to open the webpage" 
		  					. "|View ""Changes and New Features""`nClick to open the webpage|Exit", 0x10, "GREY")
		; custom button 1 - set to go to download webpage
		If ( iButtonID == 1001 )
		{
			Run, http://ahkscript.org/download/
		}
		; custom button 2 - set to go to changelog webpage
		Else If ( iButtonID == 1002 )
		{
			Run, http://ahkscript.org/docs/AHKL_ChangeLog.htm
		}
		; custom button 3 - set to close
		Else If ( iButtonID == 1003 )
		{
			ExitApp
		}
	}
	; if version installed is the latest
	Else If ( A_AhkVersion >= Latest_AhkVersion )
	{
		iButtonID := TaskDialog("", "AutoHotkey Update||Your copy of AutoHotkey is up to date."
							. "`n||Installed version " A_AhkVersion "`nLatest version " Latest_AhkVersion, "Exit", 0x10, "GREEN")
		; custom button 1 - set to close
		If ( iButtonID == 1001 )
		{
			ExitApp
		}	
		
	}
ExitApp
