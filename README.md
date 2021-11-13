# Multi git

Bash script to help manipulate multiple repos.
Assumptions:

- all repos share the same URL prefix (e.g. `git@github.com:lorem/`)
- all repos reside in the same main directory
- main directory contains `multi-git-config` directory

## Install getopts

    brew install gnu-getopt
    brew link --force gnu-getopt

## Install & Config

Clone `multi-git` repo and add `mgit` to your path.

Let's assume that you need to work with the following repositories:

      git@github.com:lorem/backend
      git@github.com:lorem/frontend
      git@github.com:lorem/documentation
      git@github.com:lorem/infra

Create a new directory for all the repos and for `mgit` config:

    cd
    mkdir lorem
    mkdir lorem/multi-git-config


Create `lorem/multi-git-config/mgit-config.sh` file with appropriate values, for example:

    REPOS_ALL=(
      backend
      frontend
      documentation
      infra
    )
    
    REPOS_PRODUCT=(
      backend
      frontend
    )
    
    BASE_GIT_URL=git@github.com:lorem/

## Run

Clone all repositories:

    cd lorem/multi-git-config
    mgit clone

Check state of all the repos:

    cd lorem/multi-git-config
    mgit info
    
Check out default branch in all the repos:

    cd lorem/multi-git-config
    mgit checkout
    
Check state of repos included in `product` group:    

    cd lorem/multi-git-config
    mgit info --repos=product

Check out `hotfix` branch in repos included in `product` group:

    cd lorem/multi-git-config
    mgit checkout --repos=product --branch=hotfix

## Regular cleanup tasks

    cd lorem/multi-git-config
    mgit checkout
    mgit update
    mgit delete
    mgit clean
