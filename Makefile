.DEFAULT_GOAL := help

help: ## this help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

env:
	$(eval APP_VERSION=$(shell sed -E 's/ThisBuild \/ version *:= *"([0-9.]+)"/\1/g' version.sbt))
	$(eval ARTIFACT_VERSION=$(APP_VERSION)$(ARTIFACT_SUFFIX))
	$(eval APP_NAME=$(shell sed -En 's/.*name *:= *"([-a-z0-9]+)".*/\1/p' build.sbt))

app_name: env ## get application name
	@echo $(APP_NAME)

app_version: env ## get pure version from version.sbt
	@echo $(ARTIFACT_VERSION)

increment_version: env ## increment version
	$(eval NEW_APP_VERSION=$(shell echo $(APP_VERSION) | awk -F. '{print $$1+0"."$$2+1".0"}'))
	@echo "ThisBuild / version:= \"$(NEW_APP_VERSION)\"" > version.sbt
