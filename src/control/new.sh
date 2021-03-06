# shellcheck shell=bash

function control(){
  # checking required tools
  REQUIRED_TOOLS=(
      hugo
      code
      git
  )
  check_tools

  # select new post version
  PS3='Choose section: '
  OPTIONS=("Post" "Music to program to" "Notes from the Lab" "Hugo Release Notes" "Tag" "Quit")
  select opt in "${OPTIONS[@]}"; do
      case $opt in
          "Post")
              read -r -p 'Title: ' POST
              POST=${POST// /-}
              POST=${POST,,}
              hugo new blog/"${YEAR}"/"${POST}"
              code {$CURPATH}/content/blog/"${YEAR}"/"${POST}"/index.md
              exit
          ;;
          "Music to program to")
              INCREMENT_FILENAME=${CURPATH}/resources/music2program2
              TEMPLATE=${CURPATH}/bin/templates/music2program2.md
              NUMBER=$(cat "$INCREMENT_FILENAME")
              TEMPLATE=$(cat "$TEMPLATE")
              INCREMENTED_NUMBER=$((NUMBER + 1))
              echo "${INCREMENTED_NUMBER}" >"${INCREMENT_FILENAME}"
              #hugo new --kind music2program2 blog/"${YEAR}"/music-to-program-to-"${INCREMENTED_NUMBER}"
              mkdir -p {$CURPATH}/content/blog/"${YEAR}"/music-to-program-to-"${INCREMENTED_NUMBER}"/
              echo eval "${TEMPLATE}" >./content/blog/"${YEAR}"/music-to-program-to-"${INCREMENTED_NUMBER}"/index.md
              code .{$CURPATH}/content/blog/"${YEAR}"/music-to-program-to-"${INCREMENTED_NUMBER}"/index.md
              exit
          ;;
          "Notes from the Lab")
              read -r -p 'Month: ' TAG
              hugo new --kind notes-from-the-laboratory blog/"${YEAR}"/notes-from-the-laboratory-"${MONTH}"
              code {$CURPATH}/content/blog/"${YEAR}"/notes-from-the-laboratory-"${MONTH}"/index.md
              exit
          ;;
          "Hugo Release Notes")
              read -r -p 'Version: ' VERSION
              hugo new --kind hugo-release-notes blog/"${YEAR}"/hugo-"${VERSION}"-release-notes/index.md
              code {$CURPATH}/content/blog/"${YEAR}"/hugo-"${VERSION}"-release-notes/index.md
              exit
          ;;
          "Tag")
              read -r -p 'Title: ' TAG
              TAG=${TAG// /-}
              TAG=${TAG,,}
              hugo new tags/"${TAG}"
              code {$CURPATH}/content/tags/"${TAG}"/_index.md
              exit
          ;;
          "Quit")
              break
          ;;
          *) echo "invalid option $REPLY" ;;
      esac
  done

}
