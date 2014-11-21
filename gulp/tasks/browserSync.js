var gulp = require('gulp');
var config = require('../config.js').browserSync
var browserSync = require('browser-sync');

gulp.task('browserSync', ['browserify'], function () {
    browserSync(config)
});
