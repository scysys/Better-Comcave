Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.AppActivate "CCLauncher_Client"
WScript.Sleep 1500
WshShell.SendKeys "USERNAME" '* <-- CCPortal Username
WshShell.SendKeys "{TAB}"
WshShell.SendKeys "PASSWORD" '* <-- CCPortal Password
WshShell.SendKeys "{ENTER}"
WshShell.SendKeys "^s"
