## Update Pack Template
This is a template modpack makers can use to easily release their modpack onto multiple platforms.
currently this template only supports 
- Windows
	- Technic
	- MultiMC

### How to use this?
- Modpack Makers
	- Well first your going to need to install `busybox`, `git`, `go` `7zip`, and `make` on your computer, I personally reccomend getting all of these through [Scoop](https://scoop.sh/)
	- After installing scoop, just run
		- `scoop install busybox git go make 7zip`
		- after you run the previous command, run
			- `go install github.com/packwiz/packwiz@latest`
		- and everything should be there, 
	- I reccomend using VSCode to manage your modpack as you have a full visual editor and git manager built in.
	- to add mods, run `packwiz <curseforge or modrinth> install <modid>`
		- for sodium from curseforge, `packwiz cf install sodium`
	- to make a release, run `make multimc` or `make technic`

	- Dont forget to make a git repo for your modpack, I reccomend using [GitLab](https://gitlab.com) due to its free Large File Support.
		- or a place to host the packwiz-data folder!

- Modpack Users
	- MultiMC
		- Use Java 17, MC 1.16.5 runs just fine on forge AND fabric on java 17