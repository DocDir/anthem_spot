gulp    = require 'gulp'
gutil   = require 'gutil'
coffee  = require 'gulp-coffee'
stylus  = require 'gulp-stylus'
connect = require 'gulp-connect'

paths =
  html:    './index.html'
  scripts: './scripts/**/*.coffee'
  styles:  './styles/**/*.styl'
  data:    './data/**/*.json'
  build:   './build'

gulp.task 'html', () ->
  gulp.src(paths.html)
    .pipe(connect.reload())
    .pipe(gulp.dest(paths.build))

gulp.task 'scripts', () ->
  gulp.src(paths.scripts)
    .pipe(coffee(bare: true).on('error', gutil.log))
    .pipe(connect.reload())
    .pipe(gulp.dest(paths.build))

gulp.task 'styles', () ->
  gulp.src(paths.styles)
    .pipe(stylus(compress: true))
    .pipe(gulp.dest(paths.build))

gulp.task 'data', () ->
  gulp.src(paths.data)
    .pipe(gulp.dest(paths.build))

gulp.task 'serve', () ->
  connect.server(root: paths.build, livereload: true)

gulp.task 'watch', () ->
  gulp.watch paths.html, ['html']
  gulp.watch paths.scripts, ['scripts']
  gulp.watch paths.styles, ['styles']
  gulp.watch paths.data, ['data']

gulp.task 'default', ['html', 'scripts', 'styles', 'data']
