#!/bin/bash

set -e

source $(dirname $0)/helpers.sh

it_can_deploy_release_to_folder_without_pom() {

  local src=$(mktemp -d $TMPDIR/out-src.XXXXXX)
  mkdir $src/m2-repo

  local url=file://$src/m2-repo
  local version=1.0.0-rc.0

  deploy_without_pom_without_credentials $url $version $src | jq -e "
    .version == {version: $(echo $version | jq -R .)}
  "
}

it_can_deploy_snapshot_to_folder_without_pom() {

  local src=$(mktemp -d $TMPDIR/out-src.XXXXXX)
  mkdir $src/m2-repo

  local url=file://$src/m2-repo
  local version=1.0.0-rc.0-SNAPSHOT

  deploy_without_pom_without_credentials $url $version $src | jq -e "
    .version == {version: $(echo $version | jq -R .)}
  "
}

# it_can_deploy_release_to_folder_with_pom() {
#
#   local src=$(mktemp -d $TMPDIR/out-src.XXXXXX)
#
#   mkdir $src/project
#   cp $(dirname $0)/resources/pom-release.xml $src/project/pom.xml
#
#   mkdir $src/m2-repo
#
#   local url=file://$src/m2-repo
#   local pom=$src/project/pom.xml
#   local version=$(xmllint --xpath "//*[local-name()='project']/*[local-name()='version']/text()" $pom)
#
#   deploy_with_pom_without_credentials $url $pom $src | jq -e "
#     .version == {version: $(echo $version | jq -R .)}
#   "
# }

# it_can_deploy_snapshot_to_folder_with_pom() {
#
#   local src=$(mktemp -d $TMPDIR/out-src.XXXXXX)
#
#   mkdir $src/project
#   cp $(dirname $0)/resources/pom-snapshot.xml $src/project/pom.xml
#
#   mkdir $src/m2-repo
#
#   local url=file://$src/m2-repo
#   local pom=$src/project/pom.xml
#   local version=$(xmllint --xpath "//*[local-name()='project']/*[local-name()='version']/text()" $pom)
#
#   deploy_with_pom_without_credentials $url $pom $src | jq -e "
#     .version == {version: $(echo $version | jq -R .)}
#   "
# }

run it_can_deploy_release_to_folder_without_pom
run it_can_deploy_snapshot_to_folder_without_pom
# run it_can_deploy_release_to_folder_with_pom
# run it_can_deploy_snapshot_to_folder_with_pom
