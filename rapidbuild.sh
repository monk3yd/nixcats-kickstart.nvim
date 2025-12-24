#!/bin/bash

# build new neovim
nix build .#nvim

# test it
# ./result/bin/nvim
