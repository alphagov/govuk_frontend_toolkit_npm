#!/bin/sh
set -e

REPO_PATH="alphagov/govuk_frontend_toolkit_npm"

echo "Add config for alphagov/$REPO_PATH"

git config --global user.name "GOV.UK Patterns & Tools CI User"
git config --global user.email "patterns-and-tools-github-user@digital.cabinet-office.gov.uk"
git remote add origin_ssh git@github.com:$REPO_PATH.git

openssl aes-256-cbc -K $encrypted_6c266e67b443_key -iv $encrypted_6c266e67b443_iv -in .travis/govuk_frontend_toolkit_npm_push.enc -out ~/.ssh/id_rsa -d
chmod 600 ~/.ssh/id_rsa

# This script runs on every push to master of the toolkit. It downloads a tarball
# of the toolkit from GitHub.

# Make sure we're building the right thing in Travis
git checkout master
git reset --hard origin/master

wget https://github.com/alphagov/govuk_frontend_toolkit/archive/master.tar.gz -O new-toolkit.tar.gz

tar -xzf new-toolkit.tar.gz

cd govuk_frontend_toolkit-master/

# Remove the package.json (with -f so that we don't fail if it doesn't exist)
rm -f package.json

# Toolkit development happens in a separate repository, so remove dev and docs-related things
rm -f README.md
rm -rf docs
rm -rf spec
rm -f CONTRIBUTING.md
rm -f Gruntfile.js
rm -f Gemfile
rm -f Gemfile.lock
rm -f push.sh
rm -f trigger.sh
rm -f create-release.sh

# Move the actual toolkit files into the repo where this script is
# --delete:  delete extraneous files from dest dir
# --archive: preserves permissions, times, symbolic links, etc

# Note: src of `*` is different from `.`, especially for delete!
# - `*` expands to each file/dir in src, which are rsync'd individually. A file that exists in dest
#   but not src won't be deleted. This is the behaviour we want.
# - `.` copies the directory in one go, deleting ANY files in dest that are not in src, which will
#   delete key files in this repo - like `package.json`, even `.git/`
rsync --delete --archive * ..

cd ..

rm -r govuk_frontend_toolkit-master
rm new-toolkit.tar.gz

echo "Check to see if the version file has been updated"

# get the version from the version file
VERSION_LATEST=`cat VERSION.txt`
echo "Version in VERSION.txt: $VERSION_LATEST"

# get the version from npm
VERSION_REGISTRY=`npm view govuk_frontend_toolkit version`
echo "Version of npm package: $VERSION_REGISTRY"

if [ "$VERSION_LATEST" != "$VERSION_REGISTRY" ]; then
  # Update `package.json` version field, without creating it's own commit or tag
  # https://docs.npmjs.com/cli/version
  npm version -f --no-git-tag-version $VERSION_LATEST

  # Adds, modifies, and removes index entries to match the working tree.
  # https://git-scm.com/docs/git-add#git-add--A
  git add --all

  git commit -m "Bump npm version of govuk_frontend_toolkit to $VERSION_LATEST"
  git push origin_ssh master
else
  echo 'VERSION.txt is the same as the version available on the registry'
  echo 'Not publishing anything'
fi
