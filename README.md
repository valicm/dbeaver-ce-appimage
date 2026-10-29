<p align="center"><img src="https://dbeaver.io/wp-content/uploads/2015/09/beaver-head.png" alt="DBeaver CE" width=128 height=128></p>
<h2 align="center">DBeaver CE AppImage</h2>
<p align="center">Unofficial / Community provided Dbeaver Community Edition AppImage - stable release</p>

[![DBeaver CE AppImage release](https://github.com/valicm/dbeaver-ce-appimage/actions/workflows/release.yml/badge.svg?branch=main)](https://github.com/valicm/dbeaver-ce-appimage/actions/workflows/release.yml)

### Get Started

#### [Download the latest stable release](https://github.com/valicm/dbeaver-ce-appimage/releases/latest)
- stable release only
- supports update of the AppImage

### Executing
#### File Manager
Double-click the `*.AppImage` file and you are done!

> In normal cases, the above method should work, but in some cases you 
> need mark file as executable. You can do this using File manager -> right click > Properties > Allow Execution,
> or by terminal issuing command `chmod +x dbeaver-ce-*.AppImage`

#### AppImageLauncher
Use AppImageLauncher for better desktop integration ==> [download AppImageLauncher](https://github.com/TheAssassin/AppImageLauncher)

#### Terminal
```bash
chmod +x dbeaver-ce-*.AppImage
./dbeaver-ce-*.AppImage
```

#### Build
The AppImage is built from .tar.gz DBeaver package by GitHub Continuous Integration using this
[Go AppImage packager v2.0.0](https://github.com/valicm/appimage-bash/tree/v2.0.0).

Desktop entry values are defined inline in `.github/workflows/release.yml`; no separate desktop file is required. Builds update `latest`, publish versioned releases, and retain the newest 10 managed versioned releases.
