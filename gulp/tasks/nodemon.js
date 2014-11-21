var gulp = require('gulp');
var nodemon = require('gulp-nodemon');
var nodemon_instance;

gulp.task('nodemon', function () {
    if (!nodemon_instance) {
        nodemon_instance = nodemon({script: 'server/server.js'});
    } else {
        nodemon_instance.emit('restart');
    }
});

