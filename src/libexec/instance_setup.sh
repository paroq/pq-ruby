#!/usr/bin/env bash

instance_dir=$( cd ../ && pwd )

mkdir ../gems 2>/dev/null
rm    ../etc/environment 2>/dev/null

echo "GEM_HOME=$instance_dir/gems" >> ../etc/environment
echo "GEM_PATH=$instance_dir/gems" >> ../etc/environment

