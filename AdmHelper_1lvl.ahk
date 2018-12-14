buildscr = 6 ;������ ��� ���������, ���� ������ ��� � verlen2.ini - ���������
downlurl := "https://github.com/AndyGHF2/SupHelp/blob/master/updt.exe?raw=true"
downllen := "https://github.com/AndyGHF2/SupHelp/blob/master/"

Utf8ToAnsi(ByRef Utf8String, CodePage = 1251)
{
    If (NumGet(Utf8String) & 0xFFFFFF) = 0xBFBBEF
        BOM = 3
    Else
        BOM = 0

    UniSize := DllCall("MultiByteToWideChar", "UInt", 65001, "UInt", 0
                    , "UInt", &Utf8String + BOM, "Int", -1
                    , "Int", 0, "Int", 0)
    VarSetCapacity(UniBuf, UniSize * 2)
    DllCall("MultiByteToWideChar", "UInt", 65001, "UInt", 0
                    , "UInt", &Utf8String + BOM, "Int", -1
                    , "UInt", &UniBuf, "Int", UniSize)

    AnsiSize := DllCall("WideCharToMultiByte", "UInt", CodePage, "UInt", 0
                    , "UInt", &UniBuf, "Int", -1
                    , "Int", 0, "Int", 0
                    , "Int", 0, "Int", 0)
    VarSetCapacity(AnsiString, AnsiSize)
    DllCall("WideCharToMultiByte", "UInt", CodePage, "UInt", 0
                    , "UInt", &UniBuf, "Int", -1
                    , "Str", AnsiString, "Int", AnsiSize
                    , "Int", 0, "Int", 0)
    Return AnsiString
}
WM_HELP(){
    IniRead, vupd, %a_temp%/verlen2.ini, UPD, v
    IniRead, desupd, %a_temp%/verlen2.ini, UPD, des
    desupd := Utf8ToAnsi(desupd)
    IniRead, updupd, %a_temp%/verlen2.ini, UPD, upd
    updupd := Utf8ToAnsi(updupd)
    msgbox, , ������ ��������� ������ %vupd%, %updupd%
    return
}

OnMessage(0x53, "WM_HELP")
Gui +OwnDialogs

SplashTextOn, , 60,��������������, ������ �������. ��������..`n��������� ������� ����������.
URLDownloadToFile, %downllen%, %a_temp%/verlen2.ini
IniRead, buildupd, %a_temp%/verlen2.ini, UPD, build
if buildupd =
{
    SplashTextOn, , 60,��������������, ������ �������. ��������..`n������. ��� ����� � ��������.
    sleep, 2000
}
if buildupd > % buildscr
{
    IniRead, vupd, %a_temp%/verlen2.ini, UPD, v
    SplashTextOn, , 60,��������������, ������ �������. ��������..`n���������� ���������� �� ������ %vupd%!
    sleep, 2000
    IniRead, desupd, %a_temp%/verlen2.ini, UPD, des
    desupd := Utf8ToAnsi(desupd)
    IniRead, updupd, %a_temp%/verlen2.ini, UPD, upd
    updupd := Utf8ToAnsi(updupd)
    SplashTextoff
    msgbox, 16384, ���������� ������� �� ������ %vupd%, %desupd%
    IfMsgBox OK
    {
        msgbox, 1, ���������� ������� �� ������ %vupd%, ������ �� �� ����������?
        IfMsgBox OK
        {
            put2 := % A_ScriptFullPath
            RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\SAMP ,put2 , % put2
            SplashTextOn, , 60,��������������, ����������. ��������..`n��������� ������ �� ������ %vupd%!
            URLDownloadToFile, %downlurl%, %a_temp%/updt.exe
            sleep, 1000
            run, %a_temp%/updt.exe
            exitapp
        }
    }
}
SplashTextoff

InputBox, %name%, AdmHelper_1lvl, ������� ���� ��� (Name_Name)

checkfile2 = %A_MyDocuments%\GTA San Andreas User Files\CR-MP\GenerationC\admhelp.txt
FileAppend %checkfile2%
FileRead, sup, %checkfile2%
FileRead, info, %checkfile%
FileDelete %checkfile%
FileAppend %checkfile%

Loop
{
checkfile2 = %A_MyDocuments%\GTA San Andreas User Files\CR-MP\GenerationC\admhelp.txt
checkfile = %A_MyDocuments%\GTA San Andreas User Files\CR-MP\GenerationC\chatlog.txt
FileRead, info, %checkfile%
if info contains ������� ��� ���� �� �������������� %name% or ������������� %name% �������
{
sup+=1
FileDelete %checkfile%
FileAppend %checkfile%
FileDelete %checkfile2%
FileAppend, %sup%, %checkfile2%
}}

return

!2::
SendInput,{F6}%sup%{Space}
return

!3::
SendInput,{F6}/kjail(Space)
return

!4::
SendInput,{F6}/mute(Space)
return