# Eaglercraft WASM-GC Docker Setup

This repository provides a Docker container setup to host the Eaglercraft 1.12.2 WASM-GC client.

## Quick Start

### Option 1: Using Docker Compose (Recommended)

1. Clone this repository:
```bash
git clone https://github.com/IRSPlays/Website-List.git
cd Website-List
```

2. Start the container:
```bash
docker-compose up -d
```

3. Open your browser and go to:
```
http://localhost:8080
```

### Option 2: Using Docker directly

1. Build the image:
```bash
docker build -t eaglercraft-wasm-gc .
```

2. Run the container:
```bash
docker run -d -p 8080:80 --name eaglercraft-wasm-gc eaglercraft-wasm-gc
```

3. Open your browser and go to:
```
http://localhost:8080
```

## What's Included

- **Eaglercraft 1.12.2 WASM-GC Client**: Full offline client that runs in modern browsers
- **Nginx Web Server**: Serves the client files with proper headers for WASM-GC support
- **Cross-Origin Headers**: Configured to support the security requirements for WASM-GC

## Browser Compatibility

The WASM-GC version requires a modern browser with WebAssembly GC support:
- Chrome 119+
- Firefox 120+
- Safari 17+
- Edge 119+

## Server Backend (Optional)

To also run an Eaglercraft server backend:

1. Uncomment the `eaglercraft-server` service in `docker-compose.yml`
2. Run: `docker-compose up -d`

The server will be available on:
- Minecraft protocol: `localhost:25565`
- WebSocket (for web clients): `localhost:8081`

## Configuration

### Port Configuration

You can change the web port by modifying the `docker-compose.yml`:
```yaml
ports:
  - "9000:80"  # Change 9000 to your desired port
```

### Custom Client Files

To use different Eaglercraft client files:
1. Replace the HTML files in the repository
2. Rebuild the container: `docker-compose up --build -d`

## Troubleshooting

### Client won't load
- Ensure your browser supports WASM-GC (see compatibility above)
- Check browser console for errors
- Verify the container is running: `docker ps`

### Connection issues
- Make sure port 8080 is not blocked by firewall
- Check container logs: `docker logs eaglercraft-wasm-gc`

### Server issues (if using server backend)
- Check server logs: `docker logs eaglercraft-server`
- Ensure Java server ports are accessible

## Security Notes

- The container runs nginx as a non-root user
- Cross-origin headers are configured for WASM-GC security requirements
- No external network access is required for the client (offline mode)

## Stopping the Container

```bash
# Using docker-compose
docker-compose down

# Using docker directly
docker stop eaglercraft-wasm-gc
docker rm eaglercraft-wasm-gc
```

## Advanced Usage

### Custom nginx configuration
Modify `nginx.conf` and rebuild to customize web server settings.

### Development mode
For development, you can mount the HTML files as a volume:
```bash
docker run -d -p 8080:80 -v $(pwd):/usr/share/nginx/html:ro eaglercraft-wasm-gc
```