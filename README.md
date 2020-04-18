# Mojang-api-ps
This tool allows you to use the Mojang Minecraft api via powershell

## Options
Use the following arguments to query the API
 
 - -Get
 - -Username
 - -Uuid
 
### Get Uuid given Username
```
> .\mojang-api.ps1 -Get Uuid -Username DadiB
fa0f34fd474647548c651754a39ac342
```

### Get Username given Uuid
```
> .\mojang-api.ps1 -Get Username -Uuid fa0f34fd474647548c651754a39ac342
DadiB
```

### Get Skin given Uuid
```
> .\mojang-api.ps1 -Get Skin -Uuid fa0f34fd474647548c651754a39ac342
```
(png saved to `$($Username).png`

### Get Skin given Username
```
> .\mojang-api.ps1 -Get Skin -Username DadiB
```
(png saved to `$($Username).png`

### Get Server Status given Server [mcsrvstat.us](https://mcsrvstat.us/)
```
> .\mojang-api.ps1 -Get ServerStatus -Server hypixel.net
Requires MC 1.8-1.15
92734 players online of 90000 max
Running on 172.65.208.29:25565
```
