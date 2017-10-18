# Rust as a snap

This is a test of a snap containing the rust compiler and tools as distributed from [www.rust-lang.org](https://www.rust-lang.org/). I wrote this as an alternative way to install rust in an clean, documented, and reliably removable way, after facing the problem of outdated rust packages in Ubuntu and beeing unable to compile recent rust source code. I do not like tools like rustup fiddling and messing around with my system. 

snap is a new packaging style made by Ubuntu and intended to be distribution independent and fit several linux distributions. snaps cannot interfere with other packages (e.g. libraries) and must be autonomous and independent. rust code seems to exactly match this model. 

## Compatibility

Should work with the linux distributions listed on [snapcraft.io](https://snapcraft.io/), especially Ubuntu, Debian, ArchLinux, Fedora, Gentoo, SUSE.




## Build

Since this is still in the state of testing, there is no automated build and the snap can not yet be automatically downloaded and installed. You have to build it on your own.

1. Make sure to have tools like gpg and snapcraft ( e.g. apt-get install snapcraft)
2. umask 022 (important for some versions of snapcraft, the snap might not be readable for non-root users)
3. run  snapcraft

It should build a file like rustc_1.21.0-0_amd64.snap

## Installation
    sudo snap install --classic --dangerous rustc_1.21.0-0_amd64.snap

## Deinstallation
    sudo snap remove rustc

## Known Problems and Limitations

The snap system is quite strict in separating and encapsulating package contents. It enforces prepending the names of all executables with the name of the snap, except for the single case that the executable's name is identical with the snap name. So while rustc remains just rustc, cargo unfortunately becomes rustc.cargo, and so on. 

This causes e.g. cargo to not find rustdoc. It will find rustc, because rustc keeps its name since identical with the package name.

Aliases and Symlinks from /usr/local/bin/ to /snap/bin will **not** work, since snap uses the name to find the binary.

As a workaround, one could install stub files like

    #!/bin/bash
    exec /snap/bin/rustc.rustdoc "$@"

as /usr/local/bin/rustdoc (and so on for all five executables with rustc. prefixes). This is a one time task and would survive upgrading to new versions of the snap/rust compiler. I know, it's ugly, but that's how the snap policy is. 

## Security

snap offers (at least under ubuntu) several security modes, called confinements ([see documentation](https://docs.snapcraft.io/reference/confinement)), _strict_ beeing the strongest and recommended one. This, however, limits the read and write acces to $HOME/snap/rustc/... , requiring users to move their sources into this subdirectory. Since the compiler produces executable code, instead of directly running attacks, it could simply build malware into the generated binaries, so the confinement is not really effective for compilers. I therefore chose the 'classic' confinement, which is less secure, but allows the executables to be used as in regular packages, i.e. can access any file.

Therefore the install command needs the --classic --dangerous options. snap would refuse installation otherwise. 

## Running

Executables will be placed in /snap/bin, so make sure to have this in your PATH variable.




