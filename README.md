These are the scripts I use to disable power saving and telemetry on my Windows 11 install.
I don't claim to have "found" any of these registry keys, they are just scripts I run when I perform an install of windows on my computer.

Note: after disabling windows defender, open MinSudo and type

```bat
taskkill /f /im smartscreen.exe > nul 2>&1 & ren C:\Windows\System32\smartscreen.exe smartscreen.exee
```

For some reason smartscreen ignores the registry key that determines if it runs in the background or not. This renames it, so it does not run.

