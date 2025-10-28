# LaTeX Project Template (LuaLaTeX)

General-purpose LaTeX template that works for:
- CV / resume
- papers / articles / homework
- reports / theses chapters
- beamer slides

## Features
- **LuaLaTeX** by default (UTF-8, system fonts, modern typesetting)
- `latexmk` for incremental builds
- VS Code + LaTeX Workshop config included
- Clean project layout with `preamble.tex`
- GitHub Action that builds `main.pdf` on tag push and uploads it as a Release asset

## Local Requirements (Arch Linux example)

```bash
sudo pacman -Syu --needed \
  texlive-basic \
  texlive-latexrecommended \
  texlive-latexextra \
  texlive-fontsrecommended \
  texlive-binextra \
  texlive-luatex \
  texlive-bibtexextra \
  biber \
  ghostscript poppler \
  make \
  code
