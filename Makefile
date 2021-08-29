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

multimc:
	-rm  -rf update-pack.data/temp
	-rm  -rf update-pack.data/bin
	-rm  -rf update-pack.data/busybox.exe
	7z d ../modpack.zip ./* -r
	7z d ../modpack.zip ./.* -r
	7z a ../modpack.zip ./* -r
	7z a ../modpack.zip ./.git -r
	7z a ../modpack.zip ./.minecraft -r

technic:
	7z d ../modpack-technic.zip ./* -r
	7z a ../modpack-technic.zip ./.minecraft/* -r
	cp modpack.icon.png icon.png
	7z a ../modpack-technic.zip ./icon.png
	rm icon.png

all: multimc technic