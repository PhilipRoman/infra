#!/bin/sh

make all

if [ -n "$1" ]; then
	HOMEDIR="$(eval echo "~$1")"
	USERNAME="$1"
else
	HOMEDIR="$HOME"
	USERNAME="$USER"
fi

[ -f "$HOMEDIR"/.bashrc ] && mv "$HOMEDIR"/.bashrc "$HOMEDIR"/.bashrc.old
ln -s /etc/profile.d/infra.bash "$HOMEDIR"/.bashrc

cat > "$HOMEDIR"/.bash_profile <<'EndOfMessage'
# include .bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
. "$HOME/.bashrc"
fi
EndOfMessage
chown "$USERNAME" "$HOMEDIR"/.bash_profile
chgrp "$USERNAME" "$HOMEDIR"/.bash_profile

if ! [ -f "$HOMEDIR"/.bashrc_local ]; then
	printf 'promptcolor=%d\n' $((RANDOM % 213 + 17)) > "$HOMEDIR/.bashrc_local"
	chown "$USERNAME" "$HOMEDIR"/.bashrc_local
	chgrp "$USERNAME" "$HOMEDIR"/.bashrc_local
fi
