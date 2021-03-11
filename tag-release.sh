#!/bin/bash

tagCmd="git tag -a $1 -m \"$1\""

eval $tagCmd
git submodule foreach --recursive $tagCmd
