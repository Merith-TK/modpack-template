## Update Pack Template
This is a template modpack makers can use to easily release their modpack onto multiple platforms.
currently this template only supports 
- Windows
	- Technic
	- MultiMC

### How to use this?
- Modpack Makers
	- Well first your going to need to install `busybox`, `git`, `7zip`, and `make` on your computer, I personally reccomend getting all of these through [Scoop](https://scoop.sh/)
	- After installing scoop, just run
		- `scoop install busybox git make 7zip`
		- and everything should be there, 
	- I reccomend using VSCode to manage your modpack as you have a full visual editor and git manager built in.
	- TO build a release, you simply need to open a terminal, (git-bash, cmd, or even powershell) inside the modpack folder, and run `make <insert release>`, for example, `make technic` will make a technic release zip, and running it again will modify it so it doesnt have issues with having to make a new file share link, same with `multimc`

	- Dont forget to make a git repo for your modpack, I reccomend using [GitLab](https://gitlab.com) due to its free Large File Support.

	- There are a few files you will need to edit as a maintainer to properly use this tool, 
		- `.gitignore`
			- Your modpack will create files that can and most likely will create issues with the updater, input the filepaths you wish for the updater to ignore, (usually files/folders that do not need to be bundled as they will be automatically created)
		- `.minecraft/icon.png`
			- This is your Modpack Icon, please change it, you may alter this one if you do not have one made specifically for you, the image is a 32x32 pixel image scaled up to 1024x1024
			- Also change the file name for it
		- `instance.cfg`
			- iconKey=icon, change this to whatever you named your modpack icon (excluding file extension)
			- name=Example Modpack, change this to your modpack name
		- `Makefile`
			- Edit this so that you can name your release zips how you want them to


	- I highly suggest using this mod or simular to push custom configs as players may make changes to their settings which *will* break the updater
		- https://www.curseforge.com/minecraft/mc-mods/yosbr

- Modpack Users
	- MultiMC
		- Add this into your instance settings if not already there
		- `$INST_DIR/update-pack.exe`
		- ![](https://i.imgur.com/wjBuHYG.png)
	- Technic
		- Nothing, your modpack maintainer will use this tool to make new technic releases automatically