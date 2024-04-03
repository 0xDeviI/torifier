/home/armin/.config/proxy/tor-socks/torifier-stop.sh
sudo openvpn --config vpnbook-openvpn-fr200/vpnbook-fr200-tcp80.ovpn --auth-user-pass /home/armin/.config/proxy/ovpn/vpnbook-cred.txt > /dev/null 2>&1 &
echo "[+] OpenVPN bridge process started."
sleep 10s
echo "[+] OpenVPN bridge seems to be connected."
sudo systemctl restart tor & \
echo "[+] TOR bridge restart called."
sleep 5s
echo "[+] TOR bridge seems to be connected."
/home/armin/.config/proxy/tor-socks/chisel server -p 13031 --reverse > /dev/null 2>&1 &
sleep 5s
/home/armin/.config/proxy/tor-socks/chisel client 127.0.0.1:13031 R:0.0.0.0:9051:127.0.0.1:9050 > /dev/null 2>&1 &
echo -e "[+] SOCKS5 TOR connection is now available on 0.0.0.0:9051\nDone!"
