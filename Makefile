# 'dotnet build' will potentially take care of making this one only rebuild as
# much as is necessary. At the moment, I think it rebuilds unconditionally
# though.
.PHONY: sitegen posts clean_all clean clean_sitegen clean_site sync_from_old

SITEGEN=bin/sitegen

# Meta-tasks
all: sitegen site

sitegen: bin
	cd sitegen && dotnet build
	cp -r sitegen/SiteGenerator.ConsoleApp/bin/Debug/net5.0/* bin/

bin:
	mkdir -p bin

clean_all: clean_sitegen clean_site

clean: clean_site

clean_sitegen:
	rm bin/*

clean_site:
	rm -rf out/*

site:
	$(SITEGEN) --build

autobuild:
	while true; do find bin config.yaml Makefile src -type f | entr -d bash -c 'scripts/time_it make site' ; done

posts:
	$(SITEGEN) --posts

sync_from_old:
	rsync -av old/_posts/ src/_posts
	for e in src/_posts/*.md ; do sed -i '/^modifiedDate/d' $$e ; done

# Run local webserver to test the site
serve:
		@echo 'Site is hosted at http://localhost:8000'
		live-server out
