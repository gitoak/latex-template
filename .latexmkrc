# Use lualatex
$pdf_mode = 4;

$interaction = 'nonstopmode';
$silent = 1;

# Put all aux/pdf/etc in out/
$out_dir = 'out';

# How to run lualatex
$lualatex = 'lualatex -synctex=1 -interaction=nonstopmode %O %S';

$bibtex_use = 2;  # 2 means use biber
