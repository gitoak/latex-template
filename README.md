# LaTeX Template

> Multi-document LaTeX template with LuaLaTeX, VS Code support, and automated PDF releases via GitHub Actions.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Features

- 🚀 **LuaLaTeX** with Unicode and system fonts
- 📦 **Multi-document support** — build multiple PDFs from one repo
- ⚡ **VS Code integration** — LaTeX Workshop configured out of the box
- 🤖 **Auto-release** — tag a commit, get PDFs in GitHub Releases
- 🔄 **Live preview** — `make watch` for continuous rebuilds

## Quick Start

```bash
# Build all documents
make

# Watch for changes (rebuilds on save)
make watch

# Clean build artifacts
make clean
```

## Usage

### Single Document

Edit `main.tex` and build:
```bash
make
```

### Multiple Documents

1. Create your documents:
   ```bash
   cp main.tex cv.tex
   cp main.tex cover_letter.tex
   ```

2. Edit `docs.mk`:
   ```makefile
   DOCUMENTS := cv cover_letter
   ```

3. Build:
   ```bash
   make  # Generates cv.pdf and cover_letter.pdf
   ```

### Automated Releases

Push a git tag to automatically build and release PDFs:
```bash
git tag v1.0.0
git push origin v1.0.0
```

GitHub Actions will build all documents and attach them to the release.

## Project Structure

```
├── main.tex          # Main document
├── preamble.tex      # Shared packages and macros
├── sections/         # Reusable content sections
├── refs.bib          # Bibliography
├── figs/             # Images
├── docs.mk           # Document list for build system
└── Makefile          # Build automation
```

## Requirements

**Linux (Arch):**
```bash
sudo pacman -S texlive-basic texlive-latexrecommended texlive-latexextra \
               texlive-fontsrecommended biber make
```

**Linux (Ubuntu/Debian):**
```bash
sudo apt-get update
sudo apt-get install -y texlive-base texlive-latex-recommended \
                        texlive-latex-extra texlive-fonts-recommended \
                        texlive-fonts-extra texlive-binaries texlive-luatex \
                        texlive-bibtex-extra biber latexmk make
```

**VS Code:**
```bash
code --install-extension James-Yu.latex-workshop
```

## License

MIT License - see [LICENSE](LICENSE) for details.
