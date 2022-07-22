# shellcheck shell=bash

check_tools() {

  for TOOL in "${REQUIRED_TOOLS[@]}"; do
    if ! command -v "${TOOL}" >/dev/null; then
      echo "${TOOL} is required... "
      exit 1
    fi
  done

}

update_citation_file() {

  CITATIONFILE=CITATION.cff
  PACKAGEFILE=package.json

  if [ -f "$SCRIPTPATH"/$CITATIONFILE ] && [ -f "$SCRIPTPATH"/$PACKAGEFILE ]; then
    VERSION=$(node -pe 'require("./${PACKAGEFILE}")["version"]')
    sed -i "s/^version: .*/version: ${VERSION}/" $CITATIONFILE
    DATE=$(date +%F)
    sed -i "s/date-released: .*/date-released: ${DATE}/" $CITATIONFILE
    git add $CITATIONFILE
  fi

}

post_release_hook() {

  local REQUIRED_TOOLS=(
    git
  )

  # check available tools and dies with missing tools
  check_tools
  # update version in citation configuration
  update_citation_file
  # adding data directory for new build information
  git add data/dnb
  git commit --signoff --amend --no-edit
  # push release to GitHub
  git push origin main --follow-tags
  git push origin --tags

}
