#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

# Go 1.27's PIE binaries crash at startup on linux-ppc64le (SIGSEGV during
# package init), so build a regular executable there.
buildmode=""
if [[ "${target_platform}" == "linux-ppc64le" ]]; then
    buildmode="-buildmode=exe"
fi

go build -o=${PREFIX}/bin/${PKG_NAME} ${buildmode} -ldflags="-s -w -X main.version=${PKG_VERSION}"
go-licenses save . --save_path=license-files --ignore github.com/mattn/go-localereader --ignore filippo.io/nistec

mkdir -p ${PREFIX}/etc/bash_completion.d
mkdir -p ${PREFIX}/share/fish/vendor_completions.d
mkdir -p ${PREFIX}/share/zsh/site-functions
install -m 644 completions/chezmoi-completion.bash ${PREFIX}/etc/bash_completion.d/chezmoi-completion.bash
install -m 644 completions/chezmoi.fish ${PREFIX}/share/fish/vendor_completions.d/chezmoi.fish
install -m 644 completions/chezmoi.zsh ${PREFIX}/share/zsh/site-functions/_chezmoi

# Manually copy licenses that go-licenses could not download
cp -r ${RECIPE_DIR}/license-files/* ${SRC_DIR}/license-files
