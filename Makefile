URLBASE=https://static.rust-lang.org/dist/
RUSTVER:=$(firstword $(subst -, ,$(SNAPCRAFT_PROJECT_VERSION)))
RUSTNAME=rust-$(RUSTVER)-$(ARCH)-unknown-linux-gnu

RUSTGZ  = $(RUSTNAME).tar.gz
RUSTASC = $(RUSTGZ).asc

KEYRING = ./keyring.gpg




build: check
	tar zxf $(RUSTGZ)


check: download $(KEYRING) force
	gpg --no-default-keyring --keyring $(KEYRING) --verify $(RUSTASC) $(RUSTGZ)



download: $(RUSTASC) $(RUSTGZ) 


$(RUSTASC) $(RUSTGZ):
	wget $(URLBASE)$@



# Just for documentation, key should no be fetched by key-id only, that's not
# secure
#$(KEYRING):
#	gpg --no-default-keyring --keyring $(KEYRING) --recv-key 5CB4A9347B3B09DC





install:
	cd $(RUSTNAME) && bash install.sh --destdir=$(SNAPCRAFT_PART_INSTALL)



force:
