param (
	$Username,
	$Uuid,
	$Server,
	$Get
)
if ($Get -eq "Uuid" -and $Username) {
	$Uuid=$(ConvertFrom-JSON -InputObject ($(Invoke-webrequest -URI "https://api.mojang.com/users/profiles/minecraft/$($Username)").Content)).id
	echo "$($Uuid)"
}
if ($Get -eq "Username" -and $Uuid) {
	$Username=$(ConvertFrom-JSON -InputObject ($(Invoke-webrequest -URI "https://sessionserver.mojang.com/session/minecraft/profile/$($Uuid)").Content)).name
	echo "$($Username)"
}
if ($Get -eq "Skin" -and ($Username -or $Uuid)) {
	if (!$Uuid) {
		$Uuid=$(ConvertFrom-JSON -InputObject ($(Invoke-webrequest -URI "https://api.mojang.com/users/profiles/minecraft/$($Username)").Content)).id
		$Base64Skin=(Invoke-webrequest -URI $(ConvertFrom-JSON -InputObject ($([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($($(ConvertFrom-JSON -InputObject ($(Invoke-webrequest -URI "https://sessionserver.mojang.com/session/minecraft/profile/$($Uuid)").Content)).properties.value)))))).textures.skin.url).Content
	} elseif (!$Username) {
		$Username=$(ConvertFrom-JSON -InputObject ($(Invoke-webrequest -URI "https://sessionserver.mojang.com/session/minecraft/profile/$($Uuid)").Content)).name
		$Base64Skin=(Invoke-webrequest -URI $(ConvertFrom-JSON -InputObject ($([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($($(ConvertFrom-JSON -InputObject ($(Invoke-webrequest -URI "https://sessionserver.mojang.com/session/minecraft/profile/$($Uuid)").Content)).properties.value)))))).textures.skin.url).Content
	}
	[IO.File]::WriteAllBytes("$pwd\$($Username).png", $Base64Skin)
}
if ($Get -eq "ServerStatus" -and $Server) {
	[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12
	$ServerInfo=ConvertFrom-JSON -InputObject ($(Invoke-webrequest -URI "https://api.mcsrvstat.us/2/$($Server)").Content)
	echo "$($ServerInfo.version)"
	echo "$($ServerInfo.players.online) players online of $($ServerInfo.players.max) max"
	echo "Running on $($ServerInfo.ip):$($ServerInfo.port)"
}
