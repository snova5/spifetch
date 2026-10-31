# spifetch

Your distro's logo, **spinning in 3D** in the terminal, next to your system info.

- On **[Fedorium Linux](https://github.com/snova5/fedorium)** it spins the real 3D Fedorium logo.
- On **any other distro** it takes that distro's ASCII logo from [fastfetch](https://github.com/fastfetch-cli/fastfetch), extrudes it into 3D and spins it, keeping its colours.
- Without fastfetch it spins your distro's name in 3D block letters.

Shows OS, kernel, uptime, desktop, shell, terminal, CPU and memory. Runs on **Linux and Windows**. Pure Python 3, no packages needed.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/snova5/spifetch/main/install.sh | sh
```

For distro logos, also install fastfetch (`sudo dnf install fastfetch`, `sudo apt install fastfetch`, `sudo pacman -S fastfetch`).

### Windows

In PowerShell (no admin needed):

```powershell
irm https://raw.githubusercontent.com/snova5/spifetch/main/install.ps1 | iex
```

Needs Python 3 (`winget install Python.Python.3.13`) and, for the logo, fastfetch (`winget install fastfetch`). Works in Windows Terminal, PowerShell and CMD.

## Use

```bash
spifetch                  # detect your distro and spin
spifetch --logo arch      # spin another distro's logo
spifetch --logo fedorium  # the Fedorium hat, anywhere
spifetch --list           # logo names you can use
spifetch --no-info        # logo only
spifetch --speed 3        # faster spin
```

Press **Ctrl+C** to stop. A bigger terminal gives more detail.

## Uninstall

```bash
rm ~/.local/bin/spifetch                     # Linux
```

```powershell
Remove-Item -Recurse "$env:LOCALAPPDATA\spifetch"   # Windows
```

## Credits

Distro logos come from fastfetch at run time and belong to their respective projects. spifetch is not affiliated with any of them.

## License

MIT
