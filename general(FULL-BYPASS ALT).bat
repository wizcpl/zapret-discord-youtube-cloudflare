@echo off
chcp 65001 >nul
:: 65001 - UTF-8

cd /d "%~dp0"
echo:

set BIN=%~dp0bin\

start "zapret: general" /min "%BIN%winws.exe" --wf-tcp=80,443 --wf-udp=443,50000-50100 ^
--filter-udp=443 --ipset="ipset-discord-cloudflare.txt" --hostlist="list-general.txt" --hostlist-exclude="excluded-list-general.txt" --hostlist-auto-fail-threshold=1 --hostlist-auto-fail-time=4 --hostlist-auto="list-general.txt" --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-udp=50000-50100 --ipset="ipset-discord-cloudflare.txt" --hostlist="list-general.txt" --hostlist-auto-fail-threshold=1 --hostlist-auto-fail-time=4 --hostlist-auto="list-general.txt" --dpi-desync=fake --dpi-desync-any-protocol --dpi-desync-cutoff=d3 --dpi-desync-repeats=6 --new ^
--filter-tcp=80 --ipset="ipset-discord-cloudflare.txt" --hostlist="list-general.txt" --hostlist-exclude="excluded-list-general.txt" --hostlist-auto-fail-threshold=1 --hostlist-auto-fail-time=4 --hostlist-auto="list-general.txt" --dpi-desync=fake,split2 --dpi-desync-autottl=4 --dpi-desync-fooling=md5sig --new ^
--filter-tcp=443 --ipset="ipset-discord-cloudflare.txt" --hostlist="list-general.txt" --hostlist-exclude="excluded-list-general.txt" --hostlist-auto-fail-threshold=1 --hostlist-auto-fail-time=4 --hostlist-auto="list-general.txt" --dpi-desync=split2 --dpi-desync-split-seqovl=652 --dpi-desync-split-pos=2 --dpi-desync-split-seqovl-pattern="%BIN%tls_clienthello_www_google_com.bin"
