##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################

#TODO: Fill up the contents below in order to reference your assignment 3 git contents
AESD_ASSIGNMENTS_VERSION = '2b869791d647725ba1bf8e3d3d77544bd5a4b3ac'
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
AESD_ASSIGNMENTS_SITE = 'git@github.com:cu-ecen-aeld/assignments-3-and-later-nazim1997.git'
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES

define AESD_ASSIGNMENTS_BUILD_CMDS
        @echo "Build directory: $(@D)"
        @echo "Target directory: $(TARGET_DIR)"
        $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/finder-app all
        $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/server all
        $(MAKE) -C $(LINUX_DIR) M=$(@D)/aesd-char-driver ARCH=$(KERNEL_ARCH) CROSS_COMPILE=$(TARGET_CROSS) EXTRA_CFLAGS="-I$(@D)/include" modules
endef

# TODO add your writer, finder and finder-test utilities/scripts to the installation steps below
define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
        @echo "Build directory: $(@D)"
    @echo "Target directory: $(TARGET_DIR)"
        $(INSTALL) -d 0755 $(@D)/conf/ $(TARGET_DIR)/etc/finder-app/conf/
        $(INSTALL) -m 0755 $(@D)/conf/* $(TARGET_DIR)/etc/finder-app/conf/
        $(INSTALL) -m 0755 $(@D)/assignment-autotest/test/assignment4/* $(TARGET_DIR)/bin
        $(INSTALL) -m 0755 $(@D)/finder-app/finder.sh $(TARGET_DIR)/usr/bin/
        $(INSTALL) -m 0755 $(@D)/finder-app/finder-test.sh $(TARGET_DIR)/usr/bin/
    $(INSTALL) -m 0755 $(@D)/finder-app/writer $(TARGET_DIR)/usr/bin/
    $(INSTALL) -m 0755 $(@D)/server/aesdsocket $(TARGET_DIR)/usr/bin/
    $(INSTALL) -m 0755 $(@D)/server/aesdsocket-start-stop $(TARGET_DIR)/etc/init.d/S99aesdsocket

    $(INSTALL) -m 0755 $(@D)/aesd-char-driver/*.ko $(TARGET_DIR)/lib/modules/$(LINUX_VERSION)
endef

$(eval $(generic-package))
