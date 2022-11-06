#!/bin/sh
#
# To use this filter with less, define LESSOPEN:
# export LESSOPEN="|/usr/bin/lesspipe.sh %s"

if [ ! -e "$1" ] ; then
	exit 1
fi

if [ -d "$1" ] ; then
	ls -alFt --color -- "$1"
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
*.tar.zst) zstd -dc -- "$1" | tar tvvf -; exit ;;
*.zst) zstd -dc -- "$1"; exit ;;
*.tar.bz2|*.tbz2) bzip2 -dc -- "$1" | tar tvvf -; exit ;;
*.[zZ]|*.gz) gzip -dc -- "$1"; exit ;;
*.bz2) bzip2 -dc -- "$1"; exit ;;
*.zip|*.jar|*.nbm) zipinfo -- "$1"; exit ;;
*.rpm) rpm -qpivl --changelog -- "$1"; exit ;;
*.cpi|*.cpio) cpio -itv < "$1"; exit ;;
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

magic="$(file -b -- "$1")"
if fgrep -q 'gzip compressed' <<< "$magic"; then
	zcat -- "$1"
	exit
fi

if egrep -q 'ELF.*(executable|shared object|core file)' <<< "$magic" && command -v objdump >/dev/null; then
	objdump -d -Mintel --no-show-raw-insn --visualize-jumps=extended-color "$1"
	exit
fi

if fgrep -q 'Java class' <<< "$magic" && command -v javap >/dev/null; then
	javap -c -p -constants -verbose "$1"
	exit
fi

if command -v sqlite3 >/dev/null; then
	if grep -i -q 'sqlite.*3.*database' <<< "$magic"; then
		sqlite3 "$1" .dump
		for t in $(sqlite3 "$1" .tables); do
			sqlite3 -box "$1" "select * from $t;"
		done
		exit
	fi
fi

if command -v source-highlight >/dev/null; then
	language=''
	if fgrep -q 'C++ source' <<< "$magic"; then
		language='-s cpp'
	elif fgrep -q 'C source' <<< "$magic"; then
		language='-s c'
	elif fgrep -q 'Java source' <<< "$magic"; then
		language='-s java'
	fi
	if [ -n "$language" ]; then
		source-highlight --out-format esc256 --style-file __my__.style $language --input "$1"
		exit
	fi
fi

if head -c64 "$1" | grep -q '[^[:print:]	]' || file -b "$1" | fgrep -q 'PDF document'; then
	if command -v xxd >/dev/null; then
		xxd -c "$(( ${COLUMNS:-80} / 4 - 2 ))" -- "$1"
		exit
	elif command -v od >/dev/null; then
		od -t x1 -- "$1"
		exit
	fi
fi

exit 1
