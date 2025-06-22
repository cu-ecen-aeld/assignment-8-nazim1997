##############################################################
#
# LDD
#
##############################################################

#TODO: Fill up the contents below in order to reference your assignment 3 git contents
LDD_VERSION = '06d665605153cc4b2fdc72f5f39816ec4f28963b'
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
LDD_SITE = 'git@github.com:cu-ecen-aeld/assignment-7-nazim1997.git'
LDD_SITE_METHOD = git
LDD_GIT_SUBMODULES = YES

define LDD_BUILD_CMDS
        @echo "LLD Build directory: $(@D)"
        @echo "LLD Target directory: $(TARGET_DIR)"
        $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/misc-modules KERNELDIR=$(LINUX_DIR)
        $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/scull KERNELDIR=$(LINUX_DIR)
endef

# TODO add your writer, finder and finder-test utilities/scripts to the installation steps below
define LDD_INSTALL_TARGET_CMDS
    @echo "LLD Build directory: $(@D)"
    @echo "LLD Target directory: $(TARGET_DIR)"

    $(INSTALL) -m 0755 $(@D)/misc-modules/*.ko $(TARGET_DIR)/lib/modules/$(uname -r)/
    $(INSTALL) -m 0755 $(@D)/scull/*.ko $(TARGET_DIR)/lib/modules/$(uname -r)/

endef

$(eval $(generic-package))