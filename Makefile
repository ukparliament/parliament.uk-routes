.PHONY: checkout_to_release deploy_to_release

# Github variables
GITHUB_API=https://api.github.com
ORG=ukparliament
REPO=parliament.uk-routes
LATEST_REL=$(GITHUB_API)/repos/$(ORG)/$(REPO)/releases
REL_TAG=$(shell curl -s $(LATEST_REL) | jq -r '.[0].tag_name')

VERSION_FILE=lib/parliament/engine/version.rb
VERSION=$(shell grep -o \'.*\' lib/parliament/engine/version.rb | tr -d "''")

checkout_to_release:
	git checkout -b release $(REL_TAG)

deploy_to_release:
	gem build *.gemspec
	gem push *.gem
	rm *.gem

test:
	@bundle install
	@rspec

check_version:
    ifeq ($(VERSION), $(REL_TAG))
        $(error The version is currently $(VERSION) and the last release was $(REL_TAG).  You need to bump the version)
    endif
