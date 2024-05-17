These scripts assume you are running Windows 11 on an SSD. It is not recommended to use it on anything else.
I don't claim to have "found" any of these registry keys, they are just scripts I run when I perform an install of windows on my computer.

Note: after disabling windows defender, open MinSudo and type

    ```bat
    taskkill /f /im smartscreen.exe > nul 2>&1 & ren C:\Windows\System32\smartscreen.exe smartscreen.exee
    ```

For some reason smartscreen ignores the registry key that determines if it runs in the background or not. This names it, so it does not run.

