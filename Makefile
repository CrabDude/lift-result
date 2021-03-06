
serve: node_modules
	@node_modules/serve/bin/serve -Slojp 0

test: node_modules
	@node_modules/hydro/bin/hydro test/*.test.js \
		--formatter $$PWD/node_modules/hydro-dot \
		--setup test/hydro.conf.js
	@sed 's/lift-result/.\//' Readme.md | node_modules/jsmd/bin/jsmd

node_modules: package.json
	@packin install --meta $< --folder $@

bench: node_modules
	@for dir in bench/*; do \
		printf "\n  \033[4;36m%s\n\033[0m" $$dir; \
		node_modules/b/bin/bench $$dir \
			--implementations "$$dir/imps" \
			--cycles 10000 \
			--reporter table; \
	done;

.PHONY: serve test bench
