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

It should build a file like rust_1.21.0-1_amd64.snap . Since by default, snap prepends all executables with the snap name (except when name and snap name are identical), therefore turns cargo into rust.cargo (cargo won't find the other executables with these names) it is necessary to alias the names with the commands below in order to get the regular names of the executables. 

## Installation

    sudo snap install --classic --dangerous rust_1.21.0-1_amd64.snap
    sudo snap alias rust.rustc rustc
    sudo snap alias rust.cargo cargo
    sudo snap alias rust.rls rls
    sudo snap alias rust.rustdoc rustdoc
    sudo snap alias rust.rust-gdb rust-gdb
    sudo snap alias rust.rust-lldb rust-lldb

Executables will be placed in /snap/bin, so make sure to have this in your PATH variable.


## Deinstallation
    sudo snap remove rust

## Open Issues
### Aliases

Snap renames all executables by prepending the snap name as a prefix (cargo becomes rust.cargo and so on), which is not just ugly, but causes cargo to not find the other tools. This can be fixed with aliases (see above).

The aliasing of executables in snaps is currently work in progress. Although the configuration file syntax allows to configure automatic aliases, the snap installer does not currently honor them. Therefore the aliases must currently be entered manually until snap has finally settled this detail. 

### Confinement

The rust tools work well in the classic (unprotected) confinement, that's why it is currently set.

It would be more desirable to run it in strict mode and to allow access to unhidden files in the users home directory, but that currently keeps rust from calling cc as a linker, since calling other programs outside the snap is not allowed in strict mode. 








