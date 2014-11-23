var client = './client';
var src = './client/src';
var js = './client/js';
var build = './client/build';

module.exports = {
    browserSync: {
        files: [ build + "/**" ],
        proxy: '0.0.0.0:3000',
        startPath: 'build/index.html'
    },
};
