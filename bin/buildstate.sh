#!/bin/bash

export PATH="$PATH:bin"

upsert_state_file "$(uname -r || date)" kernel_version state
upsert_state_file "$(vim --version || date)" vim_version state
#upsert_state_file "$(bork --version || date)" bork_version state
upsert_state_file "$(rustup --version || date)" rustup_version state
upsert_state_file "$(rustc --version || date)" rustc_version state
upsert_state_file "$(javac -version 2>&1 || date)" javac_version state

