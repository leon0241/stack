#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Script activation toggle
global toggle := false

; Previous key - used to recognise if asterisk is needed
global currentKeys := " "

; blacklist and whitelist
global exceptions := ["(", "+", "-", "*", "/", "^", " "]
global inceptions := ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "x", "y"]

; Activation Hotkey
^F6::
  ; Toggle statement checker
  if(toggle == false) {
    toggle := true
    ; Make GUI
    makeGUI()
  } else {
    toggle := false
    ; Destroy the GUI
    Gui, 1: Destroy
  }
return

; Check if key is in blacklist/whitelist (param for whichever one it is)
checkKey(state) {
  ; return true if previous key is in whitelist(currently not in use)
  if (state == true) {
    for i, elem in exceptions{
      if (currentKeys == elem) {
        return True
      }
    }
    return False

  ; return true if previous key isn't in blacklist
  } else {
    for i, elem in inceptions{
      if (currentKeys == elem) {
        return False
      }
    }
    return True
  }
}

; GUI Design
makeGUI() {
  ; Size of GUI
  GUI_X := 69 * 4.2
  GUI_Y := 69 * 5

  ; Get offset off gui from monitor size
  SysGet, ScreenRes, MonitorWorkArea 
  screenResX := ScreenResRight - GUI_X 
  screenResY := ScreenResBottom - GUI_Y 

  ; GUI Design
  Gui, 1: New, +AlwaysOnTop, STACK Mode
  Gui, Font,, Verdana
  Gui, font, s16
  Gui, add, Text, ,% "STACK Mode Running"
  Gui, font, s14
  Gui, add, Text, ,% "Shortcuts:" 
  Gui, font, s11
  Gui, add, Text, ,% "exponent - Ctrl + 2"
  Gui, add, Text, ,% "square - Shift + 2"
  Gui, add, Text, ,% "e^ - Ctrl + e"
  Gui, add, Text, ,% "sin/cos/tan - Ctrl + s/c/t"
  Gui, add, Text, ,% "trig inverse - Ctrl + Alt + s/c/t"
  Gui, show, W%GUI_X% H%GUI_Y% X%screenResX% Y%screenResY% NoActivate
  return
}

; stop the program if the gui is closed
GuiClose:
  toggle := false
  Gui, 1: Destroy
return

; Send a letter and set currentKeys to the letter
basicPrint(letter) {
  Send, % letter
  currentKeys := letter
  ; currentKeys.remove(1)
  ; currentKeys.push(letter)
}

; Send a phrase with a bracket, then move caret back to edit
bracketPrint(phrase) {
  Send, % phrase
  SendInput,{Left 1}
  currentKeys := "("
}

;-------------------;
;                   ;
;    Hotkey list    ;
;                   ;
;-------------------;

; Hotkeys below only activate if toggle is true
#If (toggle == true)

; Reset if mouse is clicked or position is changed
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

; ----------;
; SHORTCUTS ;
; ----------;


^2::
  bracketPrint("{^}()")
return

+2::
  Send, % "{^}(2)"
  currentKeys := ")"
return

^e::
  bracketPrint("exp()")
return

^s::
  bracketPrint("sin()")
return

^!s::
  bracketPrint("asin()")
return

^c::
  bracketPrint("cos()")
return

^!c::
  bracketPrint("acos()")
return

^t::
  bracketPrint("tan()")
return

^!t::
  bracketPrint("atan()")
return

; ----------------;
; INDIVIDUAL KEYS ;
; ----------------;

; Keys with asterisk handling

$(::
  if(checkKey(false) == False) {
    bracketPrint("*()")
  } else {
    bracketPrint("()")
  }
return


$x::
  if(checkKey(false) == False) {
    Send, % "*x"
  } else {
    Send, % "x"
  }
  currentKeys := "x"
return


$y::
  if(checkKey(false) == False) {
    Send, % "*y"
  } else {
    Send, % "y"
  }
  currentKeys := "y"
return


; Rest of keys

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
  basicPrint("4")
return

$5::
  basicPrint("5")
return

$6::
  basicPrint("6")
return

$7::
  basicPrint("7")
return

$8::
  basicPrint("8")
return

$9::
  basicPrint("9")
return

$0::
  basicPrint("0")
return

$Space::
  basicPrint(" ")
return

$-::
  basicPrint("-")
return

$*::
  basicPrint("*")
return

$/::
  basicPrint("/")
return

; Special symbols so need their own thing

$+::
  Send, % "{+}"
  currentKeys := "+"
return

$^::
  Send, % "{^}"
  currentKeys := "^"
return