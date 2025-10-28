# LaTeX Project Template (LuaLaTeX, multi-doc aware)# LaTeX Project Template (LuaLaTeX, multi-doc aware)



General-purpose LaTeX template for:General-purpose LaTeX template for:

- CV / resume- CV / resume

- motivation letter- motivation letter

- papers / homework / reports- papers / homework / reports

- slides (if you change the `\documentclass` to beamer)- slides (if you change the `\documentclass` to beamer)

- multiple independent PDFs in one repo- multiple independent PDFs in one repo



## Highlights## Highlights

- **LuaLaTeX** (Unicode + system fonts)- **LuaLaTeX** (Unicode + system fonts)

- `latexmk` incremental builds- `latexmk` incremental builds

- VS Code + LaTeX Workshop config baked in- VS Code + LaTeX Workshop config baked in

- `docs.mk` controls which PDFs get built- `docs.mk` controls which PDFs get built

- GitHub Actions builds every PDF listed in `docs.mk` on tag push and uploads them to a Release- GitHub Actions builds every PDF listed in `docs.mk` on tag push and uploads them to a Release



------



## 1. Local requirements (Arch Linux example)## 1. Local requirements (Arch Linux example)



```bash```bash

sudo pacman -Syu --needed \sudo pacman -Syu --needed \

  texlive-basic texlive-latexrecommended texlive-latexextra \  texlive-basic texlive-latexrecommended texlive-latexextra \

  texlive-fontsrecommended texlive-binextra \  texlive-fontsrecommended texlive-binextra \

  texlive-langenglish \  texlive-langenglish \

  biber \  biber \

  ghostscript poppler \  ghostscript poppler \

  make \  make \

  code  code

```

Then, in VS Code:

```bash
code --install-extension James-Yu.latex-workshop
```

---

## 2. Project structure

* `main.tex` – your first standalone document (CV, report, etc.)
* `preamble.tex` – shared packages/macros/fonts/etc.
* `sections/` – chunks you can `\input{}` from any document
* `refs.bib` – shared bibliography
* `figs/` – images
* `docs.mk` – **list of top-level documents to build**
* `Makefile` – builds all docs in `docs.mk`
* `.github/workflows/build-and-release.yml` – CI that builds + uploads PDFs as Release assets

---

## 3. Building locally

### 3.1 Build all configured PDFs

```bash
make
```

This will:

* run `latexmk` with LuaLaTeX,
* put intermediates + PDFs in `out/`,
* copy final PDFs (e.g. `main.pdf`, `motivation_letter.pdf`, etc.) to the repo root for quick access.

### 3.2 Live rebuild while editing

```bash
make watch
```

This watches the *first* document in `docs.mk`'s `DOCUMENTS` list and continuously rebuilds on changes.

### 3.3 Clean

```bash
make clean
```

---

## 4. VS Code workflow

* Open this repo in VS Code.
* Edit `main.tex` (or any other `.tex` file you add).
* Save.
* LaTeX Workshop uses `latexmk` (LuaLaTeX backend) and writes output to `out/`.
* PDF preview opens in a split tab.

No manual setup needed.

---

## 5. Multiple documents (CV + motivation letter + whatever)

This is where `docs.mk` comes in.

### Step 1. Create new doc(s)

Say you want:

* `cv.tex`
* `motivation_letter.tex`

You can base them off `main.tex`:

```bash
cp main.tex cv.tex
cp main.tex motivation_letter.tex
# edit them down (titles, remove abstract, etc.)
```

Tweak their metadata (`\title{}`, `\author{}`, maybe remove the abstract for a short motivation letter, etc.). You *can* leave the shared `\input{preamble.tex}` in all of them — that's the point.

### Step 2. Tell the build system

Open `docs.mk` and set:

```makefile
DOCUMENTS := cv motivation_letter
```

Now:

* `make` builds `cv.pdf` and `motivation_letter.pdf`
* `make watch` will watch `cv.tex` (the first one in the list)
* CI will include both in the GitHub Release

If you only need one doc again later (just a single report or paper), set:

```makefile
DOCUMENTS := report
```

and create `report.tex`. You don't need to keep `main.tex` at all if you don't want it.

### Q: Can I keep `main.tex` around and add others?

Absolutely. Just do:

```makefile
DOCUMENTS := main cv motivation_letter
```

Order matters for `make watch` only (it watches the first).

---

## 6. GitHub Releases (automatic PDFs on tag)

### How it works

When you tag a commit, e.g.:

```bash
git tag v1.0.0
git push origin v1.0.0
```

the GitHub Action will:

1. Install LaTeX on Ubuntu
2. Run `make release-build` (which builds every doc in `docs.mk`)
3. Create (or update) a GitHub Release for that tag
4. Attach *all the generated PDFs* as downloadable assets

So you can instantly hand over polished PDFs — CV, cover letter, whatever — without telling someone how to build LaTeX.

---

## 7. Notes / tips

* `preamble.tex` is shared across all documents. Tweak it to set fonts, macros, CV entry helpers, theorem envs, etc.
* Different docs can comment out stuff they don't need. For example, in `motivation_letter.tex` you can remove the abstract block or not call `\printbibliography`.
* For slides: create `slides.tex` using `\documentclass{beamer}` and add it to `DOCUMENTS`.

---

## 8. Quickstart examples

### Case A: single PDF (most of the time)

* You only need `main.tex`.
* `docs.mk`:

  ```makefile
  DOCUMENTS := main
  ```
* Run:

  ```bash
  make        # builds main.pdf
  git tag v1.0.0
  git push origin v1.0.0
  ```
* Grab `main.pdf` from the GitHub Release.

### Case B: you need CV + motivation letter this time

1. Make new docs:

   ```bash
   cp main.tex cv.tex
   cp main.tex motivation_letter.tex
   # edit them down (titles, remove abstract, etc.)
   ```

2. Edit `docs.mk`:

   ```makefile
   DOCUMENTS := cv motivation_letter
   ```

3. Build locally:

   ```bash
   make
   ls cv.pdf motivation_letter.pdf
   ```

4. Release them:

   ```bash
   git add .
   git commit -m "Add CV + motivation letter"
   git tag job-app-2025-10-28
   git push origin job-app-2025-10-28
   ```

5. Download both PDFs from the GitHub Release named `job-app-2025-10-28`.

No Makefile surgery. No CI edits. Just update `docs.mk`.

---

## License

Use whatever license you want. MIT is fine.
