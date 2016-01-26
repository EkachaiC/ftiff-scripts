#!/usr/bin/env bash

# Found on http://stackoverflow.com/questions/5195607/checking-bash-exit-status-of-several-commands-efficiently
function test_command {
    "$@"
    local status=$?
    echo -n "Executing '$@'… "
    if [ $status -ne 0 ]; then
        echo "ERROR: $@" >&2
        exit $status
    fi
    echo "OK"
    
}


socketfilterfw="/usr/libexec/ApplicationFirewall/socketfilterfw"

${testcommand} ${socketfilterfw} --setglobalstate on
${testcommand} ${socketfilterfw} --setallowsigned on
${testcommand} ${socketfilterfw} --setstealthmode on
