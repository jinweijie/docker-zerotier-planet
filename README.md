# Docker ZeroTier Planet

A Docker-based solution for running your own ZeroTier Planet (root server) with a web-based management interface (ztncui). This project allows you to create a private ZeroTier network infrastructure that's independent of ZeroTier's public root servers.

## 🌟 Features

- **Self-hosted ZeroTier Planet**: Run your own ZeroTier root server
- **Web Management Interface**: Easy-to-use web UI powered by ztncui
- **Multi-platform Support**: Supports both ARM64 and AMD64 architectures
- **Automatic Configuration**: Auto-detects public IP addresses
- **File Server**: Built-in file server for downloading planet and moon files
- **Docker-based**: Easy deployment and management with Docker
- **Custom World Generation**: Modified mkworld utility for planet creation

## 🚀 Quick Start

### Prerequisites

- Docker and Docker Compose installed
- Linux kernel 5.0+ (for older systems, the deploy script includes kernel upgrade options)
- Ports 9994 (UDP/TCP), 3443 (TCP), and 3000 (TCP) available

### Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/your-username/docker-zerotier-planet.git
   cd docker-zerotier-planet
   ```

2. **Configure environment variables:**

   ```bash
   cp .env.example .env
   # Edit .env file with your configuration
   nano .env
   ```

3. **Start the services:**

   ```bash
   docker-compose up -d
   ```

4. **Configure your settings in .env:**
   - Set your public IPv4 address (`IP_ADDR4`)
   - Set your public IPv6 address (`IP_ADDR6`) if available
   - Adjust ports if needed (defaults: 9994, 3443, 3000)

### Docker Compose Management

Manage your ZeroTier Planet with docker-compose:

```bash
# Start the services
docker-compose up -d

# Stop the services
docker-compose down

# View logs
docker-compose logs -f

# Restart the services
docker-compose restart

# Update to latest image
docker-compose pull
docker-compose up -d

# View service status
docker-compose ps
```

## 📋 Usage

### Access the Web Interface

After installation, access the web management interface at:

```
http://YOUR_SERVER_IP:3443
```

**Default credentials:**

- Username: `admin`
- Password: `password`

⚠️ **Important**: Change the default password immediately after first login!

### Download Planet and Moon Files

- **Planet file**: `http://YOUR_SERVER_IP:3000/planet?key=YOUR_KEY`
- **Moon file**: `http://YOUR_SERVER_IP:3000/moon_XXXXXXXX.moon?key=YOUR_KEY`

The access key is automatically generated and can be found in the container logs or config files.

### Deploy Script Commands

The `deploy.sh` script provides several management options:

1. **Install** - Fresh installation
2. **Uninstall** - Remove container and optionally data
3. **Update** - Update to latest version
4. **View Info** - Display connection information
5. **Reset Password** - Reset admin password to default
6. **CentOS Kernel Upgrade** - Upgrade kernel for older CentOS systems
7. **Check Proxy** - Verify Docker proxy configuration

## 🔧 Configuration

### Environment Variables

All configuration is managed through the `.env` file. Copy `.env.example` to `.env` and modify the values as needed:

| Variable         | Description                 | Default                                |
| ---------------- | --------------------------- | -------------------------------------- |
| `IP_ADDR4`       | IPv4 address for the planet | Required                               |
| `IP_ADDR6`       | IPv6 address for the planet | Optional                               |
| `ZT_PORT`        | ZeroTier port               | 9994                                   |
| `API_PORT`       | Web interface port          | 3443                                   |
| `FILE_PORT`      | File server port            | 3000                                   |
| `CONTAINER_NAME` | Container name              | zerotier_planet                        |
| `ZT_IMAGE`       | Docker image to use         | jinweijiedocker/zerotier-planet:latest |

### Volume Mounts

The following volumes are automatically created and managed by docker-compose:

- `./data/zerotier/dist` → `/app/dist` - Planet and moon files
- `./data/zerotier/ztncui` → `/app/ztncui` - Web interface data
- `./data/zerotier/one` → `/var/lib/zerotier-one` - ZeroTier configuration
- `./data/zerotier/config` → `/app/config` - Application configuration

Volume paths can be customized in the `.env` file using the `*_PATH` variables.

## 🌐 Network Configuration

### Required Ports

- **9994/UDP**: ZeroTier protocol
- **9994/TCP**: ZeroTier protocol
- **3443/TCP**: Web management interface
- **3000/TCP**: File server

## Client Configuration

### Windows

1. First, download a ZeroTier client from the official ZeroTier website.
2. Copy and overwrite the planet file into `C:\ProgramData\ZeroTier\One\` (Note: this is a hidden directory, so you may need to enable viewing hidden folders).
3. Open `Services` and restart the service named "ZeroTier One".
4. Run `Powershell` with Administrator priviledge, run `zerotier-cli.bat join <network id>`
5. Approve the new member from the Web UI.

### Linux

1. Install the Linux client software. `curl -s https://install.zerotier.com | sudo bash`
2. Go to the directory `/var/lib/zerotier-one`.
3. Replace the `planet` file in this directory and `sudo chown zerotier-one:zerotier-one planet`
4. Restart the zerotier-one service: `sudo service zerotier-one restart`
5. Join the network: `zerotier-cli join <network id>`
6. Approve the join request in the management web interface.
7. Run `zerotier-cli peers` and you should see the PLANET role.

### MacOS

1. Go to the `/Library/Application Support/ZeroTier/One/` directory and replace the `planet` file in this directory.
2. Restart ZeroTier-One: `cat /Library/Application\ Support/ZeroTier/One/zerotier-one.pid | sudo xargs kill`
3. Join the network: `zerotier-cli join <network id>`
4. Approve the join request in the management web interface.
5. Run `zerotier-cli peers` and you should see the PLANET role.

## 🙏 Acknowledgments

- [ZeroTier](https://github.com/zerotier/ZeroTierOne) - The core ZeroTier implementation
- [ztncui](https://github.com/key-networks/ztncui) - Web management interface

## 📞 Support

For issues and questions:

- Open an issue on GitHub
- Check the troubleshooting section
- Review ZeroTier documentation

---

**Note**: This project creates a private ZeroTier network infrastructure. Make sure you understand the implications of running your own root server before deploying in production environments.
