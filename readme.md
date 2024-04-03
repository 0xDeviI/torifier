# Torifier

![torifier started in a machine](https://github.com/0xDeviI/torifier/blob/main/assets/screenshot.jpg?raw=true)

Torifier is a set of bash scripts that allows you to securely connect to the Tor network through an OpenVPN connection and expose the Tor local port to your local network using Chisel. This script set attempts to solve 2 problems:
1. Connecting to Tor through a VPN; it fails ISPs tracking first node connection.
2. Performs port-forwarding, so you can create a socket server on the system you want to run Tor so you don't need to install Tor everywhere.

## Requirements

* OpenVPN
* Tor
* Chisel

## Installation

1. Clone this repository to your local machine.
2. Update the paths in the scripts to match your configuration.
3. Make the scripts executable with `chmod +x torifier-start.sh torifier-stop.sh`.
4. Run `torifier-start.sh` to start the OpenVPN and Tor connections and expose the Tor local port to your local network.
5. Run `torifier-stop.sh` to stop the connections.

> [!CAUTION]
> It is required to build Chisel from source in its original [repo](https://github.com/jpillora/chisel). Or if you want to use the one included in [this repo](https://github.com/0xDeviI/Torifier), make sure to check its SHA256 checksum with the original build of Chisel by [jpillora](https://github.com/jpillora/)

> [!Note]
> The OpenVPN config I did use in this project is a public OpenVPN config that is provided by [VpnBook](https://www.vpnbook.com/). It's not recommended. Install OpenVPN on your private server and use that. Keep in mind to update connection credentials stored in `vpnbook-cred.txt` .

## Structure
Although its optional, you can use same file structure as I did in order to use Torifier. I have a `proxy` directory in my `.config` directory:
```text
> ll .config/
drwxr-xr-x   - armin  3 Apr 14:41 proxy
```
The `proxy` contains this repo.  Then you have to update your `.bashrc` file in order to set aliases to Torifier scripts. Here's mine:
```text
> cat ~/.bashrc
alias torifier-start='/home/armin/.config/proxy/tor-socks/torifier-start.sh'
alias torifier-stop='/home/armin/.config/proxy/tor-socks/torifier-stop.sh'
```
Finally you have to source `.bashrc` file as follows:
```sh
source ~/.bashrc
```


## Usage

### Starting the connections

To start the OpenVPN and Tor connections and expose the Tor local port to your local network, run the following command:
```
./torifier-start.sh
```
The script will first stop any running instances of Tor and Chisel, then start an OpenVPN connection using a configuration file from VPNBook. The script will then restart the Tor service and use Chisel to expose the Tor local port to your local network.

### Stopping the connections

To stop the OpenVPN and Tor connections and stop exposing the Tor local port to your local network, run the following command:
```
./torifier-stop.sh
```
The script will stop the Chisel server and client, then kill the OpenVPN process.

## Configuration

### OpenVPN

The OpenVPN configuration file is located in the `vpnbook-openvpn-fr200` directory. You can use a different configuration file by updating the path in the `torifier-start.sh` script.

The OpenVPN credentials are stored in the `vpnbook-cred.txt` file in the `ovpn` directory. You can update the credentials by editing this file.

### Tor

The Tor configuration is handled by the systemd service. You can update the Tor configuration by editing the `/etc/tor/torrc` file.

### Chisel

The Chisel server is started on port `13031` and the client exposes the Tor local port on `0.0.0.0:9051`. You can update these ports by editing the `torifier-start.sh` script.

> [!Note]
> If you're planning to run this on Windows and perhaps you receive errors consider changing port 9051 to something else. The default Tor port in `some` Tor binaries on Windows is 9051.

## License

Torifier is released under the MIT License. See the [LICENSE](LICENSE) file for more information.
