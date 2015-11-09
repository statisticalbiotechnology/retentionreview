all: retention.pdf response.pdf diff.pdf

retention.pdf: img/* retention.bib


diff.tex: retention.tex
	git show v2:$? > /tmp/$?
	latexdiff /tmp/$? $? > diff.tex

%.png: %.pdf
	convert -density 144 $*.pdf $*.png

%.pdf: %.tex
	pdflatex $*.tex
	if ( grep -q citation $*.aux ) ; then \
		bibtex $* ; \
		pdflatex $*.tex ; \
	fi
	pdflatex $*.tex

clean:
	rm -f *.aux *.bbl *.blg *.log *~
