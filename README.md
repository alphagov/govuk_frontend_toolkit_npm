The GOV.UK Design System launched on 22 June 2018
===============

GOV.UK Frontend Toolkit has now been replaced by the GOV.UK Design System. The Toolkit will remain available in case you are currently using it, but is no longer maintained. The Government Digital Service will only carry out major bug fixes and security patches.

The GOV.UK Design System will be updated to ensure the things it contains meet level AA of WCAG 2.1, but GOV.UK Frontend Toolkit will not. [Read more about accessibility of the GOV.UK Design System](https://design-system.service.gov.uk/accessibility/).

---

# GOV.UK frontend toolkit npm package

This is an npm package for [the GOV.UK frontend toolkit][toolkit].
It bundles up the toolkit and publishes [govuk_frontend_toolkit on the npmjs
registry][npmjs] so that you can install it as a dependency in your JavaScript
application.

## Installing

To include the toolkit in your project run:

```
npm install --save govuk_frontend_toolkit
```

This will install the toolkit inside your `node_modules` and will add the
package to your package.json.

## Updating this package

All development of the toolkit should happen [upstream][toolkit] and changes
will then become available in this package.

When master is changed in the upstream repo Travis will [trigger a build][trigger]
of this repository, which will automatically build and publish the module if the
version in `VERSION.txt` is newer than the version published on NPM registry.

## Licence

[MIT License](LICENCE)


[toolkit]: https://github.com/alphagov/govuk_frontend_toolkit
[npmjs]: https://www.npmjs.org/package/govuk_frontend_toolkit
[trigger]: https://github.com/alphagov/govuk_frontend_toolkit/blob/master/trigger.sh
