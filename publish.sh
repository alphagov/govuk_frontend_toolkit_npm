#!/bin/sh
set -e

# This script runs on every push to master of the toolkit. It downloads a tarball
# of the toolkit from GitHub.

# Checkout master as Jenkins checks out an individual commit on a detached tree.
# This means when we commit later it will be on a branch
git checkout master
git reset --hard origin/master

wget https://github.com/alphagov/govuk_frontend_toolkit/archive/$TAG_FILENAME.tar.gz -O new-toolkit.tar.gz

tar -xzf new-toolkit.tar.gz

cd govuk_frontend_toolkit-master/

# Remove the package.json (with -f so that we don't fail if it doesn't exist)
rm -f package.json

# Toolkit development happens in a separate repository, so remove dev and docs-related things
rm -f README.md
rm -rf spec
rm -f CONTRIBUTING.md
rm -f Gruntfile.js
rm -f jenkins.sh

# Move the actual toolkit files into the repo where this script is
rsync -a * ..

cd ..

rm -r govuk_frontend_toolkit-master
rm new-toolkit.tar.gz

VERSION_LATEST=`cat VERSION.txt`
VERSION_REGISTRY=`npm view govuk_frontend_toolkit version`

if [ "$VERSION_LATEST" != "$VERSION_REGISTRY" ]; then
  git commit -am "Temporary commit: new toolkit files"
  npm version $VERSION_LATEST
  git reset --soft HEAD~2
  git commit -am "Bump npm version of govuk_frontend_toolkit to $VERSION_LATEST"
  git push origin master
  npm publish
else
  echo 'VERSION.txt is the same as the version available on the registry'
  echo 'Not publishing anything'
fi
