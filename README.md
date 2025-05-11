# NZ's utils

These are utilities that I created to make using my PC and maintaining OS more
comfortable.

## Installation

Uhhhhm

## `sysmaint.sh`

This is a script macro (i.e. without any arguments) that performs the
following:
- Refreshing mirror lists
- Performing full system update (including AUR packages)
- Clearing `pacman` cache
- Removing orphaned packages
- Clearing system logs

> [!NOTE]
> `sysmaint.sh` uses `trash` instead of `rm`. This is made just in case that
> something breaks.

### Dependencies

> BTW most of the dependencies probably can be replaced (e.g. Arch with any
> other `pacman`-based distro, `yay` - with any other AUR helper, etc.) but I'm
> not gonna test them.

- Arch Linux
- `rate-mirrors`
- `yay`
- `pacman-contrib`
- `trash-cli`

### Usage

```bash
$ /path/to/sysmaint.sh
```

This script is meant to run in interactive shell since you will be prompted to
confirm at some stages.

## `toggleaudio.sh`

This is a script macro (i.e. without any arguments) that switches your output
audio devices.\
E.g. you have HDMI audio output and headphones. Currently the headphones are
used as a default output. When you run this script,it will set HDMI audio as
a default output.

### Dependencies

- PulseAudio

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
