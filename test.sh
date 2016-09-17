#!/bin/sh
set -e
starting_dir=`pwd`
mix test && cd examples/registration_form && mix test
cd $starting_dir
