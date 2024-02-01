all:	clean html

html:
	jupyter-book build .

pdf:
	jupyter-book build . --builder pdflatex

clean:
	rm -rfv _build

#end

