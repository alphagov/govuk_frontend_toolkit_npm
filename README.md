# GOV.UK frontend toolkit npm package

This is an npm package for [the GOV.UK frontend toolkit][toolkit].
It bundles up the toolkit and publishes [govuk_frontend_toolkit on the npmjs registry][npmjs]
so that you can install it as a dependency in your JavaScript application.

[toolkit]: https://github.com/alphagov/govuk_frontend_toolkit
[npmjs]: https://www.npmjs.org/package/govuk_frontend_toolkit

## Installing

Include `govuk_frontend_toolkit` in your `package.json` along with a version, and run:

```
npm install
```

## Updating this package

This package is updated automatically by a job on GDS' continuous integration server whenever
the `VERSION.txt` file in the toolkit changes.

All development of the toolkit should happen [upstream][toolkit] and changes will then become
available in this package.

## Licence

[MIT License](LICENCE)
