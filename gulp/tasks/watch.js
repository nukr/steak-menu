var gulp = require('gulp');

gulp.task('watch', ['browserSync'], function () {
    gulp.watch([
        'client/js/**/*.js',
        'client/js/**/*.coffee'
    ], ['browserify']);
});
