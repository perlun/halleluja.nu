.PHONY: all clean serve

EJS=npx ejs

#
# Meta-tasks
#
all: site

clean:
	rm -rf out/*

site: out/index.html

autobuild:
	while true; do find src -type f | entr -d bash -c 'time make' ; done

#
# Tasks for individual files being generated.
#
out/index.html: src/index.ejs
	$(EJS) -o $(@) $<

# Run local webserver to test the site
serve:
	@echo 'Site is hosted at http://localhost:8000'
	cd out && busybox httpd -f -p 8000 -v
