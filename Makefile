RESOURCES_DIR := Resources

# Icon files and names
ICON_FILES := $(shell find Icons/ -depth 1 -name '*.icon')
ICON_NAMES := $(basename $(notdir $(ICON_FILES)))
ICON_SOURCES := $(shell find $(ICON_FILES) -type f)

# *.icns files
ICNS_VARIANTS := \
	Default \
	Dark
ICNS_FILES := $(foreach \
	icon,$(ICON_NAMES), \
	$(foreach variant,$(ICNS_VARIANTS), \
		$(RESOURCES_DIR)/$(icon)-$(variant).icns \
	))

.PHONY: all
all: $(RESOURCES_DIR)/Assets.car $(ICNS_FILES)

$(RESOURCES_DIR)/Assets.car: $(ICON_FILES) $(ICON_SOURCES)
	mkdir -p "$(RESOURCES_DIR)"
	xcrun actool \
		$(ICON_FILES) \
		--warnings --errors --notices \
		--output-format human-readable-text \
		--compile "$(RESOURCES_DIR)" \
		--include-all-app-icons \
		--enable-on-demand-resources NO \
		--enable-icon-stack-fallback-generation NO \
		--development-region en \
		--target-device mac \
		--platform macosx \
		--minimum-deployment-target 11.0

# *.icns files generation rule
define ICNS_RULE
$(RESOURCES_DIR)/%-$(1).icns: Icons/Exports/%-macOS-$(1)-1024x1024@2x.png
	@mkdir -p $(RESOURCES_DIR)
	bin/png2icns "$$<" "$$@"
endef

$(foreach variant,$(ICNS_VARIANTS),$(eval $(call ICNS_RULE,$(variant))))

.PHONY: clean
clean:
	find "$(RESOURCES_DIR)" -type f -name 'Assets.car' -delete
	find "$(RESOURCES_DIR)" -type f -name '*.icns' -delete
