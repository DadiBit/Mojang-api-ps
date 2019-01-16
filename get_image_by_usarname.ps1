param (
	[string]$Username=$(if (!$_) {Read-Host -Prompt 'Username'})
)
$Uuid=$(ConvertFrom-JSON -InputObject ($(Invoke-webrequest -URI "https://api.mojang.com/users/profiles/minecraft/$($Username)").Content)).id
$Base64Skin=(Invoke-webrequest -URI $(ConvertFrom-JSON -InputObject ($([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($($(ConvertFrom-JSON -InputObject ($(Invoke-webrequest -URI "https://sessionserver.mojang.com/session/minecraft/profile/$($Uuid)").Content)).properties.value)))))).textures.skin.url).Content
[IO.File]::WriteAllBytes("$pwd\$($Username).png", $Base64Skin)