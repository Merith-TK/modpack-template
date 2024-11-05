default:
	@echo "No Default make command configured"
	@echo "Please use either"
	@echo "	- make multimc"
	@echo "	- make local multimc"
	@echo "	- make curseforge"
	@echo "	- make modrinth"
	@echo "	- make local technic"
	@echo "	- make technic"
	@echo "	- make server"
	@echo "	- make all"
	@echo ""

PACKNAME := $(notdir $(shell pwd))
ICONNAME := $(shell echo $(PACKNAME) | sed 's/[^a-zA-Z0-9]/_/g')

build: refresh
	@mkdir -p .build
	@echo "PACKNAME: ${PACKNAME}"
	@echo "ICONNAME: ${ICONNAME}"
	@echo "PACKURL: $(shell pw detect)"

curseforge: build
	@echo "Making Curseforge pack"
	packwiz curseforge export --pack-file .minecraft/pack.toml
	mv ./*.zip ./.build/${PACKNAME}-curseforge.zip

modrinth: build
	@echo "Making Modrinth pack"
	packwiz modrinth export --pack-file .minecraft/pack.toml
	mv ./*.mrpack ./.build/${PACKNAME}-modrinth.mrpack

multimc: build
	@echo "Making MultiMC pack"
	cp .minecraft/icon.png ./${ICONNAME}_icon.png
	7z d .build/${PACKNAME}-multimc.zip ./* -r
	7z d .build/${PACKNAME}-multimc.zip ./.minecraft -r
	@sed -i 's#{PACKURL}#$(shell pw detect)#g' instance.cfg
	@sed -i 's#{ICONNAME}#${ICONNAME}#g' instance.cfg
	7z a .build/${PACKNAME}-multimc.zip ./* -r
	7z a .build/${PACKNAME}-multimc.zip ./.minecraft -r
	7z d .build/${PACKNAME}-multimc.zip ./.build ./.minecraft/mods ./.minecraft/pack.toml ./.minecraft/index.toml -r
	-rm ./${ICONNAME}_icon.png
	@sed -i 's#$(shell pw detect)#{PACKURL}#g' instance.cfg
	@sed -i 's#${ICONNAME}#{ICONNAME}#g' instance.cfg

technic: build
	@echo "Making Technic pack"
	@mkdir -p .technic
	-rm -rf .technic
	cp -r .minecraft .technic
	cp .minecraft/icon.png .technic/icon.png
	cd .technic && java -jar ../.minecraft/packwiz-installer-bootstrap.jar ../.minecraft/pack.toml && cd ..
	-rm -rf .technic/packwiz* .technic/index.toml .technic/pack.toml .technic/mods/*.toml
	7z d .build/${PACKNAME}-technic.zip ./* ./.* -r
	7z a .build/${PACKNAME}-technic.zip ./.technic/* -r

server: build
	@echo "Making Server pack"
	-rm -rf .server
	@mkdir -p .server
	mc-server-icon --icon .minecraft/icon.png --output .server/server-icon.png
	cd .server && java -jar ../.minecraft/packwiz-installer-bootstrap.jar -s server ../.minecraft/pack.toml && cd ..
	7z d .build/${PACKNAME}-server.zip ./* ./.* -r
	7z a .build/${PACKNAME}-server.zip ./.server/* -r

preClean:
	-rm -rf .build .server .technic
	-rm -f ./instance.cfga*

postClean:
	-git gc --aggressive --prune
	-rm -f ./*_icon.png

clean: preClean postClean

all: preClean curseforge modrinth multimc technic server postClean

refresh:
	cd .minecraft && packwiz refresh

update-packwiz:
	go install github.com/packwiz/packwiz@latest
	go install github.com/Merith-TK/packwiz-wrapper/cmd/pw@main
	go install github.com/Merith-TK/utils/cmd/mc-server-icon@main
	-clear
	@echo "Packwiz has been Updated"

release-file: build
	@echo "Generating changelog"
	@pw modlist versions
	@git log --pretty=format:"%h - %s (%ci)" --abbrev-commit > .build/CHANGELOG.md
	@echo "" >> .build/CHANGELOG.md
	@echo "<details><summary>Mod List</summary>" >> .build/CHANGELOG.md
	@echo "" >> .build/CHANGELOG.md
	@cat modlist.md >> .build/CHANGELOG.md
	@echo "</details>" >> .build/CHANGELOG.md

run-server:
	@cd .minecraft && pw refresh
	@mkdir -p .run
	@echo "eula=true" > .run/eula.txt
	@mc-server-icon --icon .minecraft/icon.png --output .run/server-icon.png
	@cd .run && java -jar ../.minecraft/packwiz-installer-bootstrap.jar ../.minecraft/pack.toml -s server
	@if [ ! -f .run/server.jar ]; then \
		echo "Downloading Fabric server jar..."; \
		curl -o .run/server.jar https://meta.fabricmc.net/v2/versions/loader/1.21.1/0.16.5/1.0.1/server/jar; \
	fi
	@cd .run && java -Xmx2G -Xms2G -jar server.jar nogui
