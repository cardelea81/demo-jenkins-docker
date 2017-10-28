TOOLS_DIR = $(PWD)/tools
GO_SH = $(TOOLS_DIR)/go.sh
.PHONY: get-go.sh
get-go.sh: $(GO_SH)/make.sh
	@echo "Installed go.sh"
$(GO_SH)/make.sh:
	@echo "Downloading go.sh"
	@mkdir -p $(TOOLS_DIR)
	@curl -SLO https://api.github.com/repos/dotronglong/go.sh/tarball/master
	@tar -xzf master && rm -rf master
	@mv dotronglong-go.sh-* $(TOOLS_DIR)/go.sh
-include $(GO_SH)/Makefile

build:
	@go build -o tools/main .

test:
	@go test -v .