PDF      := main.pdf
OUTDIR   := out
ENGINE   := lualatex

all: $(OUTDIR)/$(PDF)

$(OUTDIR)/$(PDF): main.tex preamble.tex refs.bib $(wildcard sections/*.tex) $(wildcard figs/*)
	latexmk -$(ENGINE) -interaction=nonstopmode -synctex=1 -outdir=$(OUTDIR) -f main.tex
	cp $(OUTDIR)/main.pdf $(PDF)

watch:
	latexmk -pvc -$(ENGINE) -interaction=nonstopmode -synctex=1 -outdir=$(OUTDIR) main.tex

clean:
	latexmk -C -outdir=$(OUTDIR)
	rm -rf $(OUTDIR) $(PDF)

.PHONY: all watch clean
