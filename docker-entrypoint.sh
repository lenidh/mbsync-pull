#!/usr/bin/env bash

_main() {
    docker_setup_conf

    mkdir -p $MBS_DATA

    mbsync --version
    mbsync --verbose --all --config /etc/mbsync/mbsyncrc
}

docker_setup_conf() {
    docker_substitude_conf_var MBS_DATA
    docker_substitude_conf_var MBS_MAILBOX_NAME
    docker_substitude_conf_var MBS_HOST_NAME
    docker_substitude_conf_var MBS_HOST
    docker_substitude_conf_var MBS_PORT
    docker_substitude_conf_var MBS_USER
    docker_substitude_conf_var MBS_PASSWORD
    docker_substitude_conf_var MBS_PASSWORD_FILE
    docker_substitude_conf_var MBS_TLSTYPE
    docker_substitude_conf_var MBS_TLSVERSIONS
    docker_substitude_conf_var MBS_PIPELINE_DEPTH
    docker_substitude_conf_var MBS_PATTERN
}

docker_substitude_conf_var() {
    local name=$1
    local value=$(echo "${!name}" | sed 's|/|\\\/|g')
    if [ -z ${value} ]; then
        # Remove configuration directives containing the missing variable
        sed -i "/{$name}/d" /etc/mbsync/mbsyncrc
    else
        # Insert variable content into configuration directives
        sed -i "s/{$name}/${value}/g" /etc/mbsync/mbsyncrc
    fi
}

_main "$@"
