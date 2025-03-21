#!/usr/bin/bash

echo "########################################################################"
echo "# $(mbsync --version) $(date)"
echo "########################################################################"

mbsync --verbose --all --config /etc/mbsync/mbsyncrc

echo "mbsync done."
