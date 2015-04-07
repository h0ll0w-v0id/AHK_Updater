/*
	--------------------------------------------------------
	REVISION BLOCK
		
	Project Name: AHK_Updater.ahk
	
	Revision History:
	
	Date		Rev			Change Description
	--------------------------------------------------------
	10/07/14	1.0.0		Beta release
	10/29/14	1.0.1		Updated comments
	--------------------------------------------------------

	Project Overview:
	
		A very simple AutoHotkey script that uses task dialogs to determine
		if AutoHotkey is up to date - using TaskDialog by TheGood
		
		I started this project to better understand TaskDialogs and so
		I based code off of what TheGood and just me had developed...
	
	Project Features:
	
		NA
			
	Project Notes:

		Requires PC Running Windows 7
		
		Requires TaskDialog.ahk
			
	--------------------------------------------------------
*/
; ----------------------------------------------------------
; Info .........: for a more advanced Updater - http://l.autohotkey.net/Update.ahk
; ----------------------------------------------------------
; Include ......: TaskDialog.ahk
; Author .......: TheGood
; Info .........: http://www.autohotkey.com/board/topic/54555-taskdialog-stdlib-compatible/
; ----------------------------------------------------------
#include TaskDialog.ahk
#SingleInstance Force
; ----------------------------------------------------------
; Label ........: Main Label
; ----------------------------------------------------------
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
		iButtonID := TaskDialog(0, "AutoHotkey Update||A new version of AutoHotkey is available!`n"
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
