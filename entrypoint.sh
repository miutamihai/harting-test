#!/bin/bash

echo "Building and deploying assets"

which libreoffice
MIX_ENV=prod mix assets.deploy
MIX_ENV=prod exec mix phx.server
