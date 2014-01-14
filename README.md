# GOV.UK Frontend Toolkit

This is an NPM package for [alphagov/govuk_frontend_toolkit](https://github.com/alphagov/govuk_frontend_toolkit)

## Installing

Include `govuk_frontend_toolkit` in your `package.json` along with a version, and run:

```
npm install
```

## Managing this package

### Set up

Checkout this repo and run:

```
git submodule init
```

### Updating

Follow the [contribution guidelines](https://github.com/alphagov/govuk_frontend_toolkit_npm/blob/master/CONTRIBUTING.md).

To update this package with changes from the source repo:

```
git submodule update
```

Commit the changes to the files, don't push yet. Now run:

```
npm version <version number> -m "Update NPM package to %s"
```

Ensure the version number is quoted. The `%s` chars will be replaced in the commit message with the version number. 

This command will generate a git commit so you should now have two new commits in total. Now push those commits:

```
git push origin master
```

You can then publish changes to npmjs.org by running the job `npm_publish_govuk_frontend_toolkit_npm`
on Jenkins CI.

