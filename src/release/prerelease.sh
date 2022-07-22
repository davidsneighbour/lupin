# shellcheck shell=bash

function add_replacements(){

  if test -f "$SCRIPTPATH"/replacements; then
    while read -ra __; do
      go mod edit -replace "${__[0]}"="${__[1]}"
    done <"$SCRIPTPATH"/replacements
  fi

}

function remove_replacements(){

  if test -f "$SCRIPTPATH"/replacements; then
    while read -ra __; do
      go mod edit -dropreplace "${__[0]}"
    done <"$SCRIPTPATH"/replacements
  fi

}

function pre_release_hook(){

  REQUIRED_TOOLS=(
    git
    hugo
    typos
  )

  # check available tools and dies with missing tools
  check_tools

  typos -- ./content

  remove_replacements

  "${CURPATH}"/bin/build/prepare-docs

  hugo mod get -u ./...
  hugo mod tidy

  git add "${CURPATH}"/go.mod
  FILE="${CURPATH}"/go.sum
  if test -f "$FILE"; then
    git add go.sum
  fi

  add_replacements

}
