# 'dotnet build' will potentially take care of making this one only rebuild as
# much as is necessary. At the moment, I think it rebuilds unconditionally
# though.
.PHONY: sitegen posts sync_from_old

SITEGEN=bin/sitegen

# Meta-tasks
all: sitegen site

sitegen: bin
	cd sitegen && dotnet build
	cp sitegen/SiteGenerator.ConsoleApp/bin/Debug/netcoreapp3.1/* bin/

bin:
	mkdir -p bin

clean: clean_sitegen clean_site

clean_sitegen:
	rm bin/*

clean_site:
	rm -rf out/*

site: posts \
		out/css \
		out/css/main.css \
		out/favicon.ico \
		out/icon.png \
		out/index.html \
		out/sv/om/index.html \
		out/sv/om/var-lara/index.html \
		out/sv/om/var-lara/v1/index.html \
		out/js \
		out/js/main.js \
		out/js/plugins.js \
		out/js/vendor \
		out/js/vendor/modernizr-3.11.2.min.js \
		out/robots.txt \
		out/tile-wide.png \
		out/tile.png

autobuild:
	while true; do find bin config.yaml Makefile src -type f | entr -d bash -c 'scripts/time_it make site' ; done

posts:
	$(SITEGEN) --posts

sync_from_old:
	rsync -av old/_posts/ src/_posts
	for e in src/_posts/*.md ; do sed -i '/^modifiedDate/d' $$e ; done

#
# Tasks for individual files being generated.
#
# TODO: Automate this by means of including some functionality for this in the
# sitegen tool.
out/index.html: src/index.hbs src/_includes/header.hbs src/_includes/footer.hbs $(SITEGEN) config.yaml
		$(SITEGEN) $< $(@)

out/sv/om/index.html: src/sv/om/index.hbs out/sv/om src/_includes/header.hbs src/_includes/page_header.hbs src/_includes/footer.hbs src/_includes/page_footer.hbs $(SITEGEN) config.yaml
		$(SITEGEN) $< $(@)

out/sv/om/var-lara/index.html: src/sv/om/var-lara/index.hbs out/sv/om/var-lara src/_includes/header.hbs src/_includes/page_header.hbs src/_includes/footer.hbs src/_includes/page_footer.hbs $(SITEGEN) config.yaml
		$(SITEGEN) $< $(@)

out/sv/om/var-lara/v1/index.html: src/sv/om/var-lara/v1/index.hbs out/sv/om/var-lara/v1 src/_includes/header.hbs src/_includes/page_header.hbs src/_includes/footer.hbs src/_includes/page_footer.hbs $(SITEGEN) config.yaml
		$(SITEGEN) $< $(@)

#
# Ensure target folders are created
#
out/css:
		mkdir -p $(@)

out/js:
		mkdir -p $(@)

out/js/vendor:
		mkdir -p $(@)

out/sv/om:
		mkdir -p $(@)

out/sv/om/var-lara:
		mkdir -p $(@)

out/sv/om/var-lara/v1:
		mkdir -p $(@)

#
# Generic rules for static assets (copied as-is)
#
out/css/%.css: src/css/%.css
		cp $< $(@)

out/js/%.js: src/js/%.js
		cp $< $(@)

out/js/vendor/%.js: src/js/vendor/%.js
		cp $< $(@)

out/%: src/%
		cp $< $(@)

# Run local webserver to test the site
serve:
		@echo 'Site is hosted at http://localhost:8000'
		live-server out
