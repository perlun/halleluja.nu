.PHONY: all clean serve

EJS=npx ejs

#
# Meta-tasks
#
all: site

clean:
	rm -rf out/*

site: \
	out/css \
	out/css/main.css \
	out/favicon.ico \
	out/icon.png \
	out/index.html \
	out/js \
	out/js/main.js \
	out/js/plugins.js \
	out/js/vendor \
	out/js/vendor/modernizr-3.11.2.min.js \
	out/robots.txt \
	out/tile-wide.png \
	out/tile.png

autobuild:
	while true; do find Makefile src -type f | entr -d bash -c 'time make' ; done

#
# Tasks for individual files being generated.
#
out/index.html: src/index.ejs
	$(EJS) -o $(@) $<

#
# Ensure target folders are created
#
out/css:
	mkdir -p $(@)

out/js:
	mkdir -p $(@)

out/js/vendor:
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
	cd out && busybox httpd -f -p 8000 -v
