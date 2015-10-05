all: retention.pdf response.pdf

retention.pdf: img/* retention.bib

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
