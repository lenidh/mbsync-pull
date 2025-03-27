#!/usr/bin/bash

echo "########################################################################"
echo "# $(mbsync --version) $(date)"
echo "########################################################################"

setpriv --reuid "${MBS_UID}" --regid "${MBS_GID}" --clear-groups mbsync --verbose --all --config /etc/mbsync/mbsyncrc

echo "mbsync done."
