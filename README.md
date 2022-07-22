Lupin. A swiss army knife for managing my [GoHugo](https://gohugo.io) based website projects. Might be useful for others one day.

[![Codacy Badge](https://app.codacy.com/project/badge/Grade/b29d13eca8434ceaa6d5a72f631f7b16)](https://www.codacy.com/gh/davidsneighbour/lupin/dashboard)

# (In|Un)stallation, Building, Testing

-  To install run `./install` in this repository as super user. This will copy the binary to `/opt/lupin/` and link it to `/usr/local/bin/`. 
-  To uninstall run `./uninstall` in this repository as super user. This will remove the folder in `/opt/lupin` and unlink the binary in `/usr/local/bin/`.
-  To build the binary run `./build`. This will compile it in `dist/lupin`.
-  To test the binary run `./test`. This will compile it and install the binary.
