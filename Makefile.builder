BUILDER_SRC_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
BUILDER_MAKEFILE += $(BUILDER_SRC_DIR)/Makefile.src

# vim: ft=make
