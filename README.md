## Update Pack Template
This is a template modpack makers can use to easily release their modpack onto multiple platforms.
currently this template only supports 
- Curseforge
	- Please note recent API changes to curseforge have broken support for most mods from curseforge in the other three formats
	- Multi/PolyMC requires users to download mods manually
	- Technc requires modpack makers to download mods manually
	- Modrinth just doesnt support it at all
- [Multi/PolyMC](https://polymc.org)
- Technic
- Modrinth


### How to use this?
[![Gitpod ready-to-code](https://img.shields.io/badge/Gitpod-ready--to--code-908a85?logo=gitpod)](https://gitpod.io/from-referrer/)
- Modpack Makers
	- Well first your going to need to install `busybox`, `git`, `go` `7zip`, and `make` on your computer,
	- On Windows I personally reccomend getting all of these through [Scoop](https://scoop.sh/)
		- After installing scoop, just run
			- `scoop install busybox git go make 7zip`
	- On Linux,
		- Ubuntu/Debian
			- `sudo apt install git p7zip make`
			- golang needs the latest release, which is unfortunately not in the repos, please manually install it, there are plenty of guides online for this
		- Arch
			- please use an AUR helper such as `yay`
			- `yay -Syu git go p7zip make`
	
	- after you install go, run this command to install packwiz
		- `go install github.com/packwiz/packwiz@latest`

	- I reccomend using VSCode to manage your modpack as you have a full visual editor and git manager built in.
	- to add mods, run `packwiz <curseforge or modrinth> install <modid>`
		- for sodium from curseforge, `packwiz cf install sodium`
	- to make a release, run `make multimc` or `make technic`

	- Dont forget to make a git repo for your modpack, I reccomend using [GitLab](https://gitlab.com) due to its free Large File Support.
		- or a place to host the packwiz-data folder!

- Modpack Users
	- MultiMC
		- Use Java 17, MC 1.16.5 runs just fine on forge AND fabric on java 17
