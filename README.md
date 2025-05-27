> [!WARNING]
> This repository has been split into several others and is now archived.
> See `sysmaint` and `togglesound`

# NZ's utils

These are utilities that I created to make using my PC and maintaining OS more
comfortable.

## Installation

Uhhhhm

## `sysmaint.sh`

This is a bash script that provides a simple framework for creating and executing
system maintenance scripts (aka modules) all at once. Execute one file and
~~get a segfault~~ run all the preconfigured modules.

### Modules

`sysmaint.sh` is just a starting point. The only thing it does is providing some
useful functions and including the config file. All the tasks are performed by
the modules added via the config file. See the source of the module you want to add.
The repository provides some modules that inherit sysmaint's pre-modular features.
You can see them at (and add them from) [`sysm_modules`](./sysm_modules) directory.
Also see the [`sysm_modules/README.md`](./sysm_modules/README.md).

### Dependencies

The main script itself requires bash only whereas each module defines its own
dependencies. See the source of the module you want to add. If dependencies are not
satisfied, the module will be skipped.

### Configuring

All the configurations are made in a single file `$HOME/.config/sysm_include.sh`. It
is a bash script which is supposed to be used just to include other scripts (modules)
you want to add. You should provide absolute paths to the files but sysmaint provides
a simple $MODULES variable that leads to the repo modules directory. Here's a legit
(i.e. working) example `sysm_include.sh` file, try copying it and execute sysmaint:

```bash
. $MODULES/mirrors.sh
. $MODULES/update.sh
. $MODULES/syslogs.sh
```

Of course since it's just a shell script you are free to add there whatever you want.

### Usage

```bash
$ /path/to/util/sysmaint.sh
```

This script is meant to run in interactive shell since you can be prompted to
confirm at some stages.

## `toggleaudio.sh`

This is a script macro (i.e. without any arguments) that switches your output
audio devices.\
E.g. you have HDMI audio output and headphones. Currently the headphones are
used as a default output. When you run this script, it will set HDMI audio as
a default output.

### Dependencies

- PulseAudio (works also on pipewire-pulse)

### Usage

```bash
$ /path/to/toggleaudio.sh
```

This script can be invoked in the background. It accepts no arguments, does not
print anything to `stdout` or `stderr` and does not prompt user for anything.

> Eventually this script was desinged just to be called via i3wm keybinding.

## Credits
Made by **nz** aka **nunzayin** aka **Nick Zaber**

## License
GNU GPL v3 (see the [`LICENSE`](./LICENSE))
