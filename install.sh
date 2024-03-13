
if [[ "$(id -u)" -eq 0 ]]; then
	echo "script is running as root"
else
	echo "script not running as root, exiting.." 1>&2
	exit 1
fi

echo $(which apt)
if [[ -n "$(which apt)" ]]; then
	echo "apt installed"
else
	echo "apt not installed, exiting.." 1>&2
	exit 1
fi
