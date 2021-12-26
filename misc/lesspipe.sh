#!/bin/sh
#
# To use this filter with less, define LESSOPEN:
# export LESSOPEN="|/usr/bin/lesspipe.sh %s"

if [ ! -e "$1" ] ; then
	exit 1
fi

if [ -d "$1" ] ; then
	ls -alF --sort=t --color -- "$1"
	exit
fi

exec 2>/dev/null

case "$1" in
*.[1-9n].bz2|*.[1-9]x.bz2|*.man.bz2|*.[1-9n].[gx]z|*.[1-9]x.[gx]z|*.man.[gx]z|*.[1-9n].lzma|*.[1-9]x.lzma|*.man.lzma)
	case "$1" in
	*.gz)		DECOMPRESSOR="gzip -dc" ;;
	*.bz2)		DECOMPRESSOR="bzip2 -dc" ;;
	*.xz|*.lzma)	DECOMPRESSOR="xz -dc" ;;
	esac
	if [ -n "$DECOMPRESSOR" ] && $DECOMPRESSOR -- "$1" | file - | grep -q troff; then
		$DECOMPRESSOR -- "$1" | groff -Tascii -mandoc -
		exit
	fi ;;&
*.[1-9n]|*.[1-9]x|*.man)
	if file "$1" | grep -q troff; then
		groff -Tascii -mandoc "$1" | cat -s
		exit
	fi ;;&
*.tar) tar tvvf "$1"; exit ;;
*.tgz|*.tar.gz|*.tar.[zZ]) tar tzvvf "$1"; exit ;;
*.tar.xz) tar Jtvvf "$1"; exit ;;
*.xz|*.lzma) xz -dc -- "$1"; exit ;;
*.tar.bz2|*.tbz2) bzip2 -dc -- "$1" | tar tvvf -; exit ;;
*.[zZ]|*.gz) gzip -dc -- "$1"; exit ;;
*.bz2) bzip2 -dc -- "$1"; exit ;;
*.zip|*.jar|*.nbm) zipinfo -- "$1"; exit ;;
*.rpm) rpm -qpivl --changelog -- "$1"; exit ;;
*.cpi|*.cpio) cpio -itv < "$1"; exit ;;
*.o) objdump -D | vasm; exit ;;
*.gif|*.jpeg|*.jpg|*.pcd|*.png|*.tga|*.tiff|*.tif)
	if command -v identify >/dev/null; then
		identify "$1"
		tiv "$1" || true
		exit
	elif command -v gm >/dev/null; then
		gm identify "$1"
		exit
	else
		echo "No identify available"
		echo "Install ImageMagick or GraphicsMagick to browse images"
		exit 1
	fi ;;
esac

if command -v source-highlight >/dev/null; then
	magic="$(file "$1")"
	language=''
	if printf %s "$magic" | fgrep -q 'C++ source'; then
		language='-s cpp'
	elif printf %s "$magic" | fgrep -q 'C source'; then
		language='-s c'
	elif printf %s "$magic" | fgrep -q 'Java source'; then
		language='-s java'
	fi
	source-highlight --out-format esc256 --style-file __my__.style $language --input "$1" && exit
fi

exit 1
