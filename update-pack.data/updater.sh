GITURL="https://github.com/git-for-windows/git/releases/download/v2.33.0.windows.1/PortableGit-2.33.0-64-bit.7z.exe"

#install git if not found
if [ ! -f "bin/git/bin/git.exe" ]; then
	if [ ! -d "temp" ]; then
		mkdir temp
	fi
	if [ ! -f "temp/git.install.exe" ]; then
		wget $GITURL -O temp/git.install.exe
	fi
	temp/git.install.exe -o bin/git -y
fi

cd ../
update-pack.data/bin/git/bin/git.exe config --global pull.rebase false
update-pack.data/bin/git/bin/git.exe pull origin main

echo "[$0] If there were any errors, please inform the Modpack Author"