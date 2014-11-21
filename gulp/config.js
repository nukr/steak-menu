var client = './client';
var src = './client/src';
var js = './client/js';
var build = './client/build';

module.exports = {
    browserSync: {
        files: [ build + "/**" ],
        server: {
            baseDir: client
        },
        startPath: 'build/index.html'
    },
};
