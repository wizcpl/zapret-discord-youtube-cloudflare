[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::InputEncoding = [System.Text.Encoding]::UTF8
Set-Location -LiteralPath $PSScriptRoot
$binPath = Join-Path $PSScriptRoot "bin"
$listsPath = Join-Path $PSScriptRoot "lists"
$ipsetlist = Join-Path $listsPath "ipset-all.txt"
$ipsetexclude = Join-Path $listsPath "ipset-exclude.txt"
$listgeneral = Join-Path $listsPath "list-general.txt"
$listexclude = Join-Path $listsPath "list-exclude.txt"
$listgoogle = Join-Path $listsPath "list-google.txt"
$winwsExe = Join-Path $binPath "winws.exe"
$quicGoogleFile = Join-Path $binPath "quic_initial_www_google_com.bin"
$tlsGoogleFile  = Join-Path $binPath "tls_clienthello_www_google_com.bin"
$tlsFourpda = Join-Path $binPath "tls_clienthello_4pda_to.bin"
$arguments = @"
--wf-tcp=80,443,2053,2083,2087,2096,8443,25565 --wf-udp=443,19294-19344,50000-50100 ^
--filter-tcp=25565 --ipset-exclude="$ipsetexclude" --dpi-desync-any-protocol=1 --dpi-desync-cutoff=n5 --dpi-desync=multisplit --dpi-desync-split-seqovl=582 --dpi-desync-split-pos=1 --dpi-desync-split-seqovl-pattern="$tlsFourpda" --new ^
--filter-udp=443 --hostlist-auto="$listgeneral" --hostlist="$listgeneral" --hostlist-exclude="$listexclude" --ipset-exclude="$ipsetexclude" --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic="$quicGoogleFile" --new ^
--filter-udp=19294-19344,50000-50100 --filter-l7=discord,stun --dpi-desync=fake --dpi-desync-fake-discord="$quicGoogleFile" --dpi-desync-fake-stun="$quicGoogleFile" --dpi-desync-repeats=6 --new ^
--filter-tcp=2053,2083,2087,2096,8443 --hostlist-domains=discord.media --dpi-desync=fake,fakedsplit --dpi-desync-repeats=6 --dpi-desync-fooling=ts --dpi-desync-fakedsplit-pattern=0x00 --dpi-desync-fake-tls="$tlsGoogleFile" --new ^
--filter-tcp=443 --hostlist-auto="$listgeneral" --hostlist="$listgoogle" --ip-id=zero --dpi-desync=fake,fakedsplit --dpi-desync-repeats=6 --dpi-desync-fooling=ts --dpi-desync-fakedsplit-pattern=0x00 --dpi-desync-fake-tls="$tlsGoogleFile" --new ^
--filter-tcp=80,443 --hostlist-auto="$listgeneral" --hostlist="$listgeneral" --hostlist-exclude="$listexclude" --ipset-exclude="$ipsetexclude" --dpi-desync=fake,fakedsplit --dpi-desync-repeats=6 --dpi-desync-fooling=ts --dpi-desync-fakedsplit-pattern=0x00 --dpi-desync-fake-tls="$tlsGoogleFile" --new ^
--filter-udp=443 --hostlist-auto="$listgeneral" --ipset="$ipsetlist" --hostlist-exclude="$listexclude" --ipset-exclude="$ipsetexclude" --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic="$quicGoogleFile" --new ^
--filter-tcp=80,443 --ipset="$ipsetlist" --hostlist-auto="$listgeneral" --hostlist-exclude="$listexclude" --ipset-exclude="$ipsetexclude" --dpi-desync=fake,fakedsplit --dpi-desync-repeats=6 --dpi-desync-fooling=ts --dpi-desync-fakedsplit-pattern=0x00 --dpi-desync-fake-tls="$tlsGoogleFile"
"@
$arguments = $arguments -replace '\s*\^\s*\r?\n\s*', ' '
Start-Process -FilePath $winwsExe -ArgumentList $arguments -WorkingDirectory $binPath -WindowStyle Hidden
Write-Host "zapret running in background, this window will close after 5 seconds. Zapret name - winws.exe"
Start-Sleep 5
Exit