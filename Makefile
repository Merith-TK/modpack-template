default:
	@echo "No Default make command configured"
	@echo "Please use either"
	@echo "   - make multimc"
	@echo "   - make technic"
	@echo "   - make all"
	@echo ""
	@echo "MultiMC will make a pack with the updater.exe built in"
	@echo "  along with the git history"
	@echo ""
	@echo "Techic will make a pack that can be used for technic"
	@echo ""
	@echo "All will make both technic and MultiMC packs"
	@echo ""
	
multimc:
	@echo "Making MultiMC pack"
	7z d ../modpack.zip ./* -r
	7z d ../modpack.zip ./.* -r
	7z a ../modpack.zip ./* -r
	7z a ../modpack.zip ./.minecraft -r

technic:
	@echo "Making Technic pack"
	-rm -rf .technic
	-cp -r .minecraft .technic
	mv .technic/modpack.icon.png .technic/icon.png
	cd .technic && java -jar packwiz-installer-bootstrap.jar https://gitlab.com/Merith-TK/modpack-template/-/raw/packwiz/packwiz-data/pack.toml && cd ..
	-rm -rf .technic/packwiz*
	7z d ../modpack-technic.zip ./* -r
	7z a ../modpack-technic.zip ./.technic/* -r

all: multimc technic