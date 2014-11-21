var gulp = require('gulp');
var source = require('vinyl-source-stream');
var browserify = require('browserify');
var uglify = require('gulp-uglify');
var watchify = require('watchify');
var bundleLogger = require('../util/bundleLogger');
var handleErrors = require('../util/handleErrors');

gulp.task('browserify', function () {
    var bundler = watchify(browserify('./client/js/app.coffee', watchify.args));

    var bundle = function(ids) {
        // Log when bundling starts
        bundleLogger.start();

        return bundler
            .bundle()
            // Report compile errors
            .on('error', handleErrors)
            // Use vinyl-source-stream to make the
            // stream gulp compatible. Specifiy the
            // desired output filename here.
            .pipe(source('bundle.js'))
            // Specify the output destination
            .pipe(gulp.dest('./client/build/'))
            // Log when bundling completes!
            .on('end', bundleLogger.end);
    };

    // Rebundle with watchify on changes.
    bundler.on('update', bundle);

    return bundle();

});


