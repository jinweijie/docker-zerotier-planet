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

## 🏗️ Build from Source

### Prerequisites

- Docker with buildx support
- Git
- jq (for version checking)

### Build Process

1. **Build the image:**

   ```bash
   chmod +x build.sh
   ./build.sh
   ```

2. **The build script will:**
   - Check for latest ZeroTier version
   - Build multi-architecture image (ARM64/AMD64)
   - Push to Docker Hub (if configured)

### Custom Build

```bash
docker buildx build \
  --platform linux/arm64,linux/amd64 \
  -t your-username/zerotier-planet:latest \
  --push .
```

## 📁 Project Structure

```
docker-zerotier-planet/
├── docker-compose.yml     # Docker Compose configuration
├── .env.example          # Environment variables template
├── .env                  # Environment variables (create from .env.example)
├── Dockerfile            # Multi-stage Docker build
├── build.sh              # Build script with version checking
├── patch/
│   ├── entrypoint.sh     # Container startup script
│   ├── http_server.js    # File server implementation
│   └── mkworld_custom.cpp # Modified world generation utility
└── README.md             # This file
```

## 🔒 Security Considerations

- Change default admin password immediately
- Use firewall rules to restrict access to management ports
- Consider using HTTPS for the web interface in production
- Regularly update the container image
- Monitor access logs

## 🌐 Network Configuration

### Required Ports

- **9994/UDP**: ZeroTier protocol
- **9994/TCP**: ZeroTier protocol
- **3443/TCP**: Web management interface
- **3000/TCP**: File server

### Firewall Rules

```bash
# UFW example
ufw allow 9994/udp
ufw allow 9994/tcp
ufw allow 3443/tcp
ufw allow 3000/tcp
```

## 🐛 Troubleshooting

### Common Issues

1. **Container won't start:**

   - Check if ports are available
   - Verify Docker daemon is running
   - Check container logs: `docker-compose logs`

2. **Can't access web interface:**

   - Verify firewall settings
   - Check if API_PORT is correct in `.env` file
   - Ensure container is running: `docker-compose ps`

3. **Planet file download fails:**
   - Check file server port configuration
   - Verify access key is correct
   - Check file server logs

### Logs

```bash
# Container logs
docker-compose logs -f

# File server logs
docker-compose exec zerotier_planet cat /app/server.log

# ZeroTier logs
docker-compose exec zerotier_planet cat /var/lib/zerotier-one/zerotier-one.log
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.

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
