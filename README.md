# Multi git

Bash script to help manipulate multiple repos.
Assumptions:

- all repos share the same URL prefix (e.g. `git@github.com:lorem/`)
- all repos reside in the same main directory
- main directory contains `multi-git` repo

## Install getopts

    brew install gnu-getopt
    brew link --force gnu-getopt

## Config

Update `mgit-vars.sh` repo with appropriate values, for example:

    REPOS_ALL=(
      documentation
      api
      backend
      frontend
      infra
      technical
    )
    
    REPOS_PRODUCT=(
      api
      backend
      frontend
    )
    
    BASE_GIT_URL=git@github.com:lorem/


## Run

Check state of all the repos:

    ./mgit.sh info
    
Check out default branch in all the repos:

    ./mgit.sh checkout
    
Clone all the repos:

    ./mgit.sh clone
    
Check state of repos included in `product` group:    
    
    ./mgit.sh info --repos=product

Clone repos included in `product` group:    

    ./mgit.sh clone --repos=product

Check out `hotfix` branch in repos included in `product` group:

    ./mgit.sh checkout --repos=product --branch=hotfix
