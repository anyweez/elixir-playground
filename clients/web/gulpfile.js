'use strict'
let gulp = require('gulp');
let rollup = require('gulp-rollup');
let babel = require('gulp-babel');
let rename = require('gulp-rename');

gulp.task('default', ['js', 'html']);

gulp.task('html', function () {
    return gulp.src('./html/index.html')
        .pipe(rename('app.html.eex'))
        .pipe(gulp.dest('../../mud/web/templates/layout'));
})

gulp.task('js', function () {
    return gulp.src('./js/app.js')
        .pipe(rollup({
            entry: './js/app.js',
            allowRealFiles: true,
        }))
        .pipe(babel({
            presets: ['es2015'],
        }))
        .pipe(gulp.dest('../../mud/priv/static/js'));
});

gulp.task('watch', ['default'], function () {
    gulp.watch('./js/*.js', ['js']);
    gulp.watch('./html/*.html', ['html']);
});