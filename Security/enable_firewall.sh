#!/bin/bash

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

test_command ${socketfilterfw} --setglobalstate on
test_command ${socketfilterfw} --setallowsigned on
test_command ${socketfilterfw} --setstealthmode on
