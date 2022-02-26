default:
	@echo "No Default make command configured"
	@echo "Please use either"
	@echo "   - make curseforge"
	@echo "   - make multimc"
	@echo "   - make technic"
	@echo "   - make all"
	@echo ""
	@echo "Curseforge will make a curseforge compatible zip"
	@echo "Multimc will make a multimc zip file which contains"
	@echo "   the packwiz updater"
	@echo ""
	@echo "Technic will make a technic pack zip"
	@echo ""
	@echo "All will make all packs it can"
	@echo ""
	
curseforge:
	@echo "Making Curseforge pack"
	@-mkdir ../modpack-curseforge
	packwiz curseforge export --mods-folder packwiz-data/mods/ --pack-file packwiz-data/pack.toml
	cp -r .minecraft overrides
	7z a *.zip overrides 
	rm -rf overrides
	mv *.zip ../modpack-curseforge/

multimc:
	@echo "Making MultiMC pack"
	7z d ../modpack-multimc.zip ./* -r
	7z d ../modpack-multimc.zip ./.* -r
	7z a ../modpack-multimc.zip ./* -r
	7z a ../modpack-multimc.zip ./.minecraft -r

technic:
	@echo "Making Technic pack"
	-rm -rf .technic
	-cp -r .minecraft .technic
	mv .technic/modpack.icon.png .technic/icon.png
	cd .technic && java -jar packwiz-installer-bootstrap.jar https://gitlab.com/Merith-TK/modpack-template/-/raw/main/packwiz-data/pack.toml && cd ..
	-rm -rf .technic/packwiz*
	7z d ../modpack-technic.zip ./* -r
	7z a ../modpack-technic.zip ./.technic/* -r

all: curseforge multimc technic