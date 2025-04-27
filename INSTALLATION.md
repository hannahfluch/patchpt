# Patched PacketTracer Setup

Version: 8.2.2

## PacketTracer Installation

1. Install the Linux package from the official Cisco Website (you need to login to do so):
https://www.netacad.com/resources/lab-downloads?courseLang=en-US

2. Extract packettracer
The file you download is a debian package, which needs to be extraced first, using:
```bash
ar x ar x Packet_Tracer822_amd64_signed.deb
tar -xf data.tar.xz
```

3. System-wide setup
- Move the `pt` from the local opt directory to the root `/opt` directory.
- Move the xml files and png files to the corresponding system-wide locations:

Icons:
```bash
cd usr/share/icons/gnome/48x48/mimetypes/
sudo cp * /usr/share/icons/gnome/48x48/mimetypes
```

Mime:
```bash
cd usr/share/mime/packages
sudo cp * /usr/share/mime/packages
```

With that, the basic packettracer setup is complete. Note that it will currently only be able to be run via the command line. Since no `.desktop` file exists yet. (Check out the official `postinst` script in the download directory to change that)

Try to run it like this:
```bash
sh /opt/pt/packettracer
```

## Patching

1. Clone the GitHub Repo
```bash
git clone https://github.com/hannahfluch/patchpt
```

2. Apply the patch
Use the `patch.sh` shellscript with a path to the correct PacketTracer binary to compelte the setup:
```bash
sh patch.sh /opt/pt/bin/PacketTracer
```

Now you should be able to launch the `Activity Wizard` window (wizard head icon) without having to enter a password.
