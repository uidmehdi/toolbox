# Alpine Utility Container

## Overview
Lightweight Alpine Linux-based container with essential network, development, and database tools.

## Features
- Network tools: tcpdump, bind-tools, nmap-ncat
- Development utilities: git, vim
- Database clients: Redis, PostgreSQL
- Storage support: NFS utils

## Build & Deployment
### Docker Build
```bash
docker build -t toolbox .
```

### GitHub Container Registry
Automatically builds multi-arch images for:
- Linux x86_64 
- Linux ARM64

## Image Tags
- `latest`: Most recent build
- `alpine<version>`: Specific Alpine version
- Branch and PR specific tags

## Usage
```bash
docker run -it ghcr.io/uidmehdi/toolbox
```
