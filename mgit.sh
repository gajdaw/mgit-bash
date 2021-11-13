#!/usr/bin/env bash

. mgit-vars.sh
. mgit-lib.sh

: ${REPOS:=all}
: ${BRANCH:=master}

set -o errexit

print_usage() {
    echo "USAGE: $0 [-h/--help] {checkout,clean,clone,info,update} [--repos=<value>] [--branch=<value>]" >&2
    echo "       checkout - checkout given branch (default branch: master)" >&2
    echo "       clean    - clean repositories" >&2
    echo "       clone    - clone repos" >&2
    echo "       info     - print info about repo" >&2
    echo "       update   - update repositories" >&2
}


case "$1" in
    checkout|clean|clone|info|update) COMMAND="$1" ;;
    *) print_usage; echo "unknown command '$1'" >&2; exit 1 ;;
esac

shift

while getopts ":h-:" OPTCHAR; do
    case "${OPTCHAR}" in
        h) print_usage; exit 0 ;;
        -)
            case "${OPTARG}" in
                help) print_usage; exit 0 ;;
                repos) REPOS="${!OPTIND}"; ((OPTIND++)) ;;
                repos=*) REPOS="${OPTARG#*=}" ;;
                branch) BRANCH="${!OPTIND}"; ((OPTIND++)) ;;
                branch=*) BRANCH="${OPTARG#*=}" ;;
                *) print_usage; echo "unknown option '--${OPTARG}'" >&2; exit 1 ;;
            esac
        ;;
        *) print_usage; echo "unknown option '-${OPTARG}'" >&2; exit 1 ;;
    esac
done

case "${REPOS}" in
    all) SELECTED_REPOS=(${REPOS_ALL[@]}) ;;
    product) SELECTED_REPOS=(${REPOS_PRODUCT[@]}) ;;
    *) print_usage; echo "unknown value for --repos option" >&2; exit 1 ;;
esac


set -o nounset -o pipefail

# pre-checks (osx: for realpath use: brew install coreutils)
which realpath xargs dirname tee git curl > /dev/null

SELF=$(realpath "$0" | xargs dirname) && cd $SELF/

case "${COMMAND}" in
    info)
        (runExamplesInfo)
    ;;
    clone)
        (runClone)
    ;;
    checkout)
        (runCheckout)
    ;;
    update)
        (runUpdate)
    ;;
    clean)
        (runClean)
    ;;
esac

## vim:ts=4:sw=4:et:syn=sh:
