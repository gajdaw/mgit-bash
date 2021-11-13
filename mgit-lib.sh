#!/usr/bin/env bash

function runInfoForOneRepo() {
    echo "---------------------------------------------------"
    echo "REPO:      ${1}"
    cd $1
    echo -n "STATUS:    "
    git status -sb
    echo -n "REV-PARSE: "
    git rev-parse HEAD
    echo -n "DESCRIBE:  "
    git describe --tags
    cd ..
}

function runExamplesInfo() {
    cd ..
    for ex in "${SELECTED_REPOS[@]}"
    do
        runInfoForOneRepo ${ex}
    done
}


function runCloneForOneRepo() {
    echo "---------------------------------------------------"
    echo "REPO:     ${1}"
    git clone ${BASE_GIT_URL}${1}.git || true
}

function runClone() {
    cd ..
    for ex in "${SELECTED_REPOS[@]}"
    do
        runCloneForOneRepo ${ex}
    done
}

function runCheckoutOneRepo() {
    echo "---------------------------------------------------"
    echo "REPO:     ${1}"
    cd $1
    git checkout $2 || true
    cd ..
}

function runCheckout() {
    cd ..
    for ex in "${SELECTED_REPOS[@]}"
    do
        runCheckoutOneRepo ${ex} $BRANCH
    done
}

function runUpdateOneRepo() {
    echo "---------------------------------------------------"
    echo "REPO:     ${1}"
    cd $1
    git fetch
    git reset --hard >/dev/null
    git clean -df >/dev/null
    git rebase >/dev/null
    cd ..
}

function runUpdate() {
    cd ..
    for ex in "${SELECTED_REPOS[@]}"
    do
        runUpdateOneRepo ${ex}
    done
}

function runCleanOneRepo() {
    echo "---------------------------------------------------"
    echo "REPO:     ${1}"
    cd $1
    git-clean-repo.sh
    cd ..
}

function runClean() {
    cd ..
    for ex in "${SELECTED_REPOS[@]}"
    do
        runCleanOneRepo ${ex}
    done
}
