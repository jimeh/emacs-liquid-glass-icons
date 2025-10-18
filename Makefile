# Output directory
RESOURCES_DIR := Resources

ICON_FILES := $(shell find Icons/ -depth 1 -name '*.icon')
ICON_SOURCES := $(shell find $(ICON_FILES) -type f)

.PHONY: all
all: $(RESOURCES_DIR)/Assets.car

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

.PHONY: clean
clean:
	find "$(RESOURCES_DIR)" -type f -name 'Assets.car' -delete
