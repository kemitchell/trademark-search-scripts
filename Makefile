all: report

mark-identifications:
	curl -o $@ "http://trademarks.kemitchell.com/mark-identifications-$(shell date -I).txt"

node_modules/.bin/levenfilter:
	npm install levenfilter

report: searches node_modules/.bin/levenfilter mark-identifications
	./find-superstrings < $< > $@.unsorted
	./find-near-matches < $< >> $@.unsorted
	sort -u < $@.unsorted > $@
	rm $@.unsorted
	cat $@
