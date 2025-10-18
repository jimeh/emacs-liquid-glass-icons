RESOURCES_DIR := Resources
IMG_DIR := img

# Icon files and names
ICON_FILES := $(sort $(shell find Icons/ -depth 1 -name '*.icon'))
ICON_NAMES := $(sort $(basename $(notdir $(ICON_FILES))))
ICON_SOURCES := $(sort $(shell find $(ICON_FILES) -type f))
ICON_VARIANTS := Default Dark

# *.icns files
ICNS_FILES := $(foreach \
	icon,$(ICON_NAMES), \
	$(foreach variant,$(ICON_VARIANTS), \
		$(RESOURCES_DIR)/$(icon)-$(variant).icns \
	) \
)

#
# Make all targets
#

.PHONY: all
all: \
	$(RESOURCES_DIR)/Assets.car \
	$(ICNS_FILES) \
	$(foreach icon,$(ICON_NAMES),$(IMG_DIR)/$(icon)-preview.png) \
	$(IMG_DIR)/logo.png

#
# Resources/Assets.car generation
#

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

#
# Resources/*.icns files generation rule
#

define ICNS_RULE
$(RESOURCES_DIR)/%-$(1).icns: Icons/Exports/%-macOS-$(1)-1024x1024@2x.png
	@mkdir -p $(RESOURCES_DIR)
	bin/png2icns "$$<" "$$@"
endef

$(foreach variant,$(ICON_VARIANTS),$(eval $(call ICNS_RULE,$(variant))))

#
# img/*.png generation
#

img/logo.png: \
  $(foreach icon,$(ICON_NAMES), \
    Icons/Exports/$(icon)-iOS-Default-1024x1024@2x.png \
  )
	mkdir -p $(IMG_DIR)
	bin/pngs2collage \
		--output "$@" \
		--max-width 512 \
		--max-height 512 \
		--gap 64 \
		--border 0 \
		--max-columns 99 \
		$^

img/%-preview.png: \
  $(foreach variant,$(ICON_VARIANTS), \
    Icons/Exports/%-iOS-$(variant)-1024x1024@2x.png \
  )
	mkdir -p $(IMG_DIR)
	bin/pngs2collage \
		--output "$@" \
		--max-width 512 \
		--max-height 512 \
		--gap 64 \
		--border 0 \
		--max-columns 99 \
		$^

#
# Clean up
#

.PHONY: clean
clean:
	find "$(RESOURCES_DIR)" -type f -name 'Assets.car' -delete
	find "$(RESOURCES_DIR)" -type f -name '*.icns' -delete
