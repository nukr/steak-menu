var async = require('async');
var Zepto = require('browserify-zepto');
var AppActionCreator = require('../actions/AppActionCreator');

module.exports = {

    getAll: function () {
        async.parallel([
            function getModules(callback) {
                Zepto.getJSON('http://0.0.0.0:3000/api/actions', function (modules) {
                    callback(null, modules);
                });
            },
            function getCompanies(callback) {
                Zepto.getJSON('http://0.0.0.0:3000/api/companies', function (companies) {
                    callback(null, companies);
                });
            },
            function getLocales(callback) {
                Zepto.getJSON('http://0.0.0.0:3000/api/locales', function (locales) {
                    callback(null, locales);
                });
            },
            function getPackages(callback) {
                Zepto.getJSON('http://0.0.0.0:3000/api/packs', function (packages) {
                    callback(null, packages);
                });
            }
        ], function (err, results) {

            results.allModules = results[0]
            results.allCompanies = results[1]
            results.allLocales = results[2]
            results.allPackages = results[3]

            AppActionCreator.receiveAll(results);
        });
    }

}
