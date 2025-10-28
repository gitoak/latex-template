# Load document list
include docs.mk

OUTDIR    := out
ENGINE    := lualatex

# PDFs we expect, e.g. main -> main.pdf
PDFS := $(addsuffix .pdf,$(DOCUMENTS))

# Default target: build all PDFs
all: $(PDFS)

# Pattern rule:
# given name.pdf, depend on name.tex and everything else,
# run latexmk on that tex file, and copy final pdf up one level.
%.pdf: %.tex preamble.tex refs.bib $(wildcard sections/*.tex) $(wildcard figs/*)
	latexmk -$(ENGINE) -interaction=nonstopmode -synctex=1 -outdir=$(OUTDIR) -f $<
	cp $(OUTDIR)/$@ $@

# Convenience: watch the *first* document in DOCUMENTS continuously
watch:
	latexmk -pvc -$(ENGINE) -interaction=nonstopmode -synctex=1 -outdir=$(OUTDIR) $(firstword $(DOCUMENTS)).tex

# Clean all build products
clean:
	latexmk -C -outdir=$(OUTDIR)
	rm -rf $(OUTDIR) $(PDFS)

# Special target for CI release builds:
release-build: all
	@echo "Built PDFs: $(PDFS)"

.PHONY: all watch clean release-build
