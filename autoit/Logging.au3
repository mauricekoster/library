#include-once

Local $prvMsg
Local $prvLogLevel = 0
Local $prvLogMode = 0

Dim $do_console = False ; mode = 4
Dim $do_debugview = False ; mode = 8
Dim $do_file = False ; mode = 2
Dim $log_begin = False

Func _IIf($condition, $truepart, $falsepart)
	If $condition Then
		Return $truepart
	Else
		Return $falsepart
	EndIf
EndFunc   ;==>_IIf

#Region Output

Func OutputDebug($msg)

	;Output to application attaching a console to the script engine
	ConsoleWrite($msg & @CRLF)
	;Output to debugger (dbgview.exe)
	OutputDebugString($msg)

EndFunc   ;==>OutputDebug

Func OutputDebugString($msg)
	DllCall("kernel32.dll", "none", "OutputDebugString", "str", $msg)
EndFunc   ;==>OutputDebugString

#EndRegion Output


#Region Log functies

Func LogLevel()
	if $prvLogLevel = 0 Then
		$l = RegRead("HKEY_CURRENT_USER\Software\VB and VBA Program Settings\All\Logging", "Level")
		if @error <> 0 Then
			$prvLogLevel = 1 ; Error
		Else
			Switch $l
				Case "ERROR"
					$prvLogLevel = 1
				Case "WARNING"
					$prvLogLevel = 2
				Case "INFO"
					$prvLogLevel = 3
				Case "DEBUG"
					$prvLogLevel = 4

			EndSwitch
		EndIf
		;OutputDebug( "! LogLevel: " & $prvLogLevel )
	EndIf
	Return $prvLogLevel
EndFunc   ;==>LogLevel

Func LogMode()
	if $prvLogMode = 0 Then
		$l = RegRead("HKEY_CURRENT_USER\Software\VB and VBA Program Settings\All\Logging", "Mode")
		if @error <> 0 Then
			$prvLogMode = 4 ; Console
		else
			$prvLogMode = $l
		endif

		if BitAND($prvLogMode, 2) > 0 then
			$do_file = True
		EndIf
		if BitAND($prvLogMode, 4) > 0 then
			$do_console = True
		EndIf
		if BitAND($prvLogMode, 8) > 0 then
			$do_debugview = True
		EndIf

	EndIf
	Return $prvLogMode
EndFunc   ;==>LogMode

Func __log_console_message($msg, $donewline = True)
	if $do_console then
		if $log_begin Then
			ConsoleWrite(@CRLF)
			$log_begin = False
		EndIf
		ConsoleWrite($msg)
		if $donewline Then ConsoleWrite(@CRLF)

	EndIf
EndFunc   ;==>__log_console_message

Func __log_debugview_message($msg)
	if $do_debugview then
		OutputDebugString($msg & @CRLF)
	EndIf
EndFunc   ;==>__log_debugview_message

Func LogError($msg)
	LogMode()
	__log_console_message("! " & $msg)
	__log_debugview_message("[error] " & $msg)
EndFunc   ;==>LogError

Func LogWarning($msg)
	LogMode()
	If LogLevel() >= 2 Then
		__log_console_message("- " & $msg)
		__log_debugview_message("[warning] " & $msg)
	EndIf
EndFunc   ;==>LogWarning

Func LogInfo($msg)
	LogMode()
	If LogLevel() >= 3 Then
		__log_console_message("* " & $msg)
		__log_debugview_message("[info] " & $msg)
	EndIf
EndFunc   ;==>LogInfo

Func LogDebug($msg)
	LogMode()
	If LogLevel() >= 4 Then
		__log_console_message("> " & $msg)
		__log_debugview_message("[debug] " & $msg)
	EndIf
EndFunc   ;==>LogDebug

Func LogBegin($msg)
	LogMode()

	__log_console_message("+> " & StringFormat("%-100s : ", $msg), False)
	$log_begin = True
	$prvMsg = $msg
EndFunc   ;==>LogBegin

Func LogEnd($errcode = 0)
	LogMode()
	$msg = "[ " & _IIf($errcode = 0, "ok", "!!") & " ]"
	if not $log_begin Then
		$msg = "+ END> " & StringFormat("%-96s : ", "") & $msg
	EndIf
	$log_begin = False
	__log_console_message($msg)
	__log_debugview_message($prvMsg & " " & $msg)
	$log_begin = False
EndFunc   ;==>LogEnd


#EndRegion Log functies

#Region test functie
Func _TestOuputDebug()
	LogError("ERROR")
	LogWarning("WARNING")
	LogInfo("INFO")
	LogDebug("DEBUG")

	LogBegin("Test error")
	Sleep(2000)
	LogEnd()

	LogBegin("Test error")
	Sleep(2000)
	LogInfo("Bla bla")
	Sleep(2000)
	LogEnd()

EndFunc   ;==>_TestOuputDebug


_TestOuputDebug()

#EndRegion test functie
