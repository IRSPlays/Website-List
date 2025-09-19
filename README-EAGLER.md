Eaglercraft Server Setup (automated scripts)

This repository includes helper scripts to download, extract, and run an Eaglercraft/EaglercraftX server distribution in this codespace.

Files added:
- `scripts/setup_eagler_server.sh` — attempts to download a server distribution ZIP (tries a few common release URLs). You can set the `SERVER_URL` environment variable to a direct zip file URL.
- `scripts/run_eagler_server.sh` — finds the first `.jar` under `eagler-server/` and launches it with `java` in the background, logging to `eagler-server.log`.

Usage

1. Ensure Java (JRE or JDK) is installed in the codespace.

2. Run the setup script (optionally set `SERVER_URL`):

```bash
# directly use provided candidates
./scripts/setup_eagler_server.sh

# or provide a direct URL to a distribution zip
SERVER_URL="https://example.com/path/to/eagler-server.zip" ./scripts/setup_eagler_server.sh
```

3. Start the server:

```bash
./scripts/run_eagler_server.sh
```

Notes & caveats

- These scripts attempt to download the server distribution from GitHub. If network access to GitHub is blocked in your environment the download will fail — in that case, upload the distribution ZIP or server `.jar` into `eagler-server/` and run the `run_eagler_server.sh` script.
- The server will run inside the codespace container. Exposing it to the public internet requires port forwarding / codespace port configuration.
