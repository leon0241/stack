#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

global toggle := false
global currentKeys := " "

global exceptions := ["(", "+", "-", "*", "/", "^", " "]
global inceptions := ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "x", "y"]

^F6::
  if(toggle == false) {
    toggle := true
    ; Gui, New, +AlwaysOnTop, STACK Mode
    ; Gui, add, Text, ,STACK Mode Running
    ; Gui, add, Text, vcurrentKeys, % "Current Key: " . currentKeys
    ; Gui, show, W200 H50 X0 Y0 NoActivate
    makeGUI()
  } else {
    ; Send, "test"
    toggle := false
    Gui, 1: Destroy
  }
return



checkKey(state) {
  if (state == true) {
    for i, elem in exceptions{
      if (currentKeys == elem) {
        return True
      }
    }
    return False
  } else {
    for i, elem in inceptions{
      if (currentKeys == elem) {
        return False
      }
    }
    return True
  }
}

; cba doing gui atm maybe later lol

makeGUI() {
  GUI_X = 200
  GUI_Y = 200

  SysGet, ScreenRes, MonitorWorkArea 
  screenResX := ScreenResRight - GUI_X 
  screenResY := ScreenResBottom - GUI_Y 

  Gui, 1: New, +AlwaysOnTop, STACK Mode
  Gui, add, Text, ,STACK Mode Running
  ; Gui, add, Text, vcurrentKeys, % "Current Key: " . currentKeys
  Gui, show, W%GUI_X% H%GUI_Y% X%screenResX% Y%screenResY% NoActivate
  return
}

basicPrint(letter) {
  Send, % letter

  ; currentKeys.remove(1)
  ; currentKeys.push(letter)
  currentKeys := letter
}

bracketPrint(phrase) {
  Send, % phrase
  SendInput,{Left 1}
  currentKeys := "("
}

GuiClose:
  toggle := false
  Gui, 1: Destroy
return


#If (toggle == true)
LButton::
  Send {LButton}
  currentKeys := " "
return

Left::
  SendInput, {Left 1}
  currentKeys := " "
return

Right::
  SendInput, {Right 1}
  currentKeys := " "
return

^2::
  bracketPrint("{^}()")
return

+2::
  Send, % "^(2)"
  currentKeys := ")"
return

^e::
  bracketPrint("exp()")
return

^s::
  bracketPrint("sin()")
return

^+s::
  bracketPrint("asin()")
return

^c::
  bracketPrint("cos()")
return

+^c::
  bracketPrint("acos()")
return

^t::
  bracketPrint("tan()")
return

+^t::
  bracketPrint("atan()")
return

$(::
  if(checkKey(false) == True) {
    bracketPrint("()")
  } else {
    bracketPrint("*()")
  }
return


$x::
  if(checkKey(false) == True) {
    Send, % "x"
  } else {
    Send, % "*x"
  }
  currentKeys := "x"
return


$y::
  if(checkKey(false) == True) {
    Send, % "y"
  } else {
    Send, % "*y"
  }
  currentKeys := "y"
return

$1::
  basicPrint("1")
return

$2::
  basicPrint("2")
return

$3::
  basicPrint("3")
return

$4::
  Send, % "4"
  currentKeys := "4"
return

$5::
  Send, % "5"
  currentKeys := "5"
return

$6::
  Send, % "6"
  currentKeys := "6"
return

$7::
  Send, % "7"
  currentKeys := "7"
return

$8::
  Send, % "8"
  currentKeys := "8"
return

$9::
  Send, % "9"
  currentKeys := "9"
return

$0::
  Send, % "0"
  currentKeys := "0"
return

$Space::
  Send, % " "
  currentKeys := " "
return

$+::
  Send, {+}
  currentKeys := "+"
return

$-::
  Send, % "-"
  currentKeys := "-"
return

$*::
  Send, % "*"
  currentKeys := "*"
return

$/::
  Send, % "/"
  currentKeys := "/"
return

$^::
  Send, {^}
  currentKeys := "^"
return