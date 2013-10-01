#!/bin/bash

jirac_mktemp() {
        if [[ $OSTYPE == darwin* ]]; then
                # MAC OS
                echo $(mktemp "/tmp/jirac_$RANDOM")
        else
                echo $(mktemp)
        fi
}
